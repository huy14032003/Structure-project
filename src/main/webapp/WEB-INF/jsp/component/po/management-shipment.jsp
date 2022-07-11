<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    table#tbl-shipment {
        cursor: grab;
    }

    .container-filter {
        width: 60%;
    }

    .container-search {
        width: 28%;
    }

    @media screen and (max-width: 1365px) {
        table#tbl-shipment {
            min-width: 200vw !important;
        }

        .container-filter {
            width: 100%;
        }

        .container-search {
            width: 50%;
        }
    }

    @media screen and (min-width: 1366px) and (max-width: 1919px) {
        table#tbl-shipment {
            min-width: 200vw !important;
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
                    <select name="sl-custom" class="form-control my-select" id="customer-select"></select>
                    <label class="label-inline mx-2">Plant:</label>
                    <select name="sl-custom" class="form-control my-select" id="plant-select"></select>
                    <label class="label-inline mx-2">Customer code:</label>
                    <select name="sl-custom" class="form-control my-select" id="customerCode-select"></select>
                    <label class="label-inline mx-2">ETAC week:</label>
                    <select name="sl-custom" class="form-control my-select" id="week-select"></select>
                </div>
                <div class="container-search px-2 py-2 d-flex-rcb">
                    <button class="btn btn-primary mx-2 text-nowrap my-button" onclick="downloadShipment()"><i class="fa fa-download"></i> Download</button>
                    <div class="input-group">
                        <input type="text" id="search-order" class="form-control my-input" placeholder="Descr"  style="width: auto !important;">
                        <div class="input-group-append">
                            <button class="input-group-text btn btn-search my-button"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 py-3">
                <div class="table-responsive">
                    <table class="table my-table" id="tbl-shipment">
                        <thead>
                            <tr>
                                <th style="background: #2061C5; color: #fff;">#</th>
                                <th style="background: #2061C5; color: #fff;">Plant</th>
                                <th style="background: #2061C5; color: #fff;">Material</th>
                                <th style="background: #2061C5; color: #fff;">Quantity</th>
                                <th style="background: #2061C5; color: #fff;">Amount LC</th>
                                <th style="background: #2061C5; color: #fff;">Batch</th>
                                <th style="background: #2061C5; color: #fff;">Sloc</th>
                                <th style="background: #2061C5; color: #fff;">MvT</th>
                                <th style="background: #2061C5; color: #fff;">Mat doc</th>
                                <th style="background: #2061C5; color: #fff;">Pstg date</th>
                                <th style="background: #2061C5; color: #fff;">Time</th>
                                <th style="background: #2061C5; color: #fff;">PO</th>
                                <th style="background: #2061C5; color: #fff;">Vendor</th>
                                <th style="background: #2061C5; color: #fff;">Order</th>
                                <th style="background: #2061C5; color: #fff;">Cost ctr</th>
                                <th style="background: #2061C5; color: #fff;">Descr</th>
                                <th style="background: #2061C5; color: #fff;">Text</th>
                                <th style="background: #2061C5; color: #fff;">User</th>
                                <th style="background: #2061C5; color: #fff;">Item</th>
                                <th style="background: #2061C5; color: #fff;">Customer</th>
                                <th style="background: #2061C5; color: #fff;">Crr</th>
                                <th style="background: #2061C5; color: #fff;">Reference</th>
                                <th style="background: #2061C5; color: #fff;">File name</th>
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
    <table class="table" id="tbl-shipment-download">
        <thead>
            <tr>
                <th style="background: #2061C5; color: #fff; text-align: center;">#</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Plant</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Material</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Quantity</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Amount LC</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Batch</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Sloc</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">MvT</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Mat doc</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Pstg date</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Time</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">PO</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Vendor</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Order</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Cost ctr</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Descr</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Text</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">User</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Item</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Customer</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Crr</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">Reference</th>
                <th style="background: #2061C5; color: #fff; text-align: center;">File name</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script>
    var dataset = {
        timeSpan: '',
        descr: '',
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
                type: 'Shipment',
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
            url: '/pm-system/api/sign/getListShipmentFinal',
            data: {
                endCustomer: dataset.endCustomer,
                plant: dataset.plant,
                customerCode: dataset.customerCode,
                week: dataset.week,
                descr: dataset.descr
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
                getShipmentData();
            }
        });
    }

    function getShipmentData() {
        var html = '';
        var myData = pagination(state.data, state.page, state.rows);
        var data = myData.data;
        if (data.length > 0) {
            for (i in data) {
                html +=
                    '<tr>' +
                    '<td>' + ((state.page - 1) * state.rows + (i * 1 + 1)) + '</td>' +
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
                    '<td>' + fixedNull(data[i].file_name) + '</td>' +
                    '</tr>';
            }
        } else {
            html += '<tr><td colspan="23">No data to display</td></tr>';
        }
        $('#tbl-shipment tbody').html(html);
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
        getShipmentData();
    }

    function downloadShipment() {
        var data = dataset.tableData;
        var html = '';
        if (data.length > 0) {
            for (i in data) {
                console.log(i)
                console.log(Number((state.page - 1) * state.rows))
                html +=
                    '<tr>' +
                    '<td style="text-align: center; vertical-align: middle;">' + ((state.page - 1) * state.rows + (i * 1 + 1)) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].plant) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].material) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].quantity) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].amount_lc) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].batch) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].sloc) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].mvt) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].mat_doc) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].pstg_date) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].time) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].po) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].vendor) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].order) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].cost_ctr) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].descr) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].text) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].users) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].item) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].customer) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].curr) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].reference) + '</td>' +
                    '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].file_name) + '</td>' +
                    '</tr>';
            }
        } else {
            html += '<tr><td colspan="22">No data to display</td></tr>';
        }
        $('#tbl-shipment-download tbody').html(html);
        exportToExcel('tbl-shipment-download');
    }

    function fixedNull(text) {
        var res = '';
        if (text != null && text != undefined) {
            res = text;
        }
        return res;
    }

    $('.btn-search').on('click', function () {
        dataset.descr = $('#search-order').val().trim();
        getDataTablePagination();
    });

    $('#search-order').on('keyup', function (e) {
        if (e.keyCode == 13) {
            dataset.descr = $('#search-order').val().trim();
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
            sa = window.document.execCommand("SaveAs", true, "Shipment_Management_" + dataset.week + ".xls");
            return sa;

        } else {
            var link = window.document.createElement("a");
            link.setAttribute("href", "data:application/vnd.ms-excel;charset=utf-8,%EF%BB%BF" + encodeURIComponent(html));
            link.setAttribute("download", "Shipment_Management_" + dataset.week + ".xls");
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