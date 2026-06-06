<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>酒店查询</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="top">
    <h2>酒店</h2>
    <div>
        <c:choose>
            <c:when test="${empty sessionScope.loginUser}">
                <a href="${pageContext.request.contextPath}/login">登录</a>
                <a href="${pageContext.request.contextPath}/register">注册</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/orders">行程/订单</a>
                <a href="${pageContext.request.contextPath}/profile">我的</a>
                <a href="${pageContext.request.contextPath}/logout">退出</a>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/admin/login">后台</a>
    </div>
</div>

<div class="hero-search">
    <div class="wrap">
        <form action="${pageContext.request.contextPath}/rooms" method="get">
            <div class="search-line">
                <div class="search-input">🔍<input name="keyword" value="${keyword}" placeholder="搜索房型名称、床型或设施"></div>
                <button class="yellow" type="submit">查找</button>
            </div>
            <div class="date-line">
                <label>入住<input type="date" name="checkinDate" value="${checkinDate}"></label>
                <label>离店<input type="date" name="checkoutDate" value="${checkoutDate}"></label>
                <label>价格
                    <select name="sort">
                        <option value="priceAsc" ${sort=='priceAsc'?'selected':''}>低价优先</option>
                        <option value="rating" ${sort=='rating'?'selected':''}>评分优先</option>
                        <option value="priceDesc" ${sort=='priceDesc'?'selected':''}>高价优先</option>
                    </select>
                </label>
            </div>
            <div class="quick">
                <a class="chip ${empty category?'active':''}" href="${pageContext.request.contextPath}/rooms?checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">全部房型</a>
                <a class="chip ${category=='大床房'?'active':''}" href="${pageContext.request.contextPath}/rooms?category=大床房&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">大床房</a>
                <a class="chip ${category=='双床房'?'active':''}" href="${pageContext.request.contextPath}/rooms?category=双床房&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">双床房</a>
                <a class="chip ${category=='电竞房'?'active':''}" href="${pageContext.request.contextPath}/rooms?category=电竞房&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">电竞房</a>
                <a class="chip ${category=='亲子房'?'active':''}" href="${pageContext.request.contextPath}/rooms?category=亲子房&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">亲子房</a>
                <a class="chip ${category=='套房'?'active':''}" href="${pageContext.request.contextPath}/rooms?category=套房&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">套房</a>
            </div>
            <div class="filter-panel">
                <label>房型分类
                    <select name="category">
                        <option value="">全部</option>
                        <option value="大床房" ${category=='大床房'?'selected':''}>大床房</option>
                        <option value="双床房" ${category=='双床房'?'selected':''}>双床房</option>
                        <option value="电竞房" ${category=='电竞房'?'selected':''}>电竞房</option>
                        <option value="亲子房" ${category=='亲子房'?'selected':''}>亲子房</option>
                        <option value="套房" ${category=='套房'?'selected':''}>套房</option>
                    </select>
                </label>
                <label>价格不高于<input type="number" name="maxPrice" value="${maxPrice}" placeholder="不限"></label>
                <button class="btn gray" type="submit">筛选</button>
            </div>
        </form>
    </div>
</div>

<div class="wrap">
    <div class="hotel-list">
        <c:forEach items="${roomTypes}" var="rt">
            <a class="hotel-card" href="${pageContext.request.contextPath}/room/detail?id=${rt.id}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}">
                <img src="${empty rt.imageUrl ? 'https://images.unsplash.com/photo-1566073771259-6a8506099945' : rt.imageUrl}" alt="${rt.typeName}">
                <div>
                    <div class="hotel-title">
                        <h3>${rt.typeName}</h3>
                        <span class="score">${rt.rating}</span>
                    </div>
                    <div class="subtitle">${rt.category} · ${rt.starLevel} · “${rt.description}”</div>
                    <div class="meta">${rt.distanceText} · ${rt.bedType} · 可住 ${rt.capacity} 人</div>
                    <div>
                        <c:forTokens items="${rt.tags}" delims="," var="tag"><span class="tag">${tag}</span></c:forTokens>
                    </div>
                    <div class="price-row">
                        <div><span class="available">当前可订 ${rt.availableCount} 间</span></div>
                        <div><span class="price">￥${rt.price}</span> /晚</div>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>
</div>
</body>
</html>
