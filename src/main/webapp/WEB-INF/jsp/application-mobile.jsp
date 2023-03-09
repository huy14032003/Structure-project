<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page trimDirectiveWhitespaces="true"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="mobile-web-app-capable" content="yes">
    <title>LMS - ${title}</title>
    <link rel="icon" type="image/ico" href="/sample-system/assets/images/logoFII.png">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" type="text/css" href="/sample-system/assets/plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/sample-system/assets/dist/css/adminlte.min.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/bootstrap-select.1.13.14/dist/css/bootstrap-select.min.css">
    <!-- Alertify JS -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/alertify/alertify.min.css">
    <!-- Customize -->
    <link rel="stylesheet" href="/sample-system/assets/css/custom/style.css">

    <!-- jQuery -->
    <script src="/sample-system/assets/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="/sample-system/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap select -->
    <script src="/sample-system/assets/plugins/bootstrap-select.1.13.14/dist/js/bootstrap-select.min.js"></script>
    <!-- Scanner QRCode -->
    <script src="/sample-system/assets/plugins/qrcode/html5-qrcode.min.js"></script>
    <!-- Alertify JS -->
    <script src="/sample-system/assets/plugins/alertify/alertify.min.js"></script>
    <script src="/sample-system/assets/js/custom/core-customize.js"></script>
</head>

<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed sidebar-collapse">
    <%@ include file="common/loader.jsp" %>
    <div class="wrapper">
        <div class="content-wrapper" style="background-color: #E6ECF2;margin: 0 !important;">
            <section class="content" style="background-color: #E6ECF2; min-height: 88vh;padding: 0; padding: 0 !important;">
                <div class="container-fluid">
                    <%@ include file="router.jsp" %>
                </div>
            </section>
            <aside class="control-sidebar control-sidebar-light">
            </aside>
        </div>
        <script>
            $(document).ready(function () {
                document.cookie = ("lang=vi-VN;path=/sample-system/");
                window.localStorage.setItem('lang', 'vi-VN');
            });
        </script>
    </div>
</body>

</html>