package ${basePackage}.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.dactiv.framework.commons.RestResult;
import com.github.dactiv.framework.commons.id.IdEntity;
import com.github.dactiv.framework.commons.page.Page;
import com.github.dactiv.framework.commons.page.PageRequest;
import com.github.dactiv.framework.mybatis.plus.MybatisPlusQueryGenerator;
import com.github.dactiv.framework.security.enumerate.ResourceType;
import com.github.dactiv.framework.security.plugin.Plugin;
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

    private final ${table.entityName}Service ${table.entityVarName}Service;

    private final MybatisPlusQueryGenerator<${table.entityName}Entity> queryGenerator;

    public ${table.entityName}Controller(MybatisPlusQueryGenerator<${table.entityName}Entity> queryGenerator,
                                         ${table.entityName}Service ${table.entityVarName}Service) {
        this.${table.entityVarName}Service = ${table.entityVarName}Service;
        this.queryGenerator = queryGenerator;
    }

    /**
     * 获取 table: ${table.tableName} 实体集合
     *
     * @param request  http servlet request
     *
     * @return ${table.tableName} 实体集合
     *
     * @see ${table.entityName}Entity
    */
    @PostMapping("find")
    @PreAuthorize("isAuthenticated()")
    public List<${table.entityName}Entity> find(HttpServletRequest request) {
        QueryWrapper<${table.entityName}Entity> query = queryGenerator.getQueryWrapperByHttpRequest(request);
        query.orderByDesc(IdEntity.ID_FIELD_NAME);
        return ${table.entityVarName}Service.find(query);
    }

    /**
     * 获取 table: ${table.tableName} 分页信息
     *
     * @param pageRequest 分页信息
     * @param request  http servlet request
     *
     * @return 分页实体
     *
     * @see ${table.entityName}Entity
     */
    @PostMapping("page")
    @Plugin(name = "首页展示")
    @PreAuthorize("hasAuthority('perms[${table.pluginName}:page]')")
    public Page<${table.entityName}Entity> page(PageRequest pageRequest, HttpServletRequest request) {
        QueryWrapper<${table.entityName}Entity> query = queryGenerator.getQueryWrapperByHttpRequest(request);
        query.orderByDesc(IdEntity.ID_FIELD_NAME);
        return ${table.entityVarName}Service.findPage(pageRequest, query);
    }

    /**
     * 获取 table: ${table.tableName} 实体
     *
     * @param id 主键 ID
     *
     * @return ${table.tableName} 实体
     *
     * @see ${table.entityName}Entity
     */
    @GetMapping("get")
    @PreAuthorize("hasAuthority('perms[${table.pluginName}:get]')")
    @Plugin(name = "编辑信息")
    public ${table.entityName}Entity get(@RequestParam Integer id) {
        return ${table.entityVarName}Service.get(id);
    }

    /**
     * 保存 table: ${table.tableName} 实体
     *
     * @param entity ${table.tableName} 实体
     *
     * @see ${table.entityName}Entity
     */
    @PostMapping("save")
    @PreAuthorize("hasAuthority('perms[${table.pluginName}:save]')")
    @Plugin(name = "保存或添加信息", audit = true,operationDataTrace = true)
    public RestResult<Integer> save(@Valid @RequestBody ${table.entityName}Entity entity) {
        ${table.entityVarName}Service.save(entity);
        return RestResult.ofSuccess("保存成功", entity.getId());
    }

    /**
     * 删除 table: ${table.tableName} 实体
     *
     * @param ids 主键 ID 值集合
     *
     * @see ${table.entityName}Entity
     */
    @PostMapping("delete")
    @PreAuthorize("hasAuthority('perms[${table.pluginName}:delete]')")
    @Plugin(name = "删除信息", audit = true,operationDataTrace = true)
    public RestResult<?> delete(@RequestParam List<Integer> ids) {
        ${table.entityVarName}Service.deleteById(ids);
        return RestResult.of("删除" + ids.size() + "条记录成功");
    }

}
