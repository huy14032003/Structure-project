<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!-- <script type="text/javascript" src="/assets/js/plugins/charts/highchart/modules/pareto.js"></script> -->
<link rel="stylesheet" type="text/css" href="/assets/css/custom/critical-shortage.css">
<style>
    #tblBuyer thead tr th {
        background-color: #CCFFFF;
        color: blue;
        padding: 3px 5px;
        border: 1px solid #B7B7B7;
        text-align: center;
    }
    #tblBuyer tbody tr td {
        background-color: #FFFFFF;
        padding: 3px 10px;
        border: 1px solid #B7B7B7;
    }
    input[name=shipping_mode]:disabled:hover {
        cursor: pointer;
    }

    select[class*=slShippingMode]{
        width: 100%;
    }

    .modal-md-custom{
        width: 700px !important;
    }
</style>

<div class="loader hidden"></div>
<div class="panel panel-flat row no-margin">
    <div class="col-lg-12" style="background-color: #EBEDF9; min-height: calc(100vh - 110px);">
        <div class="panel panel-overview text-uppercase" id="header">
            <span>EDC </span><span class="title-docno"></span>
        </div>
        <div class="row no-margin pb-5">
            <div class="col-sm-1 no-padding-left">
                <div class="input-group no-margin">
                    <input type="text" class="form-control" name="searchByPN" placeholder="Part Number">
                </div>
            </div>
            <div class="col-sm-1 no-padding-left">
                <div class="input-group no-margin">
                    <input type="text" class="form-control" name="searchByMP" placeholder="Source MFR Code">
                </div>
            </div>
            <div class="col-sm-2 no-padding-left">
                <select class="form-control bootstrap-select" name="slBuyer" data-live-search="true" multiple data-focus-off="true" data-actions-box="true" data-none-selected-text="Choose Buyer"></select>
            </div>
            <div class="col-sm-2">
            </div>
            <div class="col-sm-6 no-padding" style="text-align: right;">
                <!--<button class="btn btn-primary btn-custom" data-toggle="modal" data-target="#modal-docno"><i class="icon-paragraph-justify3"></i> Doc No</button>-->
                <button class="btn btn-primary btn-custom btnImportFile" data-toggle="modal" data-target="#modal-import"><i class="fa fa-upload"></i> Import File</button>
                <button class="btn btn-primary btn-custom" onclick="exportData()"><i class="fa fa-download"></i> Export File</button>
            </div>
        </div>
        <div class="row no-margin">
            <div class="col-sm-12 no-padding table-responsive">
                <table id="tblBuyer" class="table table-hover table-sticky">
                    <thead>
                        <th>#</th>
                        <th>PN</th>
                        <th>MFR_PN</th>
                        <th>Source MFR Code</th>
                        <th>Plant</th>
                        <th>Vendor</th>
                        <th>Open PO</th>
                        <th>Buyer Name</th>
                        <th>Forcus Range NO</th>
                        <th>Forcus Range YES</th>
                        <th class="shippingMode">Shipping Mode</th>
                        <th>ETA & CommitQty</th>
                    </thead>
                    <tbody></tbody>
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
                        <h4 class="modal-title">List Doc No </h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12 no-padding">
                                <table class="table table-sm table-bordered text-center table-hover" id="tblListDocNo">
                                    <thead>
                                        <tr>
                                            <th>Doc No</th>
                                            <th>Create At</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="modal-import">
            <div class="modal-dialog modal-md-custom">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Import Input File </h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
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
                        <!-- <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label">EDC File</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="file" name="input-file-1" accept=".xls, .xlsx, .csv" />
                            </div>
                        </div> -->
                        <div class="row form-group" style="display: flex;align-items: center;justify-content: space-between;">
                            <label class="control-label col-md-3" style="margin-bottom: 0;">Select file type: </label>
                            <div class="col-md-9">
                                <select name="" id="sl-upload" class="form-control form-control-sm">
                                    <option value="normal-edc">EDC V1</option>
                                    <option value="master-edc">EDC V2</option>
                                    <option value="ctb-tool">SAP V3</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 normal-edc mode-upload">
                                <div class="row" style="display: flex;align-items: center;justify-content: space-between;">
                                    <label class="control-label col-md-3" style="margin-bottom: 0;">EDC V1:</label>
                                    <div class="col-md-5">
                                        <input type="file" class="normal-edc" name="input-edcv1" accept=".xls, .xlsx, .csv" />
                                    </div>
                                    <div class="col-md-4">
                                        <a href="/assets/files/edc_v1.xlsx"><i class="fa fa-download"></i> Download format file</a>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 master-edc mode-upload hidden">
                                <div class="row" style="display: flex;align-items: center;justify-content: space-between;">
                                    <label class="control-label col-md-3" style="margin-bottom: 0;">EDC V2:</label>
                                    <div class="col-md-5">
                                        <input type="file" class="master-edc" name="input-edcv2" accept=".xls, .xlsx, .csv" />
                                    </div>
                                    <div class="col-md-4">
                                        <a href="/assets/files/edc_v2.xlsx"><i class="fa fa-download"></i> Download format file</a>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 ctb-tool mode-upload hidden">
                                <div class="row" style="display: flex;align-items: center;justify-content: space-between;">
                                    <label class="control-label col-md-3" style="margin-bottom: 0;">ZNM24:</label>
                                    <div class="col-md-5">
                                        <input type="file" class="ctb-tool" name="input-znm24" accept=".xls, .xlsx, .csv" />
                                    </div>
                                    <div class="col-md-4">
                                        <a href="/assets/files/znm24.xlsx"><i class="fa fa-download"></i> Download format file</a>
                                    </div>
                                </div>
                                <div class="row" style="display: flex;align-items: center;justify-content: space-between;">
                                    <label class="control-label col-md-3">ZNM22:</label>
                                    <div class="col-md-5">
                                        <input type="file" class="ctb-tool" name="input-znm22" accept=".xls, .xlsx, .csv" />
                                    </div>
                                    <div class="col-md-4">
                                        <a href="/assets/files/znm22.xlsx"><i class="fa fa-download"></i> Download format file</a>
                                    </div>
                                </div>
                            </div>
                        </div>
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
        docNo: '',
        smmsRole: '${employeeSMMSRole}',
        page: 0,
        path: '',
        buyerList: [],
        numberData: 10,
    }
    init();
    function init() {
        //loadListDocNo();
        loadConfig();
        loadListBuyer();
        loadData();
    }

    function loadListDocNo() {
        $('.loader').removeClass('hidden');
        $('#tblListDocNo>tbody').html('');
        $.ajax({
            type: "GET",
            url:  dataset.path + "/api/pm/sd/list",
            data: {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft
            },
            contentType: "application/json; charset=utf-8",
            success: function(res){
                if(res.code == 'SUCCESS') {
                    var data = res.data;
                    var html = '';
                    for(i in data) {
                        if(data[i].usingEdc) {
                            html += '<tr data-docno="' + data[i].docNo + '"><td>' + data[i].docNo + '</td>'
                                 +  '<td>' + data[i].createdAt + '</td></tr>';
                        }
                    }
                    $('#tblListDocNo>tbody').html(html);
                    $('#tblListDocNo>tbody>tr').on('click', function() {
                        dataset.docNo = this.dataset.docno;
                        dataset.buyerList = [];
                        $('select[name=slBuyer]').val(dataset.buyerList);
                        $('select[name=slBuyer]').selectpicker('refresh');
                        dataset.partNumber = '';
                        $('input[name=searchByPN]').val('');
                        dataset.sourceManufactureCode = '';
                        $('input[name=searchByMP]').val('');
                        $('.title-docno').html(' ' + dataset.docNo);
                        loadData();
                        $('#modal-docno').modal('hide');
                    });
                    if(data.length == 0) {
                        $('#modal-docno').modal('hide');
                        $('#modal-import').modal('show');
                    } else {
                        $('#modal-docno').modal('show');
                    }
                }
            },
            failure: function(errMsg) {
                console.log(errMsg);
            },
            complete: function() {
                $('.loader').addClass('hidden');
            }
        });
    }

    $('input[name="accept-fr"]').on('click', function() {
        $('input[name="focus-range"]').attr('disabled', function(_, attr) { return !attr});
        $('input[name="focus-range"]').val(function(_,value) { return value==1 ? '' : 1});
    });

    $('#cbxEDC').on('click', function() {
        $('input[name="input-file-4"]').attr('disabled', function(_, attr) { return !attr});
        $('input[name="input-file-6"]').attr('disabled', function(_, attr) { return !attr});
    });

    $('#sl-upload').on('change', function(){
        var val = this.value;
        $('.mode-upload').addClass('hidden');
        $('.'+val).removeClass('hidden');
        $('input[class='+val+']').val('');
    });

    function uploadFile() {
        var form = new FormData();
        form.append("bu", dataset.bu);
        form.append("factory", dataset.factory);
        form.append("cft", dataset.cft);
        form.append("docNo", dataset.docNo);
        form.append("buyer", dataset.buyer);

        var focusRange = Number($('input[name="focus-range"]').val());
        if($('input[name="accept-fr"]')[0].checked) {
            form.append("focusRange", focusRange);
        }

        var url= '';
        var mode_upload = document.getElementById('sl-upload').value;
        if(mode_upload == 'normal-edc'){
            var edcv1 = document.querySelector('input[name="input-edcv1"]').files[0];

            if(edcv1 == undefined){
                alert('Warning, EDC V1 is empty, try again!');
                return;
            }

            form.append('edcFile', edcv1);
            url = '/api/pm/sd/edc/upload';
        }else if(mode_upload == 'master-edc'){
            var edcv2 = document.querySelector('input[name="input-edcv2"]').files[0];

            if(edcv2 == undefined){
                alert('Warning, EDC V2 is empty, try again!');
                return;
            }

            form.append('edcFile', edcv2);
            url = 'api/pm/sd/edc/report/upload';
        }else if(mode_upload == 'ctb-tool'){
            var znm24 = document.querySelector('input[name="input-znm24"]').files[0];
            var znm22 = document.querySelector('input[name="input-znm22"]').files[0];

            if(znm24 == undefined){
                alert('Warning, ZNM24 file is empty, try again!');
                return;
            }else if(znm22 == undefined){
                alert('Warning, ZNM22 file is empty, try again!');
                return;
            }

            form.append('znm24File', znm24);
            form.append('znm22File', znm22);
            url = 'api/pm/sd/edc/upload/sap';
        }
        // return;
        var confirm = window.confirm('Dou you want to upload file?');
        if(confirm){
            $('.loader').removeClass('hidden');
            $.ajax({
                type: 'POST',
                url: url,
                data: form,
                processData: false,
                contentType: false,
                mimeType: "multipart/form-data",
                success: function(response){
                    var res = JSON.parse(response);
                    if(res.code == 'SUCCESS') {
                        dataset.docNo = res.result.docNo;
                        loadData();
                        $('#modal-import').modal('hide');
                    }
                },
                error: function(e) {
                    console.log(e);
                    alert(JSON.parse(e.responseText).message);
                    $('.loader').addClass('hidden');
                },
                complete: function() {
                    $('.loader').addClass('hidden');
                }
            });
        }
    }

    $('#modal-import').on('hidden.bs.modal', function(){
        $('#modal-import input[type=file]').val('');
        $('.mode-upload').addClass('hidden');
        $('#sl-upload').val($('#sl-upload option:first-child').val());
        $('.'+$('#sl-upload option:first-child').val()).removeClass('hidden');
    });

    function loadConfig() {
        $.ajax({
            type: "GET",
            url:  dataset.path + "/api/pm/sd/config",
            data: {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft
            },
            contentType: "application/json; charset=utf-8",
            success: function(res){
                var html = '';
                if(!$.isEmptyObject(res.result)) {
                    var data = res.result;
                    for(i in data) {
                        var value = data[i]*100 + '%';
                        $('.' + i).html(value);
                        $('#midWeek').html(numToDay(data.midWeek));
                        $('#focusRange').html(data.focusRange);
                    }
                }
            },
            failure: function(errMsg) {
                console.log(errMsg);
            }
        });
    }

    function numToDay(num) {
        var day = '';
        if(num == 1) {
            day = 'Sun';
        } else if(num == 2) {
            day = 'Mon';
        } else if(num == 3) {
            day = 'Tue';
        } else if(num == 4) {
            day = 'Wed';
        } else if(num == 5) {
            day = 'Thu';
        } else if(num == 6) {
            day = 'Fri';
        } else if(num == 7) {
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
            success: function(res){
                if(res.code == 'SUCCESS') {
                    var data = res.data;
                    var selector = $("select[name='slBuyer']");
                    selector.children('option').remove();
                    var options = "";
                    for(i in data){
                        options+='<option value="' + data[i].buyer + '">' + data[i].buyer + '</option>';
                    }
                    selector.html(options);
                    selector.selectpicker('refresh');

                }
            },
            failure: function(errMsg) {
                console.log(errMsg);
            },
        });
    }

    $('select[name=slBuyer]').on('change', function() {
        dataset.buyer = $(this).val();
        dataset.buyerList = $(this).val();
        if(dataset.buyerList == null) {
            $('.title-docno').html(' ' + dataset.docNo);
        } else if(dataset.buyerList.length > 4){
            var buyer = '';
            for(var i=0; i< 4; i++) {
                buyer += dataset.buyerList[i] + ', ';
            }
            $('.title-docno').html(' ' + dataset.docNo + ' ' + buyer + '...');
        } else {
            $('.title-docno').html(' ' + dataset.docNo + ' ' + dataset.buyerList);
        }
        dataset.partNumber = $('input[name=searchByPN]').val();
        dataset.sourceManufactureCode = $('input[name=searchByMP]').val();
        dataset.page = 0;
        loadData();
    });
    $('input[name=searchByPN]').keyup(function (event) {
        if (event.keyCode == 13) {
            dataset.partNumber = $(this).val();
            dataset.sourceManufactureCode = $('input[name=searchByMP]').val();
            dataset.page = 0;
            loadData();
        }
    });
    $('input[name=searchByMP]').keyup(function (event) {
        if (event.keyCode == 13) {
            dataset.sourceManufactureCode = $(this).val();
            dataset.partNumber = $('input[name=searchByPN]').val();
            dataset.page = 0;
            loadData();
        }
    });

    $('#numberData').on('keyup', function(event){
        if(event.keyCode === 13){
            dataset.numberData = $(this).val();
            event.preventDefault();
            loadData();
        }
    });

    function loadData() {
        $('.loader').removeClass('hidden');
        var data = {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft,
                project: '',
                sourceManufactureCode: dataset.sourceManufactureCode,
                partNumber: dataset.partNumber,
                page: dataset.page,
                size: dataset.numberData
        };
        var url = dataset.path + "/api/pm/sd/edc/view?" + jQuery.param(data);
        for(i in dataset.buyerList) {
            url += '&buyerList=' + dataset.buyerList[i];
        }
        $.ajax({
            type: "GET",
            url: url,
            contentType: "application/json; charset=utf-8",
            success: function(res){
                $('#tblBuyer>tbody').html('');
                $('#pagination').html('');
                if(res.code == 'SUCCESS') {
                    $('#tblBuyer>tbody').html('');
                    var data = res.data;
                    var html = '';
                    var stt = 1 + (10 * dataset.page);
                    for(i in data) {
                        html += '<tr>'
                             +  '<td>' + stt + '</td>'
                             +  '<td>' + data[i].partNumber + '</td>'
                             +  '<td>' + data[i].manufacturePartNumber + '</td>'
                             +  '<td>' + data[i].sourceManufactureCode + '</td>'
                             +  '<td>' + data[i].plant + '</td>'
                             +  '<td>' + data[i].vendor + '</td>'
                             +  '<td>' + data[i].openPO + '</td>'
                             +  '<td>' + data[i].buyer + '</td>';
                        if(data[i].focusRange == null) {
                            html += '<td>' + data[i].status + '</td><td></td>';
                        } else {
                            html += '<td></td><td>' + data[i].status + '</td>';
                        }
                        html += 
                        // '<td class="shipping_mode"><input type="text" class="form-control form-control-sm" disabled name="shipping_mode" data-id="' + data[i].id + '" value="' + fixNull(data[i].shippingMode) + '" /></td>'
                                '<td class="shippingMode"><select class="slShippingMode'+data[i].id+'" data-value="'+data[i].shippingMode+'" data-id="'+data[i].id+'" style="height:30px;border-radius:5px;padding:3px" onchange="getShippingMode(this)">'+
                                    selectorCustom(data[i].shippingMode)+ 
                                '</select></td>'
                             +  '<td>' + data[i].action + '</td>'
                             +  '</tr>';
                        stt++;
                    }

                    if(html == '') {
                        html = "<tr><td colspan='12'><span>We couldn't find what you were looking for</span></tr></td>";
                    }

                    $('#tblBuyer>tbody').html(html);
                    // $('.slShippingMode').on('change',function(){
                    //     var shippingMode = $(this).val();
                    //     var id = this.dataset.id;
                    //     alert(this.dataset.value);
                    //     // updateShippingMode(id,shippingMode);
                    // });

                    // $('.shipping_mode').on('dblclick', function() {
                    //     $('input[name="shipping_mode"]').attr('disabled', true);
                    //     $('input[data-id="' + dataset.idCancel + '"]').val(dataset.valueCancel);
                    //     $(this.children[0]).attr('disabled', function(_, attr) { return !attr});
                    //     $(this.children[0]).focus();
                    //     dataset.idCancel = this.children[0].dataset.id;
                    //     dataset.valueCancel = $(this.children[0]).val();
                    // });

                    // $('input[name="shipping_mode"]').keyup(function(e) {
                    //     if(e.keyCode == 13) {
                    //         updateShippingMode(this);
                    //     }
                    // });

                    var totalPage = 0;
                    if(res.size % dataset.numberData > 0) {
                        totalPage = parseInt(res.size / dataset.numberData) + 1;
                    } else {
                        totalPage = parseInt(res.size / dataset.numberData);
                    }
                    if(totalPage != 0) {
                        pagination(totalPage, dataset.page);
                    }
                }
            },
            failure: function(errMsg) {
                console.log(errMsg);
            },
            complete: function() {
                // styleTable();
                $('.loader').addClass('hidden');

                if(dataset.smmsRole == 'MPM') {
                    $('.shippingMode').remove();
                } else if(dataset.smmsRole == 'MPM_MANAGER'){
                    $('.shippingMode').remove();
                }
            }
        });
    }

    function getShippingMode(context){
        var shippingMode = $('.slShippingMode'+context.dataset.id).val();
        var id = context.dataset.id;
        updateShippingMode(id,shippingMode);
    }

    function selectorCustom(value){
        var option = ['','ETA_BT','ETA_HN','ETA_YYG','ETA_HP','ETA_DX'];
        var result = '';
        for(j in option) {
            if(value == option[j]) {
                result += '<option value="' + option[j] + '" selected>' + option[j] + '</option>';
            } else {
                result += '<option value="' + option[j] + '">' + option[j] + '</option>';
            }
        }
        return result;
    }

    function updateShippingMode(id,shippingMode) {
        data = new FormData();
        data.append('scheduleId', Number(id));
        data.append('shippingMode', shippingMode);

        $('.loader').removeClass('hidden');
        $.ajax({
            type: 'POST',
            url: '/api/pm/sd/edc/shipping-mode',
            data: data,
            processData: false,
            contentType: false,
            mimeType: "multipart/form-data",
            success: function(response){
                var res = JSON.parse(response);
                if(res.code == 'SUCCESS') {
                    // $(context).attr('disabled', true);
                    loadData();
                }
            },
            error: function(e) {
                alert(e.responseJSON.message);
            },
            complete: function(){
                $('.loader').addClass('hidden');
            }
        });
    }

    function fixNull(text) {
        var result = '';
        if(text != null && text != 'null' && text != 'NULL') {
            result = text;
        }
        return result;
    }
    function numberWithCommas(x) {
        var parts = '';
        if(x != null) {
            parts = x.toString().split('.');
            parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            parts.join('.')
        }
        return parts;
    }

    function styleTable() {
        var listCol = $('#tblBuyer>tbody>tr>td');
        for(var i=0; i< listCol.length; i++) {
            
            if(listCol[i].innerHTML == '1. Demand') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(listCol[i]).addClass('demand');
                $(row).addClass('sort-view');
            } else if(listCol[i].innerHTML == '2. Supply') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(listCol[i]).addClass('supply');
                $(row).addClass('sort-view');
            } else if(listCol[i].innerHTML == '3. DemandTotal') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(listCol[i]).addClass('demandTotal');
            } else if(listCol[i].innerHTML == '4. SupplyTotal') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(listCol[i]).addClass('supplyTotal');
            } else if(listCol[i].innerHTML == '5. Balance') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(row).addClass('balance');
            } else if(listCol[i].innerHTML == '6. Action') {
                var row = $(listCol[i]).parent();
                var per = Number(row.children()[2].innerText) * 100;
                row.children()[2].innerHTML = per.toFixed(2) + '%';
                $(row.children()[2]).addClass(riskLevel(per));
                $(row).addClass('action');
                var length = row.children().length;
                $(row.children()[11]).attr('colspan', (length - 10));
                for(var j=12; j< length; j++) {
                    $(row.children()[j])[0].remove();
                    j--;
                    length--;
                }
            }

            if($('#btnSortView').hasClass('active')) {
                $('.sort-view').addClass('hidden');
            }
        }
    }

    function riskLevel(per) {
        var classRisk = '';
        if(Number(per) < 75) {
            classRisk = 'riskRed';
        } else if(Number(per) >= 75 && Number(per) < 90) {
            classRisk = 'riskOrange';
        } else if(Number(per) >= 90 && Number(per) < 98) {
            classRisk = 'riskYellow';
        } else if(Number(per) >= 98){
            classRisk = 'riskGreen';
        }
        return classRisk;
    }

    function exportData() {
        $('.loader').removeClass('hidden');

        var request = new XMLHttpRequest();
        request.open("POST", "/api/pm/sd/edc/export?bu=" + dataset.bu + "&factory=" + dataset.factory + "&cft=" + encodeURIComponent(dataset.cft), true);
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

                    setTimeout(function () { URL.revokeObjectURL(downloadUrl); }, 100);
                }
                $('.loader').addClass('hidden');
            } else {
                $('.loader').addClass('hidden');
                alert('Download FAIL!');
            }
        }
        request.send();
    }

    var Pagination = {
        code: '',
        Extend: function(data) {
            data = data || {};
            Pagination.size = data.size || 300;
            Pagination.page = data.page || 1;
            Pagination.step = data.step || 3;
        },

        // add pages by number (from [s] to [f])
        Add: function(s, f) {
            for (var i = s; i < f; i++) {
                Pagination.code += '<a class="p-item page-' + i + '">' + i + '</a>';
            }
        },

        // add last page with separator
        Last: function() {
            Pagination.code += '<a><i>...</i></a><a class="p-item page-' + Pagination.size + '">' + Pagination.size + '</a>';
        },

        // add first page with separator
        First: function() {
            Pagination.code += '<a class="p-item">1</a><a><i>...</i></a>';
        },

        // change page
        Click: function() {
            Pagination.page = +this.innerHTML;
            dataset.page = Pagination.page - 1;
            loadData();
            Pagination.Start();
        },

        // previous page
        Prev: function() {
            Pagination.page--;
            if (Pagination.page < 1) {
                Pagination.page = 1;
            }
            dataset.page = Pagination.page - 1;
            loadData();
            Pagination.Start();
        },

        // next page
        Next: function() {
            Pagination.page++;
            if (Pagination.page > Pagination.size) {
                Pagination.page = Pagination.size;
            }
            dataset.page = Pagination.page - 1;
            loadData();
            Pagination.Start();
        },

        // binding pages
        Bind: function() {
            var a = Pagination.e.getElementsByClassName('p-item');
            if(a.length > 1) {
                for (var i = 0; i < a.length; i++) {
                    if (+a[i].innerHTML === Pagination.page) a[i].className = 'p-item current';
                    // if(+a[i].innerHTML == Pagination.size) i--;
                    a[i].addEventListener('click', Pagination.Click, false);
                }
            }
        },

        // write pagination
        Finish: function() {
            Pagination.e.innerHTML = Pagination.code;
            Pagination.code = '';
            Pagination.Bind();
        },

        // find pagination type
        Start: function() {
            if (Pagination.size < Pagination.step * 2 + 6) {
                Pagination.Add(1, Pagination.size + 1);
            }
            else if (Pagination.page < Pagination.step * 2 + 1) {
                Pagination.Add(1, Pagination.step * 2 + 4);
                Pagination.Last();
            }
            else if (Pagination.page > Pagination.size - Pagination.step * 2) {
                Pagination.First();
                Pagination.Add(Pagination.size - Pagination.step * 2 - 2, Pagination.size + 1);
            }
            else {
                Pagination.First();
                Pagination.Add(Pagination.page - Pagination.step, Pagination.page + Pagination.step + 1);
                Pagination.Last();
            }
            Pagination.Finish();
        },

        // binding buttons
        Buttons: function(e) {
            var nav = e.getElementsByTagName('a');
            nav[0].addEventListener('click', Pagination.Prev, false);
            nav[1].addEventListener('click', Pagination.Next, false);
        },

        // create skeleton
        Create: function(e) {

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
        Init: function(e, data) {
            Pagination.Extend(data);
            Pagination.Create(e);
            Pagination.Start();
        }
    };

    function pagination(size, page) {
        Pagination.Init(document.getElementById('pagination'), {
            size: size, // pages size
            page: page + 1,  // selected page
            step: 2,   // pages before and after current
        });
    };

    function checkSMMSRole(){
        if(dataset.smmsRole == 'MPM') {
            $('.btnImportFile').remove();
        } else if(dataset.smmsRole == 'MPM_MANAGER'){
            $('.btnImportFile').remove();
        }
    }

    $(document).ready(function(){
        checkSMMSRole();
    });
</script>