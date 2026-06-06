<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html>
<head>
    <title>随心出行 - 酒店预订</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="${pageContext.request.contextPath}/static/js/click-effect.js"></script>
</head>
<body>
<div class="top">
    <h2>随心出行 · 酒店预订</h2>
    <div>
        <c:choose>
            <c:when test="${empty sessionScope.loginUser}">
                <a href="${pageContext.request.contextPath}/login">
                    <svg style="width:16px;height:16px;fill:currentColor" viewBox="0 0 24 24"><path d="M12,4A4,4 0 0,1 16,8A4,4 0 0,1 12,12A4,4 0 0,1 8,8A4,4 0 0,1 12,4M12,14C16.42,14 20,15.79 20,18V20H4V18C4,15.79 7.58,14 12,14Z"/></svg>
                    登录
                </a>
                <a href="${pageContext.request.contextPath}/register">注册</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/orders">
                    <svg style="width:16px;height:16px;fill:currentColor" viewBox="0 0 24 24"><path d="M19,19H5V8H19M19,3H18V1H16V3H8V1H6V3H5C3.89,3 3,3.9 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V5A2,2 0 0,0 21,3M16.53,11.06L15.47,10L11.59,13.88L9.53,11.82L8.47,12.88L11.59,16L16.53,11.06Z"/></svg>
                    我的订单
                </a>
                <a href="${pageContext.request.contextPath}/profile">
                    <svg style="width:16px;height:16px;fill:currentColor" viewBox="0 0 24 24"><path d="M12,4A4,4 0 0,1 16,8A4,4 0 0,1 12,12A4,4 0 0,1 8,8A4,4 0 0,1 12,4M12,14C16.42,14 20,15.79 20,18V20H4V18C4,15.79 7.58,14 12,14Z"/></svg>
                    个人中心
                </a>
                <a href="${pageContext.request.contextPath}/logout" style="color: var(--error);">退出</a>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/admin/login">
            <svg style="width:16px;height:16px;fill:currentColor" viewBox="0 0 24 24"><path d="M12,15C11.45,15 11,15.45 11,16C11,16.55 11.45,17 12,17C12.55,17 13,16.55 13,16C13,15.45 12.55,15 12,15M19,8H18V6A6,6 0 0,0 12,0A6,6 0 0,0 6,6V8H5C3.89,8 3,8.89 3,10V20C3,21.11 3.89,22 5,22H19C20.11,22 21,21.11 21,20V10C21,8.89 20.11,8 19,8M8,6A4,4 0 0,1 12,2A4,4 0 0,1 16,6V8H8V6M19,20H5V10H19V20Z"/></svg>
            管理后台
        </a>
    </div>
</div>

<div class="hero-search" style="position: relative; background: none; box-shadow: none; overflow: hidden;">
    <div class="carousel-slide" style="background-image: linear-gradient(rgba(0,0,0,0.35), rgba(0,0,0,0.55)), url('https://images.unsplash.com/photo-1566073771259-6a8506099945'); position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-size: cover; background-position: center; transition: opacity 1.2s ease-in-out; opacity: 1; z-index: 1;"></div>
    <div class="carousel-slide" style="background-image: linear-gradient(rgba(0,0,0,0.35), rgba(0,0,0,0.55)), url('https://images.unsplash.com/photo-1582719478250-c89cae4dc85b'); position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-size: cover; background-position: center; transition: opacity 1.2s ease-in-out; opacity: 0; z-index: 1;"></div>
    <div class="carousel-slide" style="background-image: linear-gradient(rgba(0,0,0,0.35), rgba(0,0,0,0.55)), url('https://images.unsplash.com/photo-1578683010236-d716f9a3f461'); position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-size: cover; background-position: center; transition: opacity 1.2s ease-in-out; opacity: 0; z-index: 1;"></div>
    
    <div class="wrap" style="position: relative; z-index: 10; padding: 24px 18px 0;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; flex-wrap: wrap; gap: 16px;">
            <div class="slogan" style="text-align: left; margin: 0; color: #fff; text-shadow: 0 2px 10px rgba(0,0,0,0.55); flex: 1; min-width: 280px;">
                <h1 style="margin: 0; font-size: 32px; font-weight: 900;">随心在手，想走就走</h1>
                <p style="margin: 8px 0 0; font-size: 16px; opacity: 0.95;">✨ 预订精选自营酒店，尊享优质服务与安心入住体验</p>
            </div>
            <div class="hero-mascot" style="flex-shrink: 0;">
                <img src="${pageContext.request.contextPath}/static/img/homelander.png" alt="Mascot" style="width: 90px; height: auto; filter: drop-shadow(0 8px 16px rgba(0,0,0,0.35));">
            </div>
        </div>
        <div class="search-box-container">
            <form action="${pageContext.request.contextPath}/rooms" method="get">
                <div class="search-line">
                    <div class="search-input">
                        <svg style="width: 20px; height: 20px; fill: var(--gray-600)" viewBox="0 0 24 24"><path d="M9.5,3A6.5,6.5 0 0,1 16,9.5C16,11.11 15.41,12.59 14.44,13.73L14.71,14H15.5L20.5,19L19,20.5L14,15.5V14.71L13.73,14.44C12.59,15.41 11.11,16 9.5,16A6.5,6.5 0 0,1 3,9.5A6.5,6.5 0 0,1 9.5,3M9.5,5C7,5 5,7 5,9.5C5,12 7,14 9.5,14C12,14 14,12 14,9.5C14,7 12,5 9.5,5Z" /></svg>
                        <input name="keyword" value="${keyword}" placeholder="搜索房型名称、床型或位置关键词...">
                    </div>
                    <button class="yellow" type="submit">开始搜索</button>
                </div>
                
                <div class="date-line" style="grid-template-columns: repeat(4, 1fr); gap: 16px; margin-top: 16px;">
                    <label>
                        <span>📅 入住日期</span>
                        <input type="date" name="checkinDate" value="${checkinDate}">
                    </label>
                    <label>
                        <span>📅 离店日期</span>
                        <input type="date" name="checkoutDate" value="${checkoutDate}">
                    </label>
                    <label>
                        <span>🛌 房型分类</span>
                        <select name="category" onchange="this.form.submit()">
                            <option value="">全部房型</option>
                            <option value="大床房" ${category=='大床房'?'selected':''}>大床房</option>
                            <option value="双床房" ${category=='双床房'?'selected':''}>双床房</option>
                            <option value="电竞房" ${category=='电竞房'?'selected':''}>电竞房</option>
                            <option value="亲子房" ${category=='亲子房'?'selected':''}>亲子房</option>
                            <option value="套房" ${category=='套房'?'selected':''}>套房</option>
                        </select>
                    </label>
                    <label>
                        <span>💰 单晚预算上限</span>
                        <input type="number" name="maxPrice" value="${maxPrice}" placeholder="不限">
                    </label>
                </div>
                
                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 16px; padding-top: 16px; border-top: 1px dashed var(--gray-200);">
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <span style="font-size: 13.5px; font-weight: 700; color: var(--gray-600);">💡 排序推荐：</span>
                        <select name="sort" onchange="this.form.submit()" style="width: 160px; margin: 0; padding: 8px 12px; background: var(--gray-50); border: 1.5px solid var(--gray-200); border-radius: var(--radius-md); font-weight: 700; font-size: 14px;">
                            <option value="priceAsc" ${sort=='priceAsc'?'selected':''}>低价优先 💰</option>
                            <option value="rating" ${sort=='rating'?'selected':''}>评分优先 ⭐</option>
                            <option value="priceDesc" ${sort=='priceDesc'?'selected':''}>高价优先 💎</option>
                        </select>
                    </div>
                    <button class="btn" type="submit" style="padding: 10px 32px; background: var(--primary); font-weight: 800; font-size: 15px; border-radius: var(--radius-md);">
                        立即筛选房源
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="wrap">
    <div class="quick">
        <a class="chip ${empty category?'active':''}" href="${pageContext.request.contextPath}/rooms?checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">全部房型</a>
        <a class="chip ${category=='大床房'?'active':''}" href="${pageContext.request.contextPath}/rooms?category=大床房&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">大床房 🛏️</a>
        <a class="chip ${category=='双床房'?'active':''}" href="${pageContext.request.contextPath}/rooms?category=双床房&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">双床房 👥</a>
        <a class="chip ${category=='电竞房'?'active':''}" href="${pageContext.request.contextPath}/rooms?category=电竞房&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">电竞房 🎮</a>
        <a class="chip ${category=='亲子房'?'active':''}" href="${pageContext.request.contextPath}/rooms?category=亲子房&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">亲子房 👶</a>
        <a class="chip ${category=='套房'?'active':''}" href="${pageContext.request.contextPath}/rooms?category=套房&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">套房 👑</a>
    </div>

    <!-- Service Guarantees to balance top-heavy layout -->
    <div class="guarantees-grid">
        <div class="guarantee-card">
            <div class="guarantee-card-icon">🛡️</div>
            <h4>安心房源</h4>
            <p>100% 官方自营真实客房，严控消毒卫生指标，放心入住</p>
        </div>
        <div class="guarantee-card">
            <div class="guarantee-card-icon">🥞</div>
            <h4>精致就餐</h4>
            <p>主厨精选营养早餐，唤醒每日元气，尊享星级服务</p>
        </div>
        <div class="guarantee-card">
            <div class="guarantee-card-icon">⚡</div>
            <h4>急速确认</h4>
            <p>支付后自动流转分配物理房间号，到店免押金极速分房</p>
        </div>
        <div class="guarantee-card">
            <div class="guarantee-card-icon">📞</div>
            <h4>金牌服务</h4>
            <p>7×24小时贴心在线旅客客服，有求必应，无忧售后</p>
        </div>
    </div>

    <div class="hotel-list">
        <c:forEach items="${roomTypes}" var="rt">
            <a class="hotel-card" href="${pageContext.request.contextPath}/room/detail?id=${rt.id}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">
                <div class="hotel-card-image-container">
                    <c:set var="firstImage" value="${fn:split(rt.imageUrl, ',')[0]}" />
                    <img src="${empty firstImage ? 'https://images.unsplash.com/photo-1566073771259-6a8506099945' : firstImage}" alt="${rt.typeName}">
                    <span class="tag-self-run">随心金牌自营</span>
                </div>
                <div class="hotel-content">
                    <div>
                        <div class="hotel-title">
                            <h3>${rt.typeName}</h3>
                            <div class="score-container">
                                <span class="score">${rt.rating}</span>
                                <span class="score-text">
                                    <c:choose>
                                        <c:when test="${rt.rating >= 4.8}">棒极了 · 极佳</c:when>
                                        <c:when test="${rt.rating >= 4.5}">非常棒 · 超赞</c:when>
                                        <c:when test="${rt.rating >= 4.0}">很好 · 推荐</c:when>
                                        <c:otherwise>不错 · 舒适</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                        <div class="subtitle">${rt.category} · ${rt.starLevel} · 可住 ${rt.capacity} 人</div>
                        <div class="meta">
                            <svg style="width:16px;height:16px;fill:var(--gray-600)" viewBox="0 0 24 24"><path d="M12,2C15.31,2 18,4.66 18,7.95C18,12.41 12,19 12,19C12,19 6,12.41 6,7.95C6,4.66 8.69,2 12,2M12,6A2,2 0 0,0 10,8A2,2 0 0,0 12,10A2,2 0 0,0 14,8A2,2 0 0,0 12,6Z"/></svg>
                            <span>${rt.distanceText}</span>
                            <span style="color:var(--gray-300);">|</span>
                            <span>${rt.bedType}</span>
                        </div>
                        <div style="margin: 8px 0;">
                            <p style="margin: 0; font-size: 13.5px; color: var(--gray-600); line-height: 1.5;">“${rt.description}”</p>
                        </div>
                        <div class="tag-list">
                            <c:if test="${not empty rt.breakfast}">
                                <span class="tag" style="background:#fff5e6; color:#ff9a14; border-color:rgba(255,154,20,0.2)">🥞 ${rt.breakfast}</span>
                            </c:if>
                            <c:forTokens items="${rt.tags}" delims="," var="tag">
                                <span class="tag">✓ ${tag}</span>
                            </c:forTokens>
                        </div>
                    </div>
                    <div class="price-row">
                        <div>
                            <span class="available">当前余房 ${rt.availableCount} 间</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <c:if test="${not empty rt.originalPrice}">
                                <span class="old">￥${rt.originalPrice}</span>
                            </c:if>
                            <div>
                                <span class="price" style="font-size: 28px; font-weight: 900; color: var(--accent-hover);">￥${rt.price}</span>
                                <span class="price-unit">/晚起</span>
                            </div>
                            <c:if test="${not empty rt.promotion}">
                                <span class="promo">🎁 ${rt.promotion}</span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>
</div>
<jsp:include page="footer.jsp" />
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var slides = document.querySelectorAll(".carousel-slide");
        var currentIndex = 0;
        if (slides && slides.length > 1) {
            setInterval(function() {
                slides[currentIndex].style.opacity = 0;
                currentIndex = (currentIndex + 1) % slides.length;
                slides[currentIndex].style.opacity = 1;
            }, 4000);
        }
    });
</script>
</body>
</html>
