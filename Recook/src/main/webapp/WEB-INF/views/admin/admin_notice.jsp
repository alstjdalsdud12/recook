<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 공지사항 관리 - ReCook</title>

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
				<h1>공지사항 관리</h1>
			</div>

			<div class="recent">

				<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
					<h2 style="margin: 0;">공지사항 목록</h2>
					<a href="${pageContext.request.contextPath}/admin/admin_notice_write" class="btn-submit">새 공지사항 작성</a>
				</div>

				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성일</th>
							<th>관리</th>
						</tr>
					</thead>

					<tbody>
						<%
							java.util.List<com.springmvc.domain.Notice> noticeList = 
								(java.util.List<com.springmvc.domain.Notice>) request.getAttribute("noticeList");
							
							if (noticeList != null && noticeList.size() > 0) {
								for (com.springmvc.domain.Notice notice : noticeList) {
						%>
						<tr>
							<td><%= notice.getN_no() %></td>
							<td><%= notice.getN_title() %></td>
							<td><%= notice.getN_datetime() %></td>
							<td>
								<a href="${pageContext.request.contextPath}/admin/admin_notice_update?n_no=<%= notice.getN_no() %>" class="btn-small btn-edit">수정</a>
								<a href="${pageContext.request.contextPath}/notice/delete?n_no=<%= notice.getN_no() %>" class="btn-small btn-delete" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
							</td>
						</tr>
						<%
								}
							} else {
						%>
						<tr>
							<td colspan="4" style="text-align: center; color: #999;">등록된 공지사항이 없습니다.</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>

			</div>

		</div>

	</div>

</body>
</html>