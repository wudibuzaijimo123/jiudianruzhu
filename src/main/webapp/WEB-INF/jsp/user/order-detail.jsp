<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>订单详情 - 随心出行</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="${pageContext.request.contextPath}/static/js/click-effect.js"></script>
</head>
<body>
<div class="top">
    <h2>订单详情</h2>
    <a href="${pageContext.request.contextPath}/orders">
        <svg style="width:16px;height:16px;fill:currentColor" viewBox="0 0 24 24"><path d="M20,11H7.83L13.41,5.41L12,4L4,12L12,20L13.41,18.59L7.83,13H20V11Z"/></svg>
        返回订单列表
    </a>
</div>

<div class="wrap" style="max-width: 680px;">
    <div class="panel" style="padding: 0; overflow: hidden; border-radius: var(--radius-lg); box-shadow: var(--shadow-lg);">
        <c:choose>
            <c:when test="${order.status=='BOOKED'}">
                <div style="background: linear-gradient(135deg, var(--primary) 0%, #4364f7 100%); color: white; padding: 30px; text-align: center;">
                    <h2 style="margin: 0; font-size: 24px; font-weight: 800;">🔔 已预订成功</h2>
                    <p style="margin: 8px 0 0; opacity: 0.9; font-size: 14px;">房间已为您保留，请凭入住人身份证件到前台办理入住</p>
                </div>
            </c:when>
            <c:when test="${order.status=='CHECKED_IN'}">
                <div style="background: linear-gradient(135deg, var(--success) 0%, #059669 100%); color: white; padding: 30px; text-align: center;">
                    <h2 style="margin: 0; font-size: 24px; font-weight: 800;">🔑 您已成功入住</h2>
                    <p style="margin: 8px 0 0; opacity: 0.9; font-size: 14px;">已分配房间号，祝您入住愉快！如有任何需要请致电前台</p>
                </div>
            </c:when>
            <c:when test="${order.status=='COMPLETED'}">
                <div style="background: linear-gradient(135deg, var(--gray-600) 0%, var(--gray-800) 100%); color: white; padding: 30px; text-align: center;">
                    <h2 style="margin: 0; font-size: 24px; font-weight: 800;">✓ 订单已完成</h2>
                    <p style="margin: 8px 0 0; opacity: 0.9; font-size: 14px;">感谢您选择入住，欢迎再次预订</p>
                </div>
            </c:when>
            <c:when test="${order.status=='CANCELED'}">
                <div style="background: linear-gradient(135deg, var(--error) 0%, #dc2626 100%); color: white; padding: 30px; text-align: center;">
                    <h2 style="margin: 0; font-size: 24px; font-weight: 800;">✕ 订单已取消</h2>
                    <p style="margin: 8px 0 0; opacity: 0.9; font-size: 14px;">该笔订单已全额退回，欢迎随时重新预订其他房型</p>
                </div>
            </c:when>
            <c:otherwise>
                <div style="background: var(--primary); color: white; padding: 30px; text-align: center;">
                    <h2 style="margin: 0; font-size: 24px; font-weight: 800;">${order.status}</h2>
                </div>
            </c:otherwise>
        </c:choose>
        
        <div style="padding: 30px;">
            <div style="border-bottom: 2px solid var(--gray-100); padding-bottom: 20px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h3 style="margin: 0; font-size: 20px; font-weight: 800; color: var(--gray-900);">${order.typeName}</h3>
                    <span class="subtitle" style="margin-top: 6px; font-size: 12px; display: inline-block;">精选品质房源</span>
                </div>
                <div style="text-align: right;">
                    <span style="font-size: 12px; color: var(--gray-600); display: block;">订单总价</span>
                    <strong style="font-size: 26px; color: var(--accent-hover); font-weight: 900;">￥${order.totalAmount}</strong>
                </div>
            </div>
            
            <div class="order-line">
                <span>订单编号</span>
                <strong>${order.orderNo}</strong>
            </div>
            <div class="order-line">
                <span>房间安排</span>
                <strong style="color: var(--primary);">
                    <c:choose>
                        <c:when test="${empty order.roomNo}">
                            🚪 到店前台分配
                        </c:when>
                        <c:otherwise>
                            🚪 ${order.roomNo} 号房
                        </c:otherwise>
                    </c:choose>
                </strong>
            </div>
            <div class="order-line">
                <span>入住日期</span>
                <strong>${order.checkinDate}</strong>
            </div>
            <div class="order-line">
                <span>退房日期</span>
                <strong>${order.checkoutDate}</strong>
            </div>
            <div class="order-line">
                <span>入住天数</span>
                <strong>${order.nights} 晚</strong>
            </div>
            <div class="order-line">
                <span>入住人姓名</span>
                <strong>${order.guestName}</strong>
            </div>
            <div class="order-line">
                <span>联系手机号</span>
                <strong>${order.guestPhone}</strong>
            </div>
            <div class="order-line">
                <span>证件号码</span>
                <strong>${order.guestIdCard}</strong>
            </div>
            
            <div style="margin-top: 30px; display: flex; gap: 12px; justify-content: center;">
                <button onclick="window.print()" class="btn gray" style="flex: 1; font-weight: 700; height: 44px; display: flex; align-items: center; justify-content: center; gap: 8px;">
                    🖨️ 打印订单凭证
                </button>
                <a href="${pageContext.request.contextPath}/rooms" class="btn" style="flex: 1; font-weight: 700; height: 44px; display: flex; align-items: center; justify-content: center;">
                    去浏览其他房型
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
