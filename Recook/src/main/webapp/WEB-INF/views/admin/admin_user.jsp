<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 회원 관리 - ReCook</title>

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
				<h1>회원 관리</h1>
			</div>

			<!-- 검색 폼 -->
			<div class="search-form">
				<form action="${pageContext.request.contextPath}/admin/user" method="get" style="display: flex; gap: 10px;">
					<input type="text" name="search" placeholder="아이디로 검색..." value="${search != null ? search : ''}">
					<button type="submit">검색</button>
					<a href="${pageContext.request.contextPath}/admin/user" class="btn-submit">초기화</a>
				</form>
			</div>

			<div class="recent">

				<div style="margin-bottom: 20px;">
					<h2 style="margin: 0;">회원 목록</h2>
				</div>

				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>닉네임</th>
							<th>아이디</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>가입일</th>
							<th>권한</th>
							<th>관리</th>
						</tr>
					</thead>

					<tbody>
						<%
							java.util.List<com.springmvc.domain.Member> memberList =
								(java.util.List<com.springmvc.domain.Member>) request.getAttribute("memberList");

							if (memberList != null && memberList.size() > 0) {
								for (com.springmvc.domain.Member member : memberList) {
						%>
						<!-- 읽기 모드 -->
						<tr id="view-<%= member.getM_no() %>">
							<td><%= member.getM_no() %></td>
							<td><span id="nick-<%= member.getM_no() %>"><%= member.getM_nickname() %></span></td>
							<td><%= member.getM_id() %></td>
							<td><span id="email-<%= member.getM_no() %>"><%= member.getM_email() %></span></td>
							<td><span id="phone-<%= member.getM_no() %>"><%= member.getM_phone() %></span></td>
							<td><%= member.getM_datetime() %></td>
							<td>
								<%
									String role = member.getM_role();
									if (role != null && role.equals("admin")) {
										out.print("<span style='color: #FF6B6B; font-weight: bold;'>관리자</span>");
									} else {
										out.print("<span style='color: #666;'>일반</span>");
									}
								%>
							</td>
							<td>
								<div class="action-buttons">
									<button class="btn-small btn-edit" onclick="toggleEdit(<%= member.getM_no() %>)">수정</button>
									<a href="${pageContext.request.contextPath}/admin/user/delete?m_no=<%= member.getM_no() %>" class="btn-small btn-delete" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
								</div>
							</td>
						</tr>

						<!-- 수정 모드 -->
						<tr id="edit-<%= member.getM_no() %>" class="edit-mode">
							<form action="${pageContext.request.contextPath}/admin/user/update" method="post" style="display: contents;">
								<td><%= member.getM_no() %><input type="hidden" name="m_no" value="<%= member.getM_no() %>"></td>
								<td><input type="text" name="m_nickname" value="<%= member.getM_nickname() %>"></td>
								<td><%= member.getM_id() %></td>
								<td><input type="email" name="m_email" value="<%= member.getM_email() %>"></td>
								<td><input type="text" name="m_phone" value="<%= member.getM_phone() == null ? "" : member.getM_phone() %>"></td>
								<td><%= member.getM_datetime() %></td>
								<td>
									<select name="m_role">
										<option value="user" <%= "user".equals(member.getM_role()) ? "selected" : "" %>>일반</option>
										<option value="admin" <%= "admin".equals(member.getM_role()) ? "selected" : "" %>>관리자</option>
									</select>
								</td>
								<td>
									<div class="action-buttons">
										<button type="submit" class="btn-small btn-save">저장</button>
										<button type="button" class="btn-small btn-cancel" onclick="toggleEdit(<%= member.getM_no() %>)">취소</button>
									</div>
								</td>
							</form>
						</tr>

						<%
								}
							} else {
						%>
						<tr>
							<td colspan="8" style="text-align: center; color: #999;">등록된 회원이 없습니다.</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>

			</div>

		</div>

	</div>

	<script>
		function toggleEdit(m_no) {
			const viewRow = document.getElementById('view-' + m_no);
			const editRow = document.getElementById('edit-' + m_no);
			
			viewRow.style.display = viewRow.style.display === 'none' ? 'table-row' : 'none';
			editRow.classList.toggle('active');
		}
	</script>

</body>
</html>