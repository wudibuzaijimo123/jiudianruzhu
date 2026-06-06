<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <title>个人中心</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="top">
    <h2>个人中心</h2>
    <div>
        <a href="${pageContext.request.contextPath}/rooms">返回首页</a>
        <a href="${pageContext.request.contextPath}/orders">我的订单</a>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>
<div class="profile-hero">
    <div class="wrap profile-grid simple-profile">
        <div class="profile-card">
            <div class="avatar">${sessionScope.loginUser.username.substring(0,1)}</div>
            <h1>${sessionScope.loginUser.username}</h1>
            <p>${empty sessionScope.loginUser.phone ? '暂未填写手机号' : sessionScope.loginUser.phone}</p>
            <a class="primary-btn small" href="${pageContext.request.contextPath}/orders">查看我的订单</a>
        </div>
        <div class="profile-form-card">
            <h2>修改个人资料</h2>
            <p class="auth-subtitle">这里的信息会在提交订单时自动带入入住信息。</p>
            <form method="post">
                <div class="form-grid">
                    <label>真实姓名
                        <input name="realName" value="${sessionScope.loginUser.realName}" placeholder="请输入真实姓名">
                    </label>
                    <label>手机号
                        <input name="phone" value="${sessionScope.loginUser.phone}" placeholder="请输入手机号">
                    </label>
                    <label class="full">身份证号
                        <input name="idCard" value="${sessionScope.loginUser.idCard}" placeholder="办理入住时使用">
                    </label>
                </div>
                <button class="primary-btn" type="submit">保存资料</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
