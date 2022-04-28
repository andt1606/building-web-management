<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="buildingListUrl" value="/admin/building-list"/>
<%--<c:url var="buildingSearchUrl" value="/admin/building-search"/>--%>
<c:url var="loadStaffAPI" value="/api/building"/>
<c:url var="buildingAPI" value="/api/building"/>
<c:url var="buildingEditUrl" value="/admin/building-edit"/>
<c:url var="buildingAssignmentAPI" value="/api/building-assignment"/>
<html>
<head>
    <title>Title</title>
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
                    <div class="widget-box">

                        <div class="widget-header">

                            <h4 class="widget-title">Tìm kiếm</h4>

                            <div class="widget-toolbar">
                                <a href="#" data-action="collapse">
                                    <i class="ace-icon fa fa-chevron-up"></i>
                                </a>

                            </div>
                        </div>
                        <div class="widget-body">
                            <div class="widget-main">

                                <!-- form cua spring, xài thì mấy cái bên dưới cũng ngon như input ấy path = name + value-->
                                <form:form commandName="modelSearch" action="${buildingListUrl}" id="listForm" method="GET">

                                    <div class="form-horizontal">
                                        <div class="form-group">

                                            <div class="col-sm-6">
                                                <div>
                                                    <label for="name">Tên sản phẩm</label>

<%--                                                    <input type="text" id="name" class="form-control" name="name" value="${modelSearch.name}"/>--%>
                                                    <!-- form-control là độ dài tới max nhưng trong sm-6 nên max trong 6 cột -->
                                                    <form:input path="name" cssClass="form-control"/>

                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div>
                                                    <label for="floorArea">Diện tích sàn</label>

                                                    <input type="number" id="floorArea" class="form-control" name="floorArea" value="${modelSearch.floorArea}"/>
                                                </div>
                                            </div>


                                        </div><!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-sm-4">
                                                <label for="district">Quận hiện có</label>

                                                <form:select path="district">
                                                    <form:option value="" label="---Chọn quận---"/>
                                                    <form:options items="${districtmaps}"/>
                                                </form:select>


                                            </div>
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="ward">Phường</label>
<%--                                                    <input type="text" id="ward" class="form-control" name="ward">--%>
                                                    <form:input path="ward" cssClass="form-control"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="street">Đường</label>
<%--                                                    <input type="text" id="street" class="form-control" name="street">--%>
                                                    <form:input path="street" cssClass="form-control"/>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="form-group">
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="numberOfBasement">Số tầng hầm</label>
                                                    <input type="number" id="numberOfBasement" class="form-control"
                                                           name="numberOfBasement" value="${modelSearch.numberOfBasement}">
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="direction">Hướng</label>
                                                    <form:input path="direction" cssClass="form-control"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="level">Hạng</label>
                                                    <form:input path="level" cssClass="form-control"/>
                                                </div>
                                            </div>

                                        </div>


                                        <div class="form-group">
                                            <div class="col-sm-3">
                                                <div>
                                                    <label for="rentAreaFrom">Diện tích từ</label>
                                                    <input type="number" id="rentAreaFrom" class="form-control"
                                                           name="rentAreaFrom" value="${modelSearch.rentAreaFrom}">
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div>
                                                    <label for="rentAreaTo">Diện tích đến</label>
                                                    <input type="number" id="rentAreaTo" class="form-control"
                                                           name="rentAreaTo" value="${modelSearch.rentAreaTo}">
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div>
                                                    <label for="rentPriceFrom">Giá thuê từ</label>
                                                    <input type="number" id="rentPriceFrom" class="form-control"
                                                           name="rentPriceFrom" value="${modelSearch.rentPriceFrom}">
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div>
                                                    <label for="rentPriceTo">Giá thuê đến</label>
                                                    <input type="number" id="rentPriceTo" class="form-control"
                                                           name="rentPriceTo" value="${modelSearch.rentPriceTo}">
                                                </div>
                                            </div>
                                        </div>


                                        <div class="form-group">

                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="managerName">Tên quản lý</label>
                                                    <form:input path="managerName" cssClass="form-control"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="managerPhone">Điện thoại quản lý</label>
                                                    <form:input path="managerPhone" cssClass="form-control"/>
                                                </div>
                                            </div>

                                            <div class="col-sm-4 " style="margin-top: 25px">
                                                <label for="staffId" >Nhân viên phụ trách</label>
                                                <form:select path="staffId" style="margin-bottom: 15px">
                                                    <form:option value="" label="---Chọn nhân viên phụ trách---"/>
                                                    <form:options items="${staffs}"/>
                                                </form:select>
                                            </div>

                                        </div>

                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <%--<label class="checkbox-inline"><input type="checkbox" value=""
                                                                                      id="checkbox_1">Tầng trệt</label>
                                                <label class="checkbox-inline"><input type="checkbox" value=""
                                                                                      id="checkbox_2">Nguyên căn</label>
                                                <label class="checkbox-inline"><input type="checkbox" value=""
                                                                                      id="checkbox_3">Nội thất</label>--%>

                                                    <form:checkboxes path="buildingType" items="${buildingTypesMap}"/>

                                            </div>

                                        </div>




                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <button type="button" class="btn btn-success" id="btnSearchBuilding">Tìm
                                                    kiếm
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>


                            </div>

                        </div> <!-- widget-box-->
                    </div>

                </div><!-- /.row -->

                <div class="row">
                    <div class="col-xs-12">
                        <div class="pull-right">
                            <a href="/admin/building-edit">
                                <button class="btn btn-white btn-info btn-bold" data-toggle="tooltip" title="Thêm tòa nhà">
                                    <i class="fa fa-plus-circle" aria-hidden="true" id="btn-add-building"></i>
                                </button>
                            </a>

                            <button class="btn btn-white btn-warning btn-bold"
                                    data-toggle="tooltip" title="Xóa tòa nhà" id="btnDeleteBuilding">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- button-add-delete -->
                <br>
                <div class="row">
                    <div class="col-xs-12">
                        <table id="buildingList" class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th></th>
                                <th>Tên tòa nhà</th>
                                <th>Địa chỉ</th>
                                <th>Tên quản lý</th>
                                <th>Số điện thoại</th>
                                <th>Diện tích sàn</th>
                                <th>Giá thuê</th>
                                <th>Phí dịch vụ</th>
                                <th>Phí môi giới</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>

                            <tbody>

                            <c:forEach var="item" items="${buildings}">
                                <tr>
                                    <td class="center">
                                        <label class="pos-rel">
                                            <input type="checkbox" class="ace" value="${item.id}" id="checkboxListBuilding_${item.id}"/>
                                        <span class="lbl"></span>
                                        </label>

                                    </td>
                                    <td>${item.name}</td>
                                    <td>${item.address}</td>
                                    <td>${item.managerName}</td>
                                    <td>${item.managerPhone}</td>
                                    <td>${item.floorArea}</td>
                                    <td>${item.rentPrice}</td>
                                    <td>${item.serviceFee}</td>
                                    <td>${item.brokerageFee}</td>
                                    <td>
                                        <button class="btn btn-xs btn-info" data-toggle="tooltip"
                                                title="Giao tòa nhà" onclick="assignmentBuilding(${item.id})">
                                            <i class="fa fa-bars"></i>
                                        </button>
                                        <a href="${buildingEditUrl}-${item.id}">
                                            <button class="btn btn-xs btn-info" data-toggle="tooltip"
                                                    title="Chỉnh sửa tòa nhà" >
                                                <i class="fa fa-pencil"></i>
                                            </button>
                                        </a>
                                    </td>

                                </tr>
                            </c:forEach>
<%--onclick="editBuilding(${item.id})"--%>

                            </tbody>
                        </table>
                    </div>
                </div>

            </div><!-- /.page-content -->
        </div>
    </div><!-- /.main-content -->
</div>

<div class="modal fade" id="assignmentBuildingModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Danh sách nhân viên</h4>
            </div>
            <div class="modal-body">
                <table class="table table-bordered" id="staffList">
                    <thead>
                    <tr>
                        <th>Chọn nhân viên</th>
                        <th>Tên nhân viên</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%--<tr>
                            <td><input type="checkbox" value="2" id="checkboxidstaff_2"/></td>
                            <td>Nguyễn Văn A</td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" value="3" id="checkboxidstaff_3"/></td>
                            <td>Nguyễn Văn B</td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" value="4" id="checkbox_4"/></td>
                            <td>Nguyễn Văn C</td>
                        </tr>--%>
                    </tbody>
                </table>
                <input type="hidden" id="buildingId" name="buildingId" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnAssignBuilding">Giao tòa nhà</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>

        </div>
    </div>
</div>


<script>

    function editBuilding(buildingId) {
        loadBuilding(buildingId);
    }

    function loadBuilding(buildingId) {
        $.ajax({
            type: 'GET',
            url: '${buildingAPI}/'+buildingId,
            // data: JSON.stringify(data),
            //trả từ server về client
            dataType: "json",
            //trả từ client về server
            contentType: "application/json",
            success: function (response) {
                //called when successful
                $.each(response.data, function (index,item) {
                    alert(item.name);
                });
            },
            error: function (e) {
                //called when there is an error
                console.log("fail");
                console.log(e.message);
            }
        });
    }

    function assignmentBuilding(buildingId){
        openModalAssignmentBuilding();
        loadStaff(buildingId);
        $('#buildingId').val(buildingId);
        console.log($('#buildingId').val());
    }

    function loadStaff(buildingId) {
        $.ajax({
            type: 'GET',
            url: "${loadStaffAPI}/"+buildingId+"/staffs",
            // data: JSON.stringify(data),
            //trả từ server về client
            dataType: "json",
            //trả từ client về server
            // contentType: "application/json",
            success: function (response) {
                //called when successful
                // console.log("success");
                var row = '';
                $.each(response.data, function (index,item) {
                    row += '<tr>';
                    row += '<td class="text-center"> <input type="checkbox" value='+ item.id +' id="checkbox_'+item.id+'" class="check-box-element" '+item.checked+'/></td>';
                    row += '<td class="text-center">' + item.fullName + '</td>';
                    row += '</tr>';
                });
                $('#staffList tbody').html(row);

            },
            error: function (e) {
                //called when there is an error
                console.log("fail");
                console.log(e.message);
            }
        });
    }

    function openModalAssignmentBuilding() {
        $('#assignmentBuildingModal').modal();
    }

    $('#btnAssignBuilding').click(function (e) {
        e.preventDefault();
        var data = {};
        // var staffs = [];
        data['buildingId'] = $('#buildingId').val();
        //$('#staffList').find('tbody input[type=checkbox]') // trỏ tới các input có type = checkbox trong staffList
        var staffIds = $('#staffList').find('tbody input[type=checkbox]:checked').map(function () {
            //map là chỉ vô tưng checkbox lấy giá trị thôi chưa return đc
            return $(this).val();
        }).get();   // lấy các giá trị = hàm map
        data['staffIds'] = staffIds;
        //call api
        assignStaff(data);
    });

    function assignStaff(data) {
        $.ajax({
            type: 'POST',
            url: '${buildingAssignmentAPI}',
            data: JSON.stringify(data),
            //trả từ server về client
            dataType: "json",
            //trả từ client về server
            contentType: "application/json",
            success: function (data) {
                //called when successful
                console.log("success");

            },
            error: function (e) {
                //called when there is an error

                console.log("fail");
                console.log(e.message);
            }
        });
    }

    $('#btnDeleteBuilding').click(function (e) {
        e.preventDefault();
        var data = {};
        var buildingIds = $('#buildingList').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data['buildingIds'] = buildingIds;
        deleteBuilding(buildingIds)
    });

    function deleteBuilding(buildingIds) {
        $.ajax({
            type: 'DELETE',
            url: '${buildingAPI}',
            data: JSON.stringify(buildingIds),
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
                location.reload();
            }
        });
    }

    $('#btnSearchBuilding').click(function (e) {
        e.preventDefault();
        $('#listForm').submit()
    });

    /*$('#btn-add-building').click(function (e) {
        e.preventDefault();
        location.assign("/admin/building-edit")
    });*/



</script>


</body>
</html>
