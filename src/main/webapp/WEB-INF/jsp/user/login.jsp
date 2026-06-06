<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <title>用户登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body class="auth-page">
<div class="auth-shell">
    <div class="auth-brand">
        <a class="back-link" href="${pageContext.request.contextPath}/rooms">返回首页</a>
        <div>
            <h1>酒店入住</h1>
            <p>酒店预定管理系统</p>
            <div class="brand-info">
                <p>前台用户可以查询房型、提交订单、查看订单详情。</p>
                <p>后台管理员可以维护房型、房间和订单状态。</p>
            </div>
        </div>
        <div class="demo-account left">
            <strong>前台测试账号</strong><br>
            账号：酒店入住<br>
            密码：123456
        </div>
    </div>
    <div class="auth-card">
        <h2>用户登录</h2>
        <p class="auth-subtitle">登录后可以预定房间、查看订单和维护个人资料</p>
        <p class="msg">${msg}</p>
        <form method="post">
            <label>账号或手机号
                <input name="account" placeholder="请输入用户名或手机号" required>
            </label>
            <label>登录密码
                <input type="password" name="password" placeholder="请输入登录密码" required>
            </label>
            <button class="primary-btn" type="submit">登录</button>
        </form>
        <div class="auth-foot">
            <span>还没有账号？</span>
            <a href="${pageContext.request.contextPath}/register">立即注册</a>
        </div>
    </div>
</div>
</body>
</html>
