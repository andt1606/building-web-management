<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>

<c:url var="customerAPI" value="/api/customer"/>
<c:url var="customerEditURL" value="/admin/customer-edit"/>
<c:url var="addTransactionAPI" value="/api/customer-add-transaction"/>
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
                <div class="col-sm-12">

                    <form:form commandName="modelEdit" action="${buildingEditUrl}" id="formEdit" method="GET">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="fullname" style="margin-bottom: 15px"> Tên đầy đủ</label>
                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="fullname" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="phone" style="margin-bottom: 15px"> Số điện thoại</label>
                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="phone" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="email" style="margin-bottom: 15px"> Email</label>
                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="email" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="companyName" style="margin-bottom: 15px"> Tên công ty</label>
                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="companyName" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="demand" style="margin-bottom: 15px"> Nhu cầu</label>
                            <div class="col-sm-9" style="margin-bottom: 15px">
                                <form:input path="demand" cssClass="form-control"/>
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
                                <button type="button" class="btn btn-primary" id="btnAddCustomer" >Cập nhật khách hàng</button>
                            </div>
                        </div>
                    </form:form>
                </div>

            </div><!-- /.row -->


            <c:forEach var="item" items="${transactions}">
                <div class="page-header">
                    <h1 style="display: inline-block;">
                        ${item.name}
                    </h1>
                    <button style="display: inline-block;" class="btn btn-white btn-info btn-bold " data-toggle="tooltip"
                            title="Thêm giao dịch" onclick="addTransaction(${item.id},'${item.code}')">
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
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="trans" items="${AllTransactionOfCustomer}">
                                <c:choose>
                                    <c:when test="${item.code == trans.code}">
                                        <tr>
                                            <td> ${trans.createdDate}</td>
                                            <td> ${trans.note} </td>
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
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnAddTrans">Thêm giao dịch</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
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


    function addTransaction(customerId, code){
        openModalAddTransaction();

        $('#customerId').val(customerId);
        console.log($('#customerId').val());

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
</script>


</body>
</html>
