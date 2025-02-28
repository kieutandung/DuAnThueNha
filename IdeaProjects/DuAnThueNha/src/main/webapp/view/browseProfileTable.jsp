<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table class="table table-bordered">
    <thead>
    <tr>
        <th>Hình ảnh</th>
        <th>Loại tài liệu</th>
        <th>Số tài liệu</th>
        <th>Trạng thái</th>
        <th>Lý do từ chối</th>
        <th>Ngày tạo</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${not empty verifications}">
        <c:forEach items="${verifications}" var="verification">
            <tr>
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
                    <button class="approve-btn" data-id="${verification.idDocument}" onclick="updateStatus(${verification.idDocument}, 'approved')">Đồng ý</button>
                    <button class="reject-btn" data-id="${verification.idDocument}" onclick="showRejectReason(${verification.idDocument})">Từ chối</button>
                </td>

            </tr>
        </c:forEach>
    </c:if>
    <c:if test="${empty verifications}">
        <tr>
            <td colspan="7" class="text-center">❌ Không có hồ sơ nào!</td>
        </tr>
    </c:if>
    </tbody>
</table>

