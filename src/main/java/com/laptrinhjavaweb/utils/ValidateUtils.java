package com.laptrinhjavaweb.utils;

import com.laptrinhjavaweb.constant.SystemConstant;

import java.lang.reflect.Field;
import java.util.Collection;

public class ValidateUtils {

    public static <T> boolean isValidObject(T object) throws IllegalAccessException {
        Field[] fields = object.getClass().getDeclaredFields();

        for (Field field : fields) {
            field.setAccessible(true);
            Object objectValue = field.get(object);

            if (objectValue != null && objectValue != "") {
                return true;
            }
        }

        return false;
    }


    public static boolean isValid(Object object){
        boolean isTrue = null != object && !SystemConstant.EMPTY_STRING.equals(object);
        if(isTrue){
            if(object instanceof String){
                return true;
            } else if(object instanceof Integer){
                return Integer.parseInt(object.toString()) > 0;
            }
        }
        return false;
    }


    public static boolean isValidProperty(Object obj) {
        boolean isTrue = null != obj && !SystemConstant.EMPTY_STRING.equals(obj.toString());

        if (isTrue) {
            if (obj instanceof String || StringBuilder.class.equals(obj.getClass())) {
                return true;
            } else if (obj instanceof Integer) {
                return 0 <= Integer.parseInt(obj.toString());
            } else if (obj instanceof Double) {
                return 0 <= Double.parseDouble(obj.toString());
            } else if (obj instanceof Long) {
                return 0 <= Long.parseLong(obj.toString());
            } else if (obj instanceof Collection) {
                return !((Collection<?>) obj).isEmpty();
            }
        }

        return false;
    }
}
