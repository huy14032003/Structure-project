<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page trimDirectiveWhitespaces="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${title}</title>
    <link rel="icon" type="image/ico" href="/sample-system/assets/images/logoFII.png">

    <!-- Theme style -->
    <link rel="stylesheet" href="/sample-system/assets/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" type="text/css" href="/sample-system/assets/plugins/fontawesome-free/css/all.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/daterangepicker/daterangepicker.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <!-- Boostrap select -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/bootstrap-select.1.13.14/dist/css/bootstrap-select.min.css">
    <!-- Alertify JS -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/alertify/alertify.min.css">
    <!-- jQuery timepicker -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/jquery-timepicker/jquery.timepicker.min.css">
    <!-- Customize -->
    <link rel="stylesheet" href="/sample-system/assets/css/custom/style.css">


    <!-- jQuery -->
    <script src="/sample-system/assets/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="/sample-system/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="/sample-system/assets/dist/js/adminlte.js"></script>
    <!-- Optinal scripts -->
    <script src="/sample-system/assets/dist/js/demo.js"></script>
    <!-- Map -->
    <!-- <link rel="stylesheet" type="text/css" href="/sample-system/assets/osm/mapbox-gl.css">
    <script src="/sample-system/assets/osm/mapbox-gl.js"></script>
    <link rel="stylesheet" type="text/css" href="/sample-system/assets/osm/mapbox.css">
    <script src="/sample-system/assets/osm/mapbox.js"></script>
    <script src="/sample-system/assets/osm/leaflet-hash.js"></script> -->
    <!-- Highchart -->
    <script type="text/javascript" src="/sample-system/assets/plugins/highchart_922/highcharts.js"></script>
    <script type="text/javascript" src="/sample-system/assets/plugins/highchart_922/modules/drilldown.js"></script>
    <script type="text/javascript" src="/sample-system/assets/plugins/highchart_922/grouped-categories.js"></script>
    <!-- Daterangepicker -->
    <script src="/sample-system/assets/plugins/moment/moment.min.js"></script>
    <script src="/sample-system/assets/plugins/daterangepicker/daterangepicker.js"></script>
    <!-- DataTables -->
    <script src="/sample-system/assets/plugins/datatables/jquery.dataTables.js"></script>
    <script src="/sample-system/assets/plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
    <!-- Boostrap select -->
    <script src="/sample-system/assets/plugins/bootstrap-select.1.13.14/dist/js/bootstrap-select.min.js"></script>
    <!-- Alertify JS -->
    <script src="/sample-system/assets/plugins/alertify/alertify.min.js"></script>
    <!-- jQuery timepicker -->
    <script src="/sample-system/assets/plugins/jquery-timepicker/jquery.timepicker.min.js"></script>
    <!-- Customize -->
    <script src="/sample-system/assets/js/custom/core-customize.js"></script>
</head>

<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed sidebar-collapse">
    <div class="wrapper">
        <%@ include file="common/loader.jsp" %>
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
            var userInfo = JSON.parse(window.localStorage.getItem('userInfo'));
            if (!isFalsy(userInfo)) {
                var name = formatUserName(userInfo);
                alertify.confirm('<spring:message code="alert" />', '<spring:message code="signOut" /><b> ' + name + '</b>?', function () {
                    window.localStorage.removeItem('userInfo');
                    window.localStorage.removeItem('firstAccess');
                    window.location.href = "/sample-system/logout";
                }, function () {
                    // Cancel
                }).set('labels', {
                    ok: '<spring:message code="ok" />',
                    cancel: '<spring:message code="cancel" />'
                });
            }
        }
    </script>
</body>

</html>