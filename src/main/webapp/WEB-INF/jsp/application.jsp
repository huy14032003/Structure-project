<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <title>${title}</title>
    <link rel="icon" type="image/ico" href="/pm-system/assets/images/favicon.ico">

    <!-- Theme style -->
    <link rel="stylesheet" href="/pm-system/assets/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" type="text/css" href="/pm-system/assets/plugins/fontawesome-free/css/all.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="/pm-system/assets/plugins/daterangepicker/daterangepicker.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="/pm-system/assets/plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <!-- Boostrap select -->
    <link rel="stylesheet" href="/pm-system/assets/plugins/bootstrap-select.1.13.14/dist/css/bootstrap-select.min.css">
    <!-- Alertify JS -->
    <link rel="stylesheet" href="/pm-system/assets/plugins/alertify/alertify.min.css">
    <!-- Customize -->
    <link rel="stylesheet" href="/pm-system/assets/css/custom/style.css">


    <!-- jQuery -->
    <script src="/pm-system/assets/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="/pm-system/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- AdminLTE App -->
    <script src="/pm-system/assets/dist/js/adminlte.js"></script>

    <!-- OPTIONAL SCRIPTS -->
    <script src="/pm-system/assets/dist/js/demo.js"></script>

    <script type="text/javascript" src="/pm-system/assets/plugins/highchart_922/highcharts.js"></script>
    <script type="text/javascript" src="/pm-system/assets/plugins/highchart_922/modules/drilldown.js"></script>
    <script type="text/javascript" src="/pm-system/assets/plugins/highchart_922/grouped-categories.js"></script>

    <!-- daterangepicker -->
    <script src="/pm-system/assets/plugins/moment/moment.min.js"></script>
    <script src="/pm-system/assets/plugins/daterangepicker/daterangepicker.js"></script>

    <!-- DataTables -->
    <script src="/pm-system/assets/plugins/datatables/jquery.dataTables.js"></script>
    <script src="/pm-system/assets/plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>

    <!-- Boostrap select -->
    <link rel="stylesheet" href="/pm-system/assets/plugins/bootstrap-select.1.13.14/dist/css/bootstrap-select.min.css">
    <script src="/pm-system/assets/plugins/bootstrap-select.1.13.14/dist/js/bootstrap-select.min.js"></script>

    <!-- Alertify JS -->
    <link rel="stylesheet" href="/pm-system/assets/plugins/alertify/alertify.min.css">
    <script src="/pm-system/assets/plugins/alertify/alertify.min.js"></script>

    <!-- Customize -->
    <!-- <script src="/pm-system/assets/js/custom/logout.js"></script> -->
    <script src="/pm-system/assets/js/custom/core-customize.js"></script>
    <style>
        .content {
            height: inherit;
            width: 100%;
            background-color: #E6ECF2;
        }
    </style>

    <!-- <script type="text/javascript" src="/pm-system/assets/js/custom/pagination.js"></script> -->
</head>

<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed sidebar-collapse">
    <div class="wrapper">
        <%@ include file="common/navbar.jsp" %>
        <%@ include file="common/sidebar.jsp" %>
        <div class="content-wrapper" style="background-color: #E6ECF2; overflow: hidden;">
            <section class="content">
                <div class="container-fluid">
                    <%@ include file="router.jsp" %>
                </div>
            </section>
            <aside class="control-sidebar control-sidebar-light">
            </aside>
            <%@ include file="common/footer.jsp" %>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            showHistoryMenu();
        });

        // Active menu
        function showHistoryMenu() {
            var path = '${path}';
            var current_li = $('li[data-path="' + path + '"]');
            current_li.children().css('background-color', '#ffffff1a');

            var parent_li = current_li.parent();

            if (parent_li.hasClass('nav-treeview')) {

                var grandparent = parent_li.parent();
                grandparent.addClass('menu-open');
                grandparent.trigger('click');
                grandparent.children()[0].style.backgroundColor = '#ffffff1a';

                var root = grandparent.parent();
                if (root.hasClass('nav-treeview')) {
                    var ex_root = root.parent();
                    ex_root.addClass('menu-open');
                    ex_root.trigger('click');
                }
            } else {
                current_li.addClass('menu-open');
            }
        }

        function logout() {
            var userInfo = localStorage.getItem('userInfo');
            if (!isFalsy(userInfo)) {
                var name = formatUserName(userInfo);
                alertify.confirm('Alert', 'Do you wan to logout?', function () {
                    window.localStorage.removeItem('userInfo');
                    window.location.href = "/pm-system/logout";
                }, function () {
                    // Cancel
                }).set('labels', {
                    ok: 'OK',
                    cancel: 'Cancel'
                });
            }
        }
    </script>
</body>

</html>