<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>后台房间管理 - 随心出行</title>
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
                <a href="${pageContext.request.contextPath}/admin/rooms" class="admin-nav-item active">
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
            <h2>实体房间状态监控</h2>
            <div style="font-size: 14.5px; color: var(--gray-600); font-weight: 600;">随心出行 · 运营中心</div>
        </div>

        <!-- Stats Grid -->
        <div class="admin-stats-grid">
            <div class="admin-stat-card">
                <div class="admin-stat-info">
                    <h3>已登记实体房</h3>
                    <p>${rooms.size()} 间</p>
                </div>
                <div class="admin-stat-icon">🚪</div>
            </div>
            <div class="admin-stat-card">
                <div class="admin-stat-info">
                    <h3>状态调度机制</h3>
                    <p style="font-size: 18px; color: var(--success); font-weight: 800;">即时刷新</p>
                </div>
                <div class="admin-stat-icon" style="background: var(--success-light); color: var(--success);">⚡</div>
            </div>
        </div>

        <!-- Add Room Form Panel -->
        <div class="admin-form-panel">
            <h3 style="margin: 0 0 16px; font-size: 16px; font-weight: 800; color: var(--gray-900);">➕ 录入实体房间</h3>
            <form method="post" action="${pageContext.request.contextPath}/admin/rooms/save">
                <div class="admin-form-grid" style="grid-template-columns: 1.5fr 1fr 1fr 1.2fr;">
                    <label>
                        <span>所属房型 *</span>
                        <select name="roomTypeId" style="background:#fff;">
                            <c:forEach items="${roomTypes}" var="rt">
                                <option value="${rt.id}">${rt.typeName} (￥${rt.price})</option>
                            </c:forEach>
                        </select>
                    </label>
                    <label>
                        <span>房间号码 *</span>
                        <input name="roomNo" required placeholder="如：8808">
                    </label>
                    <label>
                        <span>所在楼层</span>
                        <input name="floorNo" placeholder="如：8">
                    </label>
                    <label>
                        <span>初始状态</span>
                        <select name="status" style="background:#fff;">
                            <option value="FREE">空闲 (可分配/可售)</option>
                            <option value="CLEANING">清洁中</option>
                            <option value="REPAIR">维修中</option>
                        </select>
                    </label>
                </div>
                <div style="margin-top: 16px; text-align: right;">
                    <button class="btn" type="submit" style="font-weight: 800; padding: 10px 24px;">保存录入房间</button>
                </div>
            </form>
        </div>

        <!-- Table Card -->
        <div class="admin-table-card">
            <table>
                <thead>
                    <tr>
                        <th>房间号码</th>
                        <th>所属客房房型</th>
                        <th>所在物理楼层</th>
                        <th>当前客房状态</th>
                        <th style="width: 250px; text-align: center;">操作（状态调度及清理）</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${rooms}" var="r">
                        <tr>
                            <td>
                                <strong style="font-size: 16px; color: var(--gray-900);">🚪 ${r.roomNo} 室</strong>
                            </td>
                            <td><span class="tag">${r.typeName}</span></td>
                            <td><strong>${r.floorNo} 层</strong></td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.status=='FREE'}">
                                        <span class="admin-status-badge free">🟢 空闲中 (可预订)</span>
                                    </c:when>
                                    <c:when test="${r.status=='CLEANING'}">
                                        <span class="admin-status-badge cleaning">🧹 清洁整理中</span>
                                    </c:when>
                                    <c:when test="${r.status=='REPAIR'}">
                                        <span class="admin-status-badge repair">🛠️ 设备维修中</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="admin-status-badge">${r.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="text-align: center;">
                                <div style="display: flex; gap: 4px; justify-content: center;">
                                    <a class="btn blue" style="padding: 5px 10px; font-size: 12.5px; font-weight: 700;" href="${pageContext.request.contextPath}/admin/rooms/status?id=${r.id}&status=FREE">空闲</a>
                                    <a class="btn gray" style="padding: 5px 10px; font-size: 12.5px; font-weight: 700; background: #e2e8f0; color: #334155;" href="${pageContext.request.contextPath}/admin/rooms/status?id=${r.id}&status=CLEANING">清洁</a>
                                    <a class="btn red" style="padding: 5px 10px; font-size: 12.5px; font-weight: 700;" href="${pageContext.request.contextPath}/admin/rooms/status?id=${r.id}&status=REPAIR">维修</a>
                                    <span style="color:var(--gray-300); margin: 0 4px; align-self: center;">|</span>
                                    <a class="btn red" style="padding: 5px 10px; font-size: 12.5px; font-weight: 700; background: var(--error); color: white;" href="${pageContext.request.contextPath}/admin/rooms/delete?id=${r.id}" onclick="return confirm('确定要彻底删除该实体房间吗？')">删除</a>
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
