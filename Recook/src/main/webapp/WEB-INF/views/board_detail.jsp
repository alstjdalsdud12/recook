<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Board"%>
<%@ page import="com.springmvc.domain.Comment"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${board.b_title}</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board_detail.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
Board board = (Board) request.getAttribute("board");
List<String> imageList = board.getImageList();
List<Comment> comments = board.getComments();
String sessionNickname = (String) session.getAttribute("m_nickname");
%>

<div class="detail-container">
	<div class="detail-box">

		<div class="detail-top">
			<h1 class="detail-title"><%= board.getB_title() %></h1>
			<div class="detail-info"><%= board.getB_writer() %> · <%= board.getB_reg_date() %> · 조회수 <%= board.getB_hit() %></div>
		</div>

		<!-- 좋아요 -->
		<div class="like-box">
			<button class="like-btn"
				onclick="location.href='${pageContext.request.contextPath}/board/like?id=<%= board.getB_id() %>'">
				👍 ${isLiked ? '좋아요 취소' : '좋아요'} <%= board.getB_like_count() %>
			</button>
		</div>

		<!-- 이미지 -->
		<% if (imageList != null && !imageList.isEmpty()) { %>
		<div class="detail-images">
			<% for (String img : imageList) { %>
			<img src="${pageContext.request.contextPath}/recipeimage/<%= img %>">
			<% } %>
		</div>
		<% } %>

		<div class="detail-content"><%= board.getB_content() %></div>

		<div class="detail-btns">
			<button class="edit-btn"
				onclick="location.href='${pageContext.request.contextPath}/board/edit/<%= board.getB_id() %>'">
				수정</button>
			<button class="delete-btn"
				onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/board/delete?id=<%= board.getB_id() %>'">
				삭제</button>
			<button class="list-btn"
				onclick="location.href='${pageContext.request.contextPath}/board'">
				목록</button>
		</div>

		<!-- 댓글 -->
		<div class="comment-section">

			<h2 class="comment-title">댓글 (<%= comments != null ? comments.size() : 0 %>)</h2>

			<!-- 댓글 작성 폼 -->
			<form action="${pageContext.request.contextPath}/board/comment" method="post">
				<input type="hidden" name="boardId" value="<%= board.getB_id() %>">
				<div class="comment-write">
					<textarea name="content" placeholder="댓글을 입력하세요" required></textarea>
					<button type="submit">등록</button>
				</div>
			</form>

			<!-- 댓글 리스트 -->
			<div class="comment-list">
				<%
				if (comments != null) {
					for (Comment comment : comments) {
						request.setAttribute("currentComment", comment);
						request.setAttribute("boardId", board.getB_id());
				%>
				<jsp:include page="/WEB-INF/views/comment_item.jsp" />
				<%
					}
				}
				%>
			</div>

		</div>

	</div>
</div>

<script>
function checkLoginAndReply(commentId) {
    <% if (sessionNickname == null) { %>
    if (confirm('로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?')) {
        location.href = '${pageContext.request.contextPath}/login';
    }
    <% } else { %>
    toggleReplyForm(commentId);
    <% } %>
}

function toggleReplyForm(commentId) {
    const form = document.getElementById("replyForm_" + commentId);
    if (form.style.display === "none") {
        form.style.display = "block";
    } else {
        form.style.display = "none";
    }
}
</script>

</body>
</html>