<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>
<head>
    <title>用户登录 - 随心出行</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="${pageContext.request.contextPath}/static/js/click-effect.js"></script>
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
        <div class="demo-account left" id="demoUser">
            <strong style="color: var(--accent); font-size: 15px;">💡 前台测试账号</strong><br>
            <span style="opacity: 0.9;">账号：</span><strong>酒店入住</strong><br>
            <span style="opacity: 0.9;">密码：</span><strong>123456</strong>
        </div>
        <div class="demo-account left" id="demoAdmin" style="display: none; background: rgba(59, 130, 246, 0.1); border: 1.5px dashed rgba(59, 130, 246, 0.3); color: #93c5fd;">
            <strong style="color: #93c5fd; font-size: 15px;">⚙️ 系统测试管理员账号</strong><br>
            <span style="opacity: 0.9;">账号：</span><strong>admin</strong><br>
            <span style="opacity: 0.9;">密码：</span><strong>123123</strong>
        </div>
    </div>
    
    <div class="auth-card">
        <div class="login-tabs" style="display: flex; gap: 24px; border-bottom: 2px solid var(--gray-100); margin-bottom: 24px; padding-bottom: 6px;">
            <span class="login-tab active" data-type="user" style="padding: 6px 0; font-size: 17px; font-weight: 800; color: var(--primary); border-bottom: 2.5px solid var(--primary); cursor: pointer; transition: var(--transition);">用户登录</span>
            <span class="login-tab" data-type="admin" style="padding: 6px 0; font-size: 17px; font-weight: 800; color: var(--gray-600); cursor: pointer; transition: var(--transition);">管理员登录</span>
        </div>

        <h2 id="authTitle">欢迎回来</h2>
        <p class="auth-subtitle" id="authSubtitle">请登录您的账号，继续预订或查看行程订单</p>
        
        <c:if test="${not empty msg}">
            <p class="msg">${msg}</p>
        </c:if>
        
        <form method="post" id="loginForm" action="${pageContext.request.contextPath}/login">
            <input type="hidden" name="redirect" value="${param.redirect}">
            <label>
                <span id="accountLabel">账号或绑定手机号</span>
                <input id="accountInput" name="account" placeholder="请输入您的用户名或手机号" required autocomplete="username">
            </label>
            <label style="margin-top: 10px;">
                <span>登录密码</span>
                <input type="password" name="password" placeholder="请输入您的登录密码" required autocomplete="current-password">
            </label>
            <button class="primary-btn" type="submit" style="font-weight: 800; border-radius: var(--radius-md);">
                安全登录
            </button>
        </form>
        
        <div class="auth-foot" id="registerFoot">
            <span>还没有账号？</span>
            <a href="${pageContext.request.contextPath}/register">立即免费注册</a>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll('.login-tab').forEach(function(tab) {
            tab.addEventListener('click', function() {
                if (this.classList.contains('active')) return;
                
                // Remove active class from all tabs
                document.querySelectorAll('.login-tab').forEach(function(t) {
                    t.classList.remove('active');
                    t.style.color = 'var(--gray-600)';
                    t.style.borderBottom = 'none';
                });
                
                // Add active class to clicked tab
                this.classList.add('active');
                this.style.color = 'var(--primary)';
                this.style.borderBottom = '2.5px solid var(--primary)';
                
                var type = this.getAttribute('data-type');
                var form = document.getElementById('loginForm');
                var accountLabel = document.getElementById('accountLabel');
                var accountInput = document.getElementById('accountInput');
                var registerFoot = document.getElementById('registerFoot');
                var demoUser = document.getElementById('demoUser');
                var demoAdmin = document.getElementById('demoAdmin');
                var authTitle = document.getElementById('authTitle');
                var authSubtitle = document.getElementById('authSubtitle');
                
                if (type === 'user') {
                    form.action = "${pageContext.request.contextPath}/login";
                    authTitle.textContent = "欢迎回来";
                    authSubtitle.textContent = "请登录您的账号，继续预订或查看行程订单";
                    accountLabel.textContent = "账号或绑定手机号";
                    accountInput.name = "account";
                    accountInput.placeholder = "请输入您的用户名或手机号";
                    registerFoot.style.display = 'flex';
                    if (demoUser) demoUser.style.display = 'block';
                    if (demoAdmin) demoAdmin.style.display = 'none';
                } else {
                    form.action = "${pageContext.request.contextPath}/admin/login";
                    authTitle.textContent = "管理员登录";
                    authSubtitle.textContent = "请使用有运营权限的管理员账户登录系统";
                    accountLabel.textContent = "管理员账号";
                    accountInput.name = "username";
                    accountInput.placeholder = "请输入管理员登录账户";
                    registerFoot.style.display = 'none';
                    if (demoUser) demoUser.style.display = 'none';
                    if (demoAdmin) demoAdmin.style.display = 'block';
                }
            });
        });
    });
</script>
</body>
</html>
