<%@ page contentType="text/html;charset=UTF-8" %>
<table class="table table-bordered">
    <thead class="table-light">
    </thead>
    <tbody>
    <c:forEach items="${verifications}" var="verification">
        <tr data-id="${verification.idDocument}">
            <td>
                <img src="img/${verification.documentImage}" alt="Document Image" width="80" height="80">
            </td>
            <td>${verification.documentType}</td>
            <td>${verification.documentNumber}</td>
            <td class="status-column">${verification.status}</td>
            <td class="reason-column">
                <c:choose>
                    <c:when test="${not empty verification.rejectionReason}">
                        ${verification.rejectionReason}
                    </c:when>
                    <c:otherwise>Không có</c:otherwise>
                </c:choose>
            </td>
            <td>${verification.createdAt}</td>
            <td>
                <form action="adminServlet" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="profileFeedback">
                    <input type="hidden" name="idDocument" value="${verification.idDocument}">
                    <select name="status">
                        <option value="approved">Approved</option>
                        <option value="rejected">Rejected</option>
                    </select>
                    <input type="text" name="rejectionReason" placeholder="Nhập lý do..." />
                    <button type="submit" class="btn btn-primary">Gửi</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
