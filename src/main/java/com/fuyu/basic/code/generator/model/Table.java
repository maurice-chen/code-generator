package com.fuyu.basic.code.generator.model;

import java.util.List;

public class Table {

    private Long id;

    /**
     * 表名称
     */
    private String tableName;

    /**
     * 实体名称
     */
    private String entityName;

    /**
     * 实体变量名称
     */
    private String entityVarName;

    /**
     * 表注释
     */
    private String tableComment;

    /**
     * 主键java类型名称
     */
    private String primaryKeyJavaTypeName;

    /**
     * 控制器路径
     */
    private String controllerPath;

    /**
     * 插件名称
     */
    private String pluginName;

    /**
     * 列
     */
    private List<Column> columns;

    public Table() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public boolean hasDate() {
        if (columns != null && columns.size() > 0) {
            for (Column column : columns) {
                if (column.getJavaType() == JavaType.DATE) {
                    return true;
                }
            }
        }
        return false;
    }

    public boolean hasBigDecimal() {
        if (columns != null && columns.size() > 0) {
            for (Column column : columns) {
                if (column.getJavaType() == JavaType.BIGDECIMAL) {
                    return true;
                }
            }
        }
        return false;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getEntityName() {
        return entityName;
    }

    public void setEntityName(String entityName) {
        this.entityName = entityName;
    }

    public String getEntityVarName() {
        return entityVarName;
    }

    public void setEntityVarName(String entityVarName) {
        this.entityVarName = entityVarName;
    }

    public String getTableComment() {
        return tableComment;
    }

    public void setTableComment(String tableComment) {
        this.tableComment = tableComment;
    }

    public String getPrimaryKeyJavaTypeName() {
        return primaryKeyJavaTypeName;
    }

    public void setPrimaryKeyJavaTypeName(String primaryKeyJavaTypeName) {
        this.primaryKeyJavaTypeName = primaryKeyJavaTypeName;
    }

    public List<Column> getColumns() {
        return columns;
    }

    public void setColumns(List<Column> columns) {
        this.columns = columns;
    }

    public String getControllerPath() {
        return controllerPath;
    }

    public void setControllerPath(String controllerPath) {
        this.controllerPath = controllerPath;
    }

    public String getPluginName() {
        return pluginName;
    }

    public void setPluginName(String pluginName) {
        this.pluginName = pluginName;
    }
}
