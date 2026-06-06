<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <title>用户注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body class="auth-page">
<div class="auth-shell">
    <div class="auth-brand">
        <a class="back-link" href="${pageContext.request.contextPath}/rooms">返回首页</a>
        <div>
            <h1>用户注册</h1>
            <p>填写基础信息后即可在线预定房间</p>
            <div class="brand-info">
                <p>用户名和手机号会进行唯一性校验。</p>
                <p>真实姓名、手机号和身份证号会用于提交订单。</p>
            </div>
        </div>
    </div>
    <div class="auth-card wide">
        <h2>创建账号</h2>
        <p class="auth-subtitle">请填写真实联系方式，方便酒店办理入住</p>
        <p class="msg">${msg}</p>
        <form method="post">
            <div class="form-grid">
                <label>用户名
                    <input name="username" placeholder="请输入用户名" required>
                </label>
                <label>密码
                    <input type="password" name="password" placeholder="请输入登录密码" required>
                </label>
                <label>手机号
                    <input name="phone" placeholder="请输入手机号" required>
                </label>
                <label>真实姓名
                    <input name="realName" placeholder="请输入真实姓名">
                </label>
                <label class="full">身份证号
                    <input name="idCard" placeholder="办理入住时使用">
                </label>
            </div>
            <button class="primary-btn" type="submit">注册账号</button>
        </form>
        <div class="auth-foot">
            <span>已有账号？</span>
            <a href="${pageContext.request.contextPath}/login">去登录</a>
        </div>
    </div>
</div>
</body>
</html>
