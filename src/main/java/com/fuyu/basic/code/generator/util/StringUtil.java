package com.fuyu.basic.code.generator.util;


import org.apache.commons.lang3.StringUtils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil extends StringUtils {

    private static Pattern linePattern = Pattern.compile("_(\\w)");

    public static String lineToHump(String str) {
        return lineToHump(str, false);
    }

    public static String lineToHump(String str, boolean fristUpperCase) {
        str = str.toLowerCase();
        Matcher matcher = linePattern.matcher(str);
        StringBuffer sb = new StringBuffer();
        while (matcher.find()) {
            matcher.appendReplacement(sb, matcher.group(1).toUpperCase());
        }
        matcher.appendTail(sb);
        if (fristUpperCase) {
            String fristWord = sb.substring(0, 1).toUpperCase();
            sb.replace(0, 1, fristWord);
        }
        return sb.toString();
    }

}
