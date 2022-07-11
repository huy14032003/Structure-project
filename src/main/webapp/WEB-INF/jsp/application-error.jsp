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
</head>

<body>
    <%@ include file="router.jsp" %>
</body>

</html>