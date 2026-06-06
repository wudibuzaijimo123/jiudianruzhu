<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>后台订单管理 - 随心出行</title>
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
                <a href="${pageContext.request.contextPath}/admin/orders" class="admin-nav-item active">
                    <span>📋</span> 订单管理
                </a>
                <a href="${pageContext.request.contextPath}/admin/roomTypes" class="admin-nav-item">
                    <span>🛌</span> 房型管理
                </a>
                <a href="${pageContext.request.contextPath}/admin/rooms" class="admin-nav-item">
                    <span>🚪</span> 房间管理
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="admin-nav-item">
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
            <h2>订单调度与入住登记</h2>
            <div style="font-size: 14.5px; color: var(--gray-600); font-weight: 600;">随心出行 · 运营中心</div>
        </div>

        <!-- Stats Grid -->
        <div class="admin-stats-grid">
            <div class="admin-stat-card">
                <div class="admin-stat-info">
                    <h3>处理订单总量</h3>
                    <p>${orders.size()} 笔</p>
                </div>
                <div class="admin-stat-icon">📊</div>
            </div>
            <div class="admin-stat-card">
                <div class="admin-stat-info">
                    <h3>前后台连接状态</h3>
                    <p style="font-size: 18px; color: var(--success); font-weight: 800;">连接正常</p>
                </div>
                <div class="admin-stat-icon" style="background: var(--success-light); color: var(--success);">⚡</div>
            </div>
        </div>

        <!-- Filters Form -->
        <div class="admin-form-panel">
            <h3 style="margin: 0 0 16px; font-size: 16px; font-weight: 800; color: var(--gray-900);">🔍 订单条件快速筛选</h3>
            <form class="admin-form-grid" method="get">
                <label>
                    <span>检索关键字</span>
                    <input name="keyword" value="${keyword}" placeholder="订单号 / 手机号 / 入住人" style="background:#fff;">
                </label>
                <label>
                    <span>订单状态</span>
                    <select name="status" style="background:#fff;">
                        <option value="">所有状态</option>
                        <option value="BOOKED" ${status=='BOOKED'?'selected':''}>已预订</option>
                        <option value="CHECKED_IN" ${status=='CHECKED_IN'?'selected':''}>已入住</option>
                        <option value="COMPLETED" ${status=='COMPLETED'?'selected':''}>已完成</option>
                        <option value="CANCELED" ${status=='CANCELED'?'selected':''}>已取消</option>
                    </select>
                </label>
                <button class="btn" type="submit" style="height: 48px; margin-bottom: 0; font-weight: 800;">开始筛选</button>
            </form>
        </div>

        <!-- Table Card -->
        <div class="admin-table-card">
            <table>
                <thead>
                    <tr>
                        <th>订单号</th>
                        <th>预订用户</th>
                        <th>房型名称</th>
                        <th>分配房号</th>
                        <th>入住人姓名</th>
                        <th>入住日期段</th>
                        <th>实付金额</th>
                        <th>状态</th>
                        <th style="width: 170px;">前台日常操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orders}" var="o">
                        <tr>
                            <td style="font-family: monospace; font-weight: 700; color: var(--gray-900);">${o.orderNo}</td>
                            <td>
                                <strong>${o.username}</strong>
                                <span style="display: block; font-size: 12.5px; color: var(--gray-600);">${o.userPhone}</span>
                            </td>
                            <td><span class="tag">${o.typeName}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty o.roomNo}">
                                        <span style="color: var(--gray-600); font-style: italic; font-size: 13px;">到店前台分配</span>
                                    </c:when>
                                    <c:otherwise>
                                        <strong style="color: var(--primary); font-size: 15px;">🚪 ${o.roomNo} 室</strong>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><strong>${o.guestName}</strong></td>
                            <td style="font-size: 13.5px; color: var(--gray-600);">${o.checkinDate} 至 ${o.checkoutDate}</td>
                            <td style="font-weight: 900; color: var(--accent-hover); font-size: 17px;">￥${o.totalAmount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${o.status=='BOOKED'}">
                                        <span class="admin-status-badge cleaning" style="background:var(--primary-light); color:var(--primary);">已预订 🔔</span>
                                    </c:when>
                                    <c:when test="${o.status=='CHECKED_IN'}">
                                        <span class="admin-status-badge free">已入住 🔑</span>
                                    </c:when>
                                    <c:when test="${o.status=='COMPLETED'}">
                                        <span class="admin-status-badge" style="background:var(--gray-100); color:var(--gray-600);">已完成 ✓</span>
                                    </c:when>
                                    <c:when test="${o.status=='CANCELED'}">
                                        <span class="admin-status-badge repair">已取消 ✕</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="admin-status-badge">${o.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div style="display: flex; gap: 6px;">
                                    <c:if test="${o.status=='BOOKED'}">
                                        <a class="btn blue" style="padding: 6px 12px; font-size: 13px; font-weight: 700;" href="${pageContext.request.contextPath}/admin/orders/checkin?id=${o.id}">入住</a>
                                        <a class="btn red" style="padding: 6px 12px; font-size: 13px; font-weight: 700;" href="${pageContext.request.contextPath}/admin/orders/cancel?id=${o.id}" onclick="return confirm('确定要取消此订单吗？')">取消</a>
                                    </c:if>
                                    <c:if test="${o.status=='CHECKED_IN'}">
                                        <a class="btn" style="padding: 6px 12px; font-size: 13px; font-weight: 700; background: var(--success);" href="${pageContext.request.contextPath}/admin/orders/checkout?id=${o.id}">退房</a>
                                    </c:if>
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
