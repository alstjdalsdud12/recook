<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>이벤트 상세</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/event_detail.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="event-detail-container">

    <div class="detail-top">

        ${event.e_icon}

    </div>

    <div class="detail-content">

        <div class="detail-badge">

            ${event.e_badge}

        </div>

        <h1>

            ${event.e_title}

        </h1>

        <p class="detail-desc">

            ${event.e_desc}

        </p>

        <div class="detail-info">

            <div>

                📅 기간 :
                ${event.e_period}

            </div>

            <div>

                🎁 보상 :
                ${event.e_reward}

            </div>

            <div>

                🏆 참여방법 :
                ${event.e_method}

            </div>

        </div>

        <button
            class="back-btn"
            onclick="location.href='${pageContext.request.contextPath}/event'">

            이벤트 목록으로

        </button>

    </div>

</div>

</body>
</html>