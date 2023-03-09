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
    <title>LMS - ${title}</title>
    <link rel="icon" type="image/ico" href="/sample-system/assets/images/logoFII.png">

    <!-- Theme style -->
    <link rel="stylesheet" href="/sample-system/assets/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" type="text/css" href="/sample-system/assets/plugins/fontawesome-free/css/all.min.css">
    <!-- Alertify JS -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/alertify/alertify.min.css">
    <!-- Customize -->
    <link rel="stylesheet" href="/sample-system/assets/css/custom/style.css">


    <!-- jQuery -->
    <script src="/sample-system/assets/plugins/jquery/jquery.min.js"></script>\
    <!-- Bootstrap 4 -->
    <script src="/sample-system/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="/sample-system/assets/dist/js/adminlte.js"></script>
    <!-- OPTIONAL SCRIPTS -->
    <script src="/sample-system/assets/dist/js/demo.js"></script>
    <!-- Alertify JS -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/alertify/alertify.min.css">
    <script src="/sample-system/assets/plugins/alertify/alertify.min.js"></script>
    <!-- Customize -->
    <!-- <script src="/sample-system/assets/js/custom/logout.js"></script> -->
    <script src="/sample-system/assets/js/custom/core-customize.js"></script>
    <style>
        .content {
            height: inherit;
            overflow-x: hidden;
        }

        .content-wrapper {
            background-color: #E6ECF2;
            background-image: url('/sample-system/assets/images/background-home.png');
            background-size: cover;
            background-position: center center;
            background-repeat: no-repeat;
        }

        .layout-navbar-fixed .wrapper .content-wrapper{
            margin-top: calc(2rem + 1px);
        }
    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed sidebar-collapse">
    <div class="wrapper">
        <%@ include file="common/navbar.jsp" %>
        <%@ include file="common/sidebar.jsp" %>
        <div class="content-wrapper" style="background-color: #E6ECF2;">
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
        $(document).ready(function(){
            let userInfo = localStorage.getItem('userInfo');
            isFalsy(userInfo) ? $('.logout').addClass('hidden') : $('.logout').removeClass('hidden');
        });

        function logout() {
            var userInfo = JSON.parse(window.localStorage.getItem('userInfo'));
            if (!isFalsy(userInfo)) {
                var nameVn = userInfo.nameVn;
                var nameCN = userInfo.nameCn;
                var cardNo = userInfo.empNo;

                alertify.confirm('<spring:message code="alert" />', '<spring:message code="signOut" /><b> ' + nameVn + ' - ' + cardNo + '</b>?', function () {
                    window.localStorage.removeItem('userInfo');
                    window.localStorage.removeItem('firstAccess');
                    window.location.href = "/sample-system/logout";
                }, function () {

                }).set('labels', {
                    ok: '<spring:message code="ok" />',
                    cancel: '<spring:message code="cancel" />'
                });
            }
        }
    </script>
</body>

</html>