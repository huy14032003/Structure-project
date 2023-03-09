<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        .hidden {
            display: none !important;
        }

        .total {
            display: flex;
            align-items: center;
            justify-content: space-between;
            text-align: center;
        }

        .total-item {
            width: 18%;
        }

        .total-item .inner {
            color: #000;
        }

        .small-box {
            margin-bottom: 5px;
        }

        .smallbox-vehicles {
            background-color: #40A9FF;
        }

        .smallbox-running {
            background-color: #4DA13E;
        }

        .smallbox-waiting {
            background-color: #B85BB4;
        }

        .smallbox-station {
            background-color: #F58F00;
        }

        .smallbox-idle {
            background-color: #BDAFB0;
        }

        .inner p {
            font-weight: bold;
        }

        #tableStatus,
        #tableStatus th,
        #tableStatus td {
            border: 1px solid #CCC;
            border-collapse: collapse;
        }

        #tableStatus tr:nth-child(odd) {
            background-color: #E6ECF2;
        }

        #tableStatus tr:nth-child(even) {
            background-color: #F2F2F2;
        }

        #tableStatus th,
        #tableStatus td {
            vertical-align: middle;
            text-align: center;
        }

        #tableStatus th {
            background-color: #4F81BD;
            color: #fff;
            padding: 0.25rem 0.25rem;
            border-top: none;
            border-left: none;
            border-bottom: none;
        }

        #tableStatus th:last-child {
            border-right: none;
        }

        #tableStatus td {
            padding: 0.25rem 0.25rem;
            overflow: hidden;
            border-left: none;
            border-bottom: none;
        }

        #tableStatus tbody tr td:last-child {
            width: 10%;
            height: 50px;
            padding: 0;
            border-right: none;

        }

        #tableStatus tbody tr td.crLocation {
            width: 17%;
        }

        #tableStatus td a {
            text-decoration: underline;
        }

        .title-list-trucks {
            position: absolute;
            top: 7px;
            left: 0;
            color: #5988C1;
            color: #000;
            font-weight: bold;
        }

        .status-point {
            display: inline-block;
            height: 11px;
            width: 11px;
            margin-right: 5px;
            border-radius: 50%;
        }

        .icon-map {
            margin-right: 5px;
        }

        .dataTables_filter input {
            border: 1px solid #5988C1;
            border-radius: 5px;
            padding: 3px 23px 3px 5px;
            height: 35px;
            background-color: #fff;
            background-image: url('/sample-system/assets/images/icon-search.png');
            background-repeat: no-repeat;
            background-position: 97% 50%;
        }

        .dataTables_filter input:focus-visible {
            outline: none;
        }

        .page-item.active .page-link {
            background-color: #4F81BD;
            border: #4F81BD;
        }

        /* Tao hieu ung loader */
        .loader-custom{
            display: block;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            position: fixed;
            top:0;
            left:0;
            right: 0;
            z-index: 1200;
            text-align: center;
        }
        .icon-loader{
            font-size: 100px;
            color: #ddd;
            position: absolute;
            top:45%;
            left:50%;
            z-index: inherit;
        }
    </style>

    <div class="loader-custom hidden">
        <span class="icon-loader"><i class="fa fa-spinner fa-spin"></i></span>
    </div>

    <div class="row">
        <div class="col-sm-12">
            HOME PAGE
        </div>
    </div>

    <script>
        var dataset = {};
        function init() {
            loadData();
        }

        function loadData() {
            $('.loader-custom').removeClass('hidden');
            $('#tableStatus>tbody').html('');
            $.ajax({
                type: "GET",
                url: "/sample-system/api/",
                data: {
                    idTeam: dataset.id,
                    idFactory: dataset.id
                },
                contentType: "application/json; charset=utf-8",
                success: function (result) {
                    if (result.code == 'SUCCESS') {
                        var data = result.result;
                        var html = '';
                    } else {
                        html += '<tr><td colspan="9">-- NO DATA --</td></tr>';
                    }
                    $('#tableStatus > tbody').html(html);
                },
                error: function (errMsg) {
                    $('.loader-custom').addClass('hidden');
                    console.log(errMsg);
                },
                complete: function () {
                    $('.loader-custom').addClass('hidden');
                }
            });
        }

        function checkNull(val) {
            if (val == null || val == undefined || val == 'undefined' || val == '') {
                return 'N/A';
            }
            return val;
        }

        $(document).ready(function () {

        })
    </script>