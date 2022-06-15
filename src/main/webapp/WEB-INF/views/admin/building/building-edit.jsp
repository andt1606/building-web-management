<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="buildingAPI" value="/api/building"/>
<c:url var="buildingEditURL" value="/admin/building-edit"/>
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

            <%--<div class="page-header">
                <h1>
                    Dashboard
                    <small>
                        <i class="ace-icon fa fa-angle-double-right"></i>
                        overview &amp; stats
                    </small>
                </h1>
            </div><!-- /.page-header -->
--%>
            <div class="row">

                <c:set var = "builId" scope = "session" value = "${modelEdit.id}"/>
                <c:if test = "${not empty builId}">
                    <div class="col-sm-3">
                        <img style="width: 100%;height: 360px" class="img-thumbnail" src="${pageContext.request.contextPath}${modelEdit.avatar}" >
                        <div class="row center " style="margin-top: 15px;">
                            <button style="width: 80%;" type="button" class="btn btn-primary " onclick="updateAvatarBuilding(${builId})"  >Chỉnh sửa ảnh</button>
                        </div>
                    </div>
                </c:if>


                <div class="col-sm-9">
<%--                    <form class="form-horizontal" role="form" id="formEdit">--%>
                    <form:form commandName="modelEdit" action="${buildingEditUrl}" id="formEdit" method="GET">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="name" style="margin-bottom: 15px"> Tên tòa nhà</label>
                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="name" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="district" style="margin-bottom: 15px"> Quận</label>
                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:select  path="district">
                                    <form:options items="${districtmaps}"/>
                                </form:select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="ward" style="margin-bottom: 15px"> Phường</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="ward" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="street" style="margin-bottom: 15px"> Đường</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="street" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="structure" style="margin-bottom: 15px"> Kết cấu</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="structure" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="numberOfBasement" style="margin-bottom: 15px"> Số tầng hầm</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <input type="number" id="numberOfBasement" class="form-control"
                                       name="numberOfBasement" value="${modelEdit.numberOfBasement}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="floorArea" style="margin-bottom: 15px"> Diện tích sàn</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <input type="number" id="floorArea"  class="form-control" name="floorArea" value="${modelEdit.floorArea}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="direction" style="margin-bottom: 15px"> Hướng</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="direction" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="level" style="margin-bottom: 15px"> Hạng</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="level" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="rentArea" style="margin-bottom: 15px"> Diện tích thuê</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="rentArea" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group" >
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="rentAreaDescription" style="margin-bottom: 15px"> Mô tả diện tích</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="rentAreaDescription" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="rentPrice" style="margin-bottom: 15px"> Giá thuê</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <input type="number" id="rentPrice"  class="form-control" name="rentPrice" value="${modelEdit.rentPrice}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="rentPriceDescription" style="margin-bottom: 15px"> Mô tả giá thuê</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="rentPriceDescription" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="serviceFee" style="margin-bottom: 15px"> Phí dịch vụ</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="serviceFee" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="carFee" style="margin-bottom: 15px"> Phí ô tô</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="carFee" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="motoFee" style="margin-bottom: 15px"> Phí mô tô</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="motoFee" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="overtimeFee" style="margin-bottom: 15px"> Phí ngoài giờ </label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="overtimeFee" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="electricityFee" style="margin-bottom: 15px"> Tiền điện </label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="electricityFee" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="deposit" style="margin-bottom: 15px"> Đặt cọc </label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="deposit" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="payment"  style="margin-bottom: 15px"> Thanh toán</label>

                            <div class="col-sm-9"  style="margin-bottom: 15px">
                                <form:input path="payment" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="rentTime" style="margin-bottom: 15px"> Thời hạn thuê</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="rentTime" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="decorationTime" style="margin-bottom: 15px"> Thời gian trang trí</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="decorationTime" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="managerName" style="margin-bottom: 15px"> Tên chủ tòa nhà</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="managerName" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="managerPhone" style="margin-bottom: 15px"> Số điện thoại quản lý</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="managerPhone" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="brokerageFee" style="margin-bottom: 15px"> Phí môi giới</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <input type="number" id="brokerageFee"  class="form-control" name="brokerageFee" value="${modelEdit.brokerageFee}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="buildingType" style="margin-bottom: 15px"> Loại tòa nhà </label>

                            <div class="col-sm-9"  style="margin-bottom: 15px">
                                    <form:checkboxes path="buildingType" items="${buildingTypesMap}"/>
<%--                                <c:forEach var="item" items="buildingTypesMap">--%>
<%--                                    ${}--%>
<%--                                </c:forEach>--%>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="note" style="margin-bottom: 15px"> Ghi chú</label>

                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="note" cssClass="form-control"/>
                            </div>
                        </div>

                        <div>
                            <form:hidden path="id" cssClass="col-xs-10 com-sm-12"></form:hidden>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" ></label>

                            <div class="col-sm-9">
                                <button type="button" class="btn btn-primary" id="btnAddBuilding" >Cập nhật tòa nhà</button>
                                <button type="button" class="btn btn-primary">Hủy</button>
                            </div>
                        </div>

                    </form:form>
                </div>

            </div><!-- /.row -->

        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->



<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
    <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
</a>
</div><!-- /.main-container -->


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
    $('#btnAddBuilding').click(function (e) {
        //jquery hỗ trợ serialize form tức lấy dữ liệu trong form bằng việc sử dụng name="" trong các element html
        e.preventDefault();
        var data = {};
        var buildingType = [];
        var formData = $('#formEdit').serializeArray();
        $.each(formData, function (index, v) {
            if(v.name === 'buildingType'){
                buildingType.push(v.value);
            }else{
                data[""+v.name+""] = v.value;
            }
        });
        data['buildingType'] = buildingType;
        // làm băng tay
        // data['name'] = 'abc';
        // data['numberOfBasement'] = 100;
        // data['areaRent'] = '100,200,300';
        // buildingTypes.push('TANG-TRET');
        // buildingTypes.push('NGUYEN-CAN');
        // data['buildingTypes'] = buildingTypes;

        // $.each(formData, function (index, v) {
        //         data[""+v.name+""] = v.value;
        // });


        //call api add building
        $.ajax({
            type: 'POST',
            url: '${buildingAPI}',
            data: JSON.stringify(data),
            //trả từ server về client
            dataType: "json",
            //trả từ client về server
            contentType: "application/json",
            success: function (data) {
                //called when successful
                console.log("success");
                alert("Cập nhật tòa nhà thành công");
                location.reload();
            },
            error: function (e) {
                //called when there is an error
                console.log(e.message);
            }
        });

    });

    function updateAvatarBuilding(buildingId){
        openModalUpdateAvatar();

        $('#customerIdOfAvatar').val(buildingId);
        console.log($('#customerIdOfAvatar').val());

    }
    function openModalUpdateAvatar() {
        $('#updateAvatarModal').modal();
    }

    //AVATAR
    $(document).ready(function () {
        // bind form submit event
        $("#file-upload-form").on("submit", function (e) {

            // cancel the default behavior
            e.preventDefault();


            // use $.ajax() to upload file
            $.ajax({
                url: "/api/building/"+$('#customerIdOfAvatar').val(),
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
