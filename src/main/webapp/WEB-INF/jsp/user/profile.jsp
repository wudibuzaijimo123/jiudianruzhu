<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>
<head>
    <title>个人中心 - 随心出行</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="${pageContext.request.contextPath}/static/js/click-effect.js"></script>
</head>
<body style="background: #f5f7fa;">
<div class="top">
    <h2>个人中心</h2>
    <div>
        <a href="${pageContext.request.contextPath}/rooms">
            <svg style="width:16px;height:16px;fill:currentColor" viewBox="0 0 24 24"><path d="M10,20V14H14V20H19V12H22L12,3L2,12H5V20H10Z"/></svg>
            返回首页
        </a>
        <a href="${pageContext.request.contextPath}/orders">我的订单</a>
        <a href="${pageContext.request.contextPath}/logout" style="color: var(--error);">退出登录</a>
    </div>
</div>

<div class="profile-hero">
    <div class="wrap profile-grid simple-profile">
        <div class="panel profile-card">
            <div class="avatar">${sessionScope.loginUser.username.substring(0,1)}</div>
            <h1 style="font-weight: 800; font-size: 24px; color: var(--gray-900); margin: 0 0 6px;">${sessionScope.loginUser.username}</h1>
            <p style="color: var(--gray-600); font-size: 14px; margin-bottom: 24px;">
                📞 ${empty sessionScope.loginUser.phone ? '未绑定手机号' : sessionScope.loginUser.phone}
            </p>
            <a class="primary-btn small" href="${pageContext.request.contextPath}/orders" style="display: inline-flex; align-items: center; justify-content: center; border-radius: var(--radius-md); font-weight: 700;">
                查看我的订单行程
            </a>
        </div>
        
        <div class="panel profile-form-card" style="padding: 30px;">
            <h2 style="font-weight: 800; font-size: 22px; color: var(--gray-900); margin: 0 0 8px;">修改个人资料</h2>
            <p class="auth-subtitle" style="margin-bottom: 24px;">完善以下信息后，在提交酒店订单时，系统将为您自动带入入住信息。</p>
            
            <form method="post">
                <div class="form-grid">
                    <label>
                        <span>真实姓名</span>
                        <input name="realName" value="${sessionScope.loginUser.realName}" placeholder="请输入您的真实姓名" required>
                    </label>
                    <label>
                        <span>联系手机号</span>
                        <input name="phone" value="${sessionScope.loginUser.phone}" placeholder="请输入11位手机号码" required>
                    </label>
                    <label class="full">
                        <span>居民身份证号</span>
                        <input name="idCard" value="${sessionScope.loginUser.idCard}" placeholder="请输入18位身份证号（前台办理入住核验用）" required>
                    </label>
                </div>
                
                <button class="primary-btn" type="submit" style="font-weight: 800; height: 46px; border-radius: var(--radius-md); margin-top: 10px;">
                    保存修改信息
                </button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
