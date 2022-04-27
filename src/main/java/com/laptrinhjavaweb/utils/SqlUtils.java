package com.laptrinhjavaweb.utils;

public class SqlUtils {
    public static String buildQueryUsingLike(String prefix, String column, String value) {
        return (!ValidateUtils.isValidProperty(value)) ? ""
                : String.format("%nAND "+prefix+".%s LIKE %s", column, "'%" + value + "%'");
    }

}
