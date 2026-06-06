<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>我的行程订单 - 随心出行</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="top">
    <h2>我的订单</h2>
    <a href="${pageContext.request.contextPath}/rooms">
        <svg style="width:16px;height:16px;fill:currentColor" viewBox="0 0 24 24"><path d="M10,20V14H14V20H19V12H22L12,3L2,12H5V20H10Z"/></svg>
        返回首页
    </a>
</div>

<div class="wrap" style="max-width: 960px;">
    <div class="order-page-head">
        <h1 style="display: flex; align-items: center; gap: 10px;">
            🧳 您的行程订单
        </h1>
        <p>在此管理和查看您所有的预订记录、入住进程及历史订单明细。</p>
    </div>
    
    <div class="order-list">
        <c:choose>
            <c:when test="${empty orders}">
                <div class="panel" style="text-align: center; padding: 48px; color: var(--gray-600);">
                    <svg style="width:64px;height:64px;fill:var(--gray-300);margin-bottom:16px;" viewBox="0 0 24 24"><path d="M19 3H5C3.9 3 3 3.9 3 5V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3M19 19H5V5H19V19M17 12H7V10H17V12M14 16H7V14H14V16M17 8H7V6H17V8Z"/></svg>
                    <p style="margin: 0; font-size: 16px; font-weight: 700;">您目前还没有任何订单记录</p>
                    <a href="${pageContext.request.contextPath}/rooms" class="btn" style="margin-top: 16px; display: inline-block;">立即去订房</a>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${orders}" var="o">
                    <div class="order-item">
                        <div class="order-main">
                            <div style="flex: 1;">
                                <h3 style="margin: 0 0 8px; color: var(--gray-900); font-weight: 800;">${o.typeName}</h3>
                                <p style="margin: 6px 0; color: var(--gray-600); font-size: 14px; display: flex; align-items: center; gap: 6px; flex-wrap: wrap;">
                                    <span>📅 <strong>${o.checkinDate}</strong> 至 <strong>${o.checkoutDate}</strong></span>
                                    <span style="color:var(--gray-300)">|</span>
                                    <span>🌙 共 <strong>${o.nights}</strong> 晚</span>
                                    <span style="color:var(--gray-300)">|</span>
                                    <span>👤 入住人：<strong>${o.guestName}</strong></span>
                                </p>
                                <small style="color: var(--gray-600);">订单编号：${o.orderNo}</small>
                            </div>
                            
                            <c:choose>
                                <c:when test="${o.status=='BOOKED'}">
                                    <span class="status-pill" style="background: var(--primary-light); color: var(--primary); border: 1.5px solid rgba(0, 134, 246, 0.2);">已预订 🔔</span>
                                </c:when>
                                <c:when test="${o.status=='CHECKED_IN'}">
                                    <span class="status-pill" style="background: var(--success-light); color: var(--success); border: 1.5px solid rgba(16, 185, 129, 0.2);">已入住 🔑</span>
                                </c:when>
                                <c:when test="${o.status=='COMPLETED'}">
                                    <span class="status-pill" style="background: var(--gray-50); color: var(--gray-600); border: 1.5px solid var(--gray-200);">已完成 ✓</span>
                                </c:when>
                                <c:when test="${o.status=='CANCELED'}">
                                    <span class="status-pill" style="background: var(--error-light); color: var(--error); border: 1.5px solid rgba(239, 68, 68, 0.2);">已取消 ✕</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-pill">${o.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="order-actions">
                            <strong>￥${o.totalAmount}</strong>
                            <div style="display: flex; gap: 8px; flex-direction: row;">
                                <a class="btn blue" href="${pageContext.request.contextPath}/orders/detail?id=${o.id}">查看详情</a>
                                <c:if test="${o.status=='BOOKED'}">
                                    <a class="btn red" href="${pageContext.request.contextPath}/orders/cancel?id=${o.id}" onclick="return confirm('确认取消该笔订单吗？')">取消订单</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
