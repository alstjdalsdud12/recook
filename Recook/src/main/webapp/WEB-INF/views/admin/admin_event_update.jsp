<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@ page import="com.springmvc.domain.Event"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 이벤트 수정 - ReCook</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">
</head>
<body>

	<div class="admin-container">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<%
		Event event = (Event) request.getAttribute("event");
		%>

		<div class="main">

			<div class="top-bar">
				<h1>이벤트 수정</h1>
			</div>

			<div class="recent">
				<form action="${pageContext.request.contextPath}/admin/event/update" method="post">
					<input type="hidden" name="e_no" value="<%= event.getE_no() %>">

					<div class="form-group" style="margin-bottom:20px;">
						<label>제목</label>
						<input type="text" name="e_title" value="<%= event.getE_title() != null ? event.getE_title() : "" %>" required
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
					</div>

					<div class="form-group" style="margin-bottom:20px;">
						<label>설명</label>
						<textarea name="e_desc" rows="4" required
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px; resize:none;"><%= event.getE_desc() != null ? event.getE_desc() : "" %></textarea>
					</div>

					<div class="form-group" style="margin-bottom:20px;">
						<label>기간</label>
						<input type="text" name="e_period" value="<%= event.getE_period() != null ? event.getE_period() : "" %>"
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
					</div>

					<div class="form-group" style="margin-bottom:20px;">
						<label>보상</label>
						<input type="text" name="e_reward" value="<%= event.getE_reward() != null ? event.getE_reward() : "" %>"
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
					</div>

					<div class="form-group" style="margin-bottom:20px;">
						<label>참여방법</label>
						<input type="text" name="e_method" value="<%= event.getE_method() != null ? event.getE_method() : "" %>"
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
					</div>

					<div class="form-group" style="margin-bottom:20px;">
						<label>아이콘 (이모지)</label>
						<input type="text" name="e_icon" value="<%= event.getE_icon() != null ? event.getE_icon() : "" %>"
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
					</div>

					<div class="form-group" style="margin-bottom:20px;">
						<label>뱃지</label>
						<input type="text" name="e_badge" value="<%= event.getE_badge() != null ? event.getE_badge() : "" %>"
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
					</div>

					<div style="display:flex; gap:10px; margin-top:20px;">
						<button type="submit" class="btn-submit">수정하기</button>
						<a href="${pageContext.request.contextPath}/admin/event"
							class="btn-submit" style="background:#888; text-decoration:none;">취소</a>
					</div>

				</form>
			</div>

		</div>

	</div>

</body>
</html>