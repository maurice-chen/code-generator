<#macro getPrefix javaTypeName=""><#if javaTypeName == "Boolean">is<#else>get</#if></#macro>
package ${basePackage}.entity;

<#if table.hasBigDecimal()>
import java.math.BigDecimal;
</#if>
import lombok.*;

import org.apache.ibatis.type.Alias;
import com.baomidou.mybatisplus.annotation.*;
import com.github.dactiv.framework.commons.id.number.NumberIdEntity;

import java.util.*;

<#--
import javax.persistence.*;
import io.swagger.annotations.*;
import javax.validation.constraints.*;
-->

/**
 * <p>Table: ${table.tableName} - ${table.tableComment}</p>
 *
 * @author ${author}
 *
 * @since ${.now}
 */
<#--
@Table(name="${table.tableName}")
-->
@Data
@NoArgsConstructor
@EqualsAndHashCode
@Alias("${table.entityVarName}")
@TableName("${table.tableName}")
public class ${table.entityName}Entity implements NumberIdEntity<Integer>{

    /**
    * 主键
    */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
    * 创建时间
    */
    private Date creationTime = new Date();

<#list table.columns as column>
    <#if ignoreProperties?seq_contains(column.javaVarName) == false>
    /**
     * ${column.columnComment}
     */
    private ${column.javaTypeName} ${column.javaVarName};

    </#if>
</#list>
}