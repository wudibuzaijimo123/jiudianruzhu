<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>
<head>
    <title>后台管理登录 - 随心出行</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="${pageContext.request.contextPath}/static/js/click-effect.js"></script>
</head>
<body class="auth-page" style="background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);">
<div class="auth-shell" style="border: 1px solid #334155; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.5);">
    <div class="auth-brand admin-brand" style="background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%); border-right: 1px solid #334155;">
        <a class="back-link" href="${pageContext.request.contextPath}/rooms" style="background: rgba(255,255,255,0.08); border-color: rgba(255,255,255,0.15);">
            <svg style="width:14px;height:14px;fill:currentColor;vertical-align:middle;margin-right:4px;" viewBox="0 0 24 24"><path d="M20,11H7.83L13.41,5.41L12,4L4,12L12,20L13.41,18.59L7.83,13H20V11Z"/></svg>
            返回前台首页
        </a>
        <div>
            <h1 style="font-weight: 950; font-size: 36px; color: #fff;">随心管理系统</h1>
            <p style="margin-top: 8px; font-size: 15px; color: #94a3b8;">标准化酒店运营与数据维护中心</p>
            <div class="brand-info" style="color: #cbd5e1; margin-top: 24px;">
                <p>房型管理：上架、下架、删除及属性更新</p>
                <p>房间调度：清洁中、空闲、维修状态同步</p>
                <p>订单办理：实时前台入住登记、取消与退房</p>
                <p>用户管理：快速启用、禁用前台消费账号</p>
            </div>
        </div>
        <div class="demo-account left" style="background: rgba(59, 130, 246, 0.1); border: 1.5px dashed rgba(59, 130, 246, 0.3); color: #93c5fd;">
            <strong>⚙️ 系统测试管理员账号</strong><br>
            账号：<strong>admin</strong><br>
            密码：<strong>123123</strong>
        </div>
    </div>
    
    <div class="auth-card" style="background: #1e293b; color: #fff;">
        <h2 style="color: #fff; font-weight: 800;">管理员安全登录</h2>
        <p class="auth-subtitle" style="color: #94a3b8; margin-bottom: 24px;">请使用有运营权限的管理员账户校验进入系统</p>
        
        <c:if test="${not empty msg}">
            <p class="msg" style="background: rgba(239, 68, 68, 0.15); border-color: rgba(239, 68, 68, 0.3); color: #fca5a5;">${msg}</p>
        </c:if>
        
        <form method="post">
            <label style="color: #cbd5e1;">
                <span>管理员账号</span>
                <input name="username" placeholder="请输入管理员登录账户" required style="background: #0f172a; border-color: #334155; color: #fff;" autocomplete="username">
            </label>
            <label style="color: #cbd5e1; margin-top: 10px;">
                <span>登录密码</span>
                <input type="password" name="password" placeholder="请输入安全密码" required style="background: #0f172a; border-color: #334155; color: #fff;" autocomplete="current-password">
            </label>
            <button class="primary-btn" type="submit" style="font-weight: 800; background: var(--primary); box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3); border-radius: var(--radius-md); margin-top: 10px;">
                进入控制后台
            </button>
        </form>
    </div>
</div>
</body>
</html>
