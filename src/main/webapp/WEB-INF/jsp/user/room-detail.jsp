<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>随心出行 - 房型详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="top">
    <h2>房型详情</h2>
    <a href="${pageContext.request.contextPath}/rooms?checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">
        <svg style="width:16px;height:16px;fill:currentColor" viewBox="0 0 24 24"><path d="M20,11H7.83L13.41,5.41L12,4L4,12L12,20L13.41,18.59L7.83,13H20V11Z"/></svg>
        返回首页
    </a>
</div>

<div class="wrap">
    <div class="detail-hero">
        <div class="detail-image-container">
            <img src="${empty roomType.imageUrl ? 'https://images.unsplash.com/photo-1566073771259-6a8506099945' : roomType.imageUrl}" alt="${roomType.typeName}">
        </div>
        <div class="detail-body">
            <div class="detail-title">
                <div>
                    <h1>${roomType.typeName}</h1>
                    <div class="subtitle" style="margin-top: 10px;">${roomType.category} · ${roomType.starLevel}</div>
                </div>
                <div class="score-container">
                    <span class="score" style="font-size: 20px; padding: 6px 12px;">${roomType.rating}</span>
                    <span class="score-text" style="font-size: 16px;">
                        <c:choose>
                            <c:when test="${roomType.rating >= 4.8}">金牌极佳</c:when>
                            <c:when test="${roomType.rating >= 4.5}">非常棒</c:when>
                            <c:otherwise>舒适推荐</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            
            <p class="detail-desc" style="font-size: 15px; color: var(--gray-600); line-height: 1.8; margin-bottom: 24px; padding: 14px; background: var(--gray-50); border-radius: var(--radius-md); border-left: 4px solid var(--primary);">
                💡 <strong>房型描述：</strong>${roomType.description}
            </p>
            
            <div style="margin-bottom: 20px;">
                <c:forTokens items="${roomType.tags}" delims="," var="tag">
                    <span class="tag" style="margin-right: 6px; font-size: 13px; padding: 4px 10px;">✓ ${tag}</span>
                </c:forTokens>
            </div>
            
            <div class="info-grid">
                <div class="info-item">
                    <strong>🛏️ 床型信息</strong>
                    <span>${roomType.bedType}</span>
                </div>
                <div class="info-item">
                    <strong>👥 客人容量</strong>
                    <span>最多入住 ${roomType.capacity} 人</span>
                </div>
                <div class="info-item">
                    <strong>🥞 餐饮服务</strong>
                    <span>${empty roomType.breakfast ? '不含早' : roomType.breakfast}</span>
                </div>
                <div class="info-item">
                    <strong>🔌 房型设施</strong>
                    <span style="font-size: 13.5px; color: var(--gray-600);">${empty roomType.facilities ? '标准配套设施' : roomType.facilities}</span>
                </div>
            </div>
            
            <div class="panel" style="margin-top: 30px; border: 1.5px solid var(--primary-light); background: var(--gray-50);">
                <h3 style="margin: 0 0 16px; color: var(--gray-900); font-weight: 800; font-size: 17px; display: flex; align-items: center; gap: 8px;">
                    <svg style="width:20px;height:20px;fill:var(--primary)" viewBox="0 0 24 24"><path d="M19,19H5V8H19M19,3H18V1H16V3H8V1H6V3H5C3.89,3 3,3.9 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V5A2,2 0 0,0 21,3M16.53,11.06L15.47,10L11.59,13.88L9.53,11.82L8.47,12.88L11.59,16L16.53,11.06Z"/></svg>
                    选择您要入住的日期段
                </h3>
                <form class="date-edit-form" method="get" action="${pageContext.request.contextPath}/room/detail">
                    <input type="hidden" name="id" value="${roomType.id}">
                    <label>
                        <span>入住日期</span>
                        <input type="date" name="checkinDate" value="${checkinDate}" required>
                    </label>
                    <label>
                        <span>退房日期</span>
                        <input type="date" name="checkoutDate" value="${checkoutDate}" required>
                    </label>
                    <button class="btn" type="submit" style="height: 48px; margin-bottom: 0; background: var(--primary);">重新查询价格</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="bottom-bar">
    <div style="display: flex; align-items: center; gap: 12px;">
        <div>
            <c:if test="${not empty roomType.originalPrice}">
                <span class="old" style="font-size: 15px;">原价￥${roomType.originalPrice}</span>
            </c:if>
            <span class="price" style="font-size: 32px; font-weight: 900; color: var(--accent-hover);">￥${roomType.price}</span>
            <span class="price-unit" style="font-size: 15px;">/晚起</span>
        </div>
        <c:if test="${not empty roomType.promotion}">
            <span class="promo" style="font-size: 13px; padding: 4px 8px;">🎁 ${roomType.promotion}</span>
        </c:if>
    </div>
    <a class="yellow" href="${pageContext.request.contextPath}/book?roomTypeId=${roomType.id}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}" style="font-size: 17px; padding: 14px 48px; border-radius: var(--radius-md);">
        立即预订房源
    </a>
</div>
</body>
</html>
