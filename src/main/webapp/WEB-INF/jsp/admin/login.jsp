<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <title>后台登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body class="auth-page">
<div class="auth-shell">
    <div class="auth-brand admin-brand">
        <a class="back-link" href="${pageContext.request.contextPath}/rooms">返回前台</a>
        <div>
            <h1>酒店后台管理</h1>
            <p>房型、房间、订单和用户统一维护</p>
            <div class="brand-info">
                <p>管理员可办理入住、退房和订单取消。</p>
                <p>房间状态会影响前台可预订库存。</p>
            </div>
        </div>
        <div class="demo-account left">
            <strong>后台测试账号</strong><br>
            账号：admin<br>
            密码：123456
        </div>
    </div>
    <div class="auth-card">
        <h2>管理员登录</h2>
        <p class="auth-subtitle">请使用管理员账号进入后台管理系统</p>
        <p class="msg">${msg}</p>
        <form method="post">
            <label>管理员账号
                <input name="username" placeholder="请输入管理员账号" required>
            </label>
            <label>登录密码
                <input type="password" name="password" placeholder="请输入密码" required>
            </label>
            <button class="primary-btn" type="submit">登录后台</button>
        </form>
    </div>
</div>
</body>
</html>
