<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>订单详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="top">
    <h2>订单详情</h2>
    <a href="${pageContext.request.contextPath}/orders">返回订单列表</a>
</div>
<div class="wrap">
    <div class="order-card">
        <div class="hotel-title">
            <h3>
                <c:choose>
                    <c:when test="${order.status=='BOOKED'}">已预定</c:when>
                    <c:when test="${order.status=='CHECKED_IN'}">已入住</c:when>
                    <c:when test="${order.status=='COMPLETED'}">已完成</c:when>
                    <c:when test="${order.status=='CANCELED'}">已取消</c:when>
                    <c:otherwise>${order.status}</c:otherwise>
                </c:choose>
            </h3>
            <span class="tag">${order.typeName}</span>
        </div>
        <div class="order-line"><span>订单编号</span><strong>${order.orderNo}</strong></div>
        <div class="order-line"><span>房型名称</span><strong>${order.typeName}</strong></div>
        <div class="order-line"><span>房间号</span><strong>${empty order.roomNo ? '到店分配' : order.roomNo}</strong></div>
        <div class="order-line"><span>入住日期</span><strong>${order.checkinDate}</strong></div>
        <div class="order-line"><span>退房日期</span><strong>${order.checkoutDate}</strong></div>
        <div class="order-line"><span>入住晚数</span><strong>${order.nights} 晚</strong></div>
        <div class="order-line"><span>入住人</span><strong>${order.guestName}</strong></div>
        <div class="order-line"><span>联系电话</span><strong>${order.guestPhone}</strong></div>
        <div class="order-line"><span>身份证号</span><strong>${order.guestIdCard}</strong></div>
        <div class="order-line"><span>订单金额</span><strong>￥${order.totalAmount}</strong></div>
    </div>
</div>
</body>
</html>
