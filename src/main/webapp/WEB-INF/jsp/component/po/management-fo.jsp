<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    table#tbl-fo {
        min-width: 400vw !important;
        cursor: grab;
    }

    .container-filter {
        width: 60%;
    }

    .container-search {
        width: 28%;
    }

    @media screen and (max-width: 1365px) {
        table#tbl-fo {
            min-width: 600vw !important;
        }

        .container-filter {
            width: 100%;
        }

        .container-search {
            width: 50%;
        }
    }

    @media screen and (min-width: 1366px) and (max-width: 1919px) {
        table#tbl-fo {
            min-width: 500vw !important;
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
                    <button class="btn btn-primary mx-2 text-nowrap my-button" onclick="downloadFO()"><i class="fa fa-download"></i> Download</button>
                    <div class="input-group">
                        <input type="text" id="search-order" class="form-control my-input" placeholder="Product code" style="width: auto !important;">
                        <div class="input-group-append">
                            <button class="input-group-text btn btn-search my-button"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 py-3">
                <div class="table-responsive">
                    <table class="table my-table" id="tbl-fo">
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
    <table class="table my-table" id="tbl-fo-download">
        <thead></thead>
        <tbody></tbody>
    </table>
</div>

<script>
    var dataset = {
        productCode: '',
        timeSpan: '',
        colspan: 0,
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
                type: 'FO',
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
            url: '/pm-system/api/sign/getListFOFinal',
            data: {
                endCustomer: dataset.endCustomer,
                plant: dataset.plant,
                customerCode: dataset.customerCode,
                week: dataset.week,
                productCode: dataset.productCode,
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
                getFOData();
            }
        });
    }

    function getFOData() {
        var html = '';
        var myData = pagination(state.data, state.page, state.rows);
        var data = myData.data;
        if (!isArrayEmpty(data) && !isFalsy(data)) {
            $('.nodata').addClass('hidden');
            $('#tbl-fo tbody').show();
            var thead = '';
            var regEx = /^[0-9]{4}(\/|-)(0[1-9]|1[0-2])(\/|-)(0[1-9]|[1-2][0-9]|3[0-1])$/;

            var title_header = Object.keys(data[0]);
            dataset.colspan = title_header.length;
            thead += '<th style="background-color: #2061C5; color: #fff">Product code</th>';

            for (var i = 3; i < title_header.length; i++) {
                thead += '<th style="white-space: nowrap;background-color:#2061C5; color: #fff">' + title_header[i] + '</th>';
            }
            thead = '<tr>' + thead + '<th style="background-color:#2061C5; color: #fff">File name</th>' + '</tr>';

            for (var i = 0; i < data.length; i++) {
                var trow = '<td>' + fixedNull(data[i].product_code) + '</td>';
                for (var j in data[i]) {
                    if (regEx.test(j)) trow += '<td>' + data[i][j] + '</td>';
                }
                html += '<tr>' + trow + '<td>' + fixedNull(data[i].file_name) + '</td>' + '</tr>';
            }

            $('#tbl-fo thead').html(thead);
            $('#tbl-fo tbody').html(html);

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
            // html = '<tr><td>No data to display</td></tr>';
            // $('#tbl-fo tbody').html(html);
            $('#tbl-fo tbody').hide();
            $('.nodata').removeClass('hidden');
        }
    }

    // Ham nay dung cho chuc nang phan trang (khi su dung o trang khac thi chi can thay doi noi dung ben trong ham)
    function getResultPagination() {
        getFOData();
    }

    function downloadFO() {
        var data = dataset.tableData;
        var html = '';
        var thead = '';
        if (data.length > 0) {
            var thead = '';
            var regEx = /^[0-9]{4}(\/|-)(0[1-9]|1[0-2])(\/|-)(0[1-9]|[1-2][0-9]|3[0-1])$/;

            var title_header = Object.keys(data[0]);
            dataset.colspan = title_header.length;
            thead +=
                '<th style="background-color:#006699; color: #fff; text-align: center;">Product code</th>';

            for (var i = 3; i < title_header.length; i++) {
                thead += '<th style="white-space: nowrap;background-color:#006699; color: #fff; text-align: center;">' + title_header[i] + '</th>';
            }
            thead = '<tr>' + thead + '<th style="background-color:#006699; color: #fff; text-align: center;">File name</th>' + '</tr>';

            for (var i = 0; i < data.length; i++) {
                var trow = '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].product_code) + '</td>';
                for (var j in data[i]) {
                    if (regEx.test(j)) trow += '<td style="text-align: center; vertical-align: middle;">' + data[i][j] + '</td>';
                }
                html += '<tr>' + trow + '<td style="text-align: center; vertical-align: middle;">' + fixedNull(data[i].file_name) + '</td>' + '</tr>';
            }

            $('#tbl-fo-download thead').html(thead);
            $('#tbl-fo-download tbody').html(html);
            exportToExcel('tbl-fo-download');
        }
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
            dataset.productCode = $(this).val().trim();
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
            sa = window.document.execCommand("SaveAs", true, "FO_Management_" + dataset.week + ".xls");
            return sa;

        } else {
            var link = window.document.createElement("a");
            link.setAttribute("href", "data:application/vnd.ms-excel;charset=utf-8,%EF%BB%BF" + encodeURIComponent(html));
            link.setAttribute("download", "FO_Management_" + dataset.week + ".xls");
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