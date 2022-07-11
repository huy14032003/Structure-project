<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<style>
    .scroll-table:hover {
        cursor: grab;
    }

    .scroll-table {
        max-height: 800px;
        overflow: auto;
        border: 1px solid lightgray;
    }

    @media only screen and (min-width: 1366px) and (max-width: 1919px) {
        .scroll-table {
            max-height: 500px;
        }
    }
</style>

<div class="loader hidden"></div>
<div class="row">
    <div class="col-12 my-2 component">
        <div class="d-flex-rce py-2">
            <button class="btn btn-sm btn-primary btnExport hidden" onclick="exportToExcel('tblProcess')"><i class="fa fa-download"></i> Download</button>
        </div>
        <div class="table-responsive scroll-table">
            <table class="table my-table" id="tblProcess">
                <thead></thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>

<script>
    var userInfo = JSON.parse(localStorage.getItem('userInfo'));
    var empNo = userInfo.idCard;
    
    var endCustomer = searchParams('endCustomer');
    var plant = searchParams('plant');
    var customerCode = searchParams('customerCode');
    var week = searchParams('week');
    var id = Number(searchParams('id'));

    $(document).ready(function () {
        customScroll('.scroll-table');
        showPrrocess();
    });

    function searchParams(name) {
        var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
        if (results == null) {
            return null;
        } else {
            return decodeURIComponent(results[1]) || 0;
        }
    }

    function showPrrocess() {
        $('.loader').removeClass('hidden');
        var tbody = '';
        var thead = '';
        $('.loader').removeClass('hidden');
        $('#tblProcess thead').html('');
        $('#tblProcess tbody').html('');
        $.ajax({
            type: "POST",
            url: "/pm-system/api/compareETAC/upload1",
            data: {
                idCard: empNo,
                endCustomer: endCustomer,
                plant: plant,
                customerCode: customerCode,
                week1: week,
                idETAC: id
            },
            success: function (res) {
                if (res.code == 'SUCCESS') {
                    $('#tblProcess thead').html('');
                    $('#tblProcess tbody').html('');
                    var data = res.result;
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
                                    thead += '<th style="background-color: #006699;color:#fff;">' + x.split(',')[0] + '</th>';
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

                } else {
                    alert(res.message);
                    return;
                }
            },
            error: function (errMsg) {
                $('.loader').addClass('hidden');
                console.log(errMsg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                $('#tblProcess thead').html(thead);
                $('#tblProcess tbody').html(tbody);
            }
        });
    }

    function frameTable(form, data, quantityWeek, quantityMonth, numberChange) {
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
                    // '<i class="fa fa-edit" data-form="' + data['編輯'] + '" data-foxconnpn="' + data['foxconn_pn'] + '" data-weekyear ="' + x + '" onclick="addNote(this)" style="position:absolute; top: 3%;right: 3%;"></i>' +
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

        html += '<td style="font-weight: 500; background:#808080; color: #000066; text-align: center; font-weight: 500;">' + totalMonth + '</td>';
        html = '<tr>' + html + '</tr>';

        return html;
    }

    function highLight(val, form) {
        if (form == 'WKB1-WKB0' || form == 'WKB1-WKA1') {
            if (Number(val) != 0) return 'background-color: #F33C3C;';
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
            link.setAttribute("download", "ETAC_Comparision_" + week + ".xls");
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
            var x = e.pageX - slider.offsetLeft;
            var walk = (x - startX) * 5;
            slider.scrollLeft = scrollLeft - walk;
        });
    }
</script>