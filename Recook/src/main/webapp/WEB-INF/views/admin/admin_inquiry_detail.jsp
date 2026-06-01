<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 문의 답변 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">

</head>
<body>

	<div class="admin-container">

		<!-- 사이드바 -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<!-- 메인 -->
		<div class="main">

			<div class="top-bar">
				<h1>문의 답변</h1>
			</div>

			<div class="form-wrapper">

				<%
					com.springmvc.domain.Inquiry inquiry = (com.springmvc.domain.Inquiry) request.getAttribute("inquiry");
					if (inquiry != null) {
				%>

				<div style="margin-bottom: 30px;">
					<h3 style="margin-top: 0;">제목</h3>
					<p style="background: #f5f5f5; padding: 12px; border-radius: 4px;">
						<%= inquiry.getI_title() %>
					</p>
				</div>

				<div style="margin-bottom: 30px;">
					<h3>이메일</h3>
					<p style="background: #f5f5f5; padding: 12px; border-radius: 4px;">
						<%= inquiry.getI_email() %>
					</p>
				</div>

				<div style="margin-bottom: 30px;">
					<h3>문의 내용</h3>
					<p style="background: #f5f5f5; padding: 12px; border-radius: 4px; white-space: pre-wrap;">
						<%= inquiry.getI_content() %>
					</p>
				</div>

				<div style="margin-bottom: 30px;">
					<h3>작성일</h3>
					<p style="background: #f5f5f5; padding: 12px; border-radius: 4px;">
						<%= inquiry.getI_datetime() %>
					</p>
				</div>

				<%
					if (inquiry.getI_reply() == null || inquiry.getI_reply().isEmpty()) {
				%>

				<div style="border-top: 1px solid #ddd; padding-top: 30px;">
					<h3>답변 작성</h3>
					
					<form action="${pageContext.request.contextPath}/admin/inquiry/reply" method="post">
						<input type="hidden" name="i_no" value="<%= inquiry.getI_no() %>">
						
						<div class="form-group">
							<label for="reply">답변:</label>
							<textarea id="reply" name="i_reply" rows="6" placeholder="답변을 입력하세요" required></textarea>
						</div>
						
						<div class="button-group">
							<button type="submit" class="btn-submit">답변 완료</button>
							<a href="${pageContext.request.contextPath}/admin/inquiry" class="btn-cancel">취소</a>
						</div>
					</form>
				</div>

				<%
					} else {
				%>

				<div style="border-top: 1px solid #ddd; padding-top: 30px;">
					<h3>답변 완료</h3>
					<p style="background: #e8f5e9; padding: 12px; border-radius: 4px; color: #2e7d32;">
						✓ 답변이 완료되었습니다.
					</p>
					
					<div style="margin-top: 15px;">
						<h4>답변 내용</h4>
						<p style="background: #f5f5f5; padding: 12px; border-radius: 4px; white-space: pre-wrap;">
							<%= inquiry.getI_reply() %>
						</p>
					</div>
					
					<div style="margin-top: 15px;">
						<h4>답변 일시</h4>
						<p style="background: #f5f5f5; padding: 12px; border-radius: 4px;">
							<%= inquiry.getI_reply_datetime() %>
						</p>
					</div>
					
					<div class="button-group">
						<a href="${pageContext.request.contextPath}/admin/inquiry" class="btn-cancel">목록으로</a>
					</div>
				</div>

				<%
					}
				%>

				<%
					} else {
				%>

				<p style="text-align: center; color: #999;">문의를 찾을 수 없습니다.</p>

				<%
					}
				%>

			</div>

		</div>

	</div>

</body>
</html>