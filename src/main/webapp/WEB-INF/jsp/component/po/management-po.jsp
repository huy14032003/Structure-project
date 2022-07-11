<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    table#tbl-po {
        min-width: 300vw !important;
        cursor: grab;
    }

    .container-filter {
        width: 60%;
    }

    .container-search {
        width: 28%;
    }

    @media screen and (max-width: 1365px) {
        table#tbl-po {
            min-width: 500vw !important;
        }

        .container-filter {
            width: 100%;
        }

        .container-search {
            width: 50%;
        }
    }

    @media screen and (min-width: 1366px) and (max-width: 1919px) {
        table#tbl-po {
            min-width: 400vw !important;
        }

        .container-filter {
            width: 60%;
        }

        .container-search {
            width: 35%;
        }
    }
</style>
<div class="loader hidden"></div>
<div class="row">
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
                        <option value="">Select date</option>
                    </select>
                </div>
                <div class="container-search px-2 py-2 d-flex-rcb">
                    <button class="btn btn-primary mx-2 text-nowrap my-button" onclick="downloadPO()"><i class="fa fa-download"></i> Download</button>
                    <div class="input-group">
                        <input type="text" id="search-order" class="form-control my-input" placeholder="PO/PN" style="width: auto !important;">
                        <div class="input-group-append">
                            <button class="input-group-text btn btn-search my-button"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 py-3">
                <div class="table-responsive">
                    <table id="tbl-po" class="table my-table">
                        <thead>
                            <tr>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">#</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">PO</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Line</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">PN</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Quantity</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">ERD</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Unit price</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Currency</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Amount</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">PO date</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">PN desc</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Priority</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Priority desc</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">PO type</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">PO type desc</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Payment terms</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Payment terms desc</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Shipment terms</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Shipment terms desc</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Inco terms</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Inco terms desc</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Bill to party name</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Bill to party code</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Bill to party address</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">End user name</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">End user code</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">End user address</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Manufacturer name</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Shipto name</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Shipto code</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Shipto address</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Lasteditdt</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">File name</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Flag</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Site</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">Item</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">ISA 13</th>
                                <th style="background-color:#2061C5; color: #fff; text-align: center;">File name</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
                <div class="pagination d-flex-rce">
                    <ul></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<div style="width: 100%;display: none;">
    <table class="table" id="tbl-po-download">
        <thead>
            <tr>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">#</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">PO</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Line</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">PN</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Quantity</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">ERD</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Unit price</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Currency</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Amount</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">PO date</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">PN desc</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Priority</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Priority desc</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">PO type</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">PO type desc</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Payment terms</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Payment terms desc</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Shipment terms</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Shipment terms desc</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Inco terms</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Inco terms desc</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Bill to party name</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Bill to party code</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Bill to party address</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">End user name</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">End user code</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">End user address</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Manufacturer name</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Shipto name</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Shipto code</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Shipto address</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Lasteditdt</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">File name</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Flag</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Site</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">Item</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">ISA 13</th>
                <th style="background-color:#2061C5; color: #fff; text-align: center;">File name</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script>
    var dataset = {
        pn: '',
        timeSpan: '',
        po: '',
        tableData: null
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
            url: '/pm-system/api/createForm/listWeekCreateForm',
            data: {
                type: 'PO',
                endCustomer: dataset.endCustomer,
                plant: dataset.plant,
                customerCode: dataset.customerCode
            },
            success: function (res) {
                var data = res.data;
                var html = '';
                for (i in data) {
                    html += '<option value="' + data[i].week + '">' + data[i].week + '</option>';
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
            type: 'GET',
            url: '/pm-system/api/sign/getListPOFinal',
            data: {
                endCustomer: dataset.endCustomer,
                plant: dataset.plant,
                customerCode: dataset.customerCode,
                week: dataset.week,
                productCode: dataset.pn,
                po: dataset.po
            },
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
                getPOData();
            }
        });
    }

    function getPOData() {
        var html = '';
        var myData = pagination(state.data, state.page, state.rows);
        var data = myData.data;
        if (data.length > 0) {
            for (i in data) {
                html +=
                    '<tr>' +
                    '<td>' + ((state.page - 1) * state.rows + (i * 1 + 1)) + '</td>' +
                    '<td>' + formatEmpty(data[i].po) + '</td>' +
                    '<td>' + formatEmpty(data[i].line) + '</td>' +
                    '<td class="text-nowrap">' + formatEmpty(data[i].pn) + '</td>' +
                    '<td>' + formatEmpty(data[i].quantity) + '</td>' +
                    '<td class="text-nowrap">' + formatEmpty(data[i].erd) + '</td>' +
                    '<td>' + formatEmpty(data[i].unit_price) + '</td>' +
                    '<td>' + formatEmpty(data[i].currency) + '</td>' +
                    '<td>' + formatEmpty(data[i].amount) + '</td>' +
                    '<td class="text-nowrap">' + formatEmpty(data[i].po_date) + '</td>' +
                    '<td>' + formatEmpty(data[i].pn_desc) + '</td>' +
                    '<td>' + formatEmpty(data[i].priority) + '</td>' +
                    '<td>' + formatEmpty(data[i].priority_desc) + '</td>' +
                    '<td>' + formatEmpty(data[i].po_type) + '</td>' +
                    '<td>' + formatEmpty(data[i].po_type_desc) + '</td>' +
                    '<td>' + formatEmpty(data[i].payment_terms) + '</td>' +
                    '<td>' + formatEmpty(data[i].payment_terms_desc) + '</td>' +
                    '<td>' + formatEmpty(data[i].shipment_terms) + '</td>' +
                    '<td>' + formatEmpty(data[i].shipment_terms_desc) + '</td>' +
                    '<td>' + formatEmpty(data[i].inco_terms) + '</td>' +
                    '<td>' + formatEmpty(data[i].inco_terms_desc) + '</td>' +
                    '<td>' + formatEmpty(data[i].bill_to_party_name) + '</td>' +
                    '<td>' + formatEmpty(data[i].bill_to_party_code) + '</td>' +
                    '<td>' + formatEmpty(data[i].bill_to_party_address) + '</td>' +
                    '<td>' + formatEmpty(data[i].end_user_name) + '</td>' +
                    '<td>' + formatEmpty(data[i].end_user_code) + '</td>' +
                    '<td>' + formatEmpty(data[i].end_user_address) + '</td>' +
                    '<td>' + formatEmpty(data[i].manufacturer_name) + '</td>' +
                    '<td>' + formatEmpty(data[i].shipto_name) + '</td>' +
                    '<td>' + formatEmpty(data[i].shipto_code) + '</td>' +
                    '<td>' + formatEmpty(data[i].shipto_address) + '</td>' +
                    '<td class="text-nowrap">' + formatEmpty(data[i].lastedidt) + '</td>' +
                    '<td>' + formatEmpty(data[i].filename) + '</td>' +
                    '<td>' + formatEmpty(data[i].flag) + '</td>' +
                    '<td>' + formatEmpty(data[i].site) + '</td>' +
                    '<td>' + formatEmpty(data[i].item) + '</td>' +
                    '<td>' + formatEmpty(data[i].isa13) + '</td>' +
                    '<td>' + formatEmpty(data[i].file_name) + '</td>' +
                    '</tr>';
            }
        } else {
            html += '<tr><td colspan="38">No data to display</td></tr>';
        }
        $('#tbl-po tbody').html(html);
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
    }

    // Ham nay dung cho chuc nang phan trang (khi su dung o trang khac thi chi can thay doi noi dung ben trong ham)
    function getResultPagination() {
        getPOData();
    }

    function downloadPO() {
        var data = dataset.tableData;
        var html = '';
        if (data.length > 0) {
            for (i in data) {
                html +=
                    '<tr>' +
                    '<td style="vertical-align: middle; text-align: center;">' + (i * 1 + 1) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].po) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].line) + '</td>' +
                    '<td style="white-space: nowrap; vertical-align: middle; text-align: center;">' + fixedNull(data[i].pn) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].quantity) + '</td>' +
                    '<td style="white-space: nowrap; vertical-align: middle; text-align: center;">' + fixedNull(data[i].erd) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].unit_price) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].currency) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].amount) + '</td>' +
                    '<td style="white-space: nowrap; vertical-align: middle; text-align: center;">' + fixedNull(data[i].po_date) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].pn_desc) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].priority) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].priority_desc) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].po_type) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].po_type_desc) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].payment_terms) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].payment_terms_desc) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].shipment_terms) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].shipment_terms_desc) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].inco_terms) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].inco_terms_desc) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].bill_to_party_name) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].bill_to_party_code) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].bill_to_party_address) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].end_user_name) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].end_user_code) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].end_user_address) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].manufacturer_name) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].shipto_name) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].shipto_code) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].shipto_address) + '</td>' +
                    '<td style="white-space: nowrap; "vertical-align: middle; text-align: center;">' + fixedNull(data[i].lastedidt) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].filename) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].flag) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].site) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].item) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].isa13) + '</td>' +
                    '<td style="vertical-align: middle; text-align: center;">' + fixedNull(data[i].file_name) + '</td>' +
                    '</tr>';
            }
        } else {
            html += '<tr><td colspan="38">No data to display</td></tr>';
        }
        $('#tbl-po-download tbody').html(html);
        exportToExcel('tbl-po-download');
    }

    function fixedNull(text) {
        var res = '';
        if (text != null && text != undefined) {
            res = text;
        }
        return res;
    }

    $('.btn-search').on('click', function () {
        dataset.pn = dataset.po = $('#search-order').val().trim();
        getDataTablePagination();
    });

    $('#search-order').on('keyup', function (e) {
        if (e.keyCode == 13) {
            dataset.pn = dataset.po = $('#search-order').val().trim();
            getDataTablePagination();
        }
    });

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
            sa = window.document.execCommand("SaveAs", true, "PO_Management_" + dataset.week + ".xls");
            return sa;

        } else {
            var link = window.document.createElement("a");
            link.setAttribute("href", "data:application/vnd.ms-excel;charset=utf-8,%EF%BB%BF" + encodeURIComponent(html));
            link.setAttribute("download", "PO_Management_" + dataset.week + ".xls");
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