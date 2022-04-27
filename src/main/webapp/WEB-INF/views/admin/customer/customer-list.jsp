<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="buildingListUrl" value="/admin/building-list"/>
<c:url var="buildingSearchUrl" value="/admin/building-search"/>
<c:url var="loadStaffAPI" value="/api/building"/>
<c:url var="buildingAPI" value="/api/building"/>
<c:url var="buildingEditUrl" value="/admin/building-edit"/>
<c:url var="buildingAssignmentAPI" value="/api/building-assignment"/>

<c:url var="customerListUrl" value="/admin/customer-list"/>
<c:url var="customerEditUrl" value="/admin/customer-edit"/>
<c:url var="loadStaffAPICustomer" value="/api/customer"/>
<c:url var="CustomerAssignmentAPI" value="/api/customer-assignment"/>
<c:url var="customerAPI" value="/api/customer"/>
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
                                <form:form commandName="modelSearch" action="${customerListUrl}" id="listForm" method="GET">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="fullname">Tên khách hàng</label>
                                                    <form:input path="fullname" cssClass="form-control"/>
                                                </div>
                                            </div>

                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="phone">Di động</label>
                                                    <form:input path="phone" cssClass="form-control"/>
                                                </div>
                                            </div>

                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="email">Email</label>
                                                    <form:input path="email" cssClass="form-control"/>
                                                </div>
                                            </div>
                                        </div>

                                            <div class="col-sm-6" >
                                                <label for="staffId" style="margin-bottom: 15px">Nhân viên phụ trách</label>

                                                <form:select path="staffId" style="margin-bottom: 15px">
                                                    <form:option value="" label="---Chọn nhân viên phụ trách---"/>
                                                    <form:options items="${staffs}"/>
                                                </form:select>
                                            </div>


                                        <div class="form-group">
                                            <div class = "col-sm-12">
                                                <button type="button" class="btn btn-success"  id="btnSearchCustomer">Tìm kiếm</button>
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
                            <a href="/admin/customer-edit">
                                <button class="btn btn-white btn-info btn-bold" data-toggle="tooltip" title="Thêm người dùng">
                                    <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                </button>
                            </a>
                            <button class="btn btn-white btn-warning btn-bold"
                                    data-toggle="tooltip" title="Xóa người dùng" id="btnDeleteCustomer">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- button-add-delete -->
                <br>
                <div class="row">
                    <div class="col-xs-12">
                        <table id="customerList" class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th></th>
                                <th>Tên </th>
                                <th>Nhân viên quản lý</th>
                                <th>Di động</th>
                                <th>Email</th>
                                <th>Nhu cầu</th>
                                <th>Người nhập</th>
                                <th>Ngày nhập</th>
                                <th>Tình trạng</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="item" items="${customers}">
                                <tr>
                                    <td class="center">
                                        <label class="pos-rel">
                                            <input type="checkbox" class="ace" value="${item.id}" id="checkboxListBuilding_${item.id}"/>
                                            <span class="lbl"></span>
                                        </label>
                                    </td>

                                    <td>
                                            ${item.fullname}
                                    </td>
                                    <td>${item.managerAssignedName}</td>
                                    <td >${item.phone}</td>
                                    <td>${item.email}</td>

                                    <td >
                                            ${item.demand}
                                    </td>

                                    <td >
                                            ${item.createdBy}
                                    </td>

                                    <td >
                                            ${item.createdDate}
                                    </td>

                                    <td>
                                        Đang xử lý
                                    </td>

                                    <td >


                                        <button class="btn btn-xs btn-info" data-toggle="tooltip"
                                                title="Giao khách hàng" onclick="assignmentCustomer(${item.id})">
                                            <i class="fa fa-bars"></i>
                                        </button>


                                        <a href="${customerEditUrl}-${item.id}">
                                            <button class="btn btn-xs btn-info" data-toggle="tooltip"
                                                    title="Chỉnh khách hàng" >
                                                <i class="fa fa-pencil"></i>
                                            </button>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>



                            </tbody>
                        </table>
                    </div>
                </div>
            </div><!-- /.page-content -->
        </div>
    </div><!-- /.main-content -->
</div>

<div class="modal fade" id="assignmentCustomerModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Danh sách nhân viên giao khách hàng</h4>
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
                        <td class="text-center"> <input type="checkbox" value="2" id="checkbox_2" />  </td>
                        <td>Nguyễn Văn A</td>
                    </tr>
                    <tr>
                        <td class="text-center"><input type="checkbox" value="3" id="checkbox_3"/></td>
                        <td>Nguyễn Văn B</td>
                    </tr>
                    <tr>
                        <td class="text-center"><input type="checkbox" value="4" id="checkbox_4"/></td>
                        <td>Nguyễn Văn C</td>
                    </tr>--%>
                    </tbody>
                </table>
                <input type="hidden" id="customerId" name="customerId" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"  id="btnAssignCustomer">Lưu thay đổi</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>

        </div>
    </div>
</div>


<script>


    function loadStaff(customerId) {
        $.ajax({
            type: 'GET',
            url: "${loadStaffAPICustomer}/"+customerId+"/staffs",
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

    function assignmentCustomer(customerId){
        openModalAssignmentCustomer();
        loadStaff(customerId);
        $('#customerId').val(customerId);
        console.log($('#customerId').val());
    }

    function openModalAssignmentCustomer() {
        $('#assignmentCustomerModal').modal();
    }

    $('#btnAssignCustomer').click(function (e) {
        e.preventDefault();
        var data = {};
        // var staffs = [];
        data['customerId'] = $('#customerId').val();
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
            url: '${CustomerAssignmentAPI}',
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

    $('#btnDeleteCustomer').click(function (e) {
        e.preventDefault();
        var data = {};
        var customerIds = $('#customerList').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data['customerIds'] = customerIds;
        deleteBuilding(customerIds)
    });





    function deleteBuilding(customerIds) {
        $.ajax({
            type: 'DELETE',
            url: '${customerAPI}',
            data: JSON.stringify(customerIds),
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

    $('#btnSearchCustomer').click(function (e) {
        e.preventDefault();
        $('#listForm').submit()
    });



</script>


</body>
</html>
