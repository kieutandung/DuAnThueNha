<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="c" items="${allChat}">
    <c:if test="${!(myProfile.role eq 'host' and empty c.text)}">
        <ul class="list-unstyled mb-0">
            <li class="p-2 border-bottom"
                style="${(param.action eq 'showChat' and param.idHost eq c.idUser) ? 'background-color: #e0e0e0;' : ''}">
                <a href="chatServlet?action=showChat&idHost=${c.idUser}"
                   class="d-flex justify-content-between">
                    <div class="d-flex flex-row">
                        <div>
                            <img
                                    src="img/${c.image}"
                                    alt="avatar"
                                    class="rounded-circle d-flex align-self-center me-3"
                                    width="60">
                                <%--                                                                <span class="badge bg-success badge-dot"></span>--%>
                        </div>
                        <div class="pt-1">
                            <p class="fw-bold mb-0">${c.fullName}</p>
                            <c:choose>
                                <c:when test="${myProfile.idUser eq c.idSender}">
                                    <p class="small text-muted">
                                        Bạn: <span class="truncated">${c.text}</span>
                                    </p>
                                </c:when>
                                <c:otherwise>
                                    <p class="small text-muted">${c.fullName}: <span class="truncated">${c.text}</span>
                                    </p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                        <%--                                                        <div class="pt-1">--%>
                        <%--                                                            <p class="small text-muted mb-1">Just now</p>--%>
                        <%--                                                            <span class="badge bg-danger rounded-pill float-end">3</span>--%>
                        <%--                                                        </div>--%>
                </a>
            </li>
        </ul>
    </c:if>
</c:forEach>
