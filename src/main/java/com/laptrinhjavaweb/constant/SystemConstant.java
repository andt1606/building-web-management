package com.laptrinhjavaweb.constant;

import java.util.Arrays;
import java.util.List;

public class SystemConstant {
    /*Spring security 4: ROLE_ADMIN, Spring security 3 not required*/
    public static final String ADMIN_ROLE = "ROLE_ADMIN";
    /*Spring security 4: ROLE_ADMIN, Spring security 3 not required*/
    public static final String USER_ROLE = "ROLE_USER";
    public static final String MANAGER_ROLE = "MANAGER";
    public static final String STAFF_ROLE = "ROLE_STAFF";
    public static final String HOME = "/trang-chu";
    public static final String ADMIN_HOME = "/admin/home";
    public static final String INSERT_SUCCESS = "insert_success";
    public static final String UPDATE_SUCCESS = "update_success";
    public static final String DELETE_SUCCESS = "delete_success";
    public static final String ERROR_SYSTEM = "error_system";
    public static final String ALERT = "alert";
    public static final String MESSAGE_RESPONSE = "messageResponse";
    public static final String PASSWORD_DEFAULT = "123456";
    public static final String CHANGE_PASSWORD_FAIL = "change_password_fail";
    public static final String EMPTY_STRING = "";

    // Status
    public static final int ACTIVE_STATUS = 1;
    public static final int NO_ACTIVE_STATUS = 2;

    // Model
    public static final String MODEL = "model";
    public static final String SEARCH_MODEL = "modelSearch";
    public static final String BUILDINGS_MODEL = "buildings";
    public static final String DISTRICTS_MODEL = "districts";
    public static final String BUILDING_TYPES_MODEL = "buildingTypes";
    public static final String STAFFS_MODEL = "staffs";

    // Message for exception
    public static final String BUILDING_NOT_FOUND = "Building not found!";
    public static final String USER_NOT_FOUND = "User not found!";

    // For search
    public static final String BUILDING_SEARCH = "Building";
    public static final String BUILDING_ALIAS = "b.";
    public static final String EQUAL_OPERATOR = "=";
    public static final List<String> SPECIAL_PARAMS_FOR_BUILDING_SEARCH =
            Arrays.asList("buildingtypes", "rentareafrom", "rentareato", "rentpricefrom", "rentpriceto");
}
