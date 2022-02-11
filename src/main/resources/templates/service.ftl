package ${basePackage}.service;

import ${basePackage}.dao.${table.entityName}Dao;
import ${basePackage}.entity.${table.entityName}Entity;

import com.github.dactiv.framework.mybatis.plus.service.BasicService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * ${table.tableName} 的业务逻辑
 *
 * <p>Table: ${table.tableName} - ${table.tableComment}</p>
 *
 * @see ${table.entityName}Entity
 *
 * @author ${author}
 *
 * @since ${.now}
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ${table.entityName}Service extends BasicService<${table.entityName}Dao, ${table.entityName}Entity> {

}
