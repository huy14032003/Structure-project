<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
    <c:when test="${path == 'home'}">
        <%@ include file="component/home.jsp" %>
    </c:when>
    <c:when test="${path == 'po-customer-management'}">
        <%@ include file="component/po/customer-management.jsp" %>
    </c:when>
    <c:when test="${path == 'po-create-form'}">
        <%@ include file="component/po/create-form.jsp" %>
    </c:when>
    <c:when test="${path == 'po-compare-po'}">
        <%@ include file="component/po/compare-po.jsp" %>
    </c:when>
    <c:when test="${path == 'my-application'}">
        <%@ include file="component/po/my-application.jsp" %>
    </c:when>
    <c:when test="${path == 'po-sign'}">
        <%@ include file="component/po/sign.jsp" %>
    </c:when>
    <c:when test="${path == 'management-po'}">
        <%@ include file="component/po/management-po.jsp" %>
    </c:when>
    <c:when test="${path == 'management-fo'}">
        <%@ include file="component/po/management-fo.jsp" %>
    </c:when>
    <c:when test="${path == 'management-shipment'}">
        <%@ include file="component/po/management-shipment.jsp" %>
    </c:when>
    <c:when test="${path == 'management-etac'}">
        <%@ include file="component/po/management-etac.jsp" %>
    </c:when>
    <c:when test="${path == 'management-file'}">
        <%@ include file="component/po/management-file.jsp" %>
    </c:when>
    <c:when test="${path == 'foxconn-pn-management'}">
        <%@ include file="component/po/foxconn-pn-management.jsp" %>
    </c:when>
    <c:when test="${path == 'process'}">
        <%@ include file="component/po/process-po.jsp" %>
    </c:when>
    <c:when test="${path == 'management-wka1'}">
        <%@ include file="component/po/management-wka1.jsp" %>
    </c:when>
    <c:when test="${path == 'create-sign-process'}">
        <%@ include file="component/po/create-sign-process.jsp" %>
    </c:when>



    <c:when test="${path == 'page-403'}">
        <%@ include file="component/error-page/page-403.jsp" %>
    </c:when>
    <c:when test="${path == 'page-404'}">
        <%@ include file="component/error-page/page-404.jsp" %>
    </c:when>
</c:choose>