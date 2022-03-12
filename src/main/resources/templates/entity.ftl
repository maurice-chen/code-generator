<#macro getPrefix javaTypeName=""><#if javaTypeName == "Boolean">is<#else>get</#if></#macro>
package ${basePackage}.entity;

<#if table.hasBigDecimal()>
import java.math.BigDecimal;
</#if>
import lombok.*;

import org.apache.ibatis.type.Alias;
import com.baomidou.mybatisplus.annotation.*;
import com.github.dactiv.framework.mybatis.plus.baisc.support.IntegerVersionEntity;

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
@Alias("${table.entityVarName}")
@TableName("${table.tableName}")
@EqualsAndHashCode(callSuper = true)
public class ${table.entityName}Entity extends IntegerVersionEntity<Integer> {

<#list table.columns as column>
    <#if ignoreProperties?seq_contains(column.javaVarName) == false>
    /**
     * ${column.columnComment}
     */
    private ${column.javaTypeName} ${column.javaVarName};

    </#if>
</#list>
}