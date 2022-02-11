package com.fuyu.basic.code.generator.execute;

import com.fuyu.basic.code.generator.model.JsonType;
import com.fuyu.basic.code.generator.model.Table;
import com.fuyu.basic.code.generator.JavaCodeProperties;
import com.fuyu.basic.code.generator.model.Column;
import com.fuyu.basic.code.generator.model.JavaType;
import com.fuyu.basic.code.generator.util.StringUtil;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.RegExUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Component
public class TableHandler implements DisposableBean {

    private final static Logger LOGGER = LoggerFactory.getLogger(TableHandler.class);

    @Autowired
    private DataSource dataSource;
    @Autowired
    private JavaCodeProperties javaCodeProperties;

    private Connection connection;

    private final String TABLE_COMMENT_SQL = "show table status where NAME=?";
    private final String TABLE_COMMENT_COLUMN = "COMMENT";


    public TableHandler() {
    }

    @PostConstruct
    public void init() throws Exception {
        this.connection = dataSource.getConnection();
    }

    public Table getTableInfo(String tableName) {
        return getTable(tableName);
    }


    private String getTableComment(String tableName) {
        String result = null;
        try {
            PreparedStatement statement = connection.prepareStatement(TABLE_COMMENT_SQL);
            statement.setString(1, tableName);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                result = resultSet.getString(TABLE_COMMENT_COLUMN);
            }
            resultSet.close();
            statement.close();
            if (result == null) {
                result = "";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    private Table getTable(String tableName) {
        Table table = null;

        try {
            ResultSet resultSet = connection.getMetaData().getTables(null, null, tableName, new String[] { "TABLE" });
            if (!resultSet.next()) {
                LOGGER.error("表[{}]该表不存在", tableName);
                resultSet.close();
                return null;
            }

            //获取主键
            List<String> primaryKeys = getPrimaryKeys(tableName);
            if (CollectionUtils.isEmpty(primaryKeys)) {
                LOGGER.error("表[{}]找不到主键", tableName);
                resultSet.close();
                return null;
            }

            table = new Table();
            table.setTableName(tableName);

            String entityName = tableName;
            if (StringUtils.isNotBlank(javaCodeProperties.getStripPrefix())) {
                entityName = RegExUtils.replaceFirst(entityName, javaCodeProperties.getStripPrefix(), "");
            }

            table.setEntityName(StringUtil.lineToHump(entityName, true));
            table.setEntityVarName(StringUtil.lineToHump(entityName));

            table.setColumns(getTableColumns(primaryKeys, tableName));
            table.setTableComment(getTableComment(tableName));
            table.setControllerPath(StringUtil.replace(entityName, "_", "/"));
            table.setPluginName(entityName);
            table.setId(System.currentTimeMillis());

            for (Column column : table.getColumns()) {
                if (column.isPrimaryKeyFlag()) {
                    table.setPrimaryKeyJavaTypeName(column.getJavaTypeName());
                    break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return table;
    }

    public List<String> getPrimaryKeys(String tableName) {
        List<String> primaryKeys = new ArrayList<>();
        try {
            // 获取表内的主键列表
            ResultSet resultSet = connection.getMetaData().getPrimaryKeys(null, null, tableName);
            while (resultSet.next()) {
                // 获取主键的列名
                String pkColumnName = resultSet.getString("COLUMN_NAME");
                primaryKeys.add(pkColumnName);
            }
            resultSet.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return primaryKeys;
    }

    private List<Column> getTableColumns(List<String> primaryKeys, String tableName) {
        List<Column> columns = new ArrayList<>();
        try {
            // 获取列信息
            ResultSet resultSet = connection.getMetaData().getColumns(null, null, tableName, "%");
            while (resultSet.next()) {
                columns.add(getTableColumn(resultSet, primaryKeys));
            }
            resultSet.close();
            return columns;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return columns;
    }

    private Column getTableColumn(ResultSet rs, List<String> primaryKeys) {
        try {
            Column column = new Column();
            // 数据库字段类型
            int jdbcTypeInt = rs.getInt("DATA_TYPE");

            JDBCType jdbcType = JDBCType.valueOf(jdbcTypeInt);
            JavaType javaType = JavaType.valueOf(jdbcTypeInt);
            JsonType jsonType = JsonType.valueOf(jdbcTypeInt);
            // 列名
            String columnName = rs.getString("COLUMN_NAME");

            column.setJavaName(StringUtil.lineToHump(columnName, true));
            column.setJavaVarName(StringUtil.lineToHump(columnName));

            boolean primaryKeyFlag = primaryKeys.contains(columnName);

            // 表名
            String tableName = rs.getString("TABLE_NAME");
            column.setPrimaryKeyFlag(primaryKeyFlag);
            column.setColumnName(columnName);

            column.setJdbcType(jdbcTypeInt);
            column.setJdbcTypeName(jdbcType.getName());

            column.setJavaType(javaType);
            column.setJavaTypeName(javaType.getClzss().getSimpleName());

            column.setJsonType(jsonType);
            column.setJsonTypeName(jsonType.getType());

            column.setSize(rs.getInt("COLUMN_SIZE"));
            column.setNullable(rs.getBoolean("NULLABLE"));
            column.setDefaultValue(rs.getString("COLUMN_DEF"));
            column.setColumnComment(rs.getString("REMARKS"));
            column.setAutoincrement(hasColumn(rs, "IS_AUTOINCREMENT") && rs.getBoolean("IS_AUTOINCREMENT"));

            try(PreparedStatement pc = connection.prepareStatement("show index from " + tableName + " WHERE non_unique = 0 AND key_name != 'PRIMARY' AND column_name = '" + columnName + "'")) {
                try (ResultSet executeQuery = pc.executeQuery()) {
                    if (executeQuery.next()) {
                        if (!executeQuery.getBoolean("non_unique")) {
                            column.setUnique(true);
                        }
                    }
                }
            }
            return column;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 结果集内是否存在自增的列
     *
     * @param rs
     *            结果集
     * @param columnName
     *            自增列名
     * @return true：存在列表，false：不存在列
     * @throws SQLException
     *             数据库异常
     */
    private boolean hasColumn(ResultSet rs, String columnName)
            throws SQLException {
        ResultSetMetaData resultSetMetaData = rs.getMetaData();
        int columns = resultSetMetaData.getColumnCount();
        for (int x = 1; x <= columns; x++) {
            if (columnName.equals(resultSetMetaData.getColumnName(x))) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void destroy() throws Exception {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
