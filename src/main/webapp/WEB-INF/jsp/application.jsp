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
    <link rel="icon" type="image/ico" href="/sample-system/assets/img/logoFII.png">

    <link href="/sample-system/assets/css/loader.css" rel="stylesheet" type="text/css" />
    <script src="/sample-system/assets/js/loader.js"></script>
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <!-- <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700" rel="stylesheet"> -->
    <link href="/sample-system/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/sample-system/assets/css/plugins.css" rel="stylesheet" type="text/css" />
    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL PLUGINS/CUSTOM STYLES -->
    <link href="/sample-system/assets/plugins/apex/apexcharts.css" rel="stylesheet" type="text/css">
    <link href="/sample-system/assets/css/dashboard/dash_1.css" rel="stylesheet" type="text/css" />
    <!-- END PAGE LEVEL PLUGINS/CUSTOM STYLES -->
</head>

<body>
    <!-- BEGIN LOADER -->
    <div id="load_screen"> <div class="loader"> <div class="loader-content">
        <div class="spinner-grow align-self-center"></div>
    </div></div></div>
    <!--  END LOADER -->
    <!--  BEGIN MAIN CONTAINER  -->
    <%@ include file="common/navbar.jsp" %>
    <div class="main-container" id="container">

        <div class="overlay"></div>
        <div class="search-overlay"></div>
        <%@ include file="common/sidebar.jsp" %>
        <!--  BEGIN CONTENT AREA  -->
        <div id="content" class="main-content">
            <%@ include file="router.jsp" %>
            <%@ include file="common/footer.jsp" %>
        </div>
        <!--  END CONTENT AREA  -->
    </div>
    <!-- END MAIN CONTAINER -->
    <!-- BEGIN GLOBAL MANDATORY SCRIPTS -->
    <script src="/sample-system/assets/js/libs/jquery-3.1.1.min.js"></script>
    <script src="/sample-system/assets/bootstrap/js/popper.min.js"></script>
    <script src="/sample-system/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="/sample-system/assets/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="/sample-system/assets/js/app.js"></script>
    <script>
        $(document).ready(function() {
            App.init();
        });
    </script>
    <script src="/sample-system/assets/js/custom.js"></script>
    <!-- END GLOBAL MANDATORY SCRIPTS -->

    <!-- BEGIN PAGE LEVEL PLUGINS/CUSTOM SCRIPTS -->
    <script src="/sample-system/assets/plugins/apex/apexcharts.min.js"></script>
    <script src="/sample-system/assets/js/dashboard/dash_1.js"></script>
    <!-- BEGIN PAGE LEVEL PLUGINS/CUSTOM SCRIPTS -->
</body>

</html>