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
                    <a href="#">Trang chủ</a>
                </li>
                <li class="active">Quản lý khách hàng</li>
            </ul><!-- /.breadcrumb -->

        </div>

        <div class="page-content">

            <div class="row">
                <div class="col-sm-12">
                    <div class="widget-box">

                        <div class="widget-header">

                            <h4 class="widget-title search-title">Tìm kiếm khách hàng</h4>

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
                                        <div class="form-group search-form">
                                            <div class="col-sm-3 input-container">
                                                    <form:input path="fullname" cssClass="form-control input" placeholder="--Tên khách hàng--"/>
                                            </div>

                                            <div class="col-sm-3 input-container">
                                                    <form:input path="phone" cssClass="form-control input" placeholder="--Di động--"/>
                                            </div>

                                            <div class="col-sm-3 input-container">
                                                    <form:input path="email" cssClass="form-control input" placeholder="--Nhân viên phụ trách--"/>
                                            </div>

                                            <div class="col-sm-2  input-container">

                                                <form:select path="staffId" style="margin-bottom: 15px" cssClass="select-container">
                                                    <form:option value="" label="---Chọn nhân viên phụ trách---"/>
                                                    <form:options items="${staffs}"/>
                                                </form:select>
                                            </div>

                                            <div class="form-group col-sm-1">
                                                    <button type="button" class="btn btn-primary"  id="btnSearchCustomer" style="width: 100%;height: 100%">Tìm kiếm</button>
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
                        <div class="pull-left customer-title">
                            Danh sách khách hàng
                        </div>
                        <div class="pull-right" style="padding-right: 12px;padding-top: 2vh">
                            <a href="/admin/customer-edit">
                                <button class="btn btn-primary" data-toggle="tooltip" title="Thêm người dùng">
                                    <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                    Thêm
                                </button>
                            </a>
                            <button class="btn btn-danger"
                                    data-toggle="tooltip" title="Xóa người dùng" id="btnDeleteCustomer">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                                Xóa
                            </button>
                        </div>
                    </div>
                </div>
                <!-- button-add-delete -->
                <br>
                <div class="row">
                    <div class="col-xs-12">
                        <c:forEach var="item" items="${customers}">
                            <div class="customer-info">
                                <div class="row" style="height: 100%">
                                    <div class="col-xs-1 center customer-item" style="width: 3%;margin-left: 1vw">
                                        <label class="pos-rel" style="top:50%">
                                            <input type="checkbox" class="ace" value="${item.id}" id="checkboxListBuilding_${item.id}"/>
                                            <span class="lbl"></span>
                                        </label>
                                    </div>
                                    <div class="col-xs-2 customer-item" onclick="location.href='${customerEditUrl}-${item.id}';">
                                        <img src="/adu.png"height="100%" width="100%"/>
                                    </div>
                                    <div class="col-xs-auto customer-item" onclick="location.href='${customerEditUrl}-${item.id}';">
                                        <div class="customer-name">
                                                ${item.fullname}
                                        </div>
                                                    <div class="customer-info-title">
                                                        <div class="col-xs-1">
                                                            Số điện thoại:
                                                        </div>
                                                        <div class="col-xs-auto">
                                                            ${item.phone}
                                                        </div>
                                                    </div>
                                                    <div class="customer-info-title">
                                                        <div class="col-xs-1">
                                                            Email:
                                                        </div>
                                                        <div class="col-xs-auto">
                                                                ${item.email}
                                                        </div>

                                                    </div>
                                                    <div class="customer-info-title">
                                                        <div class="col-xs-1">
                                                            Người phụ trách:
                                                        </div>
                                                        <div class="col-xs-auto">
                                                                ${item.managerAssignedName}
                                                        </div>
                                                    </div>
                                                    <div class="customer-info-title">
                                                        <div class="col-xs-1">
                                                            Đã thuê:
                                                        </div>
                                                        <div class="col-xs-auto">
                                                                ${item.demand}
                                                        </div>
                                                    </div>
                                                    <div class="customer-info-title">
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
                                                    </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
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
