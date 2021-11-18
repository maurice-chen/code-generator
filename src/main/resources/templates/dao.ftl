package ${basePackage}.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ${basePackage}.dao.entity.${table.entityName};
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * ${table.tableName} 的数据访问
 *
 * <p>Table: ${table.tableName} - ${table.tableComment}</p>
 *
 * @see ${table.entityName}
 *
 * @author ${author}
 *
 * @since ${.now}
 */
@Mapper
@Repository
public interface ${table.entityName}Dao extends BaseMapper<${table.entityName}> {

}
