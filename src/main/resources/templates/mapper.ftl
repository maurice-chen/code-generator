<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- ${table.tableComment}数据访问映射 -->
<mapper namespace="${basePackage}.dao.${table.entityName}Dao" >

    <resultMap id="baseResultMap" type="${basePackage}.entity.${table.entityName}" >
    <#list table.columns as column>
        <#if column.primaryKeyFlag == true>
        <id column="${column.columnName}" jdbcType="${column.jdbcTypeName}" property="${column.javaVarName}"/>
        <#else>
        <result column="${column.columnName}" jdbcType="${column.jdbcTypeName}" property="${column.javaVarName}"/>
        </#if>
    </#list>
    </resultMap>

    <!-- 查询条件 -->
    <sql id="selectCondition">
        <include refid="${basePackage}.support.Include.${table.entityVarName}SelectCondition"></include>
    </sql>

    <sql id="baseColumnList">
        <#list table.columns as column>
        ${column.columnName}<#if column_has_next>,</#if>
        </#list>
    </sql>

    <select id="get" resultMap="baseResultMap">
        SELECT
            <include refid="baseColumnList" />
        FROM
            ${table.tableName}
        WHERE
            id = ${r'#{id}'}
    </select>

    <select id="lock" resultMap="baseResultMap" >
        SELECT
            <include refid="baseColumnList"/>
        FROM
            ${table.tableName}
        WHERE
            id = ${r'#{id}'}
        FOR UPDATE
    </select>

    <select id="count" resultType="long" parameterType="java.util.Map">
        SELECT
        <#list table.columns as column>
        <#if column.primaryKeyFlag == true>
            COUNT(${column.columnName})
        </#if>
        </#list>
        FROM
            ${table.tableName}
        <include refid="selectCondition" />
    </select>

    <select id="find" resultMap="baseResultMap" parameterType="java.util.Map">
        SELECT
            <include refid="baseColumnList" />
        FROM
            ${table.tableName}
        <include refid="selectCondition" />
        ORDER BY id DESC
        <if test="first != null and last != null">
            ${r'LIMIT #{first}, #{last}'}
        </if>
    </select>

    <delete id="delete">
        DELETE FROM ${table.tableName} WHERE id = ${r'#{'}id}
    </delete>

    <update id="update" parameterType="${table.entityVarName}">
        UPDATE
            ${table.tableName}
        SET
        <#list table.columns as column>
        <#if column.primaryKeyFlag == false>
            ${column.columnName} = ${r'#{'}${column.javaVarName}}<#if column_has_next>,</#if>
        </#if>
        </#list>
        WHERE
            id = ${r'#{'}id}
    </update>

    <insert id="insert" <#if table.primaryKeyJavaTypeName == 'Integer'> useGeneratedKeys="true"</#if>  keyProperty="id"  parameterType="${table.entityVarName}">
        <#if table.primaryKeyJavaTypeName == 'String'>
        <selectKey keyProperty="id" resultType="String" order="BEFORE">
            SELECT replace(UUID(),'-','') FROM dual
        </selectKey>
        </#if>
        INSERT INTO ${table.tableName} (
        <#list table.columns as column>
            <#if column.primaryKeyFlag && column.autoincrement>
                <#continue />
            </#if>
            ${column.columnName}<#if column_has_next>,</#if>
        </#list>
        ) VALUES (
        <#list table.columns as column>
            <#if column.primaryKeyFlag && column.autoincrement>
                <#continue />
            </#if>
            ${r'#{'}${column.javaVarName}}<#if column_has_next>,</#if>
        </#list>
        )
    </insert>

    <!-- 将代码添加到以下区域，以免生成后被覆盖 -->

</mapper>