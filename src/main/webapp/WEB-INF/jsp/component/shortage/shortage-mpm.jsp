<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!-- <script type="text/javascript" src="/assets/js/plugins/charts/highchart/modules/pareto.js"></script> -->
<link rel="stylesheet" type="text/css" href="/assets/css/custom/critical-shortage.css">
<style>
    input[name="cbxDocNoNew"] {
        height: 20px;
        width: 20px;
    }

    .table-sm thead tr th,
    .table-sm tbody tr td {
        padding: 3px 5px;
        text-align: center;
    }

    .check-status {
        color: #ff0000;
    }
    .dataTables_paginate {
        margin: 5px 0 0 0 !important;
    }
    .dataTables_paginate .paginate_button {
        padding: 5px;
    }
</style>
<div class="loader hidden"></div>
<div class="panel panel-flat row no-margin">
    <div class="col-lg-12" style="background-color: #EBEDF9; min-height: calc(100vh - 110px);">
        <div class="panel panel-overview text-uppercase" id="header">
            <span>CTB TOOLS </span><span class="title-docno"></span>
        </div>
        <div class="row no-margin pb-5">
            <div class="col-sm-1 no-padding-left">
                <div class="input-group no-margin">
                    <input type="text" class="form-control" name="searchByPN" placeholder="Part Number">
                </div>
            </div>
            <div class="col-sm-1 no-padding-left">
                <div class="input-group no-margin">
                    <!-- <span class="input-group-addon searchProject" title="Click to Filter"><i class="fa fa-search"></i></span> -->
                    <input type="text" class="form-control" name="searchByProject" placeholder="Project">
                </div>
            </div>
            <div class="col-sm-1 no-padding-left">
                <div class="input-group no-margin">
                    <input type="text" class="form-control" name="searchByMP" placeholder="Manufacture Part#">
                </div>
            </div>
            <div class="col-sm-2">
                <select class="form-control bootstrap-select" name="slBuyer" data-live-search="true" data-focus-off="true" data-actions-box="true" multiple data-none-selected-text="Choose Buyer"></select>
            </div>
            <div class="col-sm-1">
            </div>
            <div class="col-sm-6 no-padding" style="text-align: right;">
                <button class="btn btn-primary btn-custom" data-toggle="modal" data-target="#modal-docno"><i class="icon-paragraph-justify3"></i> Doc No</button>
                <button onclick="showModalImport();" class="btn btn-primary btn-custom btnImportFile"><i class="fa fa-upload"></i> Import File</button>
                <button class="btn btn-primary btn-custom" onclick="exportData()"><i class="fa fa-download"></i> Export File</button>
                <!-- <button class="btn btn-primary btn-custom" onclick="generateCritical()"><i class="fa fa-sync"></i> Generate Critical</button> -->
                <button class="btn btn-primary btn-custom btnConfirm" onclick="confirmShortage()"><i class="fa fa-check"></i> Confirm</button>
                <button id="btnSortView" class="btn btn-primary btn-custom active" onclick="toggleView(this)"><i class="fa fa-eye"></i> Short View</button>
            </div>
        </div>
        <div class="row no-margin">
            <div class="col-sm-12 no-padding table-responsive">
                <table id="tblDetail" class="table table-hover table-sticky">
                </table>
            </div>
            <div class="col-sm-6 pt-5 pb-5">
                <div class="row" style="display: flex;align-items: center;">
                    <label for="" style="white-space: nowrap;margin-bottom: 0; margin-right: 5px;"><b>Show data: </b></label>
                    <input type="number" id="numberData" class="form-control form-control-sm" style="    width: 100px;border: 1px solid #aaa;padding: 0.5rem;border-radius: 5px;height: 35px;" min="10" value="10" />
                </div>
            </div>
            <div class="col-sm-6 pt-5 pb-5" style="text-align: right;">
                <div id="pagination" class="pagination"></div>
            </div>
        </div>

        <div class="modal fade" id="modal-docno">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" style="text-align: left;">List Doc No
                            <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                        </button> -->
                            <div class="input-group pull-right" style="width: 200px;">
                                <span class="input-group-addon"><i class="fa fa-search"></i></span>
                                <input type="text" class="form-control" id="txtFilter">
                            </div>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12 no-padding table-responsive" style="max-height: 80vh;">
                                <table class="table table-sm table-bordered table-hover table-sticky" id="tblListDocNo">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Doc No</th>
                                            <th>Owner</th>
                                            <th>Created At</th>
                                            <th>Last Updated</th>
                                            <th style="z-index: 1000" class="col-action">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button onclick="showModalImport();" class="btn btn-primary btnImportFileModal btn-custom"><i class="fa fa-upload"></i> Import File</button>
                        <button class="btn btn-dèault btn-custom" data-dismiss="modal"><i class="fa fa-times"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modal-delete-docno">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" style="text-align: left;">
                            Delete DocNo: <span class="docno-name"></span>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" value="" id="cboDeleteDocNo">
                            <label for="cboDeleteDocNo" class="form-check-label">Checking to delete this DocNo in database or not</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-dèault btn-custom" data-dismiss="modal" onclick="deleteDocNo()"><i class="fa fa-times"></i> Delete</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modal-import">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Import Input File - DocNo: <span class="title-docNo"></span> </h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-5 rowNewDocNo">
                            <div class="col-sm-4">
                                <label for="cbxDocNoNew" class="control-label">Import To New DocNo</label>
                            </div>
                            <div class="col-sm-6">

                            </div>
                            <div class="col-sm-1">
                                <input type="checkbox" id="cbxDocNoNew" name="cbxDocNoNew">
                            </div>
                        </div>
                        <div class="row mb-5">
                            <div class="col-sm-4">
                                <label class="control-label">Focus Range (Weeks)</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="number" class="form-control form-control-sm" name="focus-range" step="1" disabled="disabled" />
                            </div>
                            <div class="col-sm-1">
                                <input type="checkbox" name="accept-fr">
                            </div>
                            <div class="col-sm-1">
                                <a href="#" onclick="showConfig(this)" class="btn-config"><i class="fa fa-question-circle"></i></a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <label>Demand</label>
                            </div>
                        </div>
                        <div class="row mb-10">
                            <div class="col-sm-4">
                                <label class="control-label">ZNM136v2</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" name="input-file-1" accept=".xls, .xlsx, .csv" />
                            </div>
                            <!-- <div class="col-sm-3">
                                <button class="btn btn-primary btn-custom"><i class="fa fa-upload"></i> Upload</button>
                            </div> -->
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <label>Supplier</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label">ZNM24</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" name="input-file-2" accept=".xls, .xlsx, .csv" />
                            </div>
                            <!-- <div class="col-sm-3">
                                <button class="btn btn-primary btn-custom"><i class="fa fa-upload"></i> Upload</button>
                            </div> -->
                        </div>
                        <div class="row mb-10">
                            <div class="col-sm-4">
                                <label class="control-label">ZNM07</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" name="input-file-3" accept=".xls, .xlsx, .csv" />
                            </div>
                            <!-- <div class="col-sm-3">
                                <button class="btn btn-primary btn-custom"><i class="fa fa-upload"></i> Upload</button>
                            </div> -->
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <label>GR Stock</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label">ZNM119</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" name="input-file-5" accept=".xls, .xlsx, .csv" />
                            </div>
                            <!-- <div class="col-sm-3">
                                <button class="btn btn-primary btn-custom"><i class="fa fa-upload"></i> Upload</button>
                            </div> -->
                        </div>
                        <div class="row mb-10">
                            <div class="col-sm-4">
                                <label class="control-label">MB51 File</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" id="input-file-mb51" accept=".xls, .xlsx, .csv" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <label>VMI & Intransit</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label">VMI File</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" name="input-file-vmi" accept=".xls, .xlsx, .csv" />
                            </div>
                            <!-- <div class="col-sm-3">
                                <button class="btn btn-primary btn-custom"><i class="fa fa-upload"></i> Upload</button>
                            </div> -->
                        </div>
                        <div class="row mb-10">
                            <div class="col-sm-4">
                                <label class="control-label">Intransit File</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" name="input-file-intransit" accept=".xls, .xlsx, .csv" />
                            </div>
                            <!-- <div class="col-sm-3">
                                <button class="btn btn-primary btn-custom"><i class="fa fa-upload"></i> Upload</button>
                            </div> -->
                        </div>
                        <!-- <div class="row">
                            <div class="col-sm-4">
                                <label for="cbxEDC">Using Schedule</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="checkbox" id="cbxEDC" name="using-edc">
                            </div>
                        </div> -->
                        <div class="row form-group" style="display: flex;align-items: center;justify-content: space-between;">
                            <label class="control-label col-md-3" style="margin-bottom: 0;">Select file type: </label>
                            <div class="col-md-9">
                                <select name="" id="sl-upload" class="form-control form-control-sm">
                                    <option value="-1">Using Schedule</option>
                                    <option value="0">EDC V1 (Discrete PO)</option>
                                    <option value="1">EDC V2 (Schedule)</option>
                                    <option value="2">EDC V3 (SAP)</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 edc0 mode-upload hidden">
                                <div class="row" style="display: flex;align-items: center;justify-content: space-between;">
                                    <label class="control-label col-md-4" style="margin-bottom: 0;">EDC V1:</label>
                                    <div class="col-md-6">
                                        <input type="file" class="edc0" name="input-edcv1" accept=".xls, .xlsx, .csv" />
                                    </div>
                                    <!-- <div class="col-md-4">
                                        <a href="/assets/files/edc_v1.xlsx"><i class="fa fa-download"></i> Download format file</a>
                                    </div> -->
                                </div>
                            </div>

                            <div class="col-md-12 edc1 mode-upload hidden">
                                <div class="row" style="display: flex;align-items: center;justify-content: space-between;">
                                    <label class="control-label col-md-4" style="margin-bottom: 0;">EDC V2:</label>
                                    <div class="col-md-6">
                                        <input type="file" class="edc1" name="input-edcv2" accept=".xls, .xlsx, .csv" />
                                    </div>
                                    <!-- <div class="col-md-4">
                                        <a href="/assets/files/edc_v2.xlsx"><i class="fa fa-download"></i> Download format file</a>
                                    </div> -->
                                </div>
                            </div>

                            <div class="col-md-12 edc2 mode-upload hidden">
                                <div class="row" style="display: flex;align-items: center;justify-content: space-between;">
                                    <label class="control-label col-md-4" style="margin-bottom: 0;">ZNM66:</label>
                                    <div class="col-md-6">
                                        <input type="file" class="edc2" name="input-znm66" accept=".xls, .xlsx, .csv" />
                                    </div>
                                    <!-- <div class="col-md-4">
                                        <a href="/assets/files/znm24.xlsx"><i class="fa fa-download"></i> Download format file</a>
                                    </div> -->
                                </div>
                                <div class="row" style="display: flex;align-items: center;justify-content: space-between;">
                                    <label class="control-label col-md-4">ZNM22:</label>
                                    <div class="col-md-6">
                                        <input type="file" class="ctb-tool" name="input-znm22" accept=".xls, .xlsx, .csv" />
                                    </div>
                                    <!-- <div class="col-md-4">
                                        <a href="/assets/files/znm22.xlsx"><i class="fa fa-download"></i> Download format file</a>
                                    </div> -->
                                </div>
                            </div>
                        </div>
                        <!-- <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label">EDC File</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" name="input-file-edc" accept=".xls, .xlsx, .csv" disabled />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label">ZNM22</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" name="input-file-4" accept=".xls, .xlsx, .csv" disabled />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label">ZNM66</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" name="input-file-6" accept=".xls, .xlsx, .csv" disabled />
                            </div>
                        </div> -->
                        <!--
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label">Owner</label>
                            </div>
                            <div class="col-sm-6">
                                <select id="slOwner" style="height: 25px;border-radius: 5px;"></select>
                            </div>
                        </div>
                        -->
                        <div class="row row-config hidden pt-10">
                            <div class="col-sm-12 no-padding">
                                <table class="table table-sm table-bordered text-center" id="tblConfig">
                                    <thead>
                                        <tr>
                                            <th>Red Risk Level</th>
                                            <th>Orange Risk Level</th>
                                            <th>Yellow Risk Level</th>
                                            <th>Green Risk Level</th>
                                            <th>Mid Week</th>
                                            <th>Focus Range</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><span class="redRiskLevel"></span></td>
                                            <td><span class="orangeRiskLevel"></span></td>
                                            <td><span class="yellowRiskLevel"></span></td>
                                            <td><span class="greenRiskLevel"></span></td>
                                            <td><span id="midWeek"></span></td>
                                            <td><span id="focusRange"></span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-sm-12" style="text-align: center;">
                                <button id="btnSubmit" class="btn btn-custom btn-success" onclick="uploadFile()"><i class="fa fa-check"></i> Submit</button>
                                <button id="btnCancel" class="btn btn-custom btn-danger" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> Cancel</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var dataset = {
        bu: '${bu}',
        factory: '${factory}',
        cft: '${cft}',
        smmsRole: '${employeeSMMSRole}',
        page: 0,
        path: '',
        buyerList: [],
        shortView: true,
        numberData: 10,
    }
    init();

    function init() {
        loadListDocNo();
        loadConfig();
        loadListBuyer();
        loadListUser();
    }

    var datatableDocNo;
    function loadListDocNo() {
        $('.loader').removeClass('hidden');
        $('#tblListDocNo>tbody').html('');
        if (datatableDocNo) {
            datatableDocNo.destroy();
        }
        $.ajax({
            type: "GET",
            url: dataset.path + "/api/pm/sd/list",
            data: {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                if (res.code == 'SUCCESS') {
                    var data = res.data;
                    var html = '';
                    for (var i = 0; i < data.length; i++) {
                        html += '<tr data-docno="' + data[i].docNo + '" data-focusrange="' + data[i].focusRange + '" data-usingedc="' + data[i].usingEdc + '" onclick="clickDocno(this)">' +
                            '<td>' + (i + 1) + '</td>' +
                            '<td>' + data[i].docNo + '</td>' +
                            '<td>' + fixNull(data[i].owner) + '</td>' +
                            '<td>' + data[i].createdAt + '</td>' +
                            '<td>' + data[i].updatedAt + '</td>';
                        if (dataset.smmsRole != 'BUYER_MANAGER') {
                            // html += '<td><button style="padding:5px 10px;" class="btn btn-danger" onclick="deleteDocNo(\''+data[i].docNo+'\')"><i class="fa fa-trash"></i></button></td></tr>';
                            html += '<td><button style="padding:5px 10px;" class="btn btn-danger" data-toggle="modal" onclick="showModalDeleteDocNo(\'' + data[i].docNo + '\')"><i class="fa fa-trash"></i></button></td></tr>';
                        } else {
                            $('.col-action').remove();
                            html += '</tr>';
                        }
                        //  +  '<td><button style="padding:5px 10px;" class="btn btn-danger" onclick="deleteDocNo(\''+data[i].docNo+'\')"><i class="fa fa-trash"></i></button></td>'+
                        //  +'</tr>';
                    }
                    $('#tblListDocNo>tbody').html(html);
                    datatableDocNo = $('#tblListDocNo').DataTable({
                        "paging": true,
                        "pageLength": 5,
                        "lengthChange": false,
                        "searching": true,
                        "ordering": false,
                        "info": false,
                        "autoWidth": true,
                        "language": {
                            "paginate": {
                                "previous": "<",
                                "next": ">"
                            }
                        }
                    });
                    $('#txtFilter').keyup(function () {
                        datatableDocNo.search($(this).val()).draw();
                    });
                    $('#tblListDocNo_filter').addClass('hidden');
                    // $('#tblListDocNo>tbody>tr').on('click', function () {
                    //     dataset.docNo = this.dataset.docno;
                    //     dataset.focusRange = this.dataset.focusrange;
                    //     dataset.usingEdc = this.dataset.usingedc;
                    //     dataset.buyerList = [];
                    //     $('select[name=slBuyer]').val(dataset.buyerList);
                    //     $('select[name=slBuyer]').selectpicker('refresh');
                    //     dataset.project = '';
                    //     $('input[name=searchByProject]').val('');
                    //     dataset.partNumber = '';
                    //     $('input[name=searchByPN]').val('');
                    //     dataset.manufacturePart = '';
                    //     $('input[name=searchByMP]').val('');
                    //     $('.title-docno').html(' ' + dataset.docNo);
                    //     loadData();
                    //     $('#modal-docno').modal('hide');
                    // });
                    if (data.length == 0) {
                        //$('#modal-docno').modal('hide');
                        //$('#modal-import').modal('show');
                        showModalImport();
                    } else {
                        $('#modal-docno').modal('show');
                    }
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

    function clickDocno(context) {
        dataset.docNo = context.dataset.docno;
        dataset.focusRange = context.dataset.focusrange;
        dataset.usingEdc = context.dataset.usingedc;
        dataset.buyerList = [];
        $('select[name=slBuyer]').val(dataset.buyerList);
        $('select[name=slBuyer]').selectpicker('refresh');
        dataset.project = '';
        $('input[name=searchByProject]').val('');
        dataset.partNumber = '';
        $('input[name=searchByPN]').val('');
        dataset.manufacturePart = '';
        $('input[name=searchByMP]').val('');
        $('.title-docno').html(' ' + dataset.docNo);
        dataset.page = 0;
        loadData();
        $('#modal-docno').modal('hide');
    }

    function showModalDeleteDocNo(docNo) {
        event.stopPropagation();
        $('#modal-delete-docno .modal-header .docno-name').html(docNo);
        $('#modal-delete-docno').modal('show');
        $('#cboDeleteDocNo').attr('checked', false);
        dataset.tempModalDocNo = docNo;
    }

    $('input[name="accept-fr"]').on('click', function () {
        $('input[name="focus-range"]').attr('disabled', function (_, attr) {
            return !attr
        });
        $('input[name="focus-range"]').val(function (_, value) {
            return value == 1 ? '' : 1
        });
        console.log($('input[name="accept-fr"]')[0].checked);
    });

    $('#cbxEDC').on('click', function () {
        $('input[name="input-file-4"]').attr('disabled', function (_, attr) {
            return !attr
        });
        $('input[name="input-file-6"]').attr('disabled', function (_, attr) {
            return !attr
        });
        $('input[name="input-file-edc"]').attr('disabled', function (_, attr) {
            return !attr
        });
        console.log(this.checked);
    });

    $('#sl-upload').on('change', function(){
        var val = this.value;
        $('.mode-upload').addClass('hidden');
        $('.edc'+val).removeClass('hidden');
        $('input[class=edc'+val+']').val('');
    });

    function loadListUser() {
        $.ajax({
            type: 'GET',
            url: dataset.path + "/api/pm/sd/user",
            data: {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft
            },
            //contentType: 'application/json; charset= utf-8',
            success: function (res) {
                if (res.code == "SUCCESS") {
                    console.log(res);
                    var html = '<option value="">-Select owner-</option>';
                    $('#slOwner').html('');
                    var data = res.data;
                    for (var i = 0; i < data.length; i++) {
                        html += '<option value="' + data[i].user + '">' + data[i].user + '</option>';
                    }
                    $('#slOwner').html(html);
                }
            },
            error: function (err) {
                console.log("Get Owner Error:", err);
            },
            complete: function () {

            }
        });
    }

    function deleteDocNo() {
        var cboDeleteDocno = $('#cboDeleteDocNo').prop('checked');
        if (cboDeleteDocno) {
            $.ajax({
                type: 'DELETE',
                url: dataset.path + "/api/pm/sd/remove",
                data: {
                    docNo: dataset.tempModalDocNo
                },
                success: function (res) {
                    alert(res.result);
                    loadListDocNo();
                },
                error: function (err) {
                    alert(JSON.parse(err.responseText).message);
                }
            });
        } else {
            $.ajax({
                type: 'POST',
                url: dataset.path + "/api/pm/sd/remove",
                data: {
                    docNo: dataset.tempModalDocNo
                },
                success: function (res) {
                    alert(res.result);
                    loadListDocNo();
                },
                error: function (err) {
                    console.log("Error:", err);
                }
            });
        }
    }

    function showModalImport() {
        $('#modal-docno').modal('hide');
        $('#modal-import').modal('show');
        // console.log(dataset);
        var docNo = dataset.docNo;
        if (docNo != undefined && docNo != 'null' && docNo != '') {
            $('input[name="cbxDocNoNew"]').removeAttr('checked');
            $('.title-docNo').text(docNo);
            $('.rowNewDocNo').show();
        } else {
            $('input[name="cbxDocNoNew"]').prop('checked', true);
            $('.rowNewDocNo').hide();
        }

        var focusRange = dataset.focusRange;
        if (focusRange != 'null' && focusRange != undefined) {
            $('input[name="accept-fr"]').prop('checked', true);
            $('input[name="focus-range"]').removeAttr('disabled');
            $('input[name="focus-range"]').val(focusRange);
        } else {
            $('input[name="accept-fr"]').removeAttr('checked');
            $('input[name="focus-range"]').attr('disabled', 'true');
            $('input[name="focus-range"]').val('');
        }

        var usingEdc = dataset.usingEdc;
        if (dataset.usingEdc == 'true' && usingEdc != undefined) {
            $('input[name="using-edc"]').prop('checked', true);
            $('input[name="input-file-4"]').prop('disabled', true);
            $('input[name="input-file-6"]').prop('disabled', true);
            $('input[name="input-file-edc"]').prop('disabled', true);
        } else {
            $('input[name="using-edc"]').removeAttr('checked');
            $('input[name="input-file-4"]').removeAttr('disabled');
            $('input[name="input-file-6"]').removeAttr('disabled');
            $('input[name="input-file-edc"]').removeAttr('disabled');
        }
    }

    function uploadFile() {
        var focusRange = Number($('input[name="focus-range"]').val());
        var znm136File = $('input[name="input-file-1"]').prop('files')[0];
        var znm24File = $('input[name="input-file-2"]').prop('files')[0];
        var znm07File = $('input[name="input-file-3"]').prop('files')[0];
        // var znm66File = $('input[name="input-file-6"]').prop('files')[0];
        // var znm22File = $('input[name="input-file-4"]').prop('files')[0];
        var znm119File = $('input[name="input-file-5"]').prop('files')[0];
        var vmiFile = $('input[name="input-file-vmi"]').prop('files')[0];
        var intransitFile = $('input[name="input-file-intransit"]').prop('files')[0];
        var mb51File = $('#input-file-mb51').prop('files')[0];
        // var edcFile = $('#input-file-edc').prop('files')[0];

        var edcVersion = $('#sl-upload').val();
        var edcV1 = $('input[name="input-edcv1"]').prop('files')[0];
        var edcV2 = $('input[name="input-edcv2"]').prop('files')[0];
        var znm22File = $('input[name="input-znm22"]').prop('files')[0];
        var znm66File = $('input[name="input-znm66"]').prop('files')[0];

        var form = new FormData();
        form.append("bu", dataset.bu);
        form.append("factory", dataset.factory);
        form.append("cft", dataset.cft);
        form.append("znm136File", znm136File);
        form.append("znm24File", znm24File);
        form.append("znm07File", znm07File);
        form.append("znm119File", znm119File);
        form.append("vmiFile", vmiFile);
        form.append("intransitFile", intransitFile);
        form.append("mb51File", mb51File);
        // form.append("edcFile", edcFile);
        form.append("edcVersion", edcVersion);

        var docNo = dataset.docNo;
        if ($('input[name="cbxDocNoNew"]')[0].checked == false) {
            form.append('docNo', docNo);
        }
        var user = $('#slOwner').val();
        form.append('user', user);
        // if ($('#cbxEDC')[0].checked) {
        //     form.append("usingEdc", true);
        // } else {
        //     form.append("znm22File", znm22File);
        //     form.append("znm66File", znm66File);
        // }
        if(edcVersion == 0) {
            form.append("edcFile", edcV1);
        } else if(edcVersion == 1) {
            form.append("edcFile", edcV2);
        } else if(edcVersion == 2) {
            form.append("znm22File", znm22File);
            form.append("znm66File", znm66File);
        }
        if ($('input[name="accept-fr"]')[0].checked) {
            form.append("focusRange", focusRange);
        }
        $('.loader').removeClass('hidden');

        $.ajax({
            type: 'POST',
            url: '/api/pm/sd/upload',
            data: form,
            processData: false,
            contentType: false,
            mimeType: "multipart/form-data",
            success: function (response) {
                var res = JSON.parse(response);
                if (res.code == 'SUCCESS') {
                    alert('UPLOAD SUCCESS!');
                    dataset.docNo = res.result.docNo;
                    loadData();
                    loadListDocNo();
                    $('#modal-import').modal('hide');
                }
            },
            error: function (e) {
                console.log(e);
                var res = JSON.parse(e.responseText);
                alert(res.message);
                $('.loader').addClass('hidden');
            },
            complete: function () {
                $('.loader').addClass('hidden');
            }
        });
    }

    function loadConfig() {
        $.ajax({
            type: "GET",
            url: dataset.path + "/api/pm/sd/config",
            data: {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var html = '';
                if (!$.isEmptyObject(res.result)) {
                    var data = res.result;
                    for (i in data) {
                        var value = data[i] * 100 + '%';
                        $('.' + i).html(value);
                        $('#midWeek').html(numToDay(data.midWeek));
                        $('#focusRange').html(data.focusRange);
                    }
                }
            },
            failure: function (errMsg) {
                console.log(errMsg);
            }
        });
    }

    function numToDay(num) {
        var day = '';
        if (num == 1) {
            day = 'Sun';
        } else if (num == 2) {
            day = 'Mon';
        } else if (num == 3) {
            day = 'Tue';
        } else if (num == 4) {
            day = 'Wed';
        } else if (num == 5) {
            day = 'Thu';
        } else if (num == 6) {
            day = 'Fri';
        } else if (num == 7) {
            day = 'Sat';
        }
        return day;
    }

    function showConfig(context) {
        $(context).toggleClass('active');
        $('.row-config').toggleClass('hidden');
    }


    function loadListBuyer() {
        $.ajax({
            type: "GET",
            url: dataset.path + "/api/pm/sd/buyer",
            data: {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                if (res.code == 'SUCCESS') {
                    var data = res.data;
                    var selector = $("select[name='slBuyer']");
                    selector.children('option').remove();
                    var options = '';
                    for (i in data) {
                        options += '<option value="' + data[i].buyer + '">' + data[i].buyer + '</option>';
                    }
                    selector.append(options);
                    selector.selectpicker('refresh');
                }
            },
            failure: function (errMsg) {
                console.log(errMsg);
            },
        });
    }

    $('select[name=slBuyer]').on('change', function () {
        dataset.buyerList = $(this).val();
        dataset.project = $('input[name=searchByProject]').val();
        dataset.partNumber = $('input[name=searchByPN]').val();
        dataset.manufacturePart = $('input[name=searchByMP]').val();
        dataset.page = 0;
        loadData();
    });
    $('.searchProject').on('click', function () {
        dataset.project = $('input[name=searchByProject]').val();
        dataset.page = 0;
        loadData();
    });
    $('input[name=searchByProject]').keyup(function (event) {
        if (event.keyCode == 13) {
            dataset.project = $(this).val();
            dataset.partNumber = $('input[name=searchByPN]').val();
            dataset.manufacturePart = $('input[name=searchByMP]').val();
            dataset.page = 0;
            loadData();
        }
    });
    $('input[name=searchByPN]').keyup(function (event) {
        if (event.keyCode == 13) {
            dataset.partNumber = $(this).val();
            dataset.project = $('input[name=searchByProject]').val();
            dataset.manufacturePart = $('input[name=searchByMP]').val();
            dataset.page = 0;
            loadData();
        }
    });
    $('input[name=searchByMP]').keyup(function (event) {
        if (event.keyCode == 13) {
            dataset.manufacturePart = $(this).val();
            dataset.project = $('input[name=searchByProject]').val();
            dataset.partNumber = $('input[name=searchByPN]').val();
            dataset.page = 0;
            loadData();
        }
    });

    $('#numberData').on('keyup', function (event) {
        if (event.keyCode === 13) {
            dataset.numberData = $(this).val();
            event.preventDefault();
            loadData();
        }
    });

    function loadData(docNo) {
        $('.loader').removeClass('hidden');
        var data = {
            docNo: dataset.docNo,
            project: dataset.project,
            manufacturePart: dataset.manufacturePart,
            partNumber: dataset.partNumber,
            page: dataset.page,
            size: dataset.numberData
        };
        var url = dataset.path + "/api/pm/sd/view?" + jQuery.param(data);
        for (i in dataset.buyerList) {
            url += '&buyerList=' + dataset.buyerList[i];
        }
        $.ajax({
            type: "GET",
            url: url,
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                $('#tblDetail').html('');
                $('#pagination').html('');
                var thead = '<thead>',
                    tbody = '<tbody>';
                if (res.code == 'SUCCESS') {
                    var data = res.data;
                    if (data.length > 0) {
                        thead += '<tr><th rowspan="2"><input type="checkbox" name="checkAll" /></th>';
                        for (j = 0; j < 14; j++) {
                            if (data[0][j] === 'Usage/Allocation') {
                                data[0][j] = 'Usage/<br/>Allocation';
                            }
                            thead += '<th rowspan="2">' + data[0][j] + '</th>';
                        }
                        for (j = 14; j < data[0].length - 2; j++) {
                            thead += '<th>' + data[0][j] + '</th>';
                        }
                        thead += '</tr>';
                        thead += '<tr>';
                        for (j = 14; j < data[1].length - 2; j++) {
                            thead += '<th>' + data[1][j] + '</th>';
                        }
                        thead += '</tr>';
                        thead += '</thead>';

                        for (var i = 2; i < data.length; i++) {
                            if(data[i][9] == '1. Demand' || data[i][9] == '2. Supply') {
                                tbody += '<tr class="row_' + data[i][0] + ' sort-view">';
                            } else if(data[i][9] == '5. Balance') {
                                tbody += '<tr class="row_' + data[i][0] + ' balance">';
                            } else if(data[i][9] == '6. Action') {
                                tbody += '<tr class="row_' + data[i][0] + ' action">';
                            } else {
                                tbody += '<tr class="row_' + data[i][0] + '">';
                            }
                            if (data[i][0] != null) {
                                tbody += '<td><input type="checkbox" data-id="' + data[i][3] + '" name="check-critical" /></td>';
                            }
                            for (j = 0; j < 10; j++) {
                                if(j == 1) {
                                    var per = Number(data[i][j])*100;
                                    tbody += '<td class="' + riskLevel(per) + '">' + per.toFixed(2) + '%</td>';
                                }
                                else if (j == 7) {
                                    tbody += '<td>' + numberWithCommas(data[i][j]) + '</td>';
                                } 
                                else if(j == 9) {
                                    if(data[i][j] == '1. Demand') {
                                        tbody += '<td class="demand">' + fixNull(data[i][j]) + '</td>'
                                    }
                                    else if(data[i][j] == '2. Supply') {
                                        tbody += '<td class="supply">' + fixNull(data[i][j]) + '</td>'
                                    }
                                    else if(data[i][j] == '3. DemandTotal') {
                                        tbody += '<td class="demandTotal">' + fixNull(data[i][j]) + '</td>'
                                    }
                                    else if(data[i][j] == '4. SupplyTotal') {
                                        tbody += '<td class="supplyTotal">' + fixNull(data[i][j]) + '</td>'
                                    }
                                    else {
                                        tbody += '<td>' + fixNull(data[i][j]) + '</td>'
                                    }
                                } 
                                else {
                                    tbody += '<td>' + fixNull(data[i][j]) + '</td>';
                                }
                            }
                            for (j = 10; j < data[i].length - 2; j++) {
                                if(data[i][9] == '6. Action') {
                                    tbody += '<td colspan="' + (data[i].length - 10) + '">' + data[i][j] + '</td>';
                                    break;
                                } else {
                                    tbody += (Number(data[i][j]) < 0 ? '<td class="text-danger">' + numberWithCommas(data[i][j]) + '</td>': '<td>' + numberWithCommas(data[i][j]) + '</td>');
                                }
                            }
                            tbody += '</tr>';
                        }
                        tbody += '</tbody>';

                        if (tbody == '<tbody></tbody>') {
                            tbody = "<tbody><tr><td colspan='" + (data[0].length + 1) + "'><span>We couldn't find what you were looking for</span></tr></td></tbody>";
                        }

                        $('#tblDetail').html(thead + tbody);

                        var totalPage = 0;
                        if (res.size % dataset.numberData > 0) {
                            totalPage = parseInt(res.size / dataset.numberData) + 1;
                        } else {
                            totalPage = parseInt(res.size / dataset.numberData);
                        }

                        if (totalPage != 0) {
                            pagination(totalPage, dataset.page);
                        }

                        $('input[name=checkAll]').on('click', function () {
                            var checkbox = $('input[name=check-critical]');
                            if ($(this)[0].checked) {
                                for (var i = 0; i < checkbox.length; i++) {
                                    $(checkbox[i]).attr('checked', 'checked');
                                    checkbox[i].checked = true;
                                }
                            } else {
                                checkbox.removeAttr('checked');
                                for (var i = 0; i < checkbox.length; i++) {
                                    checkbox[i].checked = false;
                                }
                            }
                        });

                        $('input[name=check-critical]').on('click', function () {
                            var id = this.dataset.id;
                            var checkbox = $('input[data-id=' + id + ']');
                            if ($(this)[0].checked) {
                                for (var i = 0; i < checkbox.length; i++) {
                                    $(checkbox[i]).attr('checked', 'checked');
                                    checkbox[i].checked = true;
                                }
                            } else {
                                checkbox.removeAttr('checked');
                                for (var i = 0; i < checkbox.length; i++) {
                                    checkbox[i].checked = false;
                                }
                            }
                        });
                    }
                }
            },
            error: function (e) {
                console.log(e);
                var res = JSON.parse(e.responseText);
                alert(res.message);
            },
            complete: function () {
                // styleTable();
                if(dataset.shortView) {
                    $('.sort-view').addClass('hidden');
                }
                $('.loader').addClass('hidden');
            }
        });
    }

    function fixNull(text) {
        var result = 'No data';
        if (text != null && text != 'null' && text != 'NULL' && text != '') {
            result = text;
        }
        return result;
    }

    function numberWithCommas(x) {
        var parts = '';
        if (x != null) {
            if (x.indexOf(';') == -1) {
                parts = x.toString().split('.');
                parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                parts.join('.')
            } else {
                parts = x;
            }
        }
        return parts;
    }

    function styleTable() {
        var listCol = $('#tblDetail>tbody>tr>td');
        for (var i = 0; i < listCol.length; i++) {

            if (listCol[i].innerHTML == '1. Demand') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(listCol[i]).addClass('demand');
                $(row).addClass('sort-view');
            } else if (listCol[i].innerHTML == '2. Supply') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(listCol[i]).addClass('supply');
                $(row).addClass('sort-view');
                var length = row.children().length;
                for (var j = 15; j < length; j++) {
                    if ($(row.children()[j]).html() != '') {
                        $(row.children()[j]).addClass('supply');
                    }
                }
            } else if (listCol[i].innerHTML == '3. DemandTotal') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(listCol[i]).addClass('demandTotal');
            } else if (listCol[i].innerHTML == '4. SupplyTotal') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(listCol[i]).addClass('supplyTotal');
            } else if (listCol[i].innerHTML == '5. Balance') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(row).addClass('balance');
            } else if (listCol[i].innerHTML == '6. Action') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(row).addClass('action');
                var length = row.children().length;
                $(row.children()[11]).attr('colspan', (length - 10));
                for (var j = 12; j < length; j++) {
                    $(row.children()[j])[0].remove();
                    j--;
                    length--;
                }
            }

            if ($('#btnSortView').hasClass('active')) {
                $('.sort-view').addClass('hidden');
            }
        }

        // var rows = $('#tblDetail>tbody>tr');
        // var listClass = [];
        // for(var i=0; i< rows.length; i++) {
        //     var aRow = $(rows[i]);
        //     var classRow = aRow[0].className;
        //     if(listClass.indexOf(classRow) == -1) {
        //         listClass.push(classRow);
        //     }
        // }
        // for(i in listClass) {
        //     var length = $('.' + listClass[i]).length.length;
        //     $('.' + listClass[i]).length
        // }
    }

    function riskLevel(per) {
        var classRisk = '';
        if (Number(per) < 75) {
            classRisk = 'riskRed';
        } else if (Number(per) >= 75 && Number(per) < 90) {
            classRisk = 'riskOrange';
        } else if (Number(per) >= 90 && Number(per) < 98) {
            classRisk = 'riskYellow';
        } else if (Number(per) >= 98) {
            classRisk = 'riskGreen';
        }
        return classRisk;
    }

    function toggleView(context) {
        $(context).toggleClass('active');
        $('.sort-view').toggleClass('hidden');
        if (dataset.shortView) {
            dataset.shortView = false;
        } else {
            dataset.shortView = true;
        }
    }

    function exportData() {
        $('.loader').removeClass('hidden');
        // alert(dataset.shortView)
        var request = new XMLHttpRequest();
        request.open("POST", "/api/pm/sd/export?docNo=" + encodeURIComponent(dataset.docNo) + '&shortView=' + dataset.shortView, true);
        // request.setRequestHeader('Content-Type', "multipart/form-data");
        request.responseType = 'blob';

        request.onload = function (e) {
            if (this.status === 200) {
                var filename = "";
                var disposition = this.getResponseHeader('Content-Disposition');
                if (disposition && disposition.indexOf('attachment') !== -1) {
                    var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                    var matches = filenameRegex.exec(disposition);
                    if (matches != null && matches[1]) filename = matches[1].replace(/['"]/g, '');
                }

                var blob = this.response;
                if (typeof window.navigator.msSaveBlob !== 'undefined') {
                    window.navigator.msSaveBlob(blob, filename);
                } else {
                    var URL = window.URL || window.webkitURL;
                    var downloadUrl = URL.createObjectURL(blob);
                    if (filename) {
                        var a = document.createElement('a');
                        if (typeof a.download === 'undefined') {
                            window.location.href = downloadUrl;
                        } else {
                            a.href = downloadUrl;
                            a.download = filename;
                            document.body.appendChild(a);
                            a.click();
                        }
                    } else {
                        window.location.href = downloadUrl;
                    }

                    setTimeout(function () {
                        URL.revokeObjectURL(downloadUrl);
                    }, 100);
                }
                $('.loader').addClass('hidden');
            } else {
                $('.loader').addClass('hidden');
            }
        }
        request.send();
    }

    function generateCritical() {
        $('.loader').removeClass('hidden');
        var partNumberList = [];
        var checkbox = $('input[name=check-critical]');
        for (var i = 0; i < checkbox.length; i++) {
            if (checkbox[i].checked) {
                if (partNumberList.indexOf(checkbox[i].dataset.id) == -1) {
                    partNumberList.push(checkbox[i].dataset.id);
                }
            }
        }

        var data = {
            docNo: encodeURIComponent(dataset.docNo),
            partNumberList: partNumberList
        }
        console.log(data);
        var request = new XMLHttpRequest();
        request.open("POST", "/api/pm/sd/generate-critical", true);
        request.setRequestHeader('Content-Type', "application/json; charset=utf-8");
        request.responseType = 'blob';

        request.onload = function (e) {
            if (this.status === 200) {
                var filename = "";
                var disposition = this.getResponseHeader('Content-Disposition');
                if (disposition && disposition.indexOf('attachment') !== -1) {
                    var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                    var matches = filenameRegex.exec(disposition);
                    if (matches != null && matches[1]) filename = matches[1].replace(/['"]/g, '');
                }

                var blob = this.response;
                if (typeof window.navigator.msSaveBlob !== 'undefined') {
                    window.navigator.msSaveBlob(blob, filename);
                } else {
                    var URL = window.URL || window.webkitURL;
                    var downloadUrl = URL.createObjectURL(blob);
                    if (filename) {
                        var a = document.createElement('a');
                        if (typeof a.download === 'undefined') {
                            window.location.href = downloadUrl;
                        } else {
                            a.href = downloadUrl;
                            a.download = filename;
                            document.body.appendChild(a);
                            a.click();
                        }
                    } else {
                        window.location.href = downloadUrl;
                    }

                    setTimeout(function () {
                        URL.revokeObjectURL(downloadUrl);
                    }, 100);
                }
                $('.loader').addClass('hidden');
            } else {
                $('.loader').addClass('hidden');
                alert('Download FAIL!');
            }
        }
        request.send(JSON.stringify(data));
    }

    function confirmShortage() {
        var confirm = window.confirm("Are you sure upload this to Master CTB?");
        if (confirm == true) {
            // var dataReq = {
            //     "docNo": dataset.reportNo,
            // }
            // $.ajax({
            //     type: 'POST',
            //     url: "/api/pm/sd/publish",
            //     cache: false,
            //     data: JSON.stringify(dataReq),
            //     contentType: "application/json; charset=utf-8",
            //     success: function (response) {

            //     }
            // });
            var form = new FormData();
            form.append("docNo", dataset.docNo);

            $.ajax({
                type: 'POST',
                url: '/api/pm/sd/confirm',
                data: form,
                processData: false,
                contentType: false,
                mimeType: "multipart/form-data",
                success: function (response) {
                    var res = JSON.parse(response);
                    if (res.code == 'SUCCESS') {
                        alert('Confirm Success!')
                    }
                },
                error: function (e) {
                    console.log(e);
                    var res = JSON.parse(e.responseText);
                    alert(res.message);
                    $('.loader').addClass('hidden');
                },
                complete: function () {
                    $('.loader').addClass('hidden');
                }
            });
        }
    }

    var Pagination = {
        code: '',
        Extend: function (data) {
            data = data || {};
            Pagination.size = data.size || 300;
            Pagination.page = data.page || 1;
            Pagination.step = data.step || 3;
        },

        // add pages by number (from [s] to [f])
        Add: function (s, f) {
            for (var i = s; i < f; i++) {
                Pagination.code += '<a class="p-item page-' + i + '">' + i + '</a>';
            }
        },

        // add last page with separator
        Last: function () {
            Pagination.code += '<a><i>...</i></a><a class="p-item page-' + Pagination.size + '">' + Pagination.size + '</a>';
        },

        // add first page with separator
        First: function () {
            Pagination.code += '<a class="p-item">1</a><a><i>...</i></a>';
        },

        // change page
        Click: function () {
            Pagination.page = +this.innerHTML;
            dataset.page = Pagination.page - 1;
            loadData();
            Pagination.Start();
        },

        // previous page
        Prev: function () {
            Pagination.page--;
            if (Pagination.page < 1) {
                Pagination.page = 1;
            }
            dataset.page = Pagination.page - 1;
            loadData();
            Pagination.Start();
        },

        // next page
        Next: function () {
            Pagination.page++;
            if (Pagination.page > Pagination.size) {
                Pagination.page = Pagination.size;
            }
            dataset.page = Pagination.page - 1;
            loadData();
            Pagination.Start();
        },

        // binding pages
        Bind: function () {
            var a = Pagination.e.getElementsByClassName('p-item');
            if (a.length > 1) {
                for (var i = 0; i < a.length; i++) {
                    if (+a[i].innerHTML === Pagination.page) a[i].className = 'p-item current';
                    // if(+a[i].innerHTML == Pagination.size) i--;
                    a[i].addEventListener('click', Pagination.Click, false);
                }
            }
        },

        // write pagination
        Finish: function () {
            Pagination.e.innerHTML = Pagination.code;
            Pagination.code = '';
            Pagination.Bind();
        },

        // find pagination type
        Start: function () {
            if (Pagination.size < Pagination.step * 2 + 6) {
                Pagination.Add(1, Pagination.size + 1);
            } else if (Pagination.page < Pagination.step * 2 + 1) {
                Pagination.Add(1, Pagination.step * 2 + 4);
                Pagination.Last();
            } else if (Pagination.page > Pagination.size - Pagination.step * 2) {
                Pagination.First();
                Pagination.Add(Pagination.size - Pagination.step * 2 - 2, Pagination.size + 1);
            } else {
                Pagination.First();
                Pagination.Add(Pagination.page - Pagination.step, Pagination.page + Pagination.step + 1);
                Pagination.Last();
            }
            Pagination.Finish();
        },

        // binding buttons
        Buttons: function (e) {
            var nav = e.getElementsByTagName('a');
            nav[0].addEventListener('click', Pagination.Prev, false);
            nav[1].addEventListener('click', Pagination.Next, false);
        },

        // create skeleton
        Create: function (e) {

            var html = [
                '<a><</a>', // previous button
                '<span></span>', // pagination container
                '<a>></a>' // next button
            ];

            e.innerHTML = html.join('');
            Pagination.e = e.getElementsByTagName('span')[0];
            Pagination.Buttons(e);
        },

        // init
        Init: function (e, data) {
            Pagination.Extend(data);
            Pagination.Create(e);
            Pagination.Start();
        }
    };

    function pagination(size, page) {
        Pagination.Init(document.getElementById('pagination'), {
            size: size, // pages size
            page: page + 1, // selected page
            step: 2, // pages before and after current
        });
    };

    // $('#txtFilter').on("keyup", function () {
    //     var value = $(this).val().toLowerCase();
    //     $("#tblListDocNo tbody tr").filter(function () {
    //         $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    //     });
    // });

    function checkSMMSRole() {
        if (dataset.smmsRole == 'BUYER') {
            window.location.href = '/401-error-page';
        } else if (dataset.smmsRole == 'BUYER_MANAGER') {
            $('.btnImportFile').remove();
            $('.btnConfirm').remove();
            $('.btnImportFileModal').remove();
        }
    }

    $(document).ready(function () {
        checkSMMSRole();
    });
</script>