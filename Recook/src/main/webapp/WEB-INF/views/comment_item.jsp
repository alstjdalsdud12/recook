<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Comment"%>
<%@ page import="java.util.List"%>

<%
Comment comment = (Comment) request.getAttribute("currentComment");
int boardId = (Integer) request.getAttribute("boardId");
String sessionNickname = (String) session.getAttribute("m_nickname");
int depth = comment.getBc_depth();
int marginLeft = depth * 25;
%>

<div class="comment-item" style="margin-left: <%= marginLeft %>px;">
    <div class="comment-top">
        <div>
            <div class="comment-writer">
                <% for(int i=0; i<depth; i++) { %>↳<% } %>
                <%= comment.getBc_writer() %>
            </div>
            <div class="comment-date"><%= comment.getBc_reg_date() %></div>
        </div>
        <div class="comment-right">
            <% if (comment.getBc_deleted() != 1) { %>
            <button class="reply-toggle-btn"
                onclick="checkLoginAndReply(<%= comment.getBc_id() %>)">답글</button>
            <% if (sessionNickname != null && sessionNickname.equals(comment.getBc_writer())) { %>
            <div class="comment-btns">
                <button onclick="location.href='${pageContext.request.contextPath}/board/comment/edit?boardId=<%= boardId %>&commentId=<%= comment.getBc_id() %>'">수정</button>
                <button onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/board/comment/delete?boardId=<%= boardId %>&commentId=<%= comment.getBc_id() %>'">삭제</button>
            </div>
            <% } %>
            <% } %>
        </div>
    </div>

    <div class="comment-content">
        <% if (comment.getBc_deleted() == 1) { %>
            <span style="color:#aaa; font-style:italic;">삭제된 글입니다.</span>
        <% } else { %>
            <%= comment.getBc_content() %>
        <% } %>
    </div>

    <!-- 답글 작성 폼 -->
    <% if (comment.getBc_deleted() != 1) { %>
    <div class="reply-form" id="replyForm_<%= comment.getBc_id() %>" style="display:none;">
        <form action="${pageContext.request.contextPath}/board/reply" method="post">
            <input type="hidden" name="boardId" value="<%= boardId %>">
            <input type="hidden" name="parentId" value="<%= comment.getBc_id() %>">
            <input type="hidden" name="depth" value="<%= depth %>">
            <div class="reply-write">
                <textarea name="content" placeholder="답글을 입력하세요" required></textarea>
                <button type="submit">등록</button>
            </div>
        </form>
    </div>
    <% } %>

    <!-- 재귀적으로 대댓글 표시 -->
    <%
    List<Comment> replies = comment.getReplies();
    if (replies != null && !replies.isEmpty()) {
        for (Comment reply : replies) {
            request.setAttribute("currentComment", reply);
            request.setAttribute("boardId", boardId);
    %>
    <jsp:include page="/WEB-INF/views/comment_item.jsp" />
    <%
        }
    }
    %>
</div>