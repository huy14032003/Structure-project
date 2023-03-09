<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
    <c:when test="${path == 'home'}">
        <%@ include file="component/sample/home.jsp" %>
    </c:when>

    <c:when test="${path == 'page-403'}">
        <%@ include file="component/error-page/page-403.jsp" %>
    </c:when>

</c:choose>