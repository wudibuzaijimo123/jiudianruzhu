<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>房型详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="top">
    <h2>房型详情</h2>
    <a href="${pageContext.request.contextPath}/rooms?checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">返回首页</a>
</div>
<div class="wrap">
    <div class="detail-hero">
        <img src="${roomType.imageUrl}" alt="${roomType.typeName}">
        <div class="detail-body">
            <div class="detail-title">
                <div>
                    <h1>${roomType.typeName}</h1>
                    <p class="subtitle">${roomType.category} · ${roomType.starLevel} · ${roomType.distanceText}</p>
                </div>
                <span class="score">${roomType.rating} 分</span>
            </div>
            <p class="detail-desc">${roomType.description}</p>
            <div>
                <c:forTokens items="${roomType.tags}" delims="," var="tag"><span class="tag">${tag}</span></c:forTokens>
            </div>
            <div class="info-grid">
                <div class="info-item"><strong>床型</strong><br>${roomType.bedType}</div>
                <div class="info-item"><strong>入住人数</strong><br>${roomType.capacity} 人</div>
                <div class="info-item"><strong>早餐</strong><br>${roomType.breakfast}</div>
                <div class="info-item"><strong>配套设施</strong><br>${roomType.facilities}</div>
            </div>
            <div class="order-card">
                <h3>选择入住时间</h3>
                <form class="date-edit-form" method="get" action="${pageContext.request.contextPath}/room/detail">
                    <input type="hidden" name="id" value="${roomType.id}">
                    <label>入住日期<input type="date" name="checkinDate" value="${checkinDate}" required></label>
                    <label>退房日期<input type="date" name="checkoutDate" value="${checkoutDate}" required></label>
                    <button class="btn gray" type="submit">更新日期</button>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="bottom-bar">
    <div><span class="price">￥${roomType.price}</span> /晚</div>
    <a class="yellow" href="${pageContext.request.contextPath}/book?roomTypeId=${roomType.id}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">立即预定</a>
</div>
</body>
</html>
