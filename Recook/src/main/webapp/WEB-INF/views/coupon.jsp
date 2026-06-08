<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Coupon"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰함</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/coupon.css">
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
List<Coupon> couponList = (List<Coupon>) request.getAttribute("couponList");
int couponCount = couponList != null ? couponList.size() : 0;
%>

<div class="coupon-container">

    <div class="coupon-top">
        <h1>🎁 쿠폰함</h1>
        <div class="coupon-count">보유 쿠폰 <%= couponCount %>개</div>
    </div>

    <div class="coupon-list">
        <%
        if (couponList != null && !couponList.isEmpty()) {
            for (Coupon coupon : couponList) {
                String brandClass = "";
                String brand = coupon.getC_brand();
                if (brand.contains("배달의민족")) brandClass = "baemin";
                else if (brand.contains("Starbucks") || brand.contains("스타벅스")) brandClass = "starbucks";
                else if (brand.contains("GS")) brandClass = "gs";
                else if (brand.contains("CU")) brandClass = "cu";
                else if (brand.contains("세븐") || brand.contains("7-Eleven")) brandClass = "seven";
                else brandClass = "default";
        %>
        <div class="coupon-card <%= brandClass %>">
            <div class="coupon-left">
                <div class="coupon-brand"><%= coupon.getC_brand() %></div>
                <div class="coupon-name"><%= coupon.getC_name() %></div>
                <div class="coupon-date"><%= coupon.getC_expire_date() %> 까지 사용 가능</div>
            </div>
            <div class="coupon-right">
                <div class="coupon-badge"><%= coupon.getC_type() %></div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div style="text-align:center; color:#999; padding:50px;">보유한 쿠폰이 없습니다.</div>
        <%
        }
        %>
    </div>

</div>

</body>
</html>