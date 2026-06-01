<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ taglib
prefix="c"
uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>이벤트</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/event.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="event-container">

    <h1 class="event-main-title">

        🎉 진행중인 이벤트

    </h1>



    <div class="event-grid">

        <c:forEach
            var="event"
            items="${eventList}">

            <div
                class="event-card"

                onclick="location.href='${pageContext.request.contextPath}/event_detail?e_no=${event.e_no}'">

                <div class="event-image">

                    ${event.e_icon}

                </div>

                <div class="event-content">

                    <div class="event-badge">

                        ${event.e_badge}

                    </div>

                    <h2>

                        ${event.e_title}

                    </h2>

                    <p>

                        ${event.e_desc}

                    </p>

                    <div class="event-reward">

                        🎁 ${event.e_reward}

                    </div>

                    <div class="event-date">

                        ${event.e_period}

                    </div>

                </div>

            </div>

        </c:forEach>

    </div>

</div>

</body>
</html>