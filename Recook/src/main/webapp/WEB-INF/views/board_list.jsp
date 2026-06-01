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

<title>자유게시판</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/board_list.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="board-container">

    <div class="board-top">

        <h1 class="board-title">
            자유게시판
        </h1>

        <button
        class="write-btn"
        onclick="location.href='${pageContext.request.contextPath}/board/write'">

            글쓰기

        </button>

    </div>

    <!-- 검색 -->

    <form
    action="${pageContext.request.contextPath}/board"
    method="get"
    class="search-form">

        <input
        type="text"
        name="keyword"
        value="${keyword}"
        placeholder="게시글 검색">

        <button type="submit">
            검색
        </button>

    <!-- 정렬 -->

    <div class="sort-box">

    <button
    type="button"
    onclick="location.href='${pageContext.request.contextPath}/board?sort=latest&keyword=${keyword}'">

        최신순

    </button>

    <button
    type="button"
    onclick="location.href='${pageContext.request.contextPath}/board?sort=hit&keyword=${keyword}'">

        조회순

    </button>

    <button
    type="button"
    onclick="location.href='${pageContext.request.contextPath}/board?sort=like&keyword=${keyword}'">

        좋아요순

    </button>

</div>
    </form>



    <div class="board-list">

        <c:forEach var="board"
        items="${boardList}">

            <div class="board-item"

            onclick="location.href='${pageContext.request.contextPath}/board/detail/${board.id}'">

                <div class="board-left">

                    <div class="board-item-title">
                        ${board.title}
                    </div>

                    <div class="board-info">

                        ${board.writer}
                        ·
                        ${board.regDate}
                        · 조회수 ${board.hit}

                    </div>

                </div>

            </div>

        </c:forEach>

    </div>

    <!-- 페이징 -->

    <div class="paging">

        <c:forEach begin="1"
        end="${totalPage}"
        var="p">

            <a

            href="${pageContext.request.contextPath}/board?page=${p}&keyword=${keyword}&sort=${sort}"

            class="${currentPage == p ? 'active-page' : ''}">

                ${p}

            </a>

        </c:forEach>

    </div>

</div>

</body>
</html>