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

            <div class="page-header">
                <h1>
                    Dashboard
                    <small>
                        <i class="ace-icon fa fa-angle-double-right"></i>
                        overview &amp; stats
                    </small>
                </h1>
            </div><!-- /.page-header -->

            <div class="row">
                <div class="col-sm-12">
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
                                   for="managerName" style="margin-bottom: 15px"> Tên quản lý</label>

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
</script>


</body>
</html>
