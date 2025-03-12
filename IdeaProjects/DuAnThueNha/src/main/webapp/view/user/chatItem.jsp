<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${c.idReceiver eq myProfile.idUser}">
        <div class="d-flex flex-row justify-content-start">
            <img class="rounded-circle" src="${pageContext.request.contextPath}/img/${c.image}" alt="avatar" style="width: 45px; height: 45px;">
            <div>
                <p class="bg-body-tertiary small p-2 ms-3 mb-1 rounded-3" style="background-color: #e0e0e0">
                        ${c.text}
                </p>
                <p class="small ms-3 mb-3 rounded-3 text-muted float-end">12:00 PM | Aug 13</p>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="d-flex flex-row justify-content-end">
            <div>
                <p class="small p-2 me-3 mb-1 text-white rounded-3 bg-primary">
                        ${c.text}
                </p>
                <p class="small me-3 mb-3 rounded-3 text-muted">12:00 PM | Aug 13</p>
            </div>
            <img class="rounded-circle" src="${pageContext.request.contextPath}/img/${myProfile.image}" alt="avatar" style="width: 45px; height: 45px;">
        </div>
    </c:otherwise>
</c:choose>



