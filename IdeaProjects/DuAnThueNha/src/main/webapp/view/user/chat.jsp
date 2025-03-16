<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Nhắn tin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="/css/chat.css">
</head>
<body>
<header>
    <jsp:include page="../header.jsp"/>
</header>
<section style="background-color: #3b71ca">
    <div class="container py-5">
        <div class="row">
            <div class="col-md-12">

                <div class="card" id="chat3" style="border-radius: 15px;">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-6 col-lg-5 col-xl-4 mb-4 mb-md-0">

                                <div class="p-3">

                                    <%--                                    <div class="input-group rounded mb-3">--%>
                                    <%--                                        <input type="search" class="form-control rounded" placeholder="Search"--%>
                                    <%--                                               aria-label="Search"--%>
                                    <%--                                               aria-describedby="search-addon"/>--%>
                                    <%--                                        <span class="input-group-text border-0" id="search-addon">--%>
                                    <%--                      <i class="fas fa-search"></i>--%>
                                    <%--                    </span>--%>
                                    <%--                                    </div>--%>

                                    <div id="allChatContainer" data-mdb-perfect-scrollbar-init style="position: relative; height: 400px">
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
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-lg-7 col-xl-8">

                                <div id="chat-container" class="pt-3 pe-3"
                                     style="position: relative; height: 400px; overflow-y: auto; scrollbar-width: none">
                                    <c:choose>
                                        <c:when test="${not empty chat}">
                                            <c:forEach var="c" items="${chat}">
                                                <c:choose>
                                                    <c:when test="${c.idReceiver eq myProfile.idUser}">

                                                        <div class="d-flex flex-row justify-content-start">
                                                            <c:if test="${not empty c.text}">
                                                                <img class="rounded-circle" src="img/${c.image}"
                                                                     alt="avatar"
                                                                     style="width: 40px; height: 100%;">
                                                                <div>
                                                                    <p class="bg-body-tertiary small p-2 ms-3 mb-1 rounded-3"
                                                                       style="background-color: #e0e0e0">${c.text}</p>
                                                                        <%-- <p class="small ms-3 mb-3 rounded-3 text-muted float-end">12:00 PM | Aug 13</p> --%>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                        </c:when>
                                                    <c:otherwise>
                                                        <div class="d-flex flex-row justify-content-end">
                                                            <c:if test="${not empty c.text}">
                                                                <div>
                                                                    <p class="small p-2 me-3 mb-1 text-white rounded-3 bg-primary">${c.text}</p>
                                                                        <%-- <p class="small me-3 mb-3 rounded-3 text-muted">12:00 PM | Aug 13</p> --%>
                                                                </div>
                                                                <img class="rounded-circle" src="img/${myProfile.image}"
                                                                     alt="avatar"
                                                                     style="width: 40px; height: 100%;">
                                                            </c:if>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-center" style="margin-top: 30px">Vui lòng chọn người liên
                                                hệ</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <c:if test="${not empty chat}">
                                    <form id="chat-form" action="chatServlet?action=sendMess&idHost=${idHost}"
                                          method="post">
                                        <div class="text-muted d-flex justify-content-start align-items-center pe-3 pt-3 mt-2">
                                            <img class="rounded-circle" src="img/${myProfile.image}"
                                                 alt="avatar 3" style="width: 40px; height: 100%;">
                                            <input required style="background-color: #eeeeee" type="text"
                                                   class="form-control form-control-lg"
                                                   id="exampleFormControlInput2"
                                                   placeholder="Nhập tin nhắn" name="sendMess">
                                            <a class="ms-1 text-muted" href="#!"><i class="fas fa-paperclip"></i></a>
                                            <a class="ms-3 text-muted" href="#!"><i class="fas fa-smile"></i></a>
                                            <button class="ms-3" type="submit"
                                                    style="border: none; margin: 0; background: none;">
                                                <i class="fa-solid fa-paper-plane" style="color: #007ce0;"></i>
                                            </button>

                                        </div>
                                    </form>
                                </c:if>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>

    </div>
</section>
<footer class="mt-5">
    <jsp:include page="../footer.jsp"/>
</footer>
<script>
    window.onload = function () {
        var chatContainer = document.getElementById('chat-container');
        if (chatContainer) {
            chatContainer.scrollTop = chatContainer.scrollHeight;
        }
    };
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        $('#chat-form').on('submit', function (e) {
            e.preventDefault(); // Ngăn form gửi truyền thống

            var formData = $(this).serialize();
            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: formData,
                success: function (response) {
                    console.log("Send message success");
                    // Append HTML fragment của tin nhắn mới (chatItem.jsp)
                    $('#chat-container').append(response);
                    // Cuộn container xuống cuối
                    var container = document.getElementById('chat-container');
                    container.scrollTop = container.scrollHeight;
                    // Xóa trường nhập tin nhắn
                    $('#exampleFormControlInput2').val('');

                    // Gọi AJAX để tải lại allChat, thêm tham số cache buster
                    $.ajax({
                        url: "chatServlet",
                        type: "GET",
                        data: {
                            action: "reloadAllChat",
                            _: new Date().getTime()  // tham số cache buster
                        },
                        success: function (allChatHtml) {
                            console.log("Reload allChat success");
                            $('#allChatContainer').html(allChatHtml);
                        },
                        error: function (xhr, status, error) {
                            console.error("Lỗi khi tải lại allChat: ", error);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Lỗi khi gửi tin nhắn: ", error);
                }
            });
        });
    });

</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/perfect-scrollbar/1.5.5/perfect-scrollbar.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.js"></script>
</body>
</html>