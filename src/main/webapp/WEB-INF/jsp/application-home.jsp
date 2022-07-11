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
    <link rel="icon" type="image/ico" href="/pm-system/assets/images/logoFavicon.ico">

    <!-- Global stylesheets -->
    <!-- <link rel="stylesheet" type="text/css" href="/assets/css/bootstrap.css"> -->
    <link rel="stylesheet" type="text/css" href="/pm-system/assets/js/bootstrap/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/pm-system/assets/js/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/pm-system/assets/css/core.css">
    <link rel="stylesheet" type="text/css" href="/pm-system/assets/css/components.css">
    <link rel="stylesheet" type="text/css" href="/pm-system/assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="/pm-system/assets/css/icons/icomoon/styles.css">
    <!-- <link rel="stylesheet" type="text/css" href="/pm-system/assets/css/icons/fontawesome/styles.min.css"> -->
    <link rel="stylesheet" type="text/css" href="/pm-system/assets/css/icons/fontawesome/all.min.css">
    <!-- /global stylesheets -->

    <!-- Core JS files -->
    <script type="text/javascript" src="/pm-system/assets/js/bootstrap/jquery.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/core/app.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/plugins/loaders/pace.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/plugins/loaders/blockui.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/plugins/uploaders/fileinput.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/plugins/ui/headroom/headroom.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/plugins/ui/headroom/headroom_jquery.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/plugins/ui/nicescroll.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/plugins/ui/ripple.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/plugins/forms/selects/bootstrap_select.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/plugins/forms/tags/tagsinput.min.js"></script>
    <script type="text/javascript" src="/pm-system/assets/js/core/layout_navbar_hideable_sidebar.js"></script>

    <script type="text/javascript" src="/pm-system/assets/tab/jquery-ui.min.js"></script>
    <!-- /core JS files -->

    <script type="text/javascript" src="/pm-system/assets/js/plugins/notify/bootstrap-notify.min.js"></script>
</head>
<style>
    .navbar-brand img {
        margin-top: -6px;
        height: 35px
    }
</style>

<script>
    var loginID = '${employeeId}';
    var loginName = '${employeeName}';
    if (loginID == '' || loginID == null || loginID == undefined) {
        $('.navbar-right .nav.navbar-nav').addClass('hidden');
    }
    else {
        $('.navbar-right .nav.navbar-nav').removeClass('hidden');
        $('#profileName').html(loginName);
    }
</script>
<body>
    <!-- Page container -->
    <div class="page-container">

        <!-- Page content -->
        <div class="page-content">
            <!-- Main content -->
            <div class="content-wrapper">
                <div class="content no-padding">
                    <div class="tocontentfii">
                        <%@ include file="router.jsp" %>
                    </div>
                </div>
                <div class="hiddenImage content-menu-tab">
                </div>
                <!-- /content area -->

            </div>
            <!-- /main content -->

        </div>
        <!-- /page content -->

    </div>
    <!-- /page container -->
    <div class="footer">
        Copyright <i class="fas fa-copyright"></i> FII-Software 2020 (Support - Tel: 26143 / Mail: cpe-vn-fii-sw@mail.foxconn.com)
     </div>
    <!-- <script type="text/javascript" src="/assets/tab/tab-scrolltab.js"></script> -->
</body>
<style>
    .tocontentfii {
        /* display: flex; */
        height: 100%;
    }

    .hiddenImage {
        display: none;
    }

    .scroll-smail {
        background: #272727;
        height: 100%;
        width: 100%;
        background: #F5F5F5;
        overflow-y: scroll;
    }

    ::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
        /* background-color: #212529; */
    }

    ::-webkit-scrollbar {
        width: 0px;
        height: 0px;
        /* background-color: #212529; */
    }

    ::-webkit-scrollbar-thumb {
        /* background-color: #212529; */
    }
</style>

</html>