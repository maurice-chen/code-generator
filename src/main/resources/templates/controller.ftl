package ${basePackage}.controller;

import com.github.dactiv.basic.authentication.domain.entity.DepartmentEntity;
import com.github.dactiv.basic.authentication.service.DepartmentService;
import com.github.dactiv.basic.commons.enumeration.ResourceSourceEnum;
import com.github.dactiv.framework.commons.RestResult;
import com.github.dactiv.framework.commons.page.Page;
import com.github.dactiv.framework.commons.page.PageRequest;
import com.github.dactiv.framework.mybatis.plus.MybatisPlusQueryGenerator;
import com.github.dactiv.framework.security.enumerate.ResourceType;
import com.github.dactiv.framework.security.plugin.Plugin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

import ${basePackage}.entity.${table.entityName}Entity;
import ${basePackage}.service.${table.entityName}Service;


/**
 *
 * ${table.tableName} 的控制器
 *
 * <p>Table: ${table.tableName} - ${table.tableComment}</p>
 *
 * @see ${table.entityName}Entity
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
    sources = ResourceSourceEnum.CONSOLE_SOURCE_VALUE
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
    @Plugin(name = "获取分页", sources = ResourceSourceEnum.CONSOLE_SOURCE_VALUE)
    @PreAuthorize("hasAuthority('perms[${table.pluginName}:page]')")
    public Page<${table.entityName}> page(PageRequest pageRequest, HttpServletRequest request) {
        return ${table.entityVarName}Service.findPage(
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
    @Plugin(name = "获取实体", sources = ResourceSourceEnum.CONSOLE_SOURCE_VALUE)
    public ${table.entityName} get(@PathVariable("id") Integer id) {
        return ${table.entityVarName}Service.get(id);
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
    @Plugin(name = "保存实体", sources = ResourceSourceEnum.CONSOLE_SOURCE_VALUE, audit = true)
    public RestResult<Integer> save(@Valid ${table.entityName} entity) {
        ${table.entityVarName}Service.save(entity);
        return RestResult.ofSuccess("保存成功", entity.getId());
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
    @Plugin(name = "删除实体", sources = ResourceSourceEnum.CONSOLE_SOURCE_VALUE, audit = true)
    public RestResult<?> delete(@RequestParam List<Integer> ids) {
        ${table.entityVarName}Service.deleteById(ids);
        return RestResult.of("删除" + ids.size() + "条记录成功");
    }

}
