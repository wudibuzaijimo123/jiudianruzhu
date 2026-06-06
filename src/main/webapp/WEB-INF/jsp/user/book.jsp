<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <title>确认订单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="top">
    <h2>确认订单</h2>
    <a href="${pageContext.request.contextPath}/room/detail?id=${roomType.id}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">返回房型详情</a>
</div>
<form method="post" action="${pageContext.request.contextPath}/book">
    <div class="wrap order-layout">
        <div>
            <p class="msg">${msg}</p>
            <div class="order-card compact-room">
                <img src="${roomType.imageUrl}" alt="${roomType.typeName}">
                <div>
                    <h3>${roomType.typeName}</h3>
                    <p>${roomType.category} · ${roomType.bedType} · ${roomType.breakfast}</p>
                    <p>${checkinDate} 入住，${checkoutDate} 退房</p>
                </div>
            </div>
            <div class="order-card guest-card">
                <h3>入住信息</h3>
                <p class="auth-subtitle">请填写实际入住人的信息，办理入住时需要核对。</p>
                <input type="hidden" name="roomTypeId" value="${roomType.id}">
                <input type="hidden" name="checkinDate" value="${checkinDate}">
                <input type="hidden" name="checkoutDate" value="${checkoutDate}">
                <div class="guest-form">
                    <label>入住人姓名
                        <input name="guestName" value="${sessionScope.loginUser.realName}" placeholder="请输入入住人姓名" required>
                    </label>
                    <label>联系手机
                        <input name="guestPhone" value="${sessionScope.loginUser.phone}" placeholder="请输入联系电话" required>
                    </label>
                    <label>身份证号
                        <input name="guestIdCard" value="${sessionScope.loginUser.idCard}" placeholder="请输入身份证号" required>
                    </label>
                </div>
            </div>
        </div>
        <div class="summary-card">
            <h3>订单金额</h3>
            <div class="order-line"><span>房型价格</span><strong>￥${roomType.price} /晚</strong></div>
            <div class="order-line"><span>入住时间</span><strong>${checkinDate} 至 ${checkoutDate}</strong></div>
            <p class="meta">提交后会生成“已预定”订单。同一账号同一时间段只能保留一张有效订单。</p>
            <button class="yellow full-btn" type="submit">提交订单</button>
        </div>
    </div>
</form>
</body>
</html>
