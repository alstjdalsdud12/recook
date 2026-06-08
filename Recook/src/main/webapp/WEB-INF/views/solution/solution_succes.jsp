<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Successfully Archived | ReCook</title>
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
    <style>
        .success-container {
            height: 80vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding-top: 100px;
        }
        .success-icon {
            font-size: 48px;
            color: #ff6e40;
            margin-bottom: 30px;
            animation: scaleUp 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .success-container h2 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            font-weight: 400;
            margin-bottom: 20px;
            color: #1c1c1e;
        }
        .success-container p {
            font-size: 16px;
            color: #8e8e93;
            line-height: 1.6;
            margin-bottom: 50px;
        }
        .btn-group {
            display: flex;
            gap: 20px;
        }
        .btn-home {
            padding: 15px 40px;
            background-color: #1c1c1e;
            color: #fff;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 1px;
            transition: 0.3s;
        }
        .btn-home:hover { background-color: #ff6e40; }
        
        @keyframes scaleUp {
            from { transform: scale(0); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>

    <main class="success-container">
        <div class="success-icon">✓</div>
        <h2>Archived Successfully.</h2>
        <p>당신이 공유해주신 지혜가 ReCook 아카이브의 일부가 되었습니다.<br>
           다른 사람들에게 새로운 영감이 될 것입니다.</p>
        
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/solution" class="btn-home">GO TO ARCHIVE</a>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>