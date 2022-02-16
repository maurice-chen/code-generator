package com.github.maurice.code.generator.execute;

import com.github.maurice.code.generator.model.Table;
import com.github.maurice.code.generator.JavaCodeProperties;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Component
public class TemplateHandler {

    private final static Logger LOGGER = LoggerFactory.getLogger(TemplateHandler.class);

    private static final String DEFAULT_ENCODING = "UTF-8";

    private Configuration configuration;

    @Autowired
    private JavaCodeProperties javaCodeProperties;

    @PostConstruct
    private void init() throws Exception {
        configuration = new Configuration(Configuration.VERSION_2_3_29);
        configuration.setClassForTemplateLoading(TemplateHandler.class, "/templates");
        configuration.setSetting("default_encoding", DEFAULT_ENCODING);
        configuration.setSetting("url_escaping_charset", DEFAULT_ENCODING);
        configuration.setSetting("datetime_format", "yyyy-MM-dd hh:mm:ss");
        configuration.setSetting("date_format", "yyyy-MM-dd");
        configuration.setSetting("time_format", "HH:mm:ss");
        configuration.setSetting("number_format", "0.######;");
    }

    private Map<String,Object> buildParams(Table table) {
        Map<String, Object> params = new HashMap<>(8);
        params.put("basePackage", javaCodeProperties.getBasePackage());
        params.put("ignoreProperties", javaCodeProperties.getIgnoreProperties());
        params.put("author", javaCodeProperties.getAuthor());
        params.put("urlPrefix", javaCodeProperties.getUrlPrefix());
        params.put("table", table);
        params.put("uuid", UUID.randomUUID().toString());
        return params;
    }


    public void genEntity(String targetDic, Table table) throws Exception {
        Map<String, Object> params = buildParams(table);

        Template template = configuration.getTemplate("entity.ftl");

        String dicPath = targetDic + File.separator + "entity";
        File dic = new File(dicPath);
        if (!dic.exists()) {
            dic.mkdirs();
        }
        String filePath  = dicPath + File.separator + table.getEntityName() + "Entity.java";
        createFile(table, params, template, filePath);
    }

    private void createFile(Table table, Map<String, Object> params, Template template, String filePath) throws IOException, TemplateException {
        File file = new File(filePath);
        FileWriter fw = new FileWriter(file);
        //StringWriter fw = new StringWriter();
        BufferedWriter bw = new BufferedWriter(fw);
        template.process(params, bw);
        bw.flush();
        fw.flush();
        bw.close();
        fw.close();
        LOGGER.info("【生成文件】表名[{}]路径[{}]", table.getTableName(), filePath);
    }


    public void genMapperXml(String targetDic, Table table) throws Exception {
        Map<String, Object> params = buildParams(table);

        Template template = configuration.getTemplate("mapper.ftl");

        String dicPath = targetDic + File.separator + "mapper";
        File dic = new File(dicPath);
        if (!dic.exists()) {
            dic.mkdirs();
        }

        String fileName = table.getTableName();
        if (StringUtils.isNotBlank(javaCodeProperties.getStripPrefix())) {
            fileName = fileName.replace(javaCodeProperties.getStripPrefix(), "");
        }
        fileName = fileName.replaceAll("_", "-");
        String filePath  = dicPath + File.separator + fileName + "-mapper.xml";
        createFile(table, params, template, filePath);
    }

    public void genIncludeMapperXml(String targetDic, List<Table> tables) throws Exception {
        Table table = tables.get(0);

        Map<String, Object> params = buildParams(table);
        params.put("tables", tables);
        Template template = configuration.getTemplate("include-mapper.ftl");

        String dicPath = targetDic + File.separator + "mapper" + File.separator + "commons";

        File dic = new File(dicPath);
        if (!dic.exists()) {
            dic.mkdirs();
        }

        String filePath  = dicPath + File.separator  + "include-mapper.xml";
        createFile(table, params, template, filePath);
    }

    public void genService(String targetDic, Table table) throws Exception {
        Map<String, Object> params = buildParams(table);

        Template template = configuration.getTemplate("service.ftl");

        String dicPath = targetDic + File.separator + "service";
        File dic = new File(dicPath);
        if (!dic.exists()) {
            dic.mkdirs();
        }
        String filePath  = dicPath + File.separator + table.getEntityName() + "Service.java";
        createFile(table, params, template, filePath);
    }

    public void genDao(String targetDic, Table table) throws Exception {
        Map<String, Object> params = buildParams(table);

        Template template = configuration.getTemplate("dao.ftl");

        String dicPath = targetDic + File.separator + "dao";
        File dic = new File(dicPath);
        if (!dic.exists()) {
            dic.mkdirs();
        }
        String filePath  = dicPath + File.separator + table.getEntityName() + "Dao.java";
        createFile(table, params, template, filePath);
    }

    public void genController(String targetDic, Table table) throws Exception {
        Map<String, Object> params = buildParams(table);

        Template template = configuration.getTemplate("controller.ftl");

        String dicPath = targetDic + File.separator + "controller";
        File dic = new File(dicPath);
        if (!dic.exists()) {
            dic.mkdirs();
        }
        String filePath  = dicPath + File.separator + table.getEntityName() + "Controller.java";

        createFile(table, params, template, filePath);
    }

    public void genDoc(String targetDic, Table table) throws Exception {
        Map<String, Object> params = buildParams(table);

        Template template = configuration.getTemplate("apifox.ftl");
        String dicPath = targetDic + File.separator + "doc";
        File dic = new File(dicPath);
        if (!dic.exists()) {
            dic.mkdirs();
        }
        String filePath  = dicPath + File.separator + table.getEntityName() + "Doc.json";

        createFile(table, params, template, filePath);
    }
}
