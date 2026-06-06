<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <title>用户登录 - 随心出行</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body class="auth-page">
<div class="auth-shell">
    <div class="auth-brand">
        <a class="back-link" href="${pageContext.request.contextPath}/rooms">
            <svg style="width:14px;height:14px;fill:currentColor;vertical-align:middle;margin-right:4px;" viewBox="0 0 24 24"><path d="M20,11H7.83L13.41,5.41L12,4L4,12L12,20L13.41,18.59L7.83,13H20V11Z"/></svg>
            返回首页
        </a>
        <div>
            <h1 style="font-weight: 950; font-size: 38px;">随心自营酒店</h1>
            <p style="margin-top: 8px; font-size: 16px; opacity: 0.95; font-weight: 600;">让旅行更简单，让入住更舒适</p>
            <div class="brand-info">
                <p>实时查询精选自营房型，一键快速预订</p>
                <p>个人订单及行程跟踪，随时在线取消</p>
                <p>双向管理系统，专为旅客与管理员打造</p>
            </div>
        </div>
        <div class="demo-account left">
            <strong style="color: var(--accent); font-size: 15px;">💡 前台测试账号</strong><br>
            <span style="opacity: 0.9;">账号：</span><strong>酒店入住</strong><br>
            <span style="opacity: 0.9;">密码：</span><strong>123456</strong>
        </div>
    </div>
    
    <div class="auth-card">
        <h2>欢迎回来</h2>
        <p class="auth-subtitle">请登录您的账号，继续预订或查看行程订单</p>
        
        <c:if test="${not empty msg}">
            <p class="msg">${msg}</p>
        </c:if>
        
        <form method="post">
            <label>
                <span>账号或绑定手机号</span>
                <input name="account" placeholder="请输入您的用户名或手机号" required autocomplete="username">
            </label>
            <label style="margin-top: 10px;">
                <span>登录密码</span>
                <input type="password" name="password" placeholder="请输入您的登录密码" required autocomplete="current-password">
            </label>
            <button class="primary-btn" type="submit" style="font-weight: 800; border-radius: var(--radius-md);">
                安全登录
            </button>
        </form>
        
        <div class="auth-foot">
            <span>还没有账号？</span>
            <a href="${pageContext.request.contextPath}/register">立即免费注册</a>
        </div>
    </div>
</div>
</body>
</html>
