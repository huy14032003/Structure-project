<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    .row {
        margin: 0;
    }

    #header {
        font-size: 18px;
        font-weight: bold;
        text-align: center;
        margin: 5px 10px;
        padding: 6px 15px;
        background: #006699;
        color: #FFF;
    }

    .style-form {
        display: block;
        width: 100%;
        background-color: #FFFFFF;
        border-radius: 3px;
        box-shadow: 5px 5px 5px rgb(0 0 0 / 12%), 0 3px 4px rgb(0 0 0 / 24%);
        border: 1px solid #ccc;
        margin-bottom: 10px;
    }

    .style-form .form-title {
        display: block;
        width: 100%;
        border-bottom: 1px solid #ccc;
        padding: 8px 15px;
    }

    .style-form .form-title>span {
        font-size: 16px;
        font-weight: bold;
    }

    .lable-title {
        display: block;
        width: 100%;
        text-align: right;
        font-weight: bold;
        line-height: 32px;
    }

    .form-control {
        color: #495057;
        background-color: #fff;
        background-clip: padding-box;
        border: 1px solid #ced4da;
        box-shadow: inset 0 0 0 transparent;
        transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
        border-radius: 3px;
        padding: 3px 8px;
        height: 32px;
    }

    .form-control:focus {
        outline: unset;
        border-color: #0267bd;
        -webkit-box-shadow: 0 1px 5px #0267bd;
        box-shadow: 0 1px 5px #0267bd;
    }

    .btn-sm {
        padding: 6px 15px;
    }

    .tbl-custom thead th {
        background-color: #006699;
        color: #FFF;
        text-align: center;
        border: 1px solid #CCC;
        padding: 4px 5px !important;
        position: sticky;
        top: -1px;
        z-index: 1;
    }

    .tbl-custom tbody td {
        padding: 4px 5px !important;
        text-align: center;
        border: 1px solid #ccc;
    }

    .tbl-custom thead th.bg-yellow,
    .tbl-custom tbody td.bg-yellow {
        background-color: #FFFF00;
        color: #101010;
    }

    .input-filter {
        float: right;
        background-color: #D2DEEF;
        width: 250px;
        margin-top: -5px;
    }

    .btn-warning {
        color: #1f2d3d;
        background-color: #ffc107;
        border-color: #ffc107;
    }

    .btn-warning:hover {
        color: #1f2d3d;
        background-color: #e0a800;
        border-color: #d39e00;
    }

    .btn-warning:not(:disabled):not(.disabled).active,
    .btn-warning:not(:disabled):not(.disabled):active,
    .show>.btn-warning.dropdown-toggle {
        color: #1f2d3d;
        background-color: #d39e00;
        border-color: #c69500;
    }

    .btn-custom {
        float: right;
        padding: 2px 10px;
        color: #FFF
    }

    .btn-note {
        float: right;
        padding: 2px 5px;
    }

    .btn-note>i {
        font-size: 13px;
    }

    .btn-select {
        width: 80%;
        background: #FFF;
        border: 1px solid #ccc;
        text-transform: unset;
        text-align: left;
    }

    .btn-preview {
        width: 15%;
        float: right;
        padding: 6px 15px;
    }

    #tblPreview thead th {
        background-color: #006699;
        color: #FFF;
        text-align: center;
        border: 1px solid #ccc;
        padding: 0.5rem;
        white-space: nowrap;
    }

    #tblPreview tbody td {
        padding: 4px 10px;
        border: 1px solid #ccc;
        text-align: center;
    }

    #tblProcess td {
        color: #000066;
    }

    .tbl-res-custom {
        max-height: 550px;
        overflow: auto;
    }
</style>
<div class="loader hidden"></div>
<div class="panel panel-re panel-flat row">
    <div class="panel panel-overview" id="header">
        <span>ETAC COMPARISON</span>
    </div>
    <div class="row mt-15">
        <div class="col-md-12" style="padding: 0 10px;">
            <div class="style-form">
                <div class="form-title"><span>Select File</span></div>
                <div class="row pt-15 pb-15">
                    <div class="col-sm-12">
                        <div class="row row_input">
                            <div class="col-sm-1">
                                <label class="lable-title">Area:</label>
                            </div>
                            <div class="col-sm-3">
                                <select class="form-control" id="txt_area">
                                    <option value="TN">Domestic</option>
                                    <option value="NN">International</option>
                                </select>
                            </div>

                            <div class="col-sm-1">
                                <label class="lable-title">Week:</label>
                            </div>
                            <div class="col-sm-3">
                                <select class="form-control" id="sl-week"></select>
                            </div>

                            <div class="col-sm-1">
                                <label class="lable-title">Select FO:</label>
                            </div>
                            <div class="col-sm-3">
                                <button id="btn_FO" class="btn btn-sm btn-select" onclick="loadListType('FO')">Select File..</button>
                                <button id="btnPreviewFO" class="btn btn-preview btn-primary"><i class="fa fa-eye"></i></button>
                                <select class="form-control hidden" id="sl_FO">
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                        <div class="row row_input">
                            <div class="col-sm-1">
                                <label class="lable-title">Factory:</label>
                            </div>
                            <div class="col-sm-3">
                                <select class="form-control" id="txt_factory"></select>
                            </div>

                            <div class="col-sm-1">
                                <label class="lable-title">Select PO:</label>
                            </div>
                            <div class="col-sm-3">
                                <button id="btn_PO" class="btn btn-sm btn-select" onclick="loadListType('PO')">Select File..</button>
                                <button id="btnPreviewPO" class="btn btn-preview btn-primary"><i class="fa fa-eye"></i></button>
                                <select class="form-control hidden" id="sl_PO">
                                    <option value=""></option>
                                </select>
                            </div>

                            <div class="col-sm-1">
                                <label class="lable-title">WKB0:</label>
                            </div>
                            <div class="col-sm-3">
                                <button id="btn_WKB0" class="btn btn-sm btn-select" onclick="loadListType('WKB0')">Select File..</button>
                                <button id="btnPreviewWKB0" class="btn btn-preview btn-primary"><i class="fa fa-eye"></i></button>
                                <select class="form-control hidden" id="sl_WKB0">
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                        <div class="row row_input">
                            <div class="col-sm-1">
                                <label class="lable-title">Customer:</label>
                            </div>
                            <div class="col-sm-3">
                                <select class="form-control" id="txt_end_customer"></select>
                            </div>

                            <div class="col-sm-1">
                                <label class="lable-title">Shipment:</label>
                            </div>
                            <div class="col-sm-3">
                                <button id="btn_Shipment" class="btn btn-sm btn-select" onclick="loadListType('Shipment')">Select File..</button>
                                <button id="btnPreviewShipment" class="btn btn-preview btn-primary"><i class="fa fa-eye"></i></button>
                                <select class="form-control hidden" id="sl_Shipment">
                                    <option value=""></option>
                                </select>
                            </div>

                            <div class="col-sm-1">
                                <label class="lable-title">WKB1:</label>
                            </div>
                            <div class="col-sm-3">
                                <button id="btn_ETAC" class="btn btn-sm btn-select" onclick="loadListType('ETAC')">Select File..</button>
                                <button id="btnPreviewETAC" class="btn btn-preview btn-primary"><i class="fa fa-eye"></i></button>
                                <select class="form-control hidden" id="sl_ETAC">
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div style="display: flex;align-items: center;justify-content: space-between;">
                        <button class="btn ml-20 btn-primary" style="width: 150px;" onclick="showPrrocess()">Process</button>
                        <button class="btn mr-20 hidden btnExport" style="background-color: #2196F3;border: 1px solid #2196F3;color: #fff;" onclick="exportToExcel('tblProcess')"><i class="fa fa-download"></i> Export Excel</button>
                    </div>
                    <div class="col-md-12 " style="padding: 10px 20px">
                        <div class="table-responsive tbl-res-custom">
                            <table id="tblProcess" class="table tbl-custom table-bordered table-sticky">
                                <thead></thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Note-->
    <div class="modal fade" id="modal-note">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Note</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <label class="control-label text-bold no-margin">Input Content</label>
                            <textarea class="form-control" style="padding: 5px;" id="txt_input_content" type="text" value="" spellcheck="false" rows="5"></textarea>
                            <input class="forn-control hidden" type="text" id="txt_wk">
                            <input class="forn-control hidden" type="text" id="txt_type_note">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm btn-primary" onclick="submitNote()"><i class="fa fa-check-circle"></i> Submit</button>
                    <button class="btn btn-sm btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal selcect File-->
    <div class="modal fade" id="modal-choose-file">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"></i> Select File</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="style-form">
                        <div class="form-title">
                            <span>List File ETAC</span>
                            <input id="txt_filter" type="text" class="form-control input-filter" placeholder="Search...">
                        </div>
                        <div class="row" style="margin-bottom: 15px;">
                            <div class="col-sm-12 no-padding table-responsive pre-scrollable" style="max-height: calc(100vh - 250px);">
                                <table id="tblListFile" class="table tbl-custom table-small table-sticky">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Code</th>
                                            <th>File Name</th>
                                            <th>Created At</th>
                                            <th>Creator</th>
                                            <th>Preview</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm bg-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Preview-->
    <div class="modal fade" id="modal-preview">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"></i> Preview</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row" style="margin-bottom: 15px;">
                        <div class="col-sm-12 no-padding table-responsive pre-scrollable" style="max-height: calc(100vh - 250px); overflow: auto;">
                            <table id="tblPreview" class="table table-small table-sticky" style="min-width: 100vw;">
                                <thead></thead>
                                <tbody></tbody>
                            </table>
                            <div class="hidden no-data text-center">--No data--</div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm bg-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var dataset = {
        "empNo": 'V0946495',
        "empName": 'Nguyễn Đức Tiến',
        "pn": "",
        "factory": "",
        "endCustomer": "",
        "typePO": "",
        "fileName": ""
    }

    $(document).ready(function () {
        init();
    });

    function init() {
        loadListSide();
    }

    function loadListSide() {
        $('#txt_area').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/listSide",
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].side + '">' + data[i].side + '</option>';
                }
                $('#txt_area').html(html);
                if (data.length > 0) {
                    dataset.side = data[0].side;
                }
                $('#txt_area').val(dataset.side);
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
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].factory + '">' + data[i].factory + '</option>';
                }
                $('#txt_factory').html(html);
                if (data.length > 0) {
                    dataset.factory = data[0].factory;
                }
                $('#txt_factory').val(dataset.factory);
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                loadListCustomer();
            }
        });
    }

    function loadListCustomer() {
        $('#txt_end_customer').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/createForm/listEndCustomerByFactoryAndSide",
            data: {
                side: dataset.side,
                factory: dataset.factory
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].end_customer + '">' + data[i].end_customer + '</option>';
                }
                $('#txt_end_customer').html(html);
                if (data.length > 0) {
                    dataset.endCustomer = data[0].end_customer;
                }
                $('#txt_end_customer').val(dataset.endCustomer);
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                getWeek();
            }
        });
    }

    function getWeek() {
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/createForm/listWeekCreateForm',
            data: {
                type: 'Input ETAC',
                side: dataset.side,
                factory: dataset.factory,
                endCustomer: dataset.endCustomer
            },
            success: function (res) {
                var data = res.data;
                var html = '';
                for (var i in data) {
                    html += '<option value="' + data[i].week + '">' + data[i].week + '</option>';
                }
                $('#sl-week').html(html);
            },
            error: function (err) {

            },
            complete: function () {
                dataset.weekSelect = $('#sl-week').val();
            }
        });
    }

    $('#sl-week').on('change', function () {
        dataset.weekSelect = $(this).val();
        $('.btn-select').html('Select File..');
    });

    function loadListType(type) {
        $('#sl_' + type).html('');

        var typeName = type;
        if (type == "ETAC" || type == 'WKB0') {
            typeName = "Input ETAC";
        }

        var url = '';
        if (type == 'WKB0') {
            url = '/pm-system/api/sign/listCreateFormByTypeWKB0';
        } else {
            url = '/pm-system/api/sign/listCreateFormByTypeOutputETAC';
        }
        $.ajax({
            type: "GET",
            url: url,
            data: {
                side: dataset.side,
                factory: dataset.factory,
                endCustomer: dataset.endCustomer,
                type: typeName,
                fileName: dataset.fileName,
                week: dataset.weekSelect
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.result;

                $('#tblListFile tbody').html('');
                var html = '';
                for (i in data) {
                    html += '<tr><td>' + (Number(i) + 1) + '</td>' +
                        '<td>' + data[i].code + '</td>' +
                        '<td><a href="#" data-type="' + type + '" data-id="' + data[i].id_file + '" onclick="chooseFile(this)">' + data[i].file_name + '</a></td>' +
                        '<td>' + data[i].updated_at + '</td>' +
                        '<td>' + data[i].creator_name + ' (' + data[i].creator_card + ')</td>' +
                        '<td><button class="btn btn-custom btn-success" onclick="filePreview(' + data[i].id_file + ',\'' + typeName + '\')"><i class="fa fa-eye"></i></td>' +
                        '</tr>';
                }
                $('#tblListFile tbody').html(html);
                $('#modal-choose-file').modal('show');
                $('#txt_filter').attr('data-type', type);

                var options = '';
                for (i in data) {
                    options += '<option value="' + data[i].id_file + '">' + data[i].file_name + '</option>';
                }
                $('#sl_' + type).html(options);
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
            }
        });
    }

    function chooseFile(context) {
        var type = context.dataset.type;
        var id = context.dataset.id;
        var text = $(context).html();
        var typeName = type;
        if (type == "ETAC" || type == 'WKB0') {
            typeName = "Input ETAC";
        }

        $('#btn_' + type).html(text);
        $('#sl_' + type).val(id);
        $('#btnPreview' + type).attr('onclick', 'filePreview(' + id + ',\'' + typeName + '\')');
        $('#modal-choose-file').modal('hide');
    }

    $('#modal-choose-file').on('hidden.bs.modal', function () {
        dataset.fileName = '';
        $('#txt_filter').val('');
    });

    $('#txt_filter').on('keyup', function (e) {
        if (e.keyCode == 13) {
            dataset.fileName = $(this).val();
            loadListType(this.dataset.type);
        }
    });

    $('#txt_factory').on('change', function () {
        dataset.factory = $(this).val();
        loadListCustomer();
        $('.btn-select').html('Select File..');
        $('.btn-preview').removeAttr('onclick');
    });

    $('#txt_end_customer').on('change', function () {
        dataset.endCustomer = $(this).val();
        $('.btn-select').html('Select File..');
        $('.btn-preview').removeAttr('onclick');
    });

    function showPrrocess() {
        var tbody = '';
        var thead = '';
        if ($('#sl_PO').val() == '' || $('#sl_FO').val() == '' || $('#sl_Shipment').val() == '' || $('#sl_ETAC').val() == '') {
            alert('File is EMPTY!');
        } else {
            $('.loader').removeClass('hidden');
            $('#tblProcess thead').html('');
            $('#tblProcess tbody').html('');
            $.ajax({
                type: "POST",
                url: "/pm-system/api/compareETAC/upload",
                data: {
                    side: dataset.side,
                    factory: dataset.factory,
                    endCustomer: dataset.endCustomer,
                    idCard: dataset.empNo,
                    idPO: $('#sl_PO').val(),
                    idFO: $('#sl_FO').val(),
                    idShipment: $('#sl_Shipment').val(),
                    idETAC: $('#sl_ETAC').val(),
                    idETAC0: $('#sl_WKB0').val(),
                    week1: dataset.weekSelect
                },
                success: function (data) {
                    //Load thead
                    var productCode = data['productCode'];
                    var projects = data['Project'];
                    var etac = data['ETAC'];

                    for (var i in productCode) {
                        var data1 = productCode[i];
                        for (var j in data1) {
                            var data2 = data1[j];
                            for (var k = 0; k < 1; k++) {
                                var data3 = data2[k];
                                var dataTable = data3.data;
                                var quantityWeek = data3.quantityWeek;
                                var quantityMonth = data3.quantityMonth;

                                thead =
                                    '<th style="background-color: #006699;color:#fff;">編輯</th>' +
                                    '<th style="background-color: #006699;color:#fff;">Plant</th>' +
                                    '<th style="background-color: #006699;color:#fff;">End customer</th>' +
                                    '<th style="background-color: #006699;color:#fff;">Foxconn P/N</th>' +
                                    '<th style="background-color: #006699;color:#fff;white-space: nowrap;">Product code</th>' +
                                    '<th style="background-color: #006699;color:#fff;">Ship cutoff date</th>' +
                                    '<th style="background-color: #006699;color:#fff;">Hub code</th>';

                                for (var x in quantityWeek) {
                                    thead += '<th style="background-color: #006699;color:#fff;">' + x + '</th>';
                                }

                                for (var y in quantityMonth) {
                                    thead += '<th style="background-color: #006699;color:#fff;white-space: nowrap;">' + y + '</th>';
                                }

                                thead += '<th style="background-color: #006699;color:#fff;">Total</th>';
                                thead = '<tr>' + thead + '</tr>';
                                break;
                            }
                            break;
                        }
                        break;
                    }

                    // Load tbody
                    var numberChange = 0;
                    for (var i in productCode) {
                        var data1 = productCode[i];
                        for (var j in data1) {
                            var data2 = data1[j];
                            for (var k = 0; k < data2.length; k++) {
                                var data3 = data2[k];
                                var dataTable = data3.data;
                                var quantityWeek = data3.quantityWeek;
                                var quantityMonth = data3.quantityMonth;
                                var html = frameTable('productcode', dataTable, quantityWeek, quantityMonth, numberChange);
                                tbody += html;
                            }

                        }

                        var data1_project = projects[i];
                        for (var j = 0; j < data1_project.length; j++) {
                            var data2_project = data1_project[j];
                            var dataTable = data2_project.data;
                            var quantityWeek = data2_project.quantityWeek;
                            var quantityMonth = data2_project.quantityMonth;
                            var html = frameTable('project', dataTable, quantityWeek, quantityMonth, numberChange);
                            tbody += html;
                        }
                        numberChange++;
                    }

                    for (var i in etac) {
                        var dataTable = etac[i].data;
                        var quantityWeek = etac[i].quantityWeek;
                        var quantityMonth = etac[i].quantityMonth;
                        var numberChange = null;
                        var html = frameTable('etac', dataTable, quantityWeek, quantityMonth, numberChange);
                        tbody += html;
                    }
                    $('.btnExport').removeClass('hidden');
                },
                error: function (errMsg) {
                    console.log(errMsg);
                },
                complete: function () {
                    $('.loader').addClass('hidden');
                    $('#tblProcess thead').html(thead);
                    $('#tblProcess tbody').html(tbody);
                }
            });
        }
    }

    function frameTable(form, data, quantityWeek, quantityMonth, numberChange) {
        // console.log(quantityWeek)
        var totalMonth = 0;
        var backgroundColor = '';
        var html = '';
        var arrColor = ['#f3f270', '#9BC2E6'];

        if (data['編輯'] == 'WKB1-WKB0' || data['編輯'] == 'WKB1-WKA1') {
            backgroundColor = 'background-color: #0fc00f;';
        } else {
            if (form == 'productcode' || form == 'project') {
                if (numberChange % 2 == 0) backgroundColor = 'background-color:' + arrColor[0] + ';';
                else {
                    backgroundColor = 'background-color:' + arrColor[1] + ';';
                }
            }
        }

        if (form == 'project' && data['編輯'] == '編輯') {
            totalMonth = '';
        }

        html =
            '<td style="' + backgroundColor + 'white-space: nowrap;text-align: left;color: #0563C1;">' + data['編輯'] + '</td>' +
            '<td style="' + backgroundColor + 'white-space: nowrap;text-align: center;">' + data['plant'] + '</td>' +
            '<td style="' + backgroundColor + 'white-space: nowrap;text-align: center;">' + data['end_customer'] + '</td>' +
            '<td style="' + backgroundColor + 'white-space: nowrap;text-align: center;">' + data['foxconn_pn'] + '</td>' +
            '<td style="' + backgroundColor + 'white-space: nowrap;text-align: center;">' + data['product_code'] + '</td>' +
            '<td style="' + backgroundColor + 'white-space: nowrap;text-align: center;">' + data['ship_cutoff_date'] + '</td>' +
            '<td style="' + backgroundColor + 'white-space: nowrap;text-align: center;">' + data['hub_code'] + '</td>';

        if (form == 'productcode') {
            for (var x in quantityWeek) {
                html +=
                    '<td style="' + highLight(quantityWeek[x], data['編輯']) + 'position: relative; text-align: center;width: 80px;">' + quantityWeek[x] +
                    '<i class="fa fa-edit" data-form="' + data['編輯'] + '" data-foxconnpn="' + data['foxconn_pn'] + '" data-weekyear ="' + x + '" onclick="addNote(this)" style="position:absolute; top: 3%;right: 3%;"></i>' +
                    '</td>';
            }
        } else {
            for (var x in quantityWeek) {
                html += '<td style="' + highLight(quantityWeek[x], data['編輯']) + 'position: relative;text-align:center;width: 80px;">' + quantityWeek[x] + '</td>';
            }
        }

        for (var y in quantityMonth) {
            totalMonth += quantityMonth[y];
            html += '<td style="background:#C0C0C0;' + highLight(quantityMonth[y], data['編輯']) + 'text-align:center;">' + quantityMonth[y] + '</td>';
        }

        html += '<td style="font-weight: 500;' + ((totalMonth >= 0 || !!totalMonth == false) ? 'background:#808080;color: #000066;text-align: center;font-weight: 500;' : 'background:#f33c3c;color: #000066;') + 'text-align: center;font-weight: 500;">' + totalMonth + '</td>';
        html = '<tr>' + html + '</tr>';

        return html;
    }

    function highLight(val, form) {
        if (form == 'WKB1-WKB0' || form == 'WKB1-WKA1') {
            if (Number(val) < 0) return 'background-color: #FF0000;';
            return 'background-color: #32CD32;';
        }
        return '';
    }

    const mergeRow = function (param) {
        var rowObj = {};
        var elem = document.getElementsByClassName(param);

        for (var i = 0; i < elem.length; i++) {
            var param_name = elem[i].getAttribute(param + '_name');
            if (rowObj[param_name] == null) {
                rowObj[param_name] = 1;
            } else {
                rowObj[param_name] += 1;
            }
        }

        for (var i in rowObj) {
            $('.' + param + '-' + i + ':not(:first)').remove();
            var param_first = document.getElementsByClassName(param + '-' + i);
            param_first[0].setAttribute("rowspan", rowObj[i]);
        }
    }

    function fixNull(text) {
        var res = '';
        if (text != null && text != undefined && text != '0') {
            res = text;
        }
        return res;
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
            link.setAttribute("download", "ETAC_Comparision_"+dataset.weekSelect+".xls");
            link.click();
        }
    }

    function addNote(context) {
        $('#modal-note').modal('show');
        var weekYear = context.dataset.weekyear.split(',');
        dataset.context = context;
        dataset.foxconnPN = context.dataset.foxconnpn;
        dataset.form = context.dataset.form;
        dataset.week = weekYear[1].slice(0, 7).split(' ')[1] * 1;
        dataset.year = weekYear[0].split('-')[0].split('/')[0] * 1;
        getNote();
    }

    function submitNote() {
        var pn = $('#txt_pn').val();
        var end_customer = $('#txt_end_customer').val();
        var factory = $('#txt_factory').val();
        var plant = $('#txt_plant').val();
        var customer = $('#txt_customer').val();

        $('.loader').removeClass('hidden');
        $.ajax({
            type: 'POST',
            url: "/pm-system/api/compareETAC/addNote",
            data: {
                side: dataset.side,
                factory: dataset.factory,
                endCustomer: dataset.endCustomer,
                note: $('#txt_input_content').val(),
                week: dataset.week,
                type: dataset.form,
                year: dataset.year,
                foxconnPN: dataset.foxconnPN
            },
            success: function (res) {
                if (res.code == 'SUCCESS') {
                    alert(res.message);
                    $('#txt_input_content').val('');
                    $('#modal-note').modal('hide');
                }
                var context = dataset.context;
                context.className = "fa fa-comment text-warning";
            },
            error: function (err) {
                console.log("Error:", err);
            },
            complete: function () {
                $('.loader').addClass('hidden');
            }
        });
    }

    function getNote() {
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/compareETAC/getNote',
            data: {
                side: dataset.side,
                week: dataset.week, //$('#txt_wk').val(),
                type: dataset.form, //$('#txt_type_note').val(),
                factory: dataset.factory,
                endCustomer: dataset.endCustomer,
                year: dataset.year,
                foxconnPN: dataset.foxconnPN
            },
            success: function (res) {
                var data = res.result;
                if (!$.isEmptyObject(data)) {
                    var note = data.note;
                    $('#txt_input_content').val(note);
                } else {
                    $('#txt_input_content').val('');
                }
            },
            error: function (error) {
                console.log('Error:', error);
            }
        });
    }

    function filePreview(id, type) {
        $('.loader').removeClass('hidden');
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
                    if (data.length > 0) {
                        var thead = checkType(type);
                        if (type == 'PO') {
                            for (i in data) {
                                html += '<tr><td>' + (Number(i) + 1) + '</td>' +
                                    '<td>' + fixedNull(data[i].po) + '</td>' +
                                    '<td>' + fixedNull(data[i].line) + '</td>' +
                                    '<td>' + fixedNull(data[i].plant) + '</td>' +
                                    '<td>' + fixedNull(data[i].customer_code) + '</td>' +
                                    '<td>' + fixedNull(data[i].customer) + '</td>' +
                                    '<td>' + fixedNull(data[i].customer_pn) + '</td>' +
                                    '<td>' + fixedNull(data[i].foxconn_pn) + '</td>' +
                                    '<td>' + fixedNull(data[i].quantity) + '</td>' +
                                    '<td>' + fixedNull(data[i].erd) + '</td>' +
                                    '<td>' + fixedNull(data[i].unit_price) + '</td>' +
                                    '<td>' + fixedNull(data[i].currency) + '</td>' +
                                    '<td>' + fixedNull(data[i].amount) + '</td>' +
                                    '<td>' + fixedNull(data[i].po_date) + '</td>' +
                                    '<td>' + fixedNull(data[i].pn_desc) + '</td>' +
                                    '<td>' + fixedNull(data[i].payment_terms) + '</td>' +
                                    '<td>' + fixedNull(data[i].shipment_terms) + '</td>' +
                                    '<td>' + fixedNull(data[i].inco_terms) + '</td>' +
                                    '<td>' + fixedNull(data[i].bill_to_party_address) + '</td>' +
                                    '<td>' + fixedNull(data[i].shipto_address) + '</td></tr>';
                            }
                        } else if (type == 'Shipment') {
                            for (i in data) {
                                html += '<tr><td>' + (Number(i) + 1) + '</td>' +
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
                                    '<td>' + fixedNull(data[i].order_low) + '</td>' +
                                    '<td>' + fixedNull(data[i].cost_ctr) + '</td>' +
                                    '<td>' + fixedNull(data[i].descr) + '</td>' +
                                    '<td>' + fixedNull(data[i].head_text) + '</td>' +
                                    '<td>' + fixedNull(data[i].users) + '</td>' +
                                    '<td>' + fixedNull(data[i].item) + '</td>' +
                                    '<td>' + fixedNull(data[i].customer) + '</td>' +
                                    '<td>' + fixedNull(data[i].curr) + '</td>' +
                                    '<td>' + fixedNull(data[i].reference) + '</td>' +
                                    '<td>' + fixedNull(data[i].eun) + '</td></tr>';
                            }

                        } else if (type == 'FO') {
                            var data = res.data;
                            var thead = '';
                            var html = '';
                            var regEx = /^[0-9]{4}(\/|-)(0[1-9]|1[0-2])(\/|-)(0[1-9]|[1-2][0-9]|3[0-1])$/;

                            var title_header = Object.keys(data[0]);
                            thead +=
                                '<th>Product code</th>' +
                                '<th>Foxconn PN</th>' +
                                '<th>Plant</th>' +
                                '<th>End customer</th>' +
                                '<th>Customer</th>' +
                                '<th>ETAC</th>';

                            for (var i = 6; i < title_header.length; i++) {
                                thead += '<th>' + title_header[i] + '</th>';
                            }
                            thead = '<tr>' + thead + '</tr>';

                            for (var i = 0; i < data.length; i++) {
                                html +=
                                    '<td>' + fixedNull(data[i].product_code) + '</td>' +
                                    '<td>' + fixedNull(data[i].foxconn_pn) + '</td>' +
                                    '<td>' + fixedNull(data[i].plant) + '</td>' +
                                    '<td>' + fixedNull(data[i].end_customer) + '</td>' +
                                    '<td>' + fixedNull(data[i].customer) + '</td>' +
                                    '<td>' + fixedNull(data[i].etac) + '</td>';
                                for (var j in data[i]) {
                                    if (regEx.test(j)) html += '<td>' + data[i][j] + '</td>';
                                }
                                html = '<tr>' + html + '</tr>';
                            }
                        } else if (type == 'Input ETAC') {
                            var data = res.data;
                            var thead = '';
                            var html = '';
                            thead +=
                                '<th>Project</th>' +
                                '<th>Product code</th>' +
                                '<th>Foxconn PN</th>' +
                                '<th>Plant</th>' +
                                '<th>End customer</th>' +
                                '<th>Ship cutoff date</th>' +
                                '<th>Hub code</th>';

                            for (var i = 0; i < 1; i++) {
                                var firstData = data[i].data;
                                var quantityWeek = data[i].quantityWeek;
                                var quantityMonth = data[i].quantityMonth;

                                for (var j in quantityWeek) {
                                    thead += '<th>' + j + '</th>';
                                }

                                for (var k in quantityMonth) {
                                    thead += '<th>' + k + '</th>';
                                }
                                thead += '<th>Total</th>';
                            }
                            thead = '<tr>' + thead + '</tr>';

                            for (var i = 0; i < data.length; i++) {
                                var firstData = data[i].data;
                                var quantityWeek = data[i].quantityWeek;
                                var quantityMonth = data[i].quantityMonth;

                                var tdHtml =
                                    '<td>' + fixedNull(firstData.project) + '</td>' +
                                    '<td>' + fixedNull(firstData.product_code) + '</td>' +
                                    '<td>' + fixedNull(firstData.foxconn_pn) + '</td>' +
                                    '<td>' + fixedNull(firstData.plant) + '</td>' +
                                    '<td>' + fixedNull(firstData.end_customer) + '</td>' +
                                    '<td>' + fixedNull(firstData.ship_cutoff_date) + '</td>' +
                                    '<td>' + fixedNull(firstData.hub_code) + '</td>';

                                for (var j in quantityWeek) {
                                    tdHtml += '<td>' + quantityWeek[j] + '</thead>';
                                }

                                var total = 0;
                                for (var k in quantityMonth) {
                                    total += quantityMonth[k];
                                    tdHtml += '<td>' + quantityMonth[k] + '</thead>';
                                }
                                tdHtml += '<td>' + total + '</td>';
                                html += '<tr>' + tdHtml + '</tr>';
                            }
                        }
                        $('#tblPreview thead').html(thead);
                        $('#tblPreview tbody').html(html);
                        $('#modal-preview').modal('show');
                        $('#tblPreview').removeClass('hidden');
                        $('.no-data').addClass('hidden');
                    } else {
                        $('#tblPreview').addClass('hidden');
                        $('.no-data').removeClass('hidden');
                        $('#modal-preview').modal('show');
                    }

                } else {
                    alert(res.message);
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

    function fixedNull(text) {
        var res = '';
        if (text != null && text != undefined) {
            res = text;
        }
        return res;
    }

    function checkType(type) {
        switch (type) {
            case 'PO': {
                var thead =
                    '<tr>' +
                    '<th>#</th>' +
                    '<th>PO</th>' +
                    '<th>Line</th>' +
                    '<th>Plant</th>' +
                    '<th>Customer code</th>' +
                    '<th>Customer</th>' +
                    '<th>Customer P/N</th>' +
                    '<th>Foxconn P/N</th>' +
                    '<th>Qty</th>' +
                    '<th>ERD</th>' +
                    '<th>Unit price</th>' +
                    '<th>Currency</th>' +
                    '<th>Amount</th>' +
                    '<th>PO date</th>' +
                    '<th>PN desc</th>' +
                    '<th>Payment terms</th>' +
                    '<th>Shipment terms</th>' +
                    '<th>Inco terms</th>' +
                    '<th>Bill to party address</th>' +
                    '<th>Shipto address</th>' +
                    '</tr>';
                return thead;
                break;
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
                    '<th>Head text</th>' +
                    '<th>User</th>' +
                    '<th>Item</th>' +
                    '<th>Customer</th>' +
                    '<th>Crr</th>' +
                    '<th>Reference</th>' +
                    '<th>EUn</th>' +
                    '</tr>';
                return thead;
                break;
            }
            default:
                break;
        }
    }

    function flatten(arr) {
        return arr.reduce(function (pre, cur) {
            return pre.concat(cur instanceof Array ? flatten(cur) : cur);
        }, []);
    }
</script>