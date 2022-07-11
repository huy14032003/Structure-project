<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
</style>

<div class="loader hidden"></div>
<div class="row">
    <div class="col-12 my-2 component">
        <div class="row">
            <div class="col-12 py-2 border-bottom">
                <span class="title-table">Add New Customer</span>
            </div>
            <div class="col-12 py-3">
                <div class="row row_input">
                    <div class="col-sm-4 col-sm-3">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-sm-4">Area:</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="txt_area"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4 col-sm-3">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-sm-4">Factory:</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="txt_factory"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4 col-sm-3 ">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-sm-4">Customer:</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="txt_customer">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4 col-sm-3">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-sm-4">End Customer:</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="txt_end_customer">
                            </div>
                        </div>
                    </div>
                    <div class=" col-sm-4 col-sm-3">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-lg-4 col-md-4 col-sm-4">Plant:</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="txt_plant">
                            </div>
                        </div>
                    </div>
                    <div class=" col-sm-4 col-sm-3">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-sm-4">Customer code:</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="txt_customer_code">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row d-flex-rcc">
                    <button id="btnAddCustomer" class="btn btn-sm btn-primary mx-1" onclick="addCustomer()"><i class="fa fa-check-circle"></i> Add</button>
                    <button id="btnUpdateCustomer" class="btn btn-sm btn-success mx-1 hidden" onclick="submitUpdateCustomer()"><i class="fa fa-check-circle"></i> Update</button>
                    <button class="btn btn-sm btn-danger mx-1" onclick="cancelInput()"><i class="fa fa-times-circle"></i> Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <div class="col-12 my-2 component">
        <div class="row">
            <div class="col-12 d-flex-rcb border-bottom py-2">
                <span class="title-table">List Customer</span>
                <div class="input-group" style="width: auto;">
                    <input id="search-order" type="text" class="form-control ip-search" placeholder="End customer">
                    <div class="input-group-append">
                        <button class="input-group-text btn btn-sm" style="border-top-left-radius: 0;border-bottom-left-radius: 0;" onclick="searchData()">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="col-12 py-3">
                <table id="tblListCustomer" class="table my-table">
                    <thead>
                        <tr>
                            <th style="width: 5%;">#</th>
                            <th>Area</th>
                            <th>Factory</th>
                            <th>Customer</th>
                            <th>End Customer</th>
                            <th>Plant</th>
                            <th>Customer code</th>
                            <th style="width: 10%;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    var userInfo = JSON.parse(localStorage.getItem('userInfo'));
    var empNo = userInfo.idCard;

    var dataset = {
        "empNo": empNo,
        "endCustomer": "",
    }

    $(document).ready(function () {
        init();
    })

    function init() {
        loadListSide();
        loadListCustomer();
    }

    function loadListSide() {
        $('#txt_area').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/listSide",
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '<option value="" disabled selected>--Select--</option>';
                for (i in data) {
                    html += '<option value="' + data[i].side + '">' + data[i].side + '</option>';
                }
                $('#txt_area').html(html);
                dataset.side = $('#txt_area').val();
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                loadListFactory();
            }
        });
    }

    $('#txt_area').on('change', function () {
        dataset.side = $(this).val();
        loadListFactory();
    });

    function loadListFactory() {
        $('#txt_factory').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/listFactory",
            data: {
                side: dataset.side
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '<option value="" disabled selected>--Select--</option>';
                for (i in data) {
                    html += '<option value="' + data[i].factory + '">' + data[i].factory + '</option>';
                }
                $('#txt_factory').html(html);
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                if (dataset.factory == undefined || dataset.factory == null) {
                    $('#txt_factory').val($('#txt_factory option:first-child').val());
                } else {
                    $('#txt_factory').val(dataset.factory);
                }
            }
        });
    }

    function loadListCustomer() {
        $('.loader').removeClass('hidden');
        $('#tblListCustomer tbody').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/getListCustomer",
            data: {
                endCustomer: dataset.endCustomer
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '';
                if (!isArrayEmpty(data) && !isFalsy(data)) {
                    for (i in data) {
                        html +=
                            '<tr class="customer_' + data[i].id + '">' +
                            '<td>' + (Number(i) + 1) + '</td>' +
                            '<td>' + formatEmpty(data[i].side) + '</td>' +
                            '<td>' + formatEmpty(data[i].factory) + '</td>' +
                            '<td>' + formatEmpty(data[i].customer) + '</td>' +
                            '<td>' + formatEmpty(data[i].end_customer) + '</td>' +
                            '<td>' + formatEmpty(data[i].plant) + '</td>' +
                            '<td>' + formatEmpty(data[i].customer_code) + '</td>' +
                            '<td class="hidden">' + formatEmpty(data[i].id) + '</td>' +
                            '<td>' +
                            '<button class="btn btn-sm btn-function btn-warning mx-1" onclick="updateCustomer(' +
                            data[i].id + ',\'' +
                            data[i].side + '\',\'' +
                            data[i].factory + '\',\'' +
                            data[i].customer + '\',\'' +
                            data[i].end_customer + '\',\'' +
                            data[i].plant + '\',\'' +
                            data[i].customer_code + '\'' +
                            ')"><i class="fa fa-pen-alt"></i></button>' +
                            '<button class="btn btn-sm btn-function btn-danger mx-1" onclick="deleteCustomer(' + data[i].id + ')"><i class="fa fa-trash-alt"></i></button>' +
                            '</td>' +
                            '</tr>';
                    }
                } else {
                    html = '<tr><td colspan="8">No data to display</td></tr>';
                }
                $('#tblListCustomer tbody').html(html);
            },
            error: function (errMsg) {
                $('.loader').addClass('hidden');
                console.log(errMsg);
                alert(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
            }
        });

    }

    $('#search-order').on('keyup', function (e) {
        if (e.keyCode == 13) {
            dataset.endCustomer = $(this).val();
            loadListCustomer();
        }
    });

    function searchData() {
        dataset.endCustomer = $('#search-order').val().toString().trim();
        loadListCustomer();
    }

    function addCustomer() {
        var area = formatEmpty($('#txt_area').val()).trim();
        var factory = formatEmpty($('#txt_factory').val()).trim();
        var customer = formatEmpty($('#txt_customer').val()).trim();
        var end_customer = formatEmpty($('#txt_end_customer').val()).trim();
        var plant = formatEmpty($('#txt_plant').val()).trim();
        var customerCode = formatEmpty($('#txt_customer_code').val()).trim();

        if (isFalsy(area)) {
            showAlertJS('error', 'Area is empty');
            return;
        } else if (isFalsy(factory)) {
            showAlertJS('error', 'Factory is empty');
            return;
        } else if (isFalsy(customer)) {
            showAlertJS('error', 'Customer code is empty');
            return;
        } else if (isFalsy(end_customer)) {
            showAlertJS('error', 'End customer PN is empty');
            return;
        } else if (isFalsy(plant)) {
            showAlertJS('error', 'Plant code is empty');
            return;
        } else if (isFalsy(customerCode)) {
            showAlertJS('error', 'Customer code is empty');
            return;
        }
        var confirm = window.confirm('Do you want to add?');
        if (confirm) {
            $('.loader').removeClass('hidden');
            $.ajax({
                type: 'POST',
                url: "/pm-system/api/customer/add",
                data: {
                    idCard: dataset.empNo,
                    side: area,
                    factory: factory,
                    customer: customer,
                    endCustomer: end_customer,
                    plant: plant,
                    customerCode: customerCode
                },
                success: function (res) {
                    showAlertJS('success', res.result);
                    resetForm();
                    loadListCustomer();
                },
                error: function (err) {
                    $('.loader').addClass('hidden');
                    alert(JSON.parse(err.responseText).message);
                    console.log(err);
                },
                complete: function () {
                    $('.loader').addClass('hidden');
                }
            });
        }
    }

    function updateCustomer(id, area, factory, customer, end_customer, plant, customer_code) {
        var info = $('#tblListCustomer .customer_' + id + ' td');
        dataset.factory = factory;
        $('#txt_area').val(area.toString()).trigger('change');
        $('#txt_plant').val(plant);
        $('#txt_customer').val(customer);
        $('#txt_end_customer').val(end_customer);
        $('#txt_customer_code').val(customer_code);
        dataset.idCustomer = id;

        $('.btn-function').attr('disabled', 'disabled');
        $('#btnAddCustomer').addClass('hidden');
        $('#btnUpdateCustomer').removeClass('hidden');
    }

    function submitUpdateCustomer() {
        var confirm = window.confirm('Do you want to update?');
        if (confirm) {
            var factory = formatEmpty($('#txt_factory').val()).trim();
            var customer = formatEmpty($('#txt_customer').val()).trim();
            var end_customer = formatEmpty($('#txt_end_customer').val()).trim();
            var plant = formatEmpty($('#txt_plant').val()).trim();
            var customerCode = formatEmpty($('#txt_customer_code').val()).trim();

            $('.loader').removeClass('hidden');
            $.ajax({
                type: 'POST',
                url: "/pm-system/api/customer/update",
                data: {
                    idCustomer: dataset.idCustomer,
                    idCard: dataset.empNo,
                    side: dataset.side,
                    factory: factory,
                    customer: customer,
                    endCustomer: end_customer,
                    plant: plant,
                    customerCode: customerCode

                },
                success: function (res) {
                    showAlertJS('success', res.result);
                    loadListCustomer();
                    cancelInput();
                    resetForm();
                },
                error: function (err) {
                    $('.loader').addClass('hidden');
                    alert(JSON.parse(err.responseText).message);
                    console.log("Error:", err);
                },
                complete: function () {
                    $('.loader').addClass('hidden');
                }
            });
        }
    }

    function cancelInput() {
        $('.row_input .form-control').val('');
        $('#btnAddCustomer').removeClass('hidden');
        $('#btnUpdateCustomer').addClass('hidden');
        $('.btn-function').removeAttr('disabled');
    }

    function deleteCustomer(idCustomer) {
        var confirm = window.confirm("Do you want to delete?");
        if (confirm) {
            $('.loader').removeClass('hidden');
            $.ajax({
                type: 'POST',
                url: "/pm-system/api/customer/deleteCustomer",
                data: {
                    idCustomer: idCustomer,
                    idCard: dataset.empNo
                },
                success: function (res) {
                    showAlertJS('success', res.result);
                    loadListCustomer();
                },
                error: function (err) {
                    $('.loader').addClass('hidden');
                    console.log("Error:", err);
                },
                complete: function () {
                    $('.loader').addClass('hidden');
                }
            });
        }
    }

    function resetForm() {
        $('#txt_area').val($('#txt_area option:first-child').val());
        $('#txt_factory').val($('#txt_factory option:first-child').val());
        $('#txt_customer').val('');
        $('#txt_end_customer').val('');
        $('#txt_plant').val('');
        $('#txt_customer_code').val('');
    }
</script>