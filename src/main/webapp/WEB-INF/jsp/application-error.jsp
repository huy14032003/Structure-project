<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page trimDirectiveWhitespaces="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LMS - ${title}</title>
    <!-- Theme style -->
    <link rel="stylesheet" href="/sample-system/assets/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" type="text/css" href="/sample-system/assets/plugins/fontawesome-free/css/all.min.css">
    <!-- Customize -->
    <link rel="stylesheet" href="/sample-system/assets/css/custom/style.css">


    <!-- jQuery -->
    <script src="/sample-system/assets/plugins/jquery/jquery.min.js"></script>

    <!-- Bootstrap 4 -->
    <script src="/sample-system/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- AdminLTE App -->
    <script src="/sample-system/assets/dist/js/adminlte.js"></script>

    <!-- OPTIONAL SCRIPTS -->
    <script src="/sample-system/assets/dist/js/demo.js"></script>

</head>

<body>
    <%@ include file="router.jsp" %>
</body>

</html>