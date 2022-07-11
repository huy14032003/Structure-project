<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    table#tbl-wka1 {
        min-width: 200vw;
        cursor: grab;
    }

    .container-filter {
        width: 55%;
    }

    .container-search {
        width: 40%;
    }

    @media screen and (max-width: 1365px) {
        table#tbl-wka1 {
            min-width: 350vw !important;
        }

        .container-filter {
            width: 100%;
        }

        .container-search {
            width: 70%;
        }
    }

    @media screen and (min-width: 1366px) and (max-width: 1919px) {
        table#tbl-wka1 {
            min-width: 300vw !important;
        }

        .container-filter {
            width: 100%;
        }

        .container-search {
            width: 50%;
        }
    }
</style>
<div class="loader hidden"></div>
<div class="row">
    <!-- <div class="col-sm-12" style="background-color:#2061C5; color: #F8F8F8; font-size: 18px; font-weight: bold;text-align: center;padding: 0.5rem;">
        ETAC FROM
        <a href="/po-management" target="_blank" style="text-decoration: underline; color: #fff;">PO</a> - 
        <a href="/fo-management" target="_blank" style="text-decoration: underline; color: #fff;">FO</a> - 
        <a href="/shipment-management" target="_blank" style="text-decoration: underline; color: #fff;">SHIPMENT MANAGEMENT</a>
    </div> -->
    <div class="col-sm-12 my-2 component d-flex-rcsb">
        <div class="row">
            <div class="border-bottom d-flex-rcb flex-wrap w-100">
                <div class="container-filter px-2 py-2 d-flex-rcb">
                    <label class="label-inline mx-2">Customer:</label>
                    <select name="sl-custom" class="form-control my-select" id="customer-select">
                        <option value="">Select customer</option>
                    </select>
                    <label class="label-inline mx-2">Plant:</label>
                    <select name="sl-custom" class="form-control my-select" id="plant-select">
                        <option value="">Select plant</option>
                    </select>
                    <label class="label-inline mx-2">Customer code:</label>
                    <select name="sl-custom" class="form-control my-select" id="customerCode-select">
                        <option value="">Select customer code</option>
                    </select>
                    <label class="label-inline mx-2">ETAC week:</label>
                    <select name="sl-custom" class="form-control my-select" id="week-select">
                        <option value="">Select week</option>
                    </select>
                </div>
                <div class="container-search px-2 py-2 d-flex-rcb">
                    <button class="btn btn-primary mx-2 text-nowrap my-button" onclick="activeModelOutputETAC()"><i class="fa fa-download"></i> Generate ETAC</button>
                    <button class="btn btn-primary mx-2 text-nowrap my-button" onclick="getListWKA1Download()"><i class="fa fa-download"></i> Download</button>
                    <div class="input-group">
                        <input type="text" id="search-order" class="form-control my-input" placeholder="Product code" style="width: auto !important;">
                        <div class="input-group-append">
                            <button class="input-group-text btn btn-search my-button"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 py-3">
                <div class="table-responsive">
                    <table class="table my-table" id="tbl-wka1">
                        <thead></thead>
                        <tbody></tbody>
                    </table>
                    <div class="hidden nodata" style="width: 100%;text-align: center;">No data to display</div>
                </div>
                <div class="pagination d-flex-rce">
                    <ul></ul>
                </div>
            </div>
        </div>
    </div>


</div>

<div style="width: 100%;display: none;">
    <table class="table" id="tbl-wka1-download">
        <thead></thead>
        <tbody></tbody>
    </table>
</div>
<div style="width: 100%;display: none;">
    <table class="table" id="tbl-download">
        <thead></thead>
        <tbody></tbody>
    </table>
</div>

<!-- Modal Note-->
<div class="modal fade" id="modal-output-etac">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Generate ETAC WKA1</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Customer:</label>
                            <div class="col-8">
                                <select id="customer-select-modal" class="form-control my-select"></select>
                            </div>
                        </div>
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Plant:</label>
                            <div class="col-8">
                                <select id="plant-select-modal" class="form-control my-select"></select>
                            </div>
                        </div>
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Customer code:</label>
                            <div class="col-8">
                                <select id="customerCode-select-modal" class="form-control my-select"></select>
                            </div>
                        </div>
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">ETAC week:</label>
                            <div class="col-8">
                                <select id="week-select-modal" class="form-control my-select"></select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm btn-primary" onclick="downloadOutputETAC()"><i class="fa fa-download"></i> Generate</button>
                <button class="btn btn-sm btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cancel</button>
            </div>
        </div>
    </div>
</div>

<script>
    var userInfo = JSON.parse(localStorage.getItem('userInfo'));
    var empNo = userInfo.idCard;
    
    var dataset = {
        empNo: empNo,
        productCode: '',
        timeSpan: '',
    };

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
        customScroll('.table-responsive');
    }

    function loadListCustomer() {
        $('#customer-select').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/createForm/listEndCustomer",
            data: {},
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].end_customer + '">' + data[i].end_customer + '</option>';
                }
                $('#customer-select').html(html);
                if (data.length > 0) {
                    dataset.endCustomer = data[0].end_customer;
                }
                $('#customer-select').val(dataset.endCustomer);
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                dataset.endCustomer = $('#customer-select').val();
                loadListPlant();
            }
        });
    }

    $('#customer-select').on('change', function () {
        dataset.endCustomer = $(this).val();
        loadListPlant();
    });

    function loadListPlant() {
        $('#plant-select').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/listPlant",
            data: {
                endCustomer: dataset.endCustomer
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].plant + '">' + data[i].plant + '</option>';
                }
                $('#plant-select').html(html);
                if (data.length > 0) {
                    dataset.plant = data[0].plant;
                }
                $('#plant-select').val(dataset.plant);
                $('#sl-plant').val(dataset.plant);
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                loadListCustomerCode();
            }
        });
    }

    $('#plant-select').on('change', function () {
        dataset.plant = $(this).val();
        loadListCustomerCode();
    });

    function loadListCustomerCode() {
        $('#customerCode-select').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/listCustomerCode",
            data: {
                endCustomer: dataset.endCustomer
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].customer_code + '">' + data[i].customer_code + '</option>';
                }
                $('#customerCode-select').html(html);
                if (data.length > 0) {
                    dataset.customerCode = data[0].customer_code;
                }
                $('#customerCode-select').val(dataset.customerCode);
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                getListWeek();
            }
        });
    }

    $('#customerCode-select').on('change', function () {
        dataset.customerCode = $(this).val();
        getListWeek();
    });

    function getListWeek() {
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/sign/listWeekWKA1',
            data: {},
            success: function (res) {
                var data = res;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i] + '">' + data[i] + '</option>';
                }
                $('#week-select').html(html);
            },
            error: function (err) {

            },
            complete: function () {
                dataset.week = $('#week-select').val();
                getDataTablePagination();
            }
        });
    }

    $('#week-select').on('change', function () {
        dataset.week = $(this).val();
        getDataTablePagination();
    });

    function getDataTablePagination() {
        $('.loader').removeClass('hidden');
        state.page = 1;
        $.ajax({
            type: 'POST',
            url: '/pm-system/api/sign/getListWKA1',
            data: {
                endCustomer: dataset.endCustomer,
                plant: dataset.plant,
                customerCode: dataset.customerCode,
                week: dataset.week,
                productCode: dataset.productCode,
            },
            success: function (res) {
                dataset.tableData = res.result;
                state.data = dataset.tableData;
            },
            error: function (errMesg) {
                $('.loader').addClass('hidden');
                console.log(errMesg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                getListWKA1();
            }
        });
    }

    function getListWKA1() {
        var myData = pagination(state.data, state.page, state.rows);
        var data = myData.data;
        var thead = '';
        var tbody = '';
        $('#tbl-wka1 thead').html('');
        $('#tbl-wka1 tbody').html('');
        if (!isArrayEmpty(data) && !isFalsy(data)) {
            $('.nodata').addClass('hidden');
            $('#tbl-wka1 tbody').show();
            for (let i = 0; i < 1; i++) {
                thead +=
                    '<th style="background:#2061C5; color: #fff;">Project</th>' +
                    '<th style="background:#2061C5; color: #fff;">Product code</th>' +
                    '<th style="background:#2061C5; color: #fff;">Foxconn P/N</th>' +
                    '<th style="background:#2061C5; color: #fff;">Plant</th>' +
                    '<th style="background:#2061C5; color: #fff;">End customer</th>' +
                    '<th style="background:#2061C5; color: #fff;">Ship cutoff date</th>' +
                    '<th style="background:#2061C5; color: #fff;">Hub code</th>';
                var quantityWeek = data[i].quantityWeek;
                var quantityMonth = data[i].quantityMonth;

                for (var j in quantityWeek) {
                    thead += '<th style="background:#2061C5; color: #fff;">' + j.split(',')[0] + ',' + '<br/><span style="white-space: nowrap;">' + j.split(',')[1] + '</span>' + '</th>';
                }

                for (var k in quantityMonth) {
                    thead += '<th style="background:#2061C5; color: #fff; white-space: nowrap;">' + k + '</th>';
                }
                thead += '<th style="background:#2061C5; color: #fff;">Total</th>';
                thead = '<tr>' + thead + '</tr>';
            }

            for (var i = 0; i < data.length; i++) {
                var firstData = data[i].data;
                var quantityWeek = data[i].quantityWeek;
                var quantityMonth = data[i].quantityMonth;

                tbody +=
                    '<td style="white-space: nowrap;">' + fixedNull(firstData.project) + '</td>' +
                    '<td style="white-space: nowrap;">' + fixedNull(firstData.product_code) + '</td>' +
                    '<td>' + fixedNull(firstData.foxconn_pn) + '</td>' +
                    '<td>' + fixedNull(firstData.plant) + '</td>' +
                    '<td>' + fixedNull(firstData.end_customer) + '</td>' +
                    '<td>' + fixedNull(firstData.ship_cutoff_date) + '</td>' +
                    '<td>' + fixedNull(firstData.hub_code) + '</td>';

                for (var j in quantityWeek) {
                    tbody += '<td>' + quantityWeek[j] + '</td>';
                }

                var total = 0;
                for (var k in quantityMonth) {
                    total += quantityMonth[k];
                    tbody += '<td style="background-color: #c0c0c0; text-align: center;">' + quantityMonth[k] + '</td>';
                }
                tbody += '<td style="background-color: #808080; text-align: center; font-weight: bold;">' + total + '</td>';

                tbody = '<tr>' + tbody + '</tr>';
            }
            $('#tbl-wka1 thead').html(thead);
            $('#tbl-wka1 tbody').html(tbody);

            pageButtons(myData.pages);

            // active page
            var li = document.querySelectorAll('.pagination ul li');
            for (let i = 0; i < li.length; i++) {
                li[i].classList.remove('active');
            }

            var liActive = document.querySelector('.li' + state.page);
            if (liActive != null && liActive != undefined) {
                document.querySelector('.li' + state.page).classList.add('active');
            }
        } else {
            // html = '<tr><td colspan="' + dataset.colspan + '">No data to display</td></tr>';
            $('#tbl-wka1 tbody').hide();
            $('.nodata').removeClass('hidden');
        }
    }

    // Ham nay dung cho chuc nang phan trang (khi su dung o trang khac thi chi can thay doi noi dung ben trong ham)
    function getResultPagination() {
        getListWKA1();
    }

    function getListWKA1Download() {
        var thead = tbody = '';
        $('#tbl-wka1-download thead').html('');
        $('#tbl-wka1-download tbody').html('');
        var data = dataset.tableData;
        if (data.length > 0) {
            $('#tbl-wka1-download tbody').show();
            $('.nodata').addClass('hidden');
            for (let i = 0; i < 1; i++) {
                thead +=
                    '<th style="background:#2061C5; color: #fff;">Project</th>' +
                    '<th style="background:#2061C5; color: #fff;">Product code</th>' +
                    '<th style="background:#2061C5; color: #fff;">Foxconn P/N</th>' +
                    '<th style="background:#2061C5; color: #fff;">Plant</th>' +
                    '<th style="background:#2061C5; color: #fff;">End customer</th>' +
                    '<th style="background:#2061C5; color: #fff;">Ship cutoff date</th>' +
                    '<th style="background:#2061C5; color: #fff;">Hub code</th>';
                var quantityWeek = data[i].quantityWeek;
                var quantityMonth = data[i].quantityMonth;

                for (var j in quantityWeek) {
                    thead += '<th style="background:#2061C5; color: #fff;">' + j.split(',')[0] + ',' + '<br/><span style="white-space: nowrap;">' + j.split(',')[1] + '</span>' + '</th>';
                }

                for (var k in quantityMonth) {
                    thead += '<th style="background:#2061C5; color: #fff; white-space: nowrap;">' + k + '</th>';
                }
                thead += '<th style="background:#2061C5; color: #fff;">Total</th>';
                thead = '<tr>' + thead + '</tr>';
            }

            for (var i = 0; i < data.length; i++) {
                var firstData = data[i].data;
                var quantityWeek = data[i].quantityWeek;
                var quantityMonth = data[i].quantityMonth;

                tbody +=
                    '<td style="white-space: nowrap; text-align: center;">' + fixedNull(firstData.project) + '</td>' +
                    '<td style="white-space: nowrap; text-align: center;">' + fixedNull(firstData.product_code) + '</td>' +
                    '<td style="text-align: center;">' + fixedNull(firstData.foxconn_pn) + '</td>' +
                    '<td style="text-align: center;">' + fixedNull(firstData.plant) + '</td>' +
                    '<td style="text-align: center;">' + fixedNull(firstData.end_customer) + '</td>' +
                    '<td style="text-align: center;">' + fixedNull(firstData.ship_cutoff_date) + '</td>' +
                    '<td style="text-align: center;">' + fixedNull(firstData.hub_code) + '</td>';

                for (var j in quantityWeek) {
                    tbody += '<td style="text-align: center;">' + quantityWeek[j] + '</td>';
                }

                var total = 0;
                for (var k in quantityMonth) {
                    total += quantityMonth[k];
                    tbody += '<td style="background-color: #c0c0c0; text-align: center;">' + quantityMonth[k] + '</td>';
                }
                tbody += '<td style="background-color: #808080; text-align: center; font-weight: bold;">' + total + '</td>';

                tbody = '<tr>' + tbody + '</tr>';
            }
            $('#tbl-wka1-download thead').html(thead);
            $('#tbl-wka1-download tbody').html(tbody);
        }
        exportToExcel('tbl-wka1-download');
    }

    function fixedNull(text) {
        var res = '';
        if (text != null && text != undefined) {
            res = text;
        }
        return res;
    }

    $('.btn-search').on('click', function () {
        dataset.productCode = $('#search-order').val().trim();
        getDataTablePagination();
    });

    $('#search-order').on('keyup', function (e) {
        if (e.keyCode == 13) {
            dataset.productCode = $('#search-order').val().trim();
            getDataTablePagination();
        }
    });

    function activeModelOutputETAC() {
        $('#modal-output-etac').modal('show');
        loadListCustomerModal();
    }

    function loadListCustomerModal() {
        $('#customer-select-modal').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/createForm/listEndCustomer",
            data: {},
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].end_customer + '">' + data[i].end_customer + '</option>';
                }
                $('#customer-select-modal').html(html);
                if (data.length > 0) {
                    dataset.endCustomerModal = data[0].end_customer;
                }
                $('#customer-select-modal').val(dataset.endCustomerModal);
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                dataset.endCustomerModal = $('#customer-select-modal').val();
                loadListPlantModal();
            }
        });
    }

    $('#customer-select-modal').on('change', function () {
        dataset.endCustomerModal = $(this).val();
        loadListPlantModal();
    });

    function loadListPlantModal() {
        $('#plant-select-modal').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/listPlant",
            data: {
                endCustomer: dataset.endCustomerModal
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].plant + '">' + data[i].plant + '</option>';
                }
                $('#plant-select-modal').html(html);
                if (data.length > 0) {
                    dataset.plantModal = data[0].plant;
                }
                $('#plant-select-modal').val(dataset.plantModal);
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                loadListCustomerCodeModal();
            }
        });
    }

    $('#plant-select-modal').on('change', function () {
        dataset.plantModal = $(this).val();
        loadListCustomerCodeModal();
    });

    function loadListCustomerCodeModal() {
        $('#customerCode-select-modal').html('');
        $.ajax({
            type: "GET",
            url: "/pm-system/api/customer/listCustomerCode",
            data: {
                endCustomer: dataset.endCustomerModal
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                var data = res.data;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].customer_code + '">' + data[i].customer_code + '</option>';
                }
                $('#customerCode-select-modal').html(html);
                if (data.length > 0) {
                    dataset.customerCodeModal = data[0].customer_code;
                }
                $('#customerCode-select-modal').val(dataset.customerCodeModal);
            },
            error: function (errMsg) {
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                getListWeekModal();
            }
        });
    }

    $('#customerCode-select-modal').on('change', function () {
        dataset.customerCodeModal = $(this).val();
        getListWeekModal();
    });

    function getListWeekModal() {
        $('#week-select-modal').html('');
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/createForm/listWeekCreateFormWKA1',
            data: {
                // type: 'PO',
                endCustomer: dataset.endCustomerModal,
                plant: dataset.plantModal,
                customerCode: dataset.customerCodeModal
            },
            success: function (res) {
                var data = res.data;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].week + '">' + data[i].week + '</option>';
                }
                $('#week-select-modal').html(html);
            },
            error: function (err) {

            },
            complete: function () {
                dataset.weekModal = $('#week-select-modal').val();
                // getListWKA1();
            }
        });
    }

    $('#week-select-modal').on('change', function () {
        dataset.weekModal = $(this).val();
    });

    function downloadOutputETAC() {
        $('.loader').removeClass('hidden');
        $.ajax({
            type: 'POST',
            url: '/pm-system/api/compareETAC/uploadOutputETAC',
            data: {
                customerCode: dataset.customerCodeModal,
                plant: dataset.plantModal,
                endCustomer: dataset.endCustomerModal,
                idCard: dataset.empNo,
                week: dataset.weekModal
            },
            success: function (res) {
                if (res.code == 'SUCCESS') {
                    var data = res.data;
                    if (data.length > 0) {
                        var thead = '';
                        var tbody = '';

                        for (let i = 0; i < 1; i++) {
                            thead +=
                                '<th style="background:#2061C5; color: #fff; text-align: center; vertical-align: middle;">Project</th>' +
                                '<th style="background:#2061C5; color: #fff; text-align: center; vertical-align: middle;">Product code</th>' +
                                '<th style="background:#2061C5; color: #fff; text-align: center; vertical-align: middle;">Foxconn P/N</th>' +
                                '<th style="background:#2061C5; color: #fff; text-align: center; vertical-align: middle;">Plant</th>' +
                                '<th style="background:#2061C5; color: #fff; text-align: center; vertical-align: middle;">End customer</th>' +
                                '<th style="background:#2061C5; color: #fff; text-align: center; vertical-align: middle;">Ship cutoff date</th>' +
                                '<th style="background:#2061C5; color: #fff; text-align: center; vertical-align: middle;">Hub code</th>';
                            var quantityWeek = data[i].quantityWeek;
                            var quantityMonth = data[i].quantityMonth;

                            for (var j in quantityWeek) {
                                thead += '<td style="background:#2061C5; color: #fff; text-align: center; vertical-align: middle;">' + j.split(',')[0] + '<br/>' + j.split(',')[1] + '</td>';
                            }

                            for (var k in quantityMonth) {
                                thead += '<td style="background:#2061C5; color: #fff; text-align: center; vertical-align: middle;">' + k + '</td>';
                            }
                            thead += '<td style="background:#2061C5; color: #fff; text-align: center; vertical-align: middle;">Total</td>';
                            thead = '<tr>' + thead + '</tr>';
                        }

                        for (var i = 0; i < data.length; i++) {
                            var firstData = data[i].data;
                            var quantityWeek = data[i].quantityWeek;
                            var quantityMonth = data[i].quantityMonth;

                            tbody +=
                                '<td style="text-align: center;">' + firstData.project + '</td>' +
                                '<td style="text-align: center;">' + firstData.product_code + '</td>' +
                                '<td style="text-align: center;">' + firstData.foxconn_pn + '</td>' +
                                '<td style="text-align: center;">' + firstData.plant + '</td>' +
                                '<td style="text-align: center;">' + firstData.end_customer + '</td>' +
                                '<td style="text-align: center;">' + firstData.ship_cutoff_date + '</td>' +
                                '<td style="text-align: center;">' + firstData.hub_code + '</td>';

                            for (var j in quantityWeek) {
                                tbody += '<td style="text-align: center;">' + quantityWeek[j] + '</td>';
                            }

                            var total = 0;
                            for (var k in quantityMonth) {
                                total += quantityMonth[k];
                                tbody += '<td style="background-color: #c0c0c0;text-align: center;">' + quantityMonth[k] + '</td>';
                            }
                            tbody += '<td style="background-color: #808080;text-align: center; font-weight: bold;">' + total + '</td>';

                            tbody = '<tr>' + tbody + '</tr>';
                        }
                        $('#tbl-download thead').html(thead);
                        $('#tbl-download tbody').html(tbody);
                        exportToExcelModal('tbl-download');
                    }
                } else {
                    alert(res.message);
                }
            },
            error: function (err) {
                $('.loader').addClass('hidden');
                console.log(err);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                // window.location.reload();
            }
        });
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
            sa = window.document.execCommand("SaveAs", true, "ETAC_WKA1_Management_" + dataset.week + ".xls");
            return sa;

        } else {
            var link = window.document.createElement("a");
            link.setAttribute("href", "data:application/vnd.ms-excel;charset=utf-8,%EF%BB%BF" + encodeURIComponent(html));
            link.setAttribute("download", "ETAC_WKA1_Management_" + dataset.week + ".xls");
            link.click();
        }
    }

    var exportToExcelModal = function (table) {
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
            sa = window.document.execCommand("SaveAs", true, "ETAC_WKA1_Management_" + dataset.weekModal + ".xls");
            return sa;

        } else {
            var link = window.document.createElement("a");
            link.setAttribute("href", "data:application/vnd.ms-excel;charset=utf-8,%EF%BB%BF" + encodeURIComponent(html));
            link.setAttribute("download", "ETAC_WKA1_Management_" + dataset.weekModal + ".xls");
            link.click();
        }
    }

    function customScroll(table) {
        var slider = document.querySelector(table);
        var isDown = false;
        var startX;
        var scrollLeft;

        slider.addEventListener('mousedown', function (e) {
            isDown = true;
            startX = e.pageX - slider.offsetLeft;
            scrollLeft = slider.scrollLeft;
        });

        slider.addEventListener('mouseup', function (e) {
            isDown = false;
        });

        slider.addEventListener('mouseleave', function (e) {
            isDown = false;
        });

        slider.addEventListener('mousemove', function (e) {
            if (!isDown) {
                return;
            }
            e.preventDefault();
            var x = (e.pageX - slider.offsetLeft);
            var walk = (x - startX) * 5;
            slider.scrollLeft = scrollLeft - walk;
        });
    }
</script>