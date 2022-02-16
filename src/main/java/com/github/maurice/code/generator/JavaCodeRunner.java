package com.github.maurice.code.generator;

import com.github.maurice.code.generator.execute.TableHandler;
import com.github.maurice.code.generator.model.Table;
import com.github.maurice.code.generator.execute.TemplateHandler;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class JavaCodeRunner implements CommandLineRunner {

    private static final Logger LOGGER = LoggerFactory.getLogger(JavaCodeRunner.class);

    @Autowired
    private TableHandler tableHandler;
    @Autowired
    private TemplateHandler templateHandler;

    @Autowired
    private JavaCodeProperties javaCodeProperties;

    @Override
    public void run(String... args) throws Exception {

        StringBuilder targetDic = new StringBuilder();
        targetDic.append(System.getProperty("user.dir"));
        targetDic.append(File.separator).append("output");

        //删除输出文件夹
        File dic = new File(targetDic.toString());
        if (dic.exists() && dic.isDirectory()) {
            FileUtils.deleteDirectory(dic);
        }

        targetDic.append(File.separator).append("src");
        targetDic.append(File.separator).append("main");
        //targetDic.append(File.separator);

        String baseDic = javaCodeProperties.getBasePackage().replace(".", File.separator);
        StringBuilder javaDic = new StringBuilder(targetDic.toString());
        javaDic.append(File.separator).append("java").append(File.separator).append(baseDic);

        StringBuilder resDic = new StringBuilder(targetDic.toString());
        resDic.append(File.separator).append("resources");

        try {

            List<Table> includeMapperTableList = new ArrayList<>();

            for (String tableName : javaCodeProperties.getTableNames()) {
                //获取表信息
                Table table = tableHandler.getTableInfo(tableName);
                if (table == null) {
                    continue;
                }

                //生成实体类
                if (javaCodeProperties.isGenEntity()) {
                    templateHandler.genEntity(javaDic.toString(), table);
                }

                //生成 数据层
                if (javaCodeProperties.isGenDao()) {
                    templateHandler.genDao(javaDic.toString(), table);
                }

                //生成 XML
                if (javaCodeProperties.isGenMapperXml()) {
                    templateHandler.genMapperXml(resDic.toString(), table);
                    includeMapperTableList.add(table);
                }

                //生成Service
                if (javaCodeProperties.isGenService()) {
                    templateHandler.genService(javaDic.toString(), table);
                }

                //生成Controller
                if (javaCodeProperties.isGenController()) {
                    templateHandler.genController(javaDic.toString(), table);
                }

                //生成Doc
                if (javaCodeProperties.isGenDoc()) {
                    templateHandler.genDoc(resDic.toString(), table);
                }

            }
            //生成 公共引入XML
            if (javaCodeProperties.isGenMapperXml() && CollectionUtils.isNotEmpty(includeMapperTableList)) {
                templateHandler.genIncludeMapperXml(resDic.toString(), includeMapperTableList);
            }
        } catch (Exception e) {
            LOGGER.error("生成出错", e);
        }

    }


}
