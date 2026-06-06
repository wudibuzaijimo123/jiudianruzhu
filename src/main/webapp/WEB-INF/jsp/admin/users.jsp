<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html><html><head><title>用户管理</title><link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"></head><body>
<div class="top"><h2>用户管理</h2><a href="${pageContext.request.contextPath}/admin/logout">退出</a></div><div class="wrap"><div class="nav"><a href="${pageContext.request.contextPath}/admin/orders">订单</a><a href="${pageContext.request.contextPath}/admin/roomTypes">房型</a><a href="${pageContext.request.contextPath}/admin/rooms">房间</a><a href="${pageContext.request.contextPath}/admin/users">用户</a></div>
<table><tr><th>用户名</th><th>姓名</th><th>手机号</th><th>消费次数</th><th>状态</th><th>操作</th></tr><c:forEach items="${users}" var="u"><tr><td>${u.username}</td><td>${u.realName}</td><td>${u.phone}</td><td>${u.consumeCount}</td><td>${u.status==1?'正常':'禁用'}</td><td><a class="btn ${u.status==1?'red':''}" href="${pageContext.request.contextPath}/admin/users/status?id=${u.id}&status=${u.status==1?0:1}">${u.status==1?'禁用':'启用'}</a></td></tr></c:forEach></table>
</div></body></html>
