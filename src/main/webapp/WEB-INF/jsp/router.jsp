<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
    <c:when test="${path == 'home'}">
        <%@ include file="component/sample/home.jsp" %>
    </c:when>
    <c:when test="${path == 'form-info-equipment'}">
        <%@ include file="component/sample/form-info-equipment.jsp" %>
    </c:when>
    <c:when test="${path == 'home2'}">
        <%@ include file="component/sample/home2.jsp" %>
    </c:when>



    <c:when test="${path == 'error-401'}">
        <%@ include file="component/error-page/error-401.jsp" %>
    </c:when>

    <c:when test="${path == 'error-403'}">
        <%@ include file="component/error-page/error-403.jsp" %>
    </c:when>

    <c:when test="${path == 'error-404'}">
        <%@ include file="component/error-page/error-404.jsp" %>
    </c:when>

    <c:when test="${path == 'error-500'}">
        <%@ include file="component/error-page/error-500.jsp" %>
    </c:when>


    <c:otherwise>
        <%@ include file="component/error-page/error-404.jsp" %>
    </c:otherwise>

</c:choose>