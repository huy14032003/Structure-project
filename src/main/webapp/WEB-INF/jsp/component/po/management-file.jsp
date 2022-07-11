<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    .modal-xl-custome {
        max-width: 90% !important;
    }

    ul#myTab .nav-item .nav-link {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    ul#myTab .nav-item .nav-link.active {
        background-color: #2061C5;
        color: #fff !important;
    }

    table#tblPreview {
        min-width: 300vw;
    }

    @media screen and (min-width: 1024px) and (max-width: 1365px) {
        table#tblPreview {
            min-width: 400vw;
        }
    }

    @media screen and (min-width: 1366px) and (max-width: 1919px) {
        table#tblPreview {
            min-width: 400vw;
        }
    }
</style>
<div class="loader hidden"></div>
<div class="row">
    <div class="col-12 my-2 component">
        <ul class="nav nav-tabs pt-2" id="myTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="po-tab" data-toggle="tab" href="#po" role="tab" aria-controls="po" aria-selected="true">
                    <span>PO</span>&nbsp;
                    <span id="po-badge" class="badge badge-danger"></span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="fo-tab" data-toggle="tab" href="#fo" role="tab" aria-controls="fo" aria-selected="false">
                    <span>FO</span>&nbsp;
                    <span id="fo-badge" class="badge badge-danger"></span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="shipment-tab" data-toggle="tab" href="#shipment" role="tab" aria-controls="shipment" aria-selected="false">
                    <span>Shipment</span>&nbsp;
                    <span id="shipment-badge" class="badge badge-danger"></span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="etac-tab" data-toggle="tab" href="#etac" role="tab" aria-controls="etac" aria-selected="false">
                    <span>ETAC</span>&nbsp;
                    <span id="etac-badge" class="badge badge-danger"></span>
                </a>
            </li>
        </ul>
        <div class="row tab-content myTabContent">
            <div id="po" class="col-sm-12 tab-pane fade show active">
                <div class="col-12 py-2 d-flex-rcb">
                    <span class="title-table">List PO File</span>
                    <div class="input-group" style="width: auto;">
                        <input id="txt_filter_po" type="text" class="form-control search-order" placeholder="ETAC week">
                        <div class="input-group-append">
                            <button class="input-group-text btn my-button" onclick="searchData('po')">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 pb-3">
                    <table id="tblListFilePO" class="table my-table">
                        <thead>
                            <tr>
                                <th style="width: 5%;">#</th>
                                <th>Application ID</th>
                                <th>File name</th>
                                <th>ETAC week</th>
                                <th>Created At</th>
                                <th>Applicant</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <div class="pagination po d-flex-rce">
                        <ul></ul>
                    </div>
                </div>
            </div>

            <div id="fo" class="col-sm-12 tab-pane fade no-padding">
                <div class="col-12 py-2 d-flex-rcb">
                    <span class="title-table">List FO File</span>
                    <div class="input-group" style="width: auto;">
                        <input id="txt_filter_fo" type="text" class="form-control search-order" placeholder="ETAC week">
                        <div class="input-group-append">
                            <button class="input-group-text btn my-button" onclick="searchData('fo')">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 pb-3">
                    <table id="tblListFileFO" class="table my-table">
                        <thead>
                            <tr>
                                <th style="width: 5%;">#</th>
                                <th>Application ID</th>
                                <th>File name</th>
                                <th>ETAC week</th>
                                <th>Created At</th>
                                <th>Applicant</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <div class="pagination fo d-flex-rce">
                        <ul></ul>
                    </div>
                </div>
            </div>

            <div id="shipment" class="col-sm-12 tab-pane fade no-padding">
                <div class="col-12 py-2 d-flex-rcb">
                    <span class="title-table">List Shipment File</span>
                    <div class="input-group" style="width: auto;">
                        <input id="txt_filter_shipment" type="text" class="form-control search-order" placeholder="ETAC week">
                        <div class="input-group-append">
                            <button class="input-group-text btn my-button" onclick="searchData('shipment')">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 pb-3">
                    <table id="tblListFileShipment" class="table my-table">
                        <thead>
                            <tr>
                                <th style="width: 5%;">#</th>
                                <th>Application ID</th>
                                <th>File name</th>
                                <th>ETAC week</th>
                                <th>Created At</th>
                                <th>Applicant</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <div class="pagination shipment d-flex-rce">
                        <ul></ul>
                    </div>
                </div>
            </div>

            <div id="etac" class="col-sm-12 tab-pane fade no-padding">
                <div class="col-12 py-2 d-flex-rcb">
                    <span class="title-table">List ETAC File</span>
                    <div class="input-group" style="width: auto;">
                        <input id="txt_filter_etac" type="text" class="form-control search-order" placeholder="ETAC week">
                        <div class="input-group-append">
                            <button class="input-group-text btn my-button" onclick="searchData('etac')">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 pb-3">
                    <table id="tblListFileETAC" class="table my-table">
                        <thead>
                            <tr>
                                <th style="width: 5%;">#</th>
                                <th>Application ID</th>
                                <th>File name</th>
                                <th>ETAC week</th>
                                <th>Process</th>
                                <th>Files</th>
                                <th>Created At</th>
                                <th>Applicant</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <div class="pagination etac d-flex-rce">
                        <ul></ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Preview-->
    <div class="modal fade" id="modal-preview">
        <div class="modal-dialog modal-xl modal-xl-custome">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><b>Preview</b></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12 table-responsive" style="max-height: calc(100vh - 250px); overflow: auto;">
                            <table id="tblPreview" class="table my-table">
                                <thead></thead>
                                <tbody></tbody>
                            </table>
                            <div class="hidden no-data text-center">No data to display</div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm btn-primary btn-download hidden" onclick="exportToExcel('tblPreview')"><i class="fa fa-download"></i> Download</button>
                    <button class="btn btn-sm bg-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i> Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Preview Create Form-->
    <div class="modal fade" id="modal-preview-create-form">
        <div class="modal-dialog modal-xl modal-xl-custome">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><b>Preview Create Form</b></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12 my-2 border">
                            <div class="row">
                                <div class="col-12 border-bottom py-2 mb-3">
                                    <span class="title-table">Information</span>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group d-flex-rcb">
                                        <label class="label-inline col-5">Customer:</label>
                                        <div class="col-7">
                                            <input type="text" id="cf-customer" class="form-control my-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group d-flex-rcb">
                                        <label class="label-inline col-5">Plant:</label>
                                        <div class="col-7">
                                            <input type="text" id="cf-plant" class="form-control my-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group d-flex-rcb">
                                        <label class="label-inline col-5">Customer code:</label>
                                        <div class="col-7">
                                            <input type="text" id="cf-customerCode" class="form-control my-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group d-flex-rcb">
                                        <label class="label-inline col-5">Type:</label>
                                        <div class="col-7">
                                            <input type="text" id="cf-type" class="form-control my-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group d-flex-rcb">
                                        <label class="label-inline col-5">Applicant:</label>
                                        <div class="col-7">
                                            <input type="text" id="cf-creator" class="form-control my-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group d-flex-rcb">
                                        <label class="label-inline col-5 control-label">Create at:</label>
                                        <div class="col-7">
                                            <input type="text" id="cf-createAt" class="form-control my-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group d-flex-rcb">
                                        <label class="label-inline col-5 control-label">ETAC week:</label>
                                        <div class="col-7">
                                            <input type="text" id="cf-week" class="form-control my-input">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 my-2 border">
                            <div class="row">
                                <div class="col-12 border-bottom py-2">
                                    <span class="title-table">Sign Process</span>
                                </div>
                                <div class="col-sm-12 py-3">
                                    <table class="table my-table" id="tbl-process-sign">
                                        <thead>
                                            <th>#</th>
                                            <th>Name</th>
                                            <th>ID Card</th>
                                            <th>Mail</th>
                                            <th>Permission</th>
                                            <th>Sign level</th>
                                            <th>Comment</th>
                                            <th>Sign at</th>
                                            <th>Status</th>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm bg-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i> Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal List Files-->
    <div class="modal fade" id="modal-list-files">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><b>List Files</b></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table my-table" id="tbl-list-files">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Application ID</th>
                                        <th>File name</th>
                                        <th>ETAC week</th>
                                        <th>Applicant</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm bg-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i> Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var userInfo = JSON.parse(localStorage.getItem('userInfo'));
    var empNo = userInfo.idCard;

    var dataset = {
        "empNo": empNo,
        "empName": 'Nguyễn Đức Tiến',
        "idUser": 1,
        "pn": "",
        "factory": "",
        "endCustomer": "",
        "typePO": "",
        "tableDataPO": null,
        "tableDataFO": null,
        "tableDataShipment": null,
        "tableDataETAC": null,
        "lengthPO": 0,
        "lengthFO": 0,
        "lengthShipment": 0,
        "lengthETAC": 0,
    };

    var state = {
        dataPO: null,
        dataFO: null,
        dataShipment: null,
        dataETAC: null,
        page: 1,
        rows: 10,
        window: 7
    };

    $(document).ready(function () {
        init();
    });

    function init() {
        getDataTablePagination('PO', '');
        getDataTablePagination('FO', '');
        getDataTablePagination('Shipment', '');
        getDataTablePagination('Input ETAC', '');
    }

    function getDataTablePagination(typeName, week) {
        $('.loader').removeClass('hidden');
        state.page = 1;
        if (typeName == "ETAC") {
            typeName = "Input ETAC";
        }
        $.ajax({
            type: "GET",
            url: "/pm-system/api/sign/listCreateFormAll",
            data: {
                // idCard: dataset.empNo,
                week: week,
                type: typeName
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                if (typeName == 'PO') {
                    dataset.tableDataPO = res.data;
                    dataset.lengthPO = res.data.length;
                    state.dataPO = dataset.tableDataPO;
                } else if (typeName == 'FO') {
                    dataset.tableDataFO = res.data;
                    dataset.lengthFO = res.data.length;
                    state.dataFO = dataset.tableDataFO;
                } else if (typeName == 'Shipment') {
                    dataset.tableDataShipment = res.data;
                    dataset.lengthShipment = res.data.length;
                    state.dataShipment = dataset.tableDataShipment;
                } else if (typeName == 'Input ETAC') {
                    dataset.tableDataETAC = res.data;
                    dataset.lengthETAC = res.data.length;
                    state.dataETAC = dataset.tableDataETAC;
                }
            },
            error: function (errMesg) {
                $('.loader').addClass('hidden');
                console.log(errMesg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                loadListFile(typeName, week);
            }
        });
    }


    function loadListFile(typeName, week) {
        var type = '';
        if (typeName == "Input ETAC") {
            type = "ETAC";
        } else {
            type = typeName;
        }

        var html = '';
        var myData;
        var dataLength = 0;
        if (typeName == 'PO') {
            myData = pagination(state.dataPO, state.page, state.rows);
            dataLength = dataset.lengthPO;
        } else if (typeName == 'FO') {
            myData = pagination(state.dataFO, state.page, state.rows);
            dataLength = dataset.lengthFO;
        } else if (typeName == 'Shipment') {
            myData = pagination(state.dataShipment, state.page, state.rows);
            dataLength = dataset.lengthShipment;
        } else if (typeName == 'Input ETAC') {
            myData = pagination(state.dataETAC, state.page, state.rows);
            dataLength = dataset.lengthETAC;
        }
        var data = myData.data;
        $('#tblListFile' + type + ' tbody').html('');
        if (!isArrayEmpty(data) && !isFalsy(data)) {
            for (var i = 0; i < data.length; i++) {
                html +=
                    '<tr>' +
                    '<td>' + (Number(state.page - 1) * state.rows + Number(i + 1)) + '</td>' +
                    '<td><a href="#" onclick="createFormPreview(\'' + data[i].code + '\'' + ')">' + data[i].code + '</a></td>' +
                    '<td><a href="#" onclick="filePreview(' + data[i].id_file + ',\'' + typeName + '\')">' + data[i].file_name + '</a></td>' +
                    '<td>' + data[i].week + '</td>';

                if (type == 'ETAC') {
                    html +=
                        '<td>' +
                        '<a href="/pm-system/process?' + 'endCustomer=' + data[i].end_customer + '&plant=' + data[i].plant + '&customerCode=' + data[i].customer_code + '&id=' + data[i].id_file + '&week=' + data[i].week + '" target="_blank">Process</a>' +
                        '</td>' +
                        '<td><a href="#" onclick="getListFiles(\'' + data[i].week + '\')">Files</a>' + '</td>';
                }

                html +=
                    '<td>' + data[i].updated_at + '</td>' +
                    '<td>' + data[i].creator_name + ' <br/>(' + data[i].creator_card + ')</td>' +
                    '<td>' + convertStatus(data[i].status) + '</td>' +
                    '<td><button class="btn btn-sm btn-danger" onclick="deleteFile(' + data[i].id_file + ')"><i class="fa fa-trash-alt"></i></button></td>' +
                    '</tr>';
            }
            $('#' + type.toLowerCase() + '-badge').html(dataLength);
        } else {
            $('#' + type.toLowerCase() + '-badge').html('');

            if (type == 'ETAC') {
                html = '<tr><td colspan="10">No data to display</td></tr>';
            } else {
                html = '<tr><td colspan="8">No data to display</td></tr>';
            }
        }
        $('#tblListFile' + type + ' tbody').html(html);

        pageButtons(myData.pages, type.toLowerCase());

        // active page
        var li = document.querySelectorAll('.pagination.' + type.toLocaleLowerCase() + ' ul li');
        for (var i = 0; i < li.length; i++) {
            li[i].classList.remove('active');
        }

        var liActive = document.querySelector('.pagination.' + type.toLocaleLowerCase() + ' ul .li' + state.page);
        if (liActive != null && liActive != undefined) {
            document.querySelector('.pagination.' + type.toLocaleLowerCase() + ' ul .li' + state.page).classList.add('active');
        }
    }

    function getResultPagination() {
        if ($('#po-tab').hasClass('active')) {
            loadListFile('PO', '');
        } else if ($('#fo-tab').hasClass('active')) {
            loadListFile('FO', '');
        } else if ($('#shipment-tab').hasClass('active')) {
            loadListFile('Shipment', '');
        } else if ($('#etac-tab').hasClass('active')) {
            loadListFile('Input ETAC', '');
        }
    }

    function convertStatus(stt) {
        var str = '';
        if (stt == 0) {
            str = '<span class="text-warning">Waiting</span>';
        } else if (stt == 1) {
            str = '<span class="text-success">Approved</span>';
        } else if (stt == 2) {
            str = '<span class="text-danger">Rejected</span>';
        }

        return str;
    }

    function filePreview(id, type, listFiles) {
        // Cho phep hien thi modal preview khi click tu modal list files
        dataset.listFiles = listFiles;
        if (listFiles == true) {
            $('#modal-list-files').modal('hide');
        }
        // Cho phep hien thi modal preview khi click tu modal list files

        $('.loader').removeClass('hidden');
        $('.btn-download').addClass('hidden');
        $('#tblPreview tbody').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/createForm/previewFile",
            data: {
                idCreateForm: id,
                type: type
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                if (res.code == 'SUCCESS') {
                    var data = res.data;
                    var html = '';
                    $('#tblPreview tbody').html('');
                    if (data.length > 0) {
                        var thead = checkType(type);
                        if (type == 'PO') {
                            for (i in data) {
                                html +=
                                    '<tr>' +
                                    '<td>' + (Number(i) + 1) + '</td>' +
                                    '<td>' + fixedNull(data[i].po) + '</td>' +
                                    '<td>' + fixedNull(data[i].line) + '</td>' +
                                    '<td>' + fixedNull(data[i].pn) + '</td>' +
                                    '<td>' + fixedNull(data[i].quantity) + '</td>' +
                                    '<td>' + fixedNull(data[i].erd) + '</td>' +
                                    '<td>' + fixedNull(data[i].unit_price) + '</td>' +
                                    '<td>' + fixedNull(data[i].currency) + '</td>' +
                                    '<td>' + fixedNull(data[i].amount) + '</td>' +
                                    '<td>' + fixedNull(data[i].po_date) + '</td>' +
                                    '<td>' + fixedNull(data[i].pn_desc) + '</td>' +
                                    '<td>' + fixedNull(data[i].priority) + '</td>' +
                                    '<td>' + fixedNull(data[i].priority_desc) + '</td>' +
                                    '<td>' + fixedNull(data[i].po_type) + '</td>' +
                                    '<td>' + fixedNull(data[i].po_type_desc) + '</td>' +
                                    '<td>' + fixedNull(data[i].payment_terms) + '</td>' +
                                    '<td>' + fixedNull(data[i].payment_terms_desc) + '</td>' +
                                    '<td>' + fixedNull(data[i].shipment_terms) + '</td>' +
                                    '<td>' + fixedNull(data[i].shipment_terms_desc) + '</td>' +
                                    '<td>' + fixedNull(data[i].inco_terms) + '</td>' +
                                    '<td>' + fixedNull(data[i].inco_terms_desc) + '</td>' +
                                    '<td>' + fixedNull(data[i].bill_to_party_name) + '</td>' +
                                    '<td>' + fixedNull(data[i].bill_to_party_code) + '</td>' +
                                    '<td>' + fixedNull(data[i].bill_to_party_address) + '</td>' +
                                    '<td>' + fixedNull(data[i].end_user_name) + '</td>' +
                                    '<td>' + fixedNull(data[i].end_user_code) + '</td>' +
                                    '<td>' + fixedNull(data[i].end_user_address) + '</td>' +
                                    '<td>' + fixedNull(data[i].manufacturer_name) + '</td>' +
                                    '<td>' + fixedNull(data[i].shipto_name) + '</td>' +
                                    '<td>' + fixedNull(data[i].shipto_code) + '</td>' +
                                    '<td>' + fixedNull(data[i].shipto_address) + '</td>' +
                                    '<td>' + fixedNull(data[i].lastedidt) + '</td>' +
                                    '<td>' + fixedNull(data[i].filename) + '</td>' +
                                    '<td>' + fixedNull(data[i].flag) + '</td>' +
                                    '<td>' + fixedNull(data[i].site) + '</td>' +
                                    '<td>' + fixedNull(data[i].item) + '</td>' +
                                    '<td>' + fixedNull(data[i].isa13) + '</td>' +
                                    '</tr>';
                            }
                        } else if (type == 'Shipment') {
                            for (i in data) {
                                html +=
                                    '<tr>' +
                                    '<td>' + (Number(i) + 1) + '</td>' +
                                    '<td>' + fixedNull(data[i].plant) + '</td>' +
                                    '<td>' + fixedNull(data[i].material) + '</td>' +
                                    '<td>' + fixedNull(data[i].quantity) + '</td>' +
                                    '<td>' + fixedNull(data[i].amount_lc) + '</td>' +
                                    '<td>' + fixedNull(data[i].batch) + '</td>' +
                                    '<td>' + fixedNull(data[i].sloc) + '</td>' +
                                    '<td>' + fixedNull(data[i].mvt) + '</td>' +
                                    '<td>' + fixedNull(data[i].mat_doc) + '</td>' +
                                    '<td>' + fixedNull(data[i].pstg_date) + '</td>' +
                                    '<td>' + fixedNull(data[i].time) + '</td>' +
                                    '<td>' + fixedNull(data[i].po) + '</td>' +
                                    '<td>' + fixedNull(data[i].vendor) + '</td>' +
                                    '<td>' + fixedNull(data[i].order) + '</td>' +
                                    '<td>' + fixedNull(data[i].cost_ctr) + '</td>' +
                                    '<td>' + fixedNull(data[i].descr) + '</td>' +
                                    '<td>' + fixedNull(data[i].text) + '</td>' +
                                    '<td>' + fixedNull(data[i].users) + '</td>' +
                                    '<td>' + fixedNull(data[i].item) + '</td>' +
                                    '<td>' + fixedNull(data[i].customer) + '</td>' +
                                    '<td>' + fixedNull(data[i].curr) + '</td>' +
                                    '<td>' + fixedNull(data[i].reference) + '</td>' +
                                    '</tr>';
                            }
                        } else if (type == 'FO') {
                            var data = res.data;
                            var thead = '';
                            var html = '';
                            var regEx = /^[0-9]{4}(\/|-)(0[1-9]|1[0-2])(\/|-)(0[1-9]|[1-2][0-9]|3[0-1])$/;

                            var title_header = Object.keys(data[0]);
                            thead +=
                                '<th>Product code</th>';

                            for (var i = 1; i < title_header.length; i++) {
                                thead += '<th>' + title_header[i] + '</th>';
                            }
                            // thead = '<tr>' + thead + '</tr>';

                            for (var i = 0; i < data.length; i++) {
                                html += '<td>' + fixedNull(data[i].product_code) + '</td>';
                                for (var j in data[i]) {
                                    if (regEx.test(j)) html += '<td>' + data[i][j] + '</td>';
                                }
                                html = '<tr>' + html + '</tr>';
                            }
                        } else if (type == 'Input ETAC') {
                            $('.btn-download').removeClass('hidden');
                            var data = res.data;
                            var thead = '';
                            var html = '';

                            thead +=
                                '<th style="background-color: #006699; color: #fff;text-align: center;">Project</th>' +
                                '<th style="background-color: #006699; color: #fff;text-align: center;">Product code</th>' +
                                '<th style="background-color: #006699; color: #fff;text-align: center;">Foxconn PN</th>' +
                                '<th style="background-color: #006699; color: #fff;text-align: center;">Plant</th>' +
                                '<th style="background-color: #006699; color: #fff;text-align: center;">End customer</th>' +
                                '<th style="background-color: #006699; color: #fff;text-align: center;">Ship cutoff date</th>' +
                                '<th style="background-color: #006699; color: #fff;text-align: center;">Hub code</th>';

                            for (var i = 0; i < 1; i++) {
                                var firstData = data[i].data;
                                var quantityWeek = data[i].quantityWeek;
                                var quantityMonth = data[i].quantityMonth;

                                for (var j in quantityWeek) {
                                    thead += '<th style="background-color: #006699; color: #fff;text-align: center;">' + j + '</th>';
                                }

                                for (var k in quantityMonth) {
                                    thead += '<th style="background-color: #006699; color: #fff;text-align: center;">' + k + '</th>';
                                }
                                thead += '<th style="background-color: #006699; color: #fff;text-align: center;">Total</th>';
                            }
                            thead = '<tr>' + thead + '</tr>';

                            for (var i = 0; i < data.length; i++) {
                                var firstData = data[i].data;
                                var quantityWeek = data[i].quantityWeek;
                                var quantityMonth = data[i].quantityMonth;

                                var tdHtml =
                                    '<td style="text-align: center; white-space: nowrap;">' + fixedNull(firstData.project) + '</td>' +
                                    '<td style="text-align: center; white-space: nowrap;">' + fixedNull(firstData.product_code) + '</td>' +
                                    '<td style="text-align: center; white-space: nowrap;">' + fixedNull(firstData.foxconn_pn) + '</td>' +
                                    '<td style="text-align: center;">' + fixedNull(firstData.plant) + '</td>' +
                                    '<td style="text-align: center;">' + fixedNull(firstData.end_customer) + '</td>' +
                                    '<td style="text-align: center;">' + fixedNull(firstData.ship_cutoff_date) + '</td>' +
                                    '<td style="text-align: center;">' + fixedNull(firstData.hub_code) + '</td>';

                                for (var j in quantityWeek) {
                                    tdHtml += '<td style="text-align: center;">' + quantityWeek[j] + '</td>';
                                }

                                var total = 0;
                                for (var k in quantityMonth) {
                                    total += quantityMonth[k];
                                    tdHtml += '<td style="background-color: #C0C0C0; text-align: center;">' + quantityMonth[k] + '</td>';
                                }
                                tdHtml += '<td style="background-color: #808080; font-weight: bold; text-align: center;">' + total + '</td>';
                                html += '<tr>' + tdHtml + '</tr>';
                            }
                        }
                        $('#tblPreview thead').html(thead);
                        $('#tblPreview tbody').html(html);
                        $('#tblPreview').removeClass('hidden');

                        $('#modal-preview').modal('show');
                        $('.no-data').addClass('hidden');

                        // var isActiveETACTab = document.getElementsByClassName('etac-tab')[0].className.indexOf('active');
                        // if (isActiveETACTab > -1 && type == 'Input ETAC') {
                        //     $('.btn-download').removeClass('hidden');
                        // } else {
                        //     $('.btn-download').addClass('hidden');
                        // }
                    } else {
                        $('#tblPreview').addClass('hidden');
                        $('.no-data').removeClass('hidden');
                        $('#modal-preview').modal('show');

                    }
                } else {
                    showAlertJS('error', res.message);
                }
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
            }
        });
    }

    $('#modal-preview').on('hidden.bs.modal', function () {
        if (dataset.listFiles == true) {
            $('#modal-list-files').modal('show');
            dataset.listFiles == false;
        }
    });

    function createFormPreview(code, listFiles) {
        dataset.listFiles = listFiles;
        if (listFiles == true) {
            $('#modal-list-files').modal('hide');
        }

        $('.loader').removeClass('hidden');
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/createForm/createFormByCode',
            data: {
                code: code,
            },
            success: function (res) {
                var data = res.result;
                if (!isObjectEmpty(data)) {
                    for (var i = 0; i < data.list.length; i++) {
                        $('#cf-customer').val(data.list[i].end_customer);
                        $('#cf-plant').val(data.list[i].plant);
                        $('#cf-customerCode').val(data.list[i].customer_code);
                        $('#cf-type').val(data.list[i].type);
                        $('#cf-creator').val(data.list[i].creator_name + ' - ' + data.list[i].creator_idCard);
                        $('#cf-createAt').val(data.list[i].created_at);
                        $('#cf-week').val(data.list[i].week);
                    }

                    $('#tbl-process-sign tbody').html('');
                    if (!isArrayEmpty(data.sign) && !isFalsy(data.sign)) {
                        for (var i = 0; i < data.sign.length; i++) {
                            var status = '';
                            if (data.sign[i].status == 0) {
                                status = '<span class="text-warning">Waiting</span>';
                            } else if (data.sign[i].status == 1) {
                                status = '<span class="text-success">Approved</span>';
                            } else if (data.sign[i].status == 2) {
                                status = '<span class="text-danger">Rejected</span>';
                            }

                            var html =
                                '<tr>' +
                                '<td>' + (i + 1) + '</td>' +
                                '<td>' + formatEmpty(data.sign[i].name) + '</td>' +
                                '<td>' + formatEmpty(data.sign[i].id_card) + '</td>' +
                                '<td>' + formatEmpty(data.sign[i].mail) + '</td>' +
                                '<td>' + formatEmpty(data.sign[i].permission) + '</td>' +
                                '<td>' + formatEmpty(data.sign[i].rank_sign) + '</td>' +
                                '<td>' + formatEmpty(data.sign[i].detail_comment) + '</td>' +
                                '<td>' + formatEmpty(data.sign[i].date_approve) + '</td>' +
                                '<td>' + status + '</td>' +
                                '</tr>';
                            $('#tbl-process-sign tbody').append(html);
                        }
                    } else {
                        $('#tbl-process-sign tbody').append('<tr><td colspan="9">No data to display</<td></tr>');
                    }
                }
            },
            error: function (err) {
                console.log(err);
                $('.loader').addClass('hidden');
            },
            complete: function () {
                $('.loader').addClass('hidden');
                $('#modal-preview-create-form').modal('show');

            }
        });
    }

    $('#modal-preview-create-form').on('hidden.bs.modal', function () {
        if (dataset.listFiles == true) {
            $('#modal-list-files').modal('show');
            dataset.listFiles == false;
        }
    });

    function getListFiles(week) {
        $('.loader').removeClass('hidden');
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/createForm/getListCreateFormOfETACComparison',
            data: {
                week: week
            },
            success: function (res) {
                var data = res.data;
                var html = '';
                if (Array.isArray(data) && data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        html +=
                            '<tr>' +
                            '<td>' + (i + 1) + '</td>' +
                            '<td onclick="createFormPreview(\'' + data[i].code + '\',' + 'true' + ')"><a href="#">' + data[i].code + '</a></td>' +
                            '<td onclick="filePreview(' + data[i].id + ',\'' + data[i].type + '\',' + 'true' + ')"><a href="#">' + data[i].file_name + '</a></td>' +
                            '<td>' + data[i].week + '</td>' +
                            '<td>' + data[i].name + '<br/>(' + data[i].id_card + ')' + '</td>' +
                            '</tr>';
                    }
                } else {
                    html = '<tr><td colspan="5">No data to display</td></tr>';
                }
                $('#tbl-list-files tbody').html(html);
                $('#modal-list-files').modal('show');
            },
            error: function (err) {
                $('.loader').addClass('hidden');
                console.log(err);
            },
            complete: function () {
                $('.loader').addClass('hidden');
            }
        });
    }

    function deleteFile(idCreateForm) {
        var confirm = window.confirm('Do you want to delete?');
        if (confirm) {
            $('.loader').removeClass('hidden');
            $.ajax({
                type: 'POST',
                url: '/pm-system/api/createForm/deleteCreateForm',
                data: {
                    idCreateForm: idCreateForm
                },
                success: function (res) {
                    showAlertJS('success', res.message);
                    if ($('#po-tab').hasClass('active')) {
                        loadListFile('PO', '')
                    } else if ($('#fo-tab').hasClass('active')) {
                        loadListFile('FO', '')
                    } else if ($('#shipment-tab').hasClass('active')) {
                        loadListFile('Shipment', '')
                    } else if ($('#etac-tab').hasClass('active')) {
                        loadListFile('ETAC', '')
                    }
                },
                error: function (err) {
                    $('.loader').addClass('hidden');
                    console.log(err);
                },
                complete: function () {
                    $('.loader').addClass('hidden');
                }
            });
        }
    }

    function fixedNull(text) {
        var res = '';
        if (text != null && text != undefined) {
            res = text;
        }
        return res;
    }

    $('#txt_filter_po').on('keyup', function (e) {
        if (e.keyCode == 13) {
            loadListFile('PO', $(this).val().trim());
        }
    });
    $('#txt_filter_fo').on('keyup', function (e) {
        if (e.keyCode == 13) {
            loadListFile('FO', $(this).val().trim());
        }
    });
    $('#txt_filter_shipment').on('keyup', function (e) {
        if (e.keyCode == 13) {
            loadListFile('Shipment', $(this).val().trim());
        }
    });
    $('#txt_filter_etac').on('keyup', function (e) {
        if (e.keyCode == 13) {
            loadListFile('ETAC', $(this).val().trim());
        }
    });

    function searchData(type) {
        var type1 = type2 = '';
        if (type == 'po') {
            type1 = 'po';
            type2 = 'PO'
        } else if (type == 'fo') {
            type1 = 'fo';
            type2 = 'FO'
        } else if (type == 'shipment') {
            type1 = 'shipment';
            type2 = 'Shipment'
        } else if (type == 'etac') {
            type1 = 'etac';
            type2 = 'ETAC'
        }
        var value = $('#txt_filter_' + type1).val().trim();
        loadListFile(type2, value);
    }

    function checkType(type) {
        switch (type) {
            case 'PO': {
                var thead =
                    '<tr>' +
                    '<th>#</th>' +
                    '<th>PO</th>' +
                    '<th>Line</th>' +
                    '<th>PN</th>' +
                    '<th>Quantity</th>' +
                    '<th>ERD</th>' +
                    '<th>Unit price</th>' +
                    '<th>Currency</th>' +
                    '<th>Amount</th>' +
                    '<th>PO date</th>' +
                    '<th>PN desc</th>' +
                    '<th>Priority</th>' +
                    '<th>Priority desc</th>' +
                    '<th>PO type</th>' +
                    '<th>PO type desc</th>' +
                    '<th>Payment terms</th>' +
                    '<th>Payment terms desc</th>' +
                    '<th>Shipment terms</th>' +
                    '<th>Shipment terms desc</th>' +
                    '<th>Inco terms</th>' +
                    '<th>Inco terms desc</th>' +
                    '<th>Bill to party name</th>' +
                    '<th>Bill to party code</th>' +
                    '<th>Bill to party address</th>' +
                    '<th>End user name</th>' +
                    '<th>End user code</th>' +
                    '<th>End user address</th>' +
                    '<th>Manufacturer name</th>' +
                    '<th>Shipto name</th>' +
                    '<th>Shipto code</th>' +
                    '<th>Shipto address</th>' +
                    '<th>Lasteditdt</th>' +
                    '<th>File name</th>' +
                    '<th>Flag</th>' +
                    '<th>Site</th>' +
                    '<th>Item</th>' +
                    '<th>ISA 13</th>' +
                    '</tr>';
                return thead;
            }
            case 'Shipment': {
                var thead =
                    '<tr>' +
                    '<th>#</th>' +
                    '<th>Plant</th>' +
                    '<th>Material</th>' +
                    '<th>Quantity</th>' +
                    '<th>Amount LC</th>' +
                    '<th>Batch</th>' +
                    '<th>Sloc</th>' +
                    '<th>MvT</th>' +
                    '<th>Mat doc</th>' +
                    '<th>Pstg date</th>' +
                    '<th>Time</th>' +
                    '<th>PO</th>' +
                    '<th>Vendor</th>' +
                    '<th>Order</th>' +
                    '<th>Cost ctr</th>' +
                    '<th>Descr</th>' +
                    '<th>Text</th>' +
                    '<th>User</th>' +
                    '<th>Item</th>' +
                    '<th>Customer</th>' +
                    '<th>Crr</th>' +
                    '<th>Reference</th>' +
                    '</tr>';
                return thead;
            }
            default:
                break;
        }
    }

    var exportToExcel = function (table) {
        var tblExport = document.getElementById(table);
        var html = '';
        for (var i = 0; i < tblExport.rows.length; i++) {
            var frame = tblExport.rows[i].innerHTML;
            if (frame != '') {
                html += '<tr>' + frame + '</tr>';
            }
        }

        html = '<table border="1">' + html + '</table>';

        var browser = window.navigator.userAgent;
        if (browser.indexOf('MSIE') > -1 || browser.indexOf('Trident') > -1) {
            window.document.open("data:application/vnd.ms-excel;");
            window.document.write(html);
            window.document.close();
            sa = window.document.execCommand("SaveAs", true, "Output_ETAC.xls");
            return sa;

        } else {
            var link = window.document.createElement("a");
            link.setAttribute("href", "data:application/vnd.ms-excel;charset=utf-8,%EF%BB%BF" + encodeURIComponent(html));
            link.setAttribute("download", "Input_ETAC.xls");
            link.click();
        }
    }
</script>