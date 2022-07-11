<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
</style>

<div class="loader hidden"></div>
<div class="row">
    <div class="col-md-9 my-2 component">
        <div class="row">
            <div class="col-12 py-2 border-bottom">
                <span class="title-table">Add New Foxconn PN</span>
            </div>
            <div class="col-sm-12 py-3">
                <div class="row row_input">
                    <div class="col-sm-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-sm-4">Customer:</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="txt_end_customer">
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-sm-4">Plant:</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="txt_plant"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-sm-4">Customer code:</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="txt_customer_code"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-sm-4">Foxconn PN:</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="txt_foxconn_pn">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-lg-4 col-md-4 col-sm-4">Product code:</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="txt_product_code">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-sm-4">Project:</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="txt_project">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row row_input d-flex-rcc">
                    <button id="btnAddFoxconnPN" class="btn btn-sm btn-primary mx-1" onclick="addFoxconnPN()"><i class="fa fa-check-circle"></i> Add</button>
                    <button id="btnUpdateFoxconnPN" class="btn btn-sm btn-success mx-1 hidden" onclick="submitUpdateFoxconnPN()"><i class="fa fa-check-circle"></i> Update</button>
                    <button class="btn btn-sm btn-danger mx-1" onclick="cancelInput()"><i class="fa fa-times-circle"></i> Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3 my-2 component">
        <div class="row">
            <div class="col-12 py-2 border-bottom">
                <span class="title-table">Add Foxconn P/N</span>
            </div>
            <div class="col-12 py-3">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group input-group d-flex-rcb">
                            <div class="input-group-prepend">
                                <a type="button" class="btn btn-primary btn-sm input-group-text" href="/pm-system/assets/files/FoxconnPN.xlsx" style="display: flex; align-items: center;white-space: nowrap;border-top-left-radius: 0;border-bottom-left-radius: 0;"><b><i class="fa fa-download"></i> Format file</b></a>
                            </div>
                            <input type="text" id="ref-foxconnPN" class="form-control" readonly style="background-color: lightgray;padding-right: 20px" value="Choose file">
                            <i class="fa fa-times text-danger icon-remove-file hidden" style="position: absolute;z-index:3;top: 50%;right: 3px;transform: translateY(-50%);" class=""></i>
                            <input type="file" id="file-foxconnPN" class="hidden">
                        </div>
                        <div class="form-group d-flex-rcc">
                            <button class="btn btn-sm btn-primary" onclick="addFileFoxconnPN()"><i class="fa fa-check-circle"></i> Add</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-12 my-2 component">
        <div class="row">
            <div class="col-12 d-flex-rcb border-bottom py-2">
                <span class="title-table">List Foxconn PN</span>
                <div class="input-group" style="width: auto;">
                    <input id="search-order" type="text" class="form-control" placeholder="FoxconnPN/ Product code/ Project">
                    <div class="input-group-append">
                        <button class="input-group-text btn btn-sm" style="border-top-left-radius: 0;border-bottom-left-radius: 0;" onclick="searchData()">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 py-3">
                <table id="tblListFoxconnPN" class="table my-table">
                    <thead>
                        <tr>
                            <th style="width: 5%;">#</th>
                            <th>Customer</th>
                            <th>Plant</th>
                            <th>Customer code</th>
                            <th>Foxconn PN</th>
                            <th>Product code</th>
                            <th>Project</th>
                            <th style="width: 10%;">Action</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
                <div class="pagination d-flex-rce">
                    <ul></ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
   var userInfo = JSON.parse(localStorage.getItem('userInfo'));
    var empNo = userInfo.idCard;
    
    var dataset = {
        empNo: empNo,
        endCustomer: "",
        foxconnPN: '',
        project: '',
        productCode: '',
        tableData: ''
    }

    var state = {
        data: null,
        page: 1,
        rows: 10,
        window: 7
    }

    $(document).ready(function () {
        init();
    });

    function init() {
        loadListCustomer();
        getDataTablePagination();
    }

    function loadListCustomer() {
        $('#txt_end_customer').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/createForm/listEndCustomer",
            data: {},
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '<option value="" disabled selected>--Select--</option>';
                for (i in data) {
                    html += '<option value="' + data[i].end_customer + '">' + data[i].end_customer + '</option>';
                }
                $('#txt_end_customer').html(html);
                // dataset.endCustomer = $('#txt_end_customer').val();
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                if (dataset.endCustomer == undefined || dataset.endCustomer == null) {
                    $('#txt_end_customer').val($('#txt_end_customer option:first-child').val());
                } else {
                    $('#txt_end_customer').val(dataset.endCustomer);
                }
                loadListPlant();
            }
        });
    }

    $('#txt_end_customer').on('change', function () {
        dataset.endCustomer = $(this).val();
        loadListPlant();
    });

    function loadListPlant() {
        $('#txt_plant').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/listPlant",
            data: {
                endCustomer: dataset.endCustomer
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '<option value="" disabled selected>--Select--</option>';
                for (i in data) {
                    html += '<option value="' + data[i].plant + '">' + data[i].plant + '</option>';
                }
                $('#txt_plant').html(html);
                // dataset.plant = $('#txt_plant').val();
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                if (dataset.plant == undefined || dataset.plant == null) {
                    $('#txt_plant').val($('#txt_plant option:first-child').val());
                } else {
                    $('#txt_plant').val(dataset.plant);
                }
                loadListCustomerCode();
            }
        });
    }

    $('#txt_plant').on('change', function () {
        dataset.plant = $(this).val();
        loadListCustomerCode();
    });

    function loadListCustomerCode() {
        $('#txt_customer_code').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/listCustomerCode",
            data: {
                endCustomer: dataset.endCustomer
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '<option value="" disabled selected>--Select--</option>';
                for (i in data) {
                    html += '<option value="' + data[i].customer_code + '">' + data[i].customer_code + '</option>';
                }
                $('#txt_customer_code').html(html);
                // dataset.customerCode = $('#txt_customer_code').val();
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                if (dataset.customerCode == undefined || dataset.customerCode == null) {
                    $('#txt_customer_code').val($('#txt_customer_code option:first-child').val());
                } else {
                    $('#txt_customer_code').val(dataset.customerCode);
                }
                // getDataTablePagination();
            }
        });
    }

    $('#txt_customer_code').on('change', function () {
        dataset.customerCode = $(this).val();
        // getDataTablePagination();
    });

    function getDataTablePagination() {
        $('.loader').removeClass('hidden');
        state.page = 1;
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/getlistFoxconnPN",
            data: {
                foxconnPN: dataset.foxconnPN,
                productCode: dataset.productCode,
                project: dataset.project
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                dataset.tableData = res.data;
                state.data = dataset.tableData;
            },
            error: function (errMesg) {
                $('.loader').addClass('hidden');
                console.log(errMesg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                loadListFoxconnPN();
            }
        });
    }

    function loadListFoxconnPN() {
        $('#tblListFoxconnPN tbody').html('');

        var html = '';
        var myData = pagination(state.data, state.page, state.rows);
        var data = myData.data;
        if (!isArrayEmpty(data) && !isFalsy(data)) {
            for (var i = 0; i < data.length; i++) {
                html +=
                    '<tr class="customer_' + data[i].id + '">' +
                    '<td>' + (Number(state.page - 1) * state.rows + Number(i + 1)) + '</td>' +
                    '<td>' + formatEmpty(data[i].end_customer) + '</td>' +
                    '<td>' + formatEmpty(data[i].plant) + '</td>' +
                    '<td>' + formatEmpty(data[i].customer_code) + '</td>' +
                    '<td>' + formatEmpty(data[i].foxconn_pn) + '</td>' +
                    '<td>' + formatEmpty(data[i].product_code) + '</td>' +
                    '<td>' + formatEmpty(data[i].project) + '</td>' +
                    '<td>' +
                    '<button class="btn btn-sm btn-function btn-warning mx-1" onclick="updateFoxconnPN(' +
                    data[i].idCustomer + ',' +
                    data[i].idCustomerModel + ',\'' +
                    data[i].end_customer + '\',\'' +
                    data[i].plant + '\',\'' +
                    data[i].customer_code + '\',\'' +
                    data[i].foxconn_pn + '\',\'' +
                    data[i].product_code + '\',\'' +
                    data[i].project + '\'' +
                    ')"><i class="fa fa-pen-alt"></i></button>' +
                    '<button class="btn btn-sm btn-function btn-danger mx-1" onclick="deleteFoxconnPN(' +
                    data[i].idCustomerModel +
                    ')"><i class="fa fa-trash-alt"></i></button>' +
                    '</td>' +
                    '</tr>';
            }
        } else {
            html = '<tr><td colspan="8">No data to display</td></tr>';
        }
        $('#tblListFoxconnPN tbody').html(html);

        pageButtons(myData.pages);

        // active page
        var li = document.querySelectorAll('.pagination ul li');
        for (var i = 0; i < li.length; i++) {
            li[i].classList.remove('active');
        }

        var liActive = document.querySelector('.pagination ul .li' + state.page);
        if (liActive != null && liActive != undefined) {
            document.querySelector('.pagination ul .li' + state.page).classList.add('active');
        }
    }

    // Ham nay dung cho chuc nang phan trang (khi su dung o trang khac thi chi can thay doi noi dung ben trong ham)
    function getResultPagination() {
        loadListFoxconnPN();
    }

    $('#search-order').on('keyup', function (e) {
        if (e.keyCode == 13) {
            dataset.foxconnPN = dataset.productCode = dataset.project = $(this).val();
            getDataTablePagination();
        }
    });

    function searchData() {
        dataset.foxconnPN = dataset.productCode = dataset.project = $('#search-order').val().toString().trim();
        getDataTablePagination();
    }

    function addFoxconnPN() {
        var endCustomer = formatEmpty($('#txt_end_customer').val()).trim();
        var plant = formatEmpty($('#txt_plant').val()).trim();
        var customerCode = formatEmpty($('#txt_customer_code').val()).trim();
        var foxconnPN = formatEmpty($('#txt_foxconn_pn').val()).trim();
        var productCode = formatEmpty($('#txt_product_code').val()).trim();
        var project = formatEmpty($('#txt_project').val()).trim();

        if (isFalsy(endCustomer)) {
            showAlertJS('error', 'Customer is empty');
            return;
        } else if (isFalsy(plant)) {
            showAlertJS('error', 'Plant is empty');
            return;
        } else if (isFalsy(customerCode)) {
            showAlertJS('error', 'Customer code is empty');
            return;
        } else if (isFalsy(foxconnPN)) {
            showAlertJS('error', 'Foxconn PN is empty');
            return;
        } else if (isFalsy(productCode)) {
            showAlertJS('error', 'Product code is empty');
            return;
        } else if (isFalsy(project)) {
            showAlertJS('error', 'Project is empty');
            return;
        }

        var confirm = window.confirm('Do you want to add new foxconn PN?');
        if (confirm) {
            $('.loader').removeClass('hidden');
            $.ajax({
                type: 'POST',
                url: "/pm-system/api/customer/addFoxconnPN",
                data: {
                    idCard: dataset.empNo,
                    endCustomer: endCustomer,
                    plant: plant,
                    customerCode: customerCode,
                    foxconnPN: foxconnPN,
                    productCode: productCode,
                    project: project
                },
                success: function (res) {
                    showAlertJS('success', res.result);
                    resetForm();
                    getDataTablePagination();
                },
                error: function (err) {
                    $('.loader').addClass('hidden');
                    console.log("Error:", err);
                    alert(JSON.parse(err.responseText).message);
                },
                complete: function () {
                    $('.loader').addClass('hidden');
                }
            });
        }
    }

    function updateFoxconnPN(id, idCustomerModel, endCustomer, plant, customerCode, foxconnPN, productCode, project) {
        dataset.endCustomer = endCustomer;
        $('#txt_end_customer').val(endCustomer.toString()).trigger('change');
        dataset.plant = plant;
        $('#txt_plant').val(plant);
        dataset.customerCode = customerCode;
        $('#txt_customer_code').val(customerCode);
        $('#txt_foxconn_pn').val(formatEmpty(foxconnPN));
        $('#txt_product_code').val(formatEmpty(productCode));
        $('#txt_project').val(formatEmpty(project));
        dataset.idCustomer = id;
        dataset.idCustomerModel = idCustomerModel;

        $('.btn-function').attr('disabled', 'disabled');
        $('#btnAddFoxconnPN').addClass('hidden');
        $('#btnUpdateFoxconnPN').removeClass('hidden');
    }

    function submitUpdateFoxconnPN() {
        var confirm = window.confirm('Do you want to update?');
        if (confirm) {
            var end_customer = formatEmpty($('#txt_end_customer').val()).trim();
            var plant = formatEmpty($('#txt_plant').val()).trim();
            var customerCode = formatEmpty($('#txt_customer_code').val()).trim();
            var foxconnPN = formatEmpty($('#txt_foxconn_pn').val()).trim();
            var productCode = formatEmpty($('#txt_product_code').val()).trim();
            var project = formatEmpty($('#txt_project').val()).trim();

            $('.loader').removeClass('hidden');
            $.ajax({
                type: 'POST',
                url: "/pm-system/api/customer/updateFoxconnPN",
                data: {
                    idCustomer: dataset.idCustomer,
                    idCustomerModel: dataset.idCustomerModel,
                    idCard: dataset.empNo,
                    endCustomer: end_customer,
                    plant: plant,
                    customerCode: customerCode,
                    foxconnPN: foxconnPN,
                    productCode: productCode,
                    project: project

                },
                success: function (res) {
                    showAlertJS('success', res.result);
                    getDataTablePagination();
                    cancelInput();
                    resetForm();
                },
                error: function (err) {
                    $('.loader').addClass('hidden');
                    console.log("Error:", err);
                    alert(JSON.parse(err.responseText).message);
                },
                complete: function () {
                    $('.loader').addClass('hidden');
                }
            });
        }
    }

    function cancelInput() {
        $('.row_input .form-control').val('');
        $('#btnAddFoxconnPN').removeClass('hidden');
        $('#btnUpdateFoxconnPN').addClass('hidden');
        $('.btn-function').removeAttr('disabled');
    }

    function deleteFoxconnPN(idCustomerModel) {
        var confirm = window.confirm("Do you want to delete?");
        if (confirm) {
            $('.loader').removeClass('hidden');
            $.ajax({
                type: 'POST',
                url: "/pm-system/api/customer/deleteFoxconnPN",
                data: {
                    idCustomerModel: idCustomerModel,
                    idCard: dataset.empNo
                },
                success: function (res) {
                    showAlertJS('success', res.result);
                    getDataTablePagination();
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

    $('#ref-foxconnPN').on('click', function () {
        $('#file-foxconnPN').click();
    });

    $('#file-foxconnPN').on('change', function (e) {
        var files = e.target.files;
        if (files.length > 0) {
            var file = dataset.file = files[0];
            $('.icon-remove-file').removeClass('hidden');
        }
        $('#ref-foxconnPN').val(file.name);
        console.log(file);
    });

    $('.icon-remove-file').on('click', function () {
        formatUploadFileFoxconnPN();
        dataset.file = null;
    });

    function formatUploadFileFoxconnPN() {
        $('.icon-remove-file').addClass('hidden');
        $('#ref-foxconnPN').val('Choose file');
        $('#file-foxconnPN').val(null);
    }

    function addFileFoxconnPN() {
        if (dataset.file == null || dataset.file == undefined) {
            showAlertJS('error', 'File cannot be empty');
            return;
        }
        var confirm = window.confirm('Do you want to upload file?');
        if (confirm) {
            $('.loader').removeClass('hidden');
            var form = new FormData();
            form.append('file', dataset.file);
            form.append('idCard', dataset.empNo);
            $.ajax({
                type: 'POST',
                url: '/pm-system/api/customer/insertListFoxconnPN',
                data: form,
                contentType: false,
                processData: false,
                mimeType: 'multipart/form-data',
                success: function (res) {
                    showAlertJS('success', JSON.parse(res).message);
                    formatUploadFileFoxconnPN();
                    getDataTablePagination();
                },
                error: function (err) {
                    $('.loader').addClass('hidden');
                    console.error(err);
                    alert(JSON.parse(err.responseText).message);
                },
                complete: function () {
                    $('.loader').addClass('hidden');
                }
            });
        }
    }

    function resetForm() {
        $('#txt_end_customer').val($('#txt_end_customer option:first-child').val());
        $('#txt_plant').val($('#txt_plant option:first-child').val());
        $('#txt_customer_code').val($('#txt_customer_code option:first-child').val());
        $('#txt_foxconn_pn').val('');
        $('#txt_product_code').val('');
        $('#txt_project').val('');
    }
</script>