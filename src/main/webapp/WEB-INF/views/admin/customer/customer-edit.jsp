<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>

<c:url var="customerAPI" value="/api/customer"/>
<c:url var="customerEditURL" value="/admin/customer-edit"/>
<c:url var="addTransactionAPI" value="/api/customer-add-transaction"/>

<%@ page import="com.laptrinhjavaweb.security.utils.SecurityUtils" %>


<html>
<head>
    <title>Chỉnh sửa tòa nhà</title>
</head>
<body>



<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="#">Home</a>
                </li>
                <li class="active">Dashboard</li>
            </ul><!-- /.breadcrumb -->

        </div>

        <div class="page-content">

            <div class="page-header">
                <h1>
                    Thông tin khách hàng
                </h1>
            </div><!-- /.page-header -->

            <div class="row">
                <c:set var = "cusId" scope = "session" value = "${modelEdit.id}"/>
                <c:if test = "${not empty cusId}">
                    <div class="col-sm-2">
                            <%--<c:choose>

                                <c:when test = "${modelEdit.id > 0}">
                                    <img class="img-responsive" src="${pageContext.request.contextPath}${modelEdit.thumbnail}" >
                                </c:when>

                                <c:otherwise>
                                    <img alt="Anh khi ko co" class="img-responsive" src="https://bootdey.com/img/Content/avatar/avatar7.png" >
                                </c:otherwise>
                            </c:choose>--%>
                        <img style="width: 100%;height: 260px" class="img-thumbnail" src="${pageContext.request.contextPath}${modelEdit.thumbnail}" >
                        <div class="row center " style="margin-top: 15px;">
                            <button style="width: 80%;" type="button" class="btn btn-primary " onclick="updateAvatar(${transactions.get(0).id})"  >Chỉnh sửa ảnh</button>
                        </div>
                    </div>
                </c:if>

                <div class="col-sm-10">

                    <form:form commandName="modelEdit" action="${buildingEditUrl}" id="formEdit" method="GET">
                        <div class="form-group">
                            <label class="col-sm-2  control-label no-padding-right"
                                   for="fullname" style="margin-bottom: 15px"> Tên đầy đủ</label>
                            <div class="col-sm-10" style="margin-bottom: 15px">
                                <form:input path="fullname" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right"
                                   for="phone" style="margin-bottom: 15px"> Số điện thoại</label>
                            <div class="col-sm-10" style="margin-bottom: 15px">
                                <form:input path="phone" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right"
                                   for="email" style="margin-bottom: 15px"> Email</label>
                            <div class="col-sm-10" style="margin-bottom: 15px">
                                <form:input path="email" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right"
                                   for="companyName" style="margin-bottom: 15px"> Tên công ty</label>
                            <div class="col-sm-10" style="margin-bottom: 15px">
                                <form:input path="companyName" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right"
                                   for="demand" style="margin-bottom: 15px"> Nhu cầu</label>
                            <div class="col-sm-10" style="margin-bottom: 15px">
                                <form:input path="demand" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right"
                                   for="note" style="margin-bottom: 15px"> Ghi chú</label>
                            <div class="col-sm-10" style="margin-bottom: 15px">
                                <form:input path="note" cssClass="form-control"/>
                            </div>
                        </div>

                        <div>
                            <form:hidden path="id" cssClass="col-xs-10 com-sm-12"></form:hidden>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right" ></label>

                            <div class="col-sm-10">
                                <button type="button" class="btn btn-primary" id="btnAddCustomer" >Cập nhật khách hàng</button>
                            </div>
                        </div>
                    </form:form>
                </div>

            </div><!-- /.row -->
            <br>
            <br>
            <br>
            <c:forEach var="item" items="${transactions}">
                <div class="page-header">
                    <h1 style="display: inline-block;vertical-align: middle" >
                        ${item.name}
                    </h1>
                    <button style="display: inline-block;" class="btn btn-white btn-info btn-bold " data-toggle="tooltip"
                            title="Thêm giao dịch" onclick="addTransaction(${item.id},'${item.code}',<%=SecurityUtils.getPrincipal().getId()%>)">
                        <i class="fa fa-plus-circle" aria-hidden="true"></i>
                    </button>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-bordered" id="222">
                            <thead>
                            <tr>
                                <th>Ngày tạo</th>
                                <th>Ghi chú</th>
                                <th>Người tạo</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="trans" items="${AllTransactionOfCustomer}">
                                <c:choose>
                                    <c:when test="${item.code == trans.code}">
                                        <tr>
                                            <td> ${trans.createdDate}</td>
                                            <td> ${trans.note} </td>
                                            <td> ${trans.staffName} </td>
                                        </tr>
                                    </c:when>
                                </c:choose>
                            </c:forEach>


                            </tbody>
                        </table>
                    </div>
                </div>
            </c:forEach>




            <%--<div class="page-header">
                <h1 style="display: inline-block;">
                    DẪN ĐI XEM
                </h1>
                <button style="display: inline-block;" class="btn btn-white btn-info btn-bold " data-toggle="tooltip" title="Thêm người dùng">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>
                </button>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <table class="table table-bordered" id="111">
                        <thead>
                        <tr>
                            <th>Ngày tạo</th>
                            <th>Ghi chú</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>10-11-2018</td>
                            <td>gọi điện và tư vấn</td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>--%>

        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->



<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
    <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
</a>
</div><!-- /.main-container -->


<div class="modal fade" id="addTransactionModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Thêm giao dịch</h4>
            </div>
            <div class="modal-body">
                <table class="table table-bordered" id="transactionNote">
                    <thead>
                    <tr>
                        <th>Ghi chú</th>
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input class="form-control" type="text" value="" id="noteTransactionId"/></td>
                        </tr>
                    </tbody>
                </table>
                <input type="hidden" id="code" name="code" value="">
                <input type="hidden" id="customerId" name="customerId" value="">
                <input type="hidden" id="staffId" name="staffId" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnAddTrans">Thêm giao dịch</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="updateAvatarModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Sửa ảnh đại diện</h4>
            </div>
            <div class="modal-body">



                <form id="file-upload-form" method="post" enctype="multipart/form-data">
                        <div class="file-upload">
                            <button class="file-upload-btn" type="button"
                                    onclick="$('.file-upload-input').trigger( 'click' )">Add Image
                            </button>

                            <div class="image-upload-wrap">


                                <input id="imgurl" class="file-upload-input" type='file' onchange="readURL(this);"
                                       accept="image/*" name="file" multiple/>


                                <div class="drag-text">
                                    <h3>Drag and drop a file or select add Image</h3>
                                </div>
                            </div>
                            <div class="file-upload-content">
                                <img class="file-upload-image" src="#" alt="your image"/>
                            </div>
                        </div>
                        <input type="hidden" id="customerIdOfAvatar" name="customerIdOfAvatar" value="">

                        <div class="modal-footer">
                        <button type="submit" class="btn btn-primary" id="btnAddAvatar">Cập nhật ảnh</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                        </div>
                </form>
            </div>


        </div>
    </div>
</div>

<script>
    $('#btnAddCustomer').click(function (e) {
        //jquery hỗ trợ serialize form tức lấy dữ liệu trong form bằng việc sử dụng name="" trong các element html
        e.preventDefault();
        var data = {};
        var buildingType = [];
        var formData = $('#formEdit').serializeArray();
        $.each(formData, function (index, v) {
                data[""+v.name+""] = v.value;
        });

        //call api add customer
        $.ajax({
            type: 'POST',
            url: '${customerAPI}',
            data: JSON.stringify(data),
            //trả từ server về client
            dataType: "json",
            //trả từ client về server
            contentType: "application/json",
            success: function (data) {
                //called when successful
                console.log("success");
                alert("Cập nhật khách hàng thành công");
                location.reload();
            },
            error: function (e) {
                //called when there is an error
                console.log(e.message);
            }
        });

    });


    function addTransaction(customerId, code,staffId){
        openModalAddTransaction();

        $('#customerId').val(customerId);
        console.log($('#customerId').val());

        $('#staffId').val(staffId);
        console.log($('#staffId').val());

        $('#code').val(code);
        console.log($('#code').val());
    }

    function openModalAddTransaction() {
        $('#addTransactionModal').modal();
    }

    $('#btnAddTrans').click(function (e) {
        e.preventDefault();
        var data = {};
        // var staffs = [];
        data['customerId'] = $('#customerId').val();
        data['staffId'] = $('#staffId').val();
        //$('#staffList').find('tbody input[type=checkbox]') // trỏ tới các input có type = checkbox trong staffList
        /*var note = $('#transactionNote').find('tbody input[type=text]').map(function () {
            //map là chỉ vô tưng checkbox lấy giá trị thôi chưa return đc
            return $(this).val();
        }).get();   // lấy các giá trị = hàm map*/
        data['code'] = $('#code').val();
        data['note'] = $('#noteTransactionId').val();
        //call api
        addTransactionCustomer(data);
    });

    function addTransactionCustomer(data) {
        $.ajax({
            type: 'POST',
            url: '${addTransactionAPI}',
            data: JSON.stringify(data),
            //trả từ server về client
            dataType: "json",
            //trả từ client về server
            contentType: "application/json",
            success: function (data) {
                //called when successful
                console.log("success");
                location.reload();
            },
            error: function (e) {
                //called when there is an error

                console.log("fail");
                console.log(e.message);
            }
        });
    }




    //AVATAR

    $(document).ready(function () {
        // bind form submit event
        $("#file-upload-form").on("submit", function (e) {

            // cancel the default behavior
            e.preventDefault();


            // use $.ajax() to upload file
            $.ajax({
                url: "/api/customer/"+$('#customerIdOfAvatar').val(),
                type: "POST",
                data: new FormData(this),
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: function (res) {
                    console.log(res);
                    location.reload();
                },
                error: function (err) {
                    console.error(err);
                }
            });
        });
    });

    function updateAvatar(customerId){
        openModalUpdateAvatar();

        $('#customerIdOfAvatar').val(customerId);
        console.log($('#customerIdOfAvatar').val());

    }
    function openModalUpdateAvatar() {
        $('#updateAvatarModal').modal();
    }

</script>

<script>
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('.image-upload-wrap').hide();
                $('.file-upload-image').attr('src', e.target.result);
                $('.file-upload-content').show();
                $('.image-title').html(input.files[0].name);
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            removeUpload();
        }
    }
    function removeUpload() {
        $('.file-upload-input').replaceWith($('.file-upload-input').clone());
        $('.file-upload-content').hide();
        $('.image-upload-wrap').show();
    }
    $('.image-upload-wrap').bind('dragover', function () {
        $('.image-upload-wrap').addClass('image-dropping');
    });
    $('.image-upload-wrap').bind('dragleave', function () {
        $('.image-upload-wrap').removeClass('image-dropping');
    });
</script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script class="jsbin" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<style>
    /* Chrome, Safari, Edge, Opera */
    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
    /* Firefox */
    input[type=number] {
        -moz-appearance: textfield;
    }

    .file-upload-btn {
        width: 100%;
        margin: 0;
        color: #fff;
        background: #1FB264;
        border: none;
        padding: 10px;
        border-radius: 4px;
        border-bottom: 4px solid #15824B;
        transition: all .2s ease;
        outline: none;
        text-transform: uppercase;
        font-weight: 700;
    }
    .file-upload-btn:hover {
        background: #1AA059;
        color: #ffffff;
        transition: all .2s ease;
        cursor: pointer;
    }
    .file-upload-btn:active {
        border: 0;
        transition: all .2s ease;
    }
    .file-upload-content {
        display: none;
        text-align: center;
    }
    .file-upload-input {
        position: absolute;
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
        outline: none;
        opacity: 0;
        cursor: pointer;
    }
    .image-upload-wrap {
        margin-top: 20px;
        border: 4px dashed #1FB264;
        position: relative;
    }
    .image-dropping,
    .image-upload-wrap:hover {
        background-color: #1FB264;
        border: 4px dashed #ffffff;
    }
    .image-title-wrap {
        padding: 0 15px 15px 15px;
        color: #222;
    }
    .drag-text {
        text-align: center;
    }
    .drag-text h3 {
        font-weight: 100;
        text-transform: uppercase;
        color: #15824B;
        padding: 60px 0;
    }
    .file-upload-image {
        max-height: 200px;
        max-width: 200px;
        margin: auto;
        padding: 20px;
    }
    .remove-image {
        width: 200px;
        margin: 0;
        color: #fff;
        background: #cd4535;
        border: none;
        padding: 10px;
        border-radius: 4px;
        border-bottom: 4px solid #b02818;
        transition: all .2s ease;
        outline: none;
        text-transform: uppercase;
        font-weight: 700;
    }
    .remove-image:hover {
        background: #c13b2a;
        color: #ffffff;
        transition: all .2s ease;
        cursor: pointer;
    }
    .remove-image:active {
        border: 0;
        transition: all .2s ease;
    }
</style>

</body>
</html>







<%--
$('#btnAddAvatar').click(function (e) {
e.preventDefault();
var customerId = $('#customerIdOfAvatar').val();
var data = new FormData(document.getElementById("imgurl"));

//call api
addAvatarCustomer(data, customerId);
});

function addAvatarCustomer(data, customerId) {
$.ajax({
url: "/customer/"+customerId,
type: 'POST',
data: data,
enctype: 'multipart/form-data',
processData: false, // tell jQuery not to process the data
contentType: false, // tell jQuery not to set contentType
cache: false,

success: function(res) {
console.log(res);
},

error: function(res) {
console.log('ERR: ' + res);
}
});
}--%>
