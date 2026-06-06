<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>我的订单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="top">
    <h2>我的订单</h2>
    <a href="${pageContext.request.contextPath}/rooms">返回首页</a>
</div>
<div class="wrap">
    <div class="order-page-head">
        <h1>订单记录</h1>
        <p>查看当前账号下的预定、入住和历史订单。</p>
    </div>
    <div class="order-list">
        <c:forEach items="${orders}" var="o">
            <div class="order-item">
                <div class="order-main">
                    <div>
                        <h3>${o.typeName}</h3>
                        <p>${o.checkinDate} 至 ${o.checkoutDate} · ${o.nights} 晚 · 入住人：${o.guestName}</p>
                        <small>订单编号：${o.orderNo}</small>
                    </div>
                    <span class="status-pill">
                        <c:choose>
                            <c:when test="${o.status=='BOOKED'}">已预定</c:when>
                            <c:when test="${o.status=='CHECKED_IN'}">已入住</c:when>
                            <c:when test="${o.status=='COMPLETED'}">已完成</c:when>
                            <c:when test="${o.status=='CANCELED'}">已取消</c:when>
                            <c:otherwise>${o.status}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="order-actions">
                    <strong>￥${o.totalAmount}</strong>
                    <a class="btn blue" href="${pageContext.request.contextPath}/orders/detail?id=${o.id}">查看详情</a>
                    <c:if test="${o.status=='BOOKED'}"><a class="btn red" href="${pageContext.request.contextPath}/orders/cancel?id=${o.id}">取消订单</a></c:if>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
