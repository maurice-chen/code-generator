package com.github.maurice.code.generator.model;

import java.math.BigDecimal;
import java.sql.JDBCType;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public enum JavaType {

    /**
     * 字符串
     */
    STRING(String.class, Arrays.asList(JDBCType.CHAR, JDBCType.LONGVARCHAR, JDBCType.VARCHAR)),
    /**
     * 金钱
     */
    BIGDECIMAL(BigDecimal.class, Collections.singletonList(JDBCType.DECIMAL)),

    /**
     * 双精度
     */
    DOUBLE(Double.class, Collections.singletonList(JDBCType.DOUBLE)),

    /**
     * 单精度
     */
    FLOAT(Float.class, Collections.singletonList(JDBCType.FLOAT)),
    /**
     * 布尔类型
     */
    BOOLEAN(Boolean.class, Arrays.asList(JDBCType.BIT, JDBCType.BOOLEAN)),
    /**
     * 整形
     */
    INTEGER(Integer.class, Arrays.asList(JDBCType.TINYINT, JDBCType.SMALLINT, JDBCType.INTEGER)),
    /**
     * 长整型
     */
    LONG(Long.class, Arrays.asList(JDBCType.BIGINT)),
    /**
     * 日期类型
     */
    DATE(Date.class, Arrays.asList(JDBCType.DATE, JDBCType.TIME, JDBCType.TIMESTAMP)),

    /**
     * 布尔类型
     */
    BYTE(Byte.class, Arrays.asList(JDBCType.BINARY, JDBCType.VARBINARY, JDBCType.LONGVARBINARY)),

    ;


    JavaType(Class clzss, List<JDBCType> jdbcTypes) {
        this.clzss = clzss;
        this.jdbcTypes = jdbcTypes;
    }


    private List<JDBCType> jdbcTypes;

    private Class clzss;

    public List<JDBCType> getJdbcTypes() {
        return jdbcTypes;
    }

    public Class getClzss() {
        return clzss;
    }

    public static JavaType valueOf(int jdbcTypeInt) {
        JDBCType jdbcType = JDBCType.valueOf(jdbcTypeInt);

        if (jdbcType == null) {
            throw new IllegalArgumentException("JDBC Type:" + jdbcTypeInt + " is not a valid Types.java value.");
        }

        for (JavaType javaType : JavaType.values()) {

            if (javaType.getJdbcTypes().contains(jdbcType)) {
                return javaType;
            }
        }

        throw new IllegalArgumentException("JDBC Type:" + jdbcTypeInt + " is not a valid Types.java value.");
    }
}
