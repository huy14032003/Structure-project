<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
      <%@ page trimDirectiveWhitespaces="true" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
          <meta charset="UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <title>${title}</title>
          <link rel="stylesheet" href="/sample-system/assets/plugins/bootstrap/bootstrap.min.css" />
          <link rel="stylesheet" href="/sample-system/assets/plugins/autocomplete/autocomplete.min.css" />
          <link rel="stylesheet" href="/sample-system/assets/plugins/tom-select/tom-select.min.css" />
          <link rel="stylesheet" href="/sample-system/assets/css/style.css" />
          <link rel="shortcut icon" href="/sample-system/assets/images/logoFII.png" type="image/x-icon" />

          <script src="/sample-system/assets/plugins/bootstrap/bootstrap.min.js"></script>
          <script src="/sample-system/assets/plugins/autocomplete/autocomplete.min.js"></script>
          <script src="/sample-system/assets/plugins/datasync/datasync.min.js"></script>
          <script src="/sample-system/assets/plugins/pagination/pagination.min.js"></script>
          <script src="/sample-system/assets/plugins/dompurify/purify.min.js"></script>
          <script src="/sample-system/assets/plugins/sweetalert/sweetalert.min.js"></script>
          <script src="/sample-system/assets/plugins/apexcharts/apexcharts.min.js"></script>
          <script src="/sample-system/assets/plugins/just-validate/just-validate.min.js"></script>
          <script src="/sample-system/assets/plugins/dayjs/dayjs.min.js"></script>
          <script src="/sample-system/assets/plugins/dayjs/extends/duration.min.js"></script>
          <script src="/sample-system/assets/plugins/dayjs/extends/isoweek.min.js"></script>
          <script src="/sample-system/assets/plugins/tom-select/tom-select.min.js"></script>
          <script src="/sample-system/assets/js/applib.js"></script>
          <script type="module" src="/sample-system/assets/js/main.js"></script>
        </head>
        <body>
          <%@ include file="common/lang.jsp" %>
            <link rel="stylesheet" href="/sample-system/assets/css/style.css">
            <%@ include file="common/header.jsp" %>
              <%@ include file="common/sidebar.jsp" %>
                <main class=" border-0  app_main--size " id="appMain">
                  <%@ include file="router.jsp" %>
                </main>
           
                <script type="module" src="/sample-system/assets/js/main.js"></script>
        </body>

        </html>