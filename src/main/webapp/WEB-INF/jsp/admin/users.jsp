<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>后台用户管理 - 随心出行</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="${pageContext.request.contextPath}/static/js/click-effect.js"></script>
</head>
<body class="admin-body">
<div class="admin-container">
    <!-- Sidebar -->
    <div class="admin-sidebar">
        <div>
            <h1>⚙️ 随心自营后台</h1>
            <div class="admin-nav">
                <a href="${pageContext.request.contextPath}/admin/orders" class="admin-nav-item">
                    <span>📋</span> 订单管理
                </a>
                <a href="${pageContext.request.contextPath}/admin/roomTypes" class="admin-nav-item">
                    <span>🛌</span> 房型管理
                </a>
                <a href="${pageContext.request.contextPath}/admin/rooms" class="admin-nav-item">
                    <span>🚪</span> 房间管理
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="admin-nav-item active">
                    <span>👥</span> 用户管理
                </a>
            </div>
        </div>
        <div style="border-top: 1px solid #334155; padding-top: 20px;">
            <p style="margin: 0; font-size: 13px; color: #94a3b8; font-weight: 600;">当前用户：操作员 admin</p>
            <a href="${pageContext.request.contextPath}/admin/logout" style="color: var(--error); font-size: 13px; font-weight: 700; margin-top: 8px; display: inline-block;">安全退出后台 ➔</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="admin-main">
        <div class="admin-header">
            <h2>注册用户管理与权限维护</h2>
            <div style="font-size: 14.5px; color: var(--gray-600); font-weight: 600;">随心出行 · 运营中心</div>
        </div>

        <!-- Stats Grid -->
        <div class="admin-stats-grid">
            <div class="admin-stat-card">
                <div class="admin-stat-info">
                    <h3>注册旅客数量</h3>
                    <p>${users.size()} 人</p>
                </div>
                <div class="admin-stat-icon">👥</div>
            </div>
            <div class="admin-stat-card">
                <div class="admin-stat-info">
                    <h3>账号安全审计</h3>
                    <p style="font-size: 18px; color: var(--success); font-weight: 800;">审计通过</p>
                </div>
                <div class="admin-stat-icon" style="background: var(--success-light); color: var(--success);">✔</div>
            </div>
        </div>

        <!-- Table Card -->
        <div class="admin-table-card">
            <table>
                <thead>
                    <tr>
                        <th>会员账号 (登录名)</th>
                        <th>旅客真实姓名</th>
                        <th>联络手机号</th>
                        <th>平台消费次数</th>
                        <th>账户许可状态</th>
                        <th style="width: 140px; text-align: center;">账户操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="u">
                        <tr>
                            <td>
                                <strong style="font-size: 15px; color: var(--gray-900);">${u.username}</strong>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty u.realName}">
                                        <span style="color: var(--gray-600); font-style: italic; font-size: 13.5px;">暂无实名信息</span>
                                    </c:when>
                                    <c:otherwise>
                                        <strong>${u.realName}</strong>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${empty u.phone ? '未录入手机' : u.phone}</td>
                            <td>
                                <span class="tag" style="background: var(--primary-light); color: var(--primary); font-weight: 800;">
                                    💼 已消费 ${u.consumeCount} 次
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.status==1}">
                                        <span class="admin-status-badge free">🟢 账号许可正常</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="admin-status-badge repair">🔴 账号已被禁用</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="text-align: center;">
                                <div style="display: flex; justify-content: center;">
                                    <a class="btn ${u.status==1?'red':'blue'}" style="padding: 6px 16px; font-size: 13px; font-weight: 700; width: 80px;" href="${pageContext.request.contextPath}/admin/users/status?id=${u.id}&status=${u.status==1?0:1}">
                                        ${u.status==1?'禁用':'启用'}
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
