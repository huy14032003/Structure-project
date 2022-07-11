<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    table#tbl-etac {
        min-width: 500vw;
        cursor: grab;
    }

    .container-filter {
        width: 60%;
    }

    .container-search {
        width: 28%;
    }

    @media screen and (max-width: 1365px) {
        table#tbl-etac {
            min-width: 800vw !important;
        }

        .container-filter {
            width: 100%;
        }

        .container-search {
            width: 50%;
        }
    }

    @media screen and (min-width: 1366px) and (max-width: 1919px) {
        table#tbl-etac {
            min-width: 700vw !important;
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
                    <button class="btn btn-primary mx-2 text-nowrap my-button" onclick="downloadETAC()"><i class="fa fa-download"></i> Download</button>
                    <div class="input-group">
                        <input type="text" id="search-order" class="form-control my-input" placeholder="Product code" style="width: auto;">
                        <div class="input-group-append">
                            <button class="input-group-text btn btn-search my-button"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 py-3">
                <div class="table-responsive">
                    <table class="table my-table" id="tbl-etac">
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

<!-- Modal Note-->
<div class="modal fade" id="modal-output-etac">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Download Output ETAC</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group row" style="display:flex;align-items: center; justify-content: space-between">
                            <label class="control-label col-md-3">Area:</label>
                            <div class="col-sm-9">
                                <select name="" id="sl-area" class="form-control form-control-sm"></select>
                            </div>
                        </div>
                        <div class="form-group row" style="display:flex;align-items: center; justify-content: space-between">
                            <label class="control-label col-md-3">Factory:</label>
                            <div class="col-sm-9">
                                <select name="" id="sl-factory" class="form-control form-control-sm"></select>
                            </div>
                        </div>
                        <div class="form-group row" style="display:flex;align-items: center; justify-content: space-between">
                            <label class="control-label col-md-3">Customer:</label>
                            <div class="col-sm-9">
                                <select name="" id="sl-customer" class="form-control form-control-sm"></select>
                            </div>
                        </div>
                        <div class="form-group row" style="display:flex;align-items: center; justify-content: space-between">
                            <label class="control-label col-md-3">Week:</label>
                            <div class="col-sm-9">
                                <select name="" id="sl-week" class="form-control form-control-sm"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group row" style="display:flex;align-items: center; justify-content: space-between">
                            <label class="control-label col-md-3">PO:</label>
                            <div class="col-sm-9">
                                <span id="idPO" class="hidden"></span>
                                <input type="text" id="file-po" class="form-control form-control-sm input-file" onclick="activeModalListFile('PO')" placeholder="Select file...">
                            </div>
                        </div>
                        <div class="form-group row" style="display:flex;align-items: center; justify-content: space-between">
                            <label class="control-label col-md-3">Shipment:</label>
                            <div class="col-sm-9">
                                <span id="idShipment" class="hidden"></span>
                                <input type="text" id="file-shipment" class="form-control form-control-sm input-file" onclick="activeModalListFile('Shipment')" placeholder="Select file...">
                            </div>
                        </div>
                        <div class="form-group row" style="display:flex;align-items: center; justify-content: space-between">
                            <label class="control-label col-md-3">FO:</label>
                            <div class="col-sm-9">
                                <span id="idFO" class="hidden"></span>
                                <input type="text" id="file-fo" class="form-control form-control-sm input-file" onclick="activeModalListFile('FO')" placeholder="Select file...">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm btn-primary" onclick="downloadOutputETAC()"><i class="fa fa-download"></i> Download</button>
                <button class="btn btn-sm btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal List File-->
<div class="modal fade" id="modal-list-file">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">List File <span class="file-name"></span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 table-responsive">
                        <table class="table" id="tbl-list-file">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Code</th>
                                    <th>File name</th>
                                    <th>Creator</th>
                                    <th>Created at</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cancel</button>
            </div>
        </div>
    </div>
</div>

<div style="width: 100%;display: none;">
    <table class="table" id="tbl-etac-download">
        <thead></thead>
        <tbody></tbody>
    </table>
</div>

<script>
    var dataset = {
        timeSpan: '',
        productCode: '',
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
        customScroll('.table-responsive');
    });

    function init() {
        loadListCustomer();
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
                // loadListShiffCutOffDate();
                getListWeek();
            }
        });
    }

    $('#customerCode-select').on('change', function () {
        dataset.customerCode = $(this).val();
        // loadListShiffCutOffDate();
        getListWeek();
    });

    // function loadListShiffCutOffDate() {
    //     $('#shipCutoffDate-select').html('');
    //     $.ajax({
    //         type: "GET",
    //         url: "/pm-system/api/sign/listShipCutOffDate",
    //         data: {
    //             plant: dataset.plant
    //         },
    //         contentType: "application/json; charset=utf-8",
    //         success: function (res) {
    //             var data = res.data;
    //             var html = '';
    //             for (i in data) {
    //                 html += '<option value="' + data[i].ship_cutoff_date + '">' + data[i].ship_cutoff_date + '</option>';
    //             }
    //             $('#shipCutoffDate-select').html(html);
    //             if (data.length > 0) {
    //                 dataset.shipCutoffDate = data[0].ship_cutoff_date;
    //             }
    //             $('#shipCutoffDate-select').val(dataset.shipCutoffDate);
    //         },
    //         error: function (errMsg) {
    //             console.log(errMsg);
    //         },
    //         complete: function () {
    //             $('.loader').addClass('hidden');
    //             getListWeek();
    //         }
    //     });
    // }

    // $('#shipCutoffDate-select').on('change', function () {
    //     dataset.shipCutoffDate = $(this).val();
    //     getListWeek();
    // });

    function getListWeek() {
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/createForm/listWeekCreateForm',
            data: {
                type: 'Input ETAC',
                endCustomer: dataset.endCustomer,
                plant: dataset.plant,
                customerCode: dataset.customerCode
            },
            success: function (res) {
                var data = res.data;
                var html = '';
                for (var i in data) {
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
            url: '/pm-system/api/sign/getListETACFinal',
            data: {
                endCustomer: dataset.endCustomer,
                plant: dataset.plant,
                customerCode: dataset.customerCode,
                week: dataset.week,
                productCode: dataset.productCode,
                // shipCutOffDate: dataset.shipCutoffDate
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
                getETACData();
            }
        });
    }

    function getETACData() {
        var html = '';
        var myData = pagination(state.data, state.page, state.rows);
        var data = myData.data;
        $('#tbl-etac thead').html('');
        $('#tbl-etac tbody').html('');
        if (data.length > 0) {
            $('.nodata').addClass('hidden');
            $('#tbl-etac tbody').show();
            var thead = '';
            var regEx = /^[0-9]{4}(\/|-)(0[1-9]|1[0-2])(\/|-)(0[1-9]|[1-2][0-9]|3[0-1])$/;

            thead +=
                '<th style="background: #2061C5; color: #fff;">Project</th>' +
                '<th style="background: #2061C5; color: #fff;">Product code</th>' +
                '<th style="background: #2061C5; color: #fff;">Foxconn PN</th>' +
                '<th style="background: #2061C5; color: #fff;">Plant</th>' +
                '<th style="background: #2061C5; color: #fff;">End customer</th>' +
                '<th style="background: #2061C5; color: #fff;">Ship cutoff date</th>' +
                '<th style="background: #2061C5; color: #fff;">Hub code</th>';

            for (var i = 0; i < data.length; i++) {
                var data1 = data[i].data;
                var trow =
                    '<td style="white-space: nowrap;">' + data1.project + '</td>' +
                    '<td style="white-space: nowrap;">' + data1.product_code + '</td>' +
                    '<td style="white-space: nowrap;">' + data1.foxconn_pn + '</td>' +
                    '<td>' + data1.plant + '</td>' +
                    '<td>' + data1.end_customer + '</td>' +
                    '<td>' + data1.ship_cutoff_date + '</td>' +
                    '<td>' + data1.hub_code + '</td>';

                var quantityWeek = data[i].quantityWeek;
                for (var j in quantityWeek) {
                    if (regEx.test(j)) {
                        i == 0 ? thead += '<th style="background: #2061C5; color: #fff;">' + j + '</th>' : '';
                        trow += '<td>' + quantityWeek[j] + '</td>';
                    }
                }
                html += '<tr>' + trow + '<td>' + fixedNull(data1.file_name) + '</td>' + '</tr>';
            }
            thead = '<tr>' + thead + '<th style="min-width: 150px; background: #2061C5; color: #fff;">File name</th>' + '</tr>';

            $('#tbl-etac thead').html(thead);
            $('#tbl-etac tbody').html(html);

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
            // $('#tbl-etac tbody').html(html);
            $('#tbl-etac tbody').hide();
            $('.nodata').removeClass('hidden');
        }
    }

    // Ham nay dung cho chuc nang phan trang (khi su dung o trang khac thi chi can thay doi noi dung ben trong ham)
    function getResultPagination() {
        getETACData();
    }

    function downloadETAC() {
        var data = dataset.tableData;
        var html = '';
        if (data.length > 0) {
            var thead = '';
            var regEx = /^[0-9]{4}(\/|-)(0[1-9]|1[0-2])(\/|-)(0[1-9]|[1-2][0-9]|3[0-1])$/;

            thead +=
                '<th style="background: #2061C5; color: #fff; text-align: center;">Project</th>' +
                '<th style="background: #2061C5; color: #fff; text-align: center;">Product code</th>' +
                '<th style="background: #2061C5; color: #fff; text-align: center;">Foxconn PN</th>' +
                '<th style="background: #2061C5; color: #fff; text-align: center;">Plant</th>' +
                '<th style="background: #2061C5; color: #fff; text-align: center;">End customer</th>' +
                '<th style="background: #2061C5; color: #fff; text-align: center;">Ship cutoff date</th>' +
                '<th style="background: #2061C5; color: #fff; text-align: center;">Hub code</th>';

            for (var i = 0; i < data.length; i++) {
                var data1 = data[i].data;
                var trow =
                    '<td style="white-space: nowrap; vertical-align: middle; text-align: center;">' + data1.project + '</td>' +
                    '<td style="white-space: nowrap; vertical-align: middle; text-align: center;">' + data1.product_code + '</td>' +
                    '<td style="white-space: nowrap; vertical-align: middle; text-align: center;">' + data1.foxconn_pn + '</td>' +
                    '<td style="text-align: centerl; vertical-align: middle; text-align: center;">' + data1.plant + '</td>' +
                    '<td style="text-align: centerl; vertical-align: middle; text-align: center;">' + data1.end_customer + '</td>' +
                    '<td style="text-align: centerl; vertical-align: middle; text-align: center;">' + data1.ship_cutoff_date + '</td>' +
                    '<td style="text-align: centerl; vertical-align: middle; text-align: center;">' + data1.hub_code + '</td>';

                var quantityWeek = data[i].quantityWeek;
                for (var j in quantityWeek) {
                    if (regEx.test(j)) {
                        i == 0 ? thead += '<th style="background: #2061C5; color: #fff; text-align: center;">' + j + '</th>' : '';
                        trow += '<td style="text-align: center; vertical-align: center;">' + quantityWeek[j] + '</td>';
                    }
                }
                html += '<tr>' + trow + '<td style="text-align: center; vertical-align: center;">' + fixedNull(data1.file_name) + '</td>' + '</tr>';
            }
            thead = '<tr>' + thead + '<th style="min-width: 150px; background: #2061C5; color: #fff; text-algin: center; vertical-align: middle;">File name</th>' + '</tr>';

            $('#tbl-etac-download thead').html(thead);
            $('#tbl-etac-download tbody').html(html);
            exportToExcel('tbl-etac-download');
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
            dataset.productCode = $('#search-order').val().trim();
            getDataTablePagination();
        }
    });

    function checkFalsen(val) {
        if (val == null || val == undefined || val == '') return false;
        return true;
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
            sa = window.document.execCommand("SaveAs", true, "ETAC_Management_" + dataset.week + ".xls");
            return sa;

        } else {
            var link = window.document.createElement("a");
            link.setAttribute("href", "data:application/vnd.ms-excel;charset=utf-8,%EF%BB%BF" + encodeURIComponent(html));
            link.setAttribute("download", "ETAC_Management_" + dataset.week + ".xls");
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