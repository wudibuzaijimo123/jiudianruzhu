<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>后台房型管理 - 随心出行</title>
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
                <a href="${pageContext.request.contextPath}/admin/roomTypes" class="admin-nav-item active">
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
            <h2>房型产品目录维护</h2>
            <div style="font-size: 14.5px; color: var(--gray-600); font-weight: 600;">随心出行 · 运营中心</div>
        </div>

        <!-- Stats Grid -->
        <div class="admin-stats-grid">
            <div class="admin-stat-card">
                <div class="admin-stat-info">
                    <h3>已录入房型</h3>
                    <p>${roomTypes.size()} 类</p>
                </div>
                <div class="admin-stat-icon">🛌</div>
            </div>
            <div class="admin-stat-card">
                <div class="admin-stat-info">
                    <h3>客房状态系统</h3>
                    <p style="font-size: 18px; color: var(--success); font-weight: 800;">销售中</p>
                </div>
                <div class="admin-stat-icon" style="background: var(--success-light); color: var(--success);">✔</div>
            </div>
        </div>

        <!-- Add Form Panel -->
        <div class="admin-form-panel">
            <h3 style="margin: 0 0 16px; font-size: 16px; font-weight: 800; color: var(--gray-900);">➕ 新增房型产品</h3>
            <form method="post" action="${pageContext.request.contextPath}/admin/roomTypes/save">
                <div class="admin-form-grid" style="grid-template-columns: repeat(auto-fit, minmax(130px, 1fr));">
                    <label>
                        <span>房型名称 *</span>
                        <input name="typeName" required placeholder="如：尊贵大床房">
                    </label>
                    <label>
                        <span>图片地址</span>
                        <input name="imageUrl" placeholder="HTTPS 图片路径">
                    </label>
                    <label>
                        <span>单晚价格 *</span>
                        <input name="price" type="number" required placeholder="￥ 售价">
                    </label>
                    <label>
                        <span>床型规格</span>
                        <input name="bedType" placeholder="如：1.8米大床">
                    </label>
                    <label>
                        <span>可住人数</span>
                        <input name="capacity" type="number" value="2">
                    </label>
                    <label>
                        <span>早餐安排</span>
                        <input name="breakfast" value="含早餐">
                    </label>
                    <label>
                        <span>配套设施</span>
                        <input name="facilities" placeholder="无线宽带、独立卫浴">
                    </label>
                    <label>
                        <span>初始状态</span>
                        <select name="status">
                            <option value="1">立即上架</option>
                            <option value="0">暂不上架</option>
                        </select>
                    </label>
                </div>
                <div style="margin-top: 16px; text-align: right;">
                    <button class="btn" type="submit" style="font-weight: 800; padding: 10px 24px;">保存并上架</button>
                </div>
            </form>
        </div>

        <!-- Table Card -->
        <div class="admin-table-card">
            <table>
                <thead>
                    <tr>
                        <th>房型名称</th>
                        <th>价格（每晚）</th>
                        <th>床型规格</th>
                        <th>可住容量</th>
                        <th>销售状态</th>
                        <th style="width: 160px; text-align: center;">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${roomTypes}" var="r">
                        <tr>
                            <td>
                                <strong style="font-size: 15px; color: var(--gray-900);">${r.typeName}</strong>
                            </td>
                            <td style="font-weight: 800; color: var(--accent-hover); font-size: 16px;">￥${r.price}</td>
                            <td>${r.bedType}</td>
                            <td><strong>${r.capacity} 人</strong></td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.status==1}">
                                        <span class="admin-status-badge free">🟢 上架销售中</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="admin-status-badge" style="background:var(--gray-100); color:var(--gray-600);">⚪ 已下架封存</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="text-align: center;">
                                <div style="display: flex; gap: 6px; justify-content: center;">
                                    <a class="btn gray" style="padding: 6px 12px; font-size: 13px; font-weight: 700;" href="${pageContext.request.contextPath}/admin/roomTypes/status?id=${r.id}&status=${r.status==1?0:1}">
                                        ${r.status==1?'下架':'上架'}
                                    </a>
                                    <a class="btn red" style="padding: 6px 12px; font-size: 13px; font-weight: 700;" href="${pageContext.request.contextPath}/admin/roomTypes/delete?id=${r.id}" onclick="return confirm('确定要删除此房型吗？删除可能会级联影响订单展示')">
                                        删除
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
