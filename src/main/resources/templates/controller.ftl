package ${basePackage}.controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import org.springframework.data.web.PageableDefault;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;

import com.github.dactiv.framework.commons.RestResult;
import com.github.dactiv.framework.spring.security.plugin.Plugin;
import com.github.dactiv.framework.spring.security.enumerate.ResourceType;
import com.github.dactiv.framework.spring.security.enumerate.ResourceSource;
import com.github.dactiv.framework.spring.web.filter.generator.mybatis.MybatisPlusQueryGenerator;

import ${basePackage}.entity.${table.entityName};
import ${basePackage}.service.${table.entityName}Service;

import java.util.Map;
import java.util.List;

import javax.validation.Valid;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * ${table.tableName} 的控制器
 *
 * <p>Table: ${table.tableName} - ${table.tableComment}</p>
 *
 * @see ${table.entityName}
 *
 * @author ${author}
 *
 * @since ${.now}
 */
@RestController
@RequestMapping("${table.controllerPath}")
@Plugin(
    name = "${table.tableComment}",
    id = "${table.pluginName}",
    parent = "system",
    type = ResourceType.Menu,
    sources = "Console"
)
public class ${table.entityName}Controller {

    @Autowired
    private ${table.entityName}Service ${table.entityVarName}Service;

    @Autowired
    private MybatisPlusQueryGenerator<?> queryGenerator;

    /**
     * 获取 table: ${table.tableName} 分页信息
     *
     * @param pageable 分页信息
     * @param request  http servlet request
     *
     * @return 分页实体
     *
     * @see ${table.entityName}
     */
    @GetMapping("page")
    @Plugin(name = "获取分页", sources = "Console")
    @PreAuthorize("hasAuthority('perms[${table.pluginName}:page]')")
    public Page<${table.entityName}> page(@PageableDefault Pageable pageable, HttpServletRequest request) {
        return ${table.entityVarName}Service.find${table.entityName}Page(
                pageable,
                queryGenerator.getQueryWrapperByHttpRequest(request)
        );
    }

    /**
     * 获取 table: ${table.tableName} 实体
     *
     * @param id 主键 ID
     *
     * @return ${table.tableName} 实体
     *
     * @see ${table.entityName}
     */
    @GetMapping("get/{id}")
    @PreAuthorize("hasAuthority('perms[${table.pluginName}:get]')")
    @Plugin(name = "获取实体", sources = "Console")
    public ${table.entityName} get(@PathVariable("id") Integer id) {
        return ${table.entityVarName}Service.get${table.entityName}(id);
    }

    /**
     * 保存 table: ${table.tableName} 实体
     *
     * @param entity ${table.tableName} 实体
     *
     * @see ${table.entityName}
     */
    @PostMapping("save")
    @PreAuthorize("hasAuthority('perms[${table.pluginName}:save]')")
    @Plugin(name = "保存实体", sources = "Console", audit = true)
    public RestResult<Map<String, Integer>> save(@Valid ${table.entityName} entity) {
        ${table.entityVarName}Service.save${table.entityName}(entity);
        return RestResult.ofSuccess("保存成功", entity.toIdEntityMap());
    }

    /**
     * 删除 table: ${table.tableName} 实体
     *
     * @param ids 主键 ID 值集合
     *
     * @see ${table.entityName}
     */
    @PostMapping("delete")
    @PreAuthorize("hasAuthority('perms[${table.pluginName}:delete]')")
    @Plugin(name = "删除实体", sources = "Console", audit = true)
    public RestResult<?> delete(@RequestParam List<Integer> ids) {
        ${table.entityVarName}Service.delete${table.entityName}(ids);
        return RestResult.of("删除" + ids.size() + "条记录成功");
    }

}
