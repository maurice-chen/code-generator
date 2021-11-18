package ${basePackage}.service;

import ${basePackage}.dao.${table.entityName}Dao;
import ${basePackage}.entity.${table.entityName};

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.dactiv.framework.commons.page.Page;
import com.github.dactiv.framework.commons.page.PageRequest;

import com.github.dactiv.framework.spring.web.query.mybatis.MybatisPlusQueryGenerator;

import java.util.*;

/**
 *
 * ${table.tableName} 的业务逻辑
 *
 * <p>Table: ${table.tableName} - ${table.tableComment}</p>
 *
 * @see ${table.entityName}
 *
 * @author ${author}
 *
 * @since ${.now}
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ${table.entityName}Service extends ServiceImpl<${table.entityName}Dao, ${table.entityName}> {

    /**
     * 查找 table : ${table.tableName} 实体分页数据
     *
     * @param pageRequest 分页请求
     * @param wrapper     过滤条件
     *
     * @return 分页实体
     *
     * @see ${table.entityName}
     */
    public Page<${table.entityName}> find${table.entityName}Page(PageRequest pageRequest, Wrapper<${table.entityName}> wrapper) {

        IPage<${table.entityName}> result = getBaseMapper().selectPage(
            MybatisPlusQueryGenerator.createQueryPage(pageRequest),
            wrapper
        );

        return MybatisPlusQueryGenerator.convertResultPage(result);
    }

}
