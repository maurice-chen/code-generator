package com.github.maurice.code.generator.model;

import java.sql.JDBCType;
import java.util.Arrays;
import java.util.List;

public enum JsonType {

    /**
     * 字符串
     */
    STRING("string", Arrays.asList(JDBCType.CHAR, JDBCType.LONGVARCHAR, JDBCType.VARCHAR,JDBCType.DATE, JDBCType.TIME, JDBCType.TIMESTAMP)),
    /**
     * 金钱
     */
    NUMBER("number", Arrays.asList(JDBCType.DECIMAL, JDBCType.DOUBLE, JDBCType.FLOAT)),

    /**
     * 布尔类型
     */
    BOOLEAN("boolean", Arrays.asList(JDBCType.BIT, JDBCType.BOOLEAN)),
    /**
     * 整形
     */
    INTEGER("integer", Arrays.asList(JDBCType.TINYINT, JDBCType.SMALLINT, JDBCType.INTEGER, JDBCType.BIGINT)),

    ;


    JsonType(String type, List<JDBCType> jdbcTypes) {
        this.type = type;
        this.jdbcTypes = jdbcTypes;
    }


    private List<JDBCType> jdbcTypes;

    private String type;

    public List<JDBCType> getJdbcTypes() {
        return jdbcTypes;
    }

    public String getType() {
        return type;
    }

    public static JsonType valueOf(int jdbcTypeInt) {
        JDBCType jdbcType = JDBCType.valueOf(jdbcTypeInt);

        if (jdbcType == null) {
            throw new IllegalArgumentException("JDBC Type:" + jdbcTypeInt + " is not a valid Types.java value.");
        }

        for (JsonType javaType : JsonType.values()) {

            if (javaType.getJdbcTypes().contains(jdbcType)) {
                return javaType;
            }
        }

        throw new IllegalArgumentException("JDBC Type:" + jdbcTypeInt + " is not a valid Types.java value.");
    }
}
