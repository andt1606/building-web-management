<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="changePasswordURL" value="/api/user/change-password"/>
<html>
<head>
    <title>Đổi mật khẩu</title>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>
            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="#">Trang chủ</a>
                </li>
                <li class="active">Đổi mật khẩu</li>
            </ul><!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <c:if test="${not empty messageResponse}">
                        <div class="alert alert-block alert-${alert}">
                            <button type="button" class="close" data-dismiss="alert">
                                <i class="ace-icon fa fa-times"></i>
                            </button>
                                ${messageResponse}
                        </div>
                    </c:if>
                    <div class="change-password-title"> Đổi mật khẩu</div>
                    <div id="profile">
                        <form:form id="formChangePassword" class="form-horizontal" name="formChangePassword">

                            <div class="form-group">
                                    <div class="col-sm-12 input-password-container">
                                        <div class="col-sm-3 text-right align-middle input_password-text">
                                            <%--<spring:message code="label.password.old"/>--%>
                                        Mật khẩu cũ:
                                        </div>
                                        <div class="col-sm-4">
                                        <input type="password" class="form-control input_password" id="oldPassword" name="oldPassword" placeholder="--Nhập mật khẩu cũ--"/>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 input-password-container">
                                            <%--<spring:message code="label.password.new"/>--%>
                                                <div class="col-sm-3  text-right align-middle input_password-text">
                                        Mật khẩu mới:
                                                </div>
                                        <div class="col-sm-4">
                                            <input type="password" class="form-control input_password" id="newPassword" name="newPassword" placeholder="--Nhập mật khẩu mới--"/>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 input-password-container">
                                            <%--<spring:message code="label.password.repeat"/>--%>
                                        <div class="col-sm-3 text-right align-middle input_password-text">
                                            Xác nhận mật khẩu:
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="password" class="form-control input_password" id="confirmPassword" name="confirmPassword" placeholder="--Xác nhận mật khẩu mới--"/>
                                        </div>
                                    </div>
                            </div>

                            <!--Btn-->
                            <div class="text-center">
                                <button type="button" class="btn btn-primary" id="btnChangePassword">Đổi mật khẩu</button>
                            </div>
                            <!--Btn-->
                            <input type="hidden" value="${model.id}" id="userId"/>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('#btnChangePassword').click(function () {
                $('#formChangePassword').submit();
            });
        });
        $(function() {
            $("form[name='formChangePassword']").validate({
                rules: {
                    oldPassword: "required",
                    newPassword: {
                        required: true,
                        minlength: 6
                    },
                    confirmPassword: "required"
                },
                messages: {
                    oldPassword: "Không bỏ trống",
                    newPassword: {
                        required: "Không bỏ trống",
                        minlength: "Mật khẩu tối thiểu 6 kí tự"
                    },
                    confirmPassword: "Không bỏ trống"
                },
                submitHandler: function(form) {
                    var formData = $('#formChangePassword').serializeArray();
                    var dataArray = {};
                    $.each(formData, function (i, v) {
                        dataArray["" + v.name + ""] = v.value;
                    });
                    changePassword(dataArray, $('#userId').val());
                }
            });
        });

        function changePassword(data, id) {
            $.ajax({
                url: '${changePasswordURL}/'+id,
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (res) {
                    if (res == 'update_success') {
                        window.location.href = "<c:url value='/admin/profile-password?message=update_success'/>";
                    } else if (res == 'change_password_fail') {
                        window.location.href = "<c:url value='/admin/profile-password?message=change_password_fail'/>";
                    }
                },
                error: function (res) {
                    console.log(res);
                    window.location.href = "<c:url value='/admin/profile-password?message=error_system'/>";
                }
            });
        }
    </script>
</div>
</body>
</html>
