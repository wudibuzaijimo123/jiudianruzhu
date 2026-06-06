<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <title>用户注册 - 随心出行</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body class="auth-page">
<div class="auth-shell">
    <div class="auth-brand" style="background: linear-gradient(135deg, #0f766e 0%, #164e63 100%);">
        <a class="back-link" href="${pageContext.request.contextPath}/rooms">
            <svg style="width:14px;height:14px;fill:currentColor;vertical-align:middle;margin-right:4px;" viewBox="0 0 24 24"><path d="M20,11H7.83L13.41,5.41L12,4L4,12L12,20L13.41,18.59L7.83,13H20V11Z"/></svg>
            返回首页
        </a>
        <div>
            <h1 style="font-weight: 950; font-size: 38px;">创建新账号</h1>
            <p style="margin-top: 8px; font-size: 16px; opacity: 0.95; font-weight: 600;">开启快捷酒店预定体验</p>
            <div class="brand-info">
                <p>用户名和手机号将作为登录的唯一标识凭证</p>
                <p>完善您的身份证信息，可实现疾速前台分房</p>
                <p>承诺严格保护您的个人身份隐私数据安全</p>
            </div>
        </div>
        <div style="font-size: 12.5px; opacity: 0.75; line-height: 1.5;">
            注册即代表您同意《服务条款》和《隐私政策》
        </div>
    </div>
    
    <div class="auth-card wide">
        <h2>注册新账号</h2>
        <p class="auth-subtitle">请填写以下基本信息，带星号(*)的为必填项</p>
        
        <c:if test="${not empty msg}">
            <p class="msg">${msg}</p>
        </c:if>
        
        <form method="post">
            <div class="form-grid">
                <label>
                    <span>用户名 *</span>
                    <input name="username" placeholder="请输入个性用户名" required autocomplete="username">
                </label>
                <label>
                    <span>登录密码 *</span>
                    <input type="password" name="password" placeholder="建议包含字母与数字" required autocomplete="new-password">
                </label>
                <label>
                    <span>手机号码 *</span>
                    <input name="phone" placeholder="用于接收预订与通知短信" required>
                </label>
                <label>
                    <span>真实姓名</span>
                    <input name="realName" placeholder="办理入住时必须与证件一致">
                </label>
                <label class="full">
                    <span>身份证号</span>
                    <input name="idCard" placeholder="可方便到店极速刷脸/前台分配房间">
                </label>
            </div>
            
            <button class="primary-btn" type="submit" style="font-weight: 800; border-radius: var(--radius-md); margin-top: 10px; background: #0f766e; box-shadow: 0 4px 12px rgba(15, 118, 110, 0.2);">
                确认注册并登录
            </button>
        </form>
        
        <div class="auth-foot">
            <span>已经有账号了？</span>
            <a href="${pageContext.request.contextPath}/login" style="color: #0f766e;">立即去登录</a>
        </div>
    </div>
</div>
</body>
</html>
