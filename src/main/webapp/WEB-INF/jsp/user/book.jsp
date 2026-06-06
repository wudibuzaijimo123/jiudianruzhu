<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>确认订单 - 随心出行</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="${pageContext.request.contextPath}/static/js/click-effect.js"></script>
</head>
<body>
<div class="top">
    <h2>确认订单</h2>
    <a href="${pageContext.request.contextPath}/room/detail?id=${roomType.id}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">
        <svg style="width:16px;height:16px;fill:currentColor" viewBox="0 0 24 24"><path d="M20,11H7.83L13.41,5.41L12,4L4,12L12,20L13.41,18.59L7.83,13H20V11Z"/></svg>
        返回房型详情
    </a>
</div>

<form method="post" action="${pageContext.request.contextPath}/book">
    <div class="wrap order-layout">
        <div>
            <c:if test="${not empty msg}">
                <p class="msg">${msg}</p>
            </c:if>
            
            <div class="panel compact-room" style="padding: 20px;">
                <img src="${empty roomType.imageUrl ? 'https://images.unsplash.com/photo-1566073771259-6a8506099945' : roomType.imageUrl}" alt="${roomType.typeName}">
                <div>
                    <h3 style="margin: 0 0 6px; font-size: 20px; font-weight: 800;">${roomType.typeName}</h3>
                    <p style="color: var(--primary); font-weight: 600; margin: 4px 0;">
                        ${roomType.category} · ${roomType.bedType} · ${empty roomType.breakfast ? '不含早' : roomType.breakfast}
                    </p>
                    <p style="color: var(--gray-600); font-size: 14px; margin: 4px 0; display: flex; align-items: center; gap: 6px;">
                        <svg style="width:16px;height:16px;fill:var(--gray-600)" viewBox="0 0 24 24"><path d="M19,19H5V8H19M19,3H18V1H16V3H8V1H6V3H5C3.89,3 3,3.9 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V5A2,2 0 0,0 21,3M16.53,11.06L15.47,10L11.59,13.88L9.53,11.82L8.47,12.88L11.59,16L16.53,11.06Z"/></svg>
                        <strong>${checkinDate}</strong> 入住 至 <strong>${checkoutDate}</strong> 离店
                    </p>
                </div>
            </div>
            
            <div class="panel guest-card">
                <h3 style="margin: 0 0 8px; font-size: 18px; font-weight: 800;">✍️ 入住人信息</h3>
                <p class="auth-subtitle" style="margin-bottom: 20px;">请填写实际入住人的姓名，姓名需与身份证件保持一致，以便顺利办理入住。</p>
                
                <input type="hidden" name="roomTypeId" value="${roomType.id}">
                <input type="hidden" name="checkinDate" value="${checkinDate}">
                <input type="hidden" name="checkoutDate" value="${checkoutDate}">
                
                <div class="guest-form">
                    <label>
                        <span>姓名</span>
                        <input name="guestName" value="${sessionScope.loginUser.realName}" placeholder="请输入主入住人真实姓名" required>
                    </label>
                    <label>
                        <span>联系手机</span>
                        <input name="guestPhone" value="${sessionScope.loginUser.phone}" placeholder="用于接收确认短信和前台联系" required>
                    </label>
                    <label>
                        <span>身份证号</span>
                        <input name="guestIdCard" value="${sessionScope.loginUser.idCard}" placeholder="前台核验身份使用" required>
                    </label>
                </div>
            </div>
        </div>
        
        <div class="summary-card">
            <h3>💳 结算详情</h3>
            <div class="order-line">
                <span>单晚房费</span>
                <strong>￥${roomType.price}</strong>
            </div>
            <div class="order-line">
                <span>入住时间</span>
                <strong style="font-size: 13.5px;">${checkinDate} 至 ${checkoutDate}</strong>
            </div>
            
            <div style="margin: 20px 0; background: var(--gray-50); padding: 14px; border-radius: var(--radius-md); border: 1px dashed var(--gray-200);">
                <h4 style="margin: 0 0 6px; font-size: 14px; font-weight: 700; color: var(--gray-900);">💡 温馨提示</h4>
                <p style="margin: 0; font-size: 12px; color: var(--gray-600); line-height: 1.6;">
                    提交订单后，我们将立即为您锁房。同一账号在相同时间段内只能拥有一张有效订单。
                </p>
            </div>
            
            <button class="yellow full-btn" type="submit" style="font-size: 16px; padding: 14px; height: auto;">
                确认并提交订单
            </button>
        </div>
    </div>
</form>
<jsp:include page="footer.jsp" />
</body>
</html>
