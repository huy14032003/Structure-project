<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    .modal-xl-custome {
        max-width: 90% !important;
    }
    table#tblPreview {
        min-width: 350vw;
    }

    @media screen and (min-width: 1024px) and (max-width: 1365px) {
        table#tblPreview {
            min-width: 450vw;
        }
    }

    @media screen and (min-width: 1366px) and (max-width: 1919px) {
        table#tblPreview {
            min-width: 500vw;
        }
    }
</style>
<div class="loader hidden"></div>
<div class="row">
    <div class="col-12 my-2 component">
        <div class="row">
            <div class="col-12 border-bottom py-2">
                <span class="title-table">Information</span>
            </div>
            <div class="col-12 py-3">
                <div class="row">
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Customer:</label>
                            <div class="col-8">
                                <select class="form-control" id="txt_end_customer"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Type:</label>
                            <div class="col-8">
                                <select class="form-control" id="txt_type">
                                    <option value="" disabled selected>--Select--</option>
                                    <option value="PO">PO</option>
                                    <option value="FO">FO</option>
                                    <option value="Shipment">Shipment</option>
                                    <option value="Input ETAC">Input ETAC</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Sign process:</label>
                            <div class="col-8">
                                <select class="form-control" id="txt_sign_process"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Plant:</label>
                            <div class="col-8">
                                <select class="form-control" id="txt_plant"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">File:</label>
                            <div class="col-8 d-flex-rcb">
                                <div class="input-group">
                                    <input type="file" class="form-control" id="txt_file" multiple>
                                    <div class="input-group-append">
                                        <button class="input-group-text btn btn-primary" onclick="showPreview()"><i class="fa fa-eye"></i></button>
                                        <button class="input-group-text btn btn-default"><i class="fa fa-question-circle"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Applicant:</label>
                            <div class="col-8">
                                <input type="text" class="form-control" id="txt_creator" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Customer code:</label>
                            <div class="col-8">
                                <select class="form-control" id="txt_customer_code"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">ETAC week:</label>
                            <div class="col-8">
                                <select type="text" id="time-span" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Create at:</label>
                            <div class="col-8">
                                <input type="text" class="form-control" id="txt_created_at" disabled>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-12 my-2 component">
        <div class="row">
            <div class="col-12 border-bottom py-2">
                <span class="title-table">Sign Process</span>
            </div>
            <div class="col-12 py-3">
                <table id="tblListSigner" class="table my-table">
                    <thead>
                        <tr>
                            <th style="width: 10%;">#</th>
                            <th>Card ID</th>
                            <th>User name</th>
                            <th>Email</th>
                            <th>Permission</th>
                            <th>Sign level</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-12 my-2 text-center">
        <button class="btn btn-sm btn-primary mx-1" id="btnSubmitForm" onclick="submitForm()"><i class="fa fa-check-circle"></i> Submit</button>
        <button class="btn btn-sm btn-danger mx-1" onclick="cancelInput()"><i class="fa fa-times-circle"></i> Cancel</button>
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
                    <div class="col-sm-12 table-responsive" style="max-height: calc(100vh - 250px);">
                        <table id="tblPreview" class="table my-table">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                        <div class="hidden no-data text-center">No data to display</div>
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
        "pn": ""
    }

    $(document).ready(function () {
        $("#txt_creator").val(dataset.empName + ' (' + dataset.empNo + ')');
        $("#txt_created_at").val(moment().format("YYYY/MM/DD"));
        init();
    });

    function init() {
        getMonday();
        loadListCustomer();
        getListSignProcess($('#txt_type').val());
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
                dataset.endCustomer = $('#txt_end_customer').val();
            },
            error: function (errMsg) {
                $('.loader').addClass('hidden');
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
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
                dataset.plant = $('#txt_plant').val();
            },
            error: function (errMsg) {
                $('.loader').addClass('hidden');
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
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
                dataset.customerCode = $('#txt_customer_code').val();
            },
            error: function (errMsg) {
                $('.loader').addClass('hidden');
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
            }
        });
    }

    $('#txt_customer_code').on('change', function () {
        dataset.customerCode = $(this).val();
    });

    function getListSignProcess(type) {
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/sign/listSignProcess',
            data: {
                type: type
            },
            success: function (res) {
                var data = res.data;
                var html = '<option value="" disabled selected>--Select--</option>';
                if (!isArrayEmpty(data) && !isFalsy(data)) {
                    for (var i = 0; i < data.length; i++) {
                        html += '<option value="' + data[i].sign_process + '">' + data[i].sign_process + '</option>';
                    }
                }
                $('#txt_sign_process').html(html);
            },
            error: function (err) {
                console.log(err);
            },
            complete: function () {
                loadListSigner();
            }
        });
    }

    $('#txt_sign_process').on('change', function () {
        loadListSigner();
    });

    $('#txt_type').on('change', function () {
        var type = $('#txt_type').val();
        $('#txt_file').val('');
        getListSignProcess(type);
    });

    function loadListSigner() {
        dataset.idSignRank = [];
        $('.loader').removeClass('hidden');
        $('#tblListSigner tbody').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/createForm/listSignByCreateForm",
            data: {
                signProcess: $('#txt_sign_process').val(),
                type: $('#txt_type').val()
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '';
                if (!isArrayEmpty(data) && !isFalsy(data)) {
                    for (var i = 0; i < data.length; i++) {
                        html +=
                            '<tr>' +
                            '<td>' + (Number(i) + 1) + '</td>' +
                            '<td>' + data[i].id_card + '</td>' +
                            '<td>' + data[i].name + '</td>' +
                            '<td>' + data[i].mail + '</td>' +
                            '<td>' + data[i].permission + '</td>' +
                            '<td>' + data[i].rank_sign + '</td>' +
                            '<tr/>';

                        dataset.idSignRank.push(data[i].idSignRank);
                    }
                } else {
                    html = '<tr><td colspan="6">No data to display</td></tr>';
                }

                $('#tblListSigner tbody').html(html);

                if (data.length > 0) {
                    $('#btnSubmitForm').removeAttr('disabled');
                } else {
                    $('#btnSubmitForm').attr('disabled', 'disabled');
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

    function showPreview() {
        var files = $('#txt_file')[0].files;
        var listFiles = [];
        if (files.length > 0) {
            var type = $('#txt_type').val();
            if (isFalsy(type)) {
                showAlertJS('error', 'Type cannot be emtpy');
                return;
            }
            var form = new FormData();
            form.append("type", $('#txt_type').val());

            for (var i in files) {
                if (parseInt(i) >= 0) {
                    form.append("file", files[i]);
                };
            }

            $('.loader').removeClass('hidden');
            $('#tblPreview tbody').html('');

            var fileType = $('#txt_type').val();
            var url = '';
            if (fileType == 'PO' || fileType == 'Shipment') {
                url = "/pm-system/api/createForm/previewPOAndShipment";
            } else {
                url = "/pm-system/api/createForm/previewFOAndETAC";
            }
            $.ajax({
                type: "POST",
                url: url,
                data: form,
                processData: false,
                contentType: false,
                mimeType: "multipart/form-data",
                success: function (res) {
                    res = JSON.parse(res);
                    if (res.code == 'SUCCESS') {
                        var data = res.data;
                        var html = '';
                        var checkArr = flatten(data);
                        if (checkArr.length > 0) {
                            var thead = checkType(fileType);
                            if (fileType == 'PO') {
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
                            } else if (fileType == 'Shipment') {
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

                            } else if (fileType == 'FO') {
                                var data = res.data;
                                var thead = '';
                                var html = '';

                                for (var i = 0; i < 1; i++) {
                                    var title_header = data[i];
                                    for (var j = 0; j < title_header.length; j++) {
                                        thead += '<th>' + title_header[j] + '</th>';
                                    }
                                    thead += '<tr>' + thead + '</tr>';
                                }

                                for (var i = 1; i < data.length; i++) {
                                    var data1 = data[i];
                                    var frame = '';
                                    for (var j = 0; j < data1.length; j++) {
                                        frame += '<td> ' + data1[j] + '</th>';
                                    }
                                    html += '<tr>' + frame + '</tr>';
                                }
                            } else if (fileType == 'Input ETAC') {
                                var data = res.data;
                                var thead = '';
                                var html = '';

                                for (var i = 0; i < 1; i++) {
                                    var title_header = data[i];
                                    for (var j = 0; j < title_header.length; j++) {
                                        thead += '<th>' + title_header[j] + '</th>';
                                    }
                                    thead += '<tr>' + thead + '</tr>';
                                }

                                for (var i = 1; i < data.length; i++) {
                                    var data1 = data[i];
                                    var frame = '';
                                    for (var j = 0; j < data1.length; j++) {
                                        frame += '<td> ' + data1[j] + '</th>';
                                    }
                                    html += '<tr>' + frame + '</tr>';
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
        } else {
            showAlertJS('error', 'File cannot be empty');
        }
    }

    function fixedNull(text) {
        var res = '';
        if (text != null && text != undefined) {
            res = text;
        }
        return res;
    }

    function submitForm() {
        var customer = formatEmpty($('#txt_end_customer').val()).trim();
        var plant = formatEmpty($('#txt_plant').val()).trim();
        var customerCode = formatEmpty($('#txt_customer_code').val()).trim();
        var type = formatEmpty($('#txt_type').val()).trim();
        var files = $('#txt_file')[0].files;
        var etacWeek = formatEmpty($('#time-span').val()).trim();
        var signProcess = formatEmpty($('#txt_sign_process').val()).trim();

        if (isFalsy(customer)) {
            showAlertJS('error', 'Customer cannot be empty');
            return;
        } else if (isFalsy(plant)) {
            showAlertJS('error', 'Plant cannot be empty');
            return;
        } else if (isFalsy(customerCode)) {
            showAlertJS('error', 'Customer code cannot be empty');
            return;
        } else if (isFalsy(type)) {
            showAlertJS('error', 'Type cannot be empty');
            return;
        } else if (files.length == 0) {
            showAlertJS('error', 'File cannot be empty');
            return;
        } else if (isFalsy((etacWeek))) {
            showAlertJS('error', 'ETAC week cannot be empty');
            return;
        } else if (isFalsy(signProcess)) {
            showAlertJS('error', 'Sign process cannot be empty');
            return;
        }

        var confirm = window.confirm('Do you want to submit?');
        if (confirm) {
            $('.loader').removeClass('hidden');
            $('#tblPreview tbody').html('');
            var form = new FormData();
            form.append("idCard", dataset.empNo);
            form.append("endCustomer", dataset.endCustomer);
            form.append("plant", dataset.plant);
            form.append("customerCode", dataset.customerCode);
            form.append("type", $('#txt_type').val());
            form.append('week', $('#time-span').val());
            for (var i = 0; i < dataset.idSignRank.length; i++) {
                form.append('idSignRank', dataset.idSignRank[i]);
            }
            for (var i in files) {
                if (parseInt(i) >= 0) {
                    form.append("file", files[i]);
                };
            }
            $.ajax({
                type: "POST",
                url: "/pm-system/api/createForm/upload",
                data: form,
                processData: false,
                contentType: false,
                mimeType: "multipart/form-data",
                success: function (res) {
                    res = JSON.parse(res);
                    if (res.code == 'SUCCESS') {
                       alert('Create file success');
                        dataset.idSignRank = [];
                    } else {
                        alert (res.message);
                    }
                },
                error: function (errMsg) {
                    console.log(errMsg);
                    alert(JSON.parse(errMsg.responseText).message);
                },
                complete: function () {
                    $('.loader').addClass('hidden');
                    window.location.reload();
                }
            });
        }
    }

    function cancelInput() {
        window.location.reload();
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

    function flatten(arr) {
        return arr.reduce(function (pre, cur) {
            return pre.concat(cur instanceof Array ? flatten(cur) : cur);
        }, []);
    }

    function getMonday() {
        var arrMonday = [];
        var today = new Date();
        var first = today.getDate() - today.getDay() + 1;
        var monday = new Date(today.setDate(first));
        var monday1 = moment(monday).subtract(7, 'days').format('YYYY/MM/DD');
        var monday2 = moment(monday).format('YYYY/MM/DD');
        var monday3 = moment(monday).add(7, 'days').format('YYYY/MM/DD');
        var monday4 = moment(monday).add(14, 'days').format('YYYY/MM/DD');
        arrMonday = [monday1, monday2, monday3, monday4, ];
        var html = '';
        for (var i = 0; i < arrMonday.length; i++) {
            html += '<option value="' + arrMonday[i] + '">' + arrMonday[i] + '</option>';
        }
        $('#time-span').html(html);
    }

    /**
     * Check empty value
     */
    function isArrayEmpty(value) {
        if (Array.isArray(value) && value.length === 0) return true;
        return false;
    }

    /**
     * Check empty value
     */
    function isFalsy(value) {
        if (value === null || value === undefined || value === 0 || value === "") return true;
        return false;
    }
</script>