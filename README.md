# 酒店预定管理系统

基于 SSM（Spring + Spring MVC + MyBatis）框架开发的酒店预定管理系统，实现酒店房型查询、在线预定、订单管理、后台房型房间维护、入住退房处理等功能。

## 项目信息



## 技术栈

| 类别 | 技术 |

|------|------|
| 语言 | Java 8 |
| 框架 | Spring 5.3.23, Spring MVC 5.3.23, MyBatis 3.5.11 |
| 数据库 | MySQL |
| 前端 | JSP / JSTL / CSS |
| 构建 | Maven |
| 部署 | Tomcat |

## 功能模块

### 前台用户

| 模块 | 功能 |
|------|------|
| 账号管理 | 用户注册、登录、退出、个人资料维护 |
| 房型浏览 | 房型列表查询、按日期/分类/价格筛选、房型详情查看 |
| 订单管理 | 在线提交预定订单、我的订单列表、订单详情查看、取消未入住订单 |
| 防重复预定 | 同一账号同一时间段重复预定限制 |

### 后台管理员

| 模块 | 功能 |
|------|------|
| 登录 | 管理员登录 |
| 房型管理 | 房型信息管理、房型上下架 |
| 房间管理 | 具体房间管理、房间状态维护 |
| 订单管理 | 全部订单查询、取消异常订单 |
| 入住管理 | 办理入住、办理退房 |
| 用户管理 | 用户账号查看与禁用/启用 |

## 数据库

### 连接配置

| 项目 | 值 |
|------|-----|
| 数据库名 | `jiudianruzhu` |
| Host | 127.0.0.1 |
| Port | 3306 |
| Username | root |
| Password | 123456 |

### 核心数据表

| 表名 | 说明 |
|------|------|
| `sys_user` | 前台用户表 |
| `sys_admin` | 后台管理员表 |
| `room_type` | 房型表 |
| `room` | 具体房间表 |
| `booking_order` | 预定订单表 |

### 初始化脚本

```
src/main/resources/sql/jiudianruzhu.sql
```

## 测试账号

| 角色 | 账号 | 密码 |
|------|------|------|
| 前台用户 | user | 123456 |
| 后台管理员 | admin | 123456 |

## 运行方式

### 前提条件

- JDK 8+
- Maven
- Tomcat
- MySQL

### 步骤

1. 使用 MySQL 客户端连接数据库。
2. 执行 `src/main/resources/sql/jiudianruzhu.sql` 初始化数据库。
3. 使用 IntelliJ IDEA 打开项目，等待 Maven 依赖下载完成。
4. 配置 Tomcat 本地服务器，以 `war exploded` 方式部署。
5. 建议将 Application Context 设置为 `/jiudianruzhu`。
6. 启动 Tomcat。

### 访问地址

| 页面 | 地址 |
|------|------|
| 首页 | http://localhost:8080/jiudianruzhu/rooms |
| 后台登录 | http://localhost:8080/jiudianruzhu/admin/login |

## 项目结构

```
src/main/java/com/example/jiudianruzhu/
├── controller/        # 控制层
├── entity/            # 实体类
├── mapper/            # MyBatis 数据访问层
├── service/           # 业务接口
│   └── impl/          # 业务实现
└── util/              # 工具类

src/main/resources/
├── db.properties
├── spring-context.xml
├── spring-mvc.xml
├── spring-mybatis.xml
└── sql/
    └── jiudianruzhu.sql

src/main/webapp/
├── WEB-INF/
│   ├── jsp/
│   │   ├── admin/     # 后台页面
│   │   └── user/      # 前台页面
│   └── web.xml
└── static/
    └── css/
        └── style.css
```

## 业务流程

1. **房型浏览** → 用户选择入住/退房日期，系统根据房间状态和已有订单计算可预订库存。
2. **提交订单** → 系统再次校验库存，并检查同一账号在同一时间段是否已预订。
3. **入住办理**（管理员）→ 订单状态变更为"已入住"，房间状态变更为"已入住"。
4. **退房办理**（管理员）→ 订单状态变更为"已完成"，房间状态变更为"清洁中"。
5. **取消订单** → 仅允许取消未入住的订单。

## 说明

本项目为《Java EE 开发技术》课程期末作品，重点体现 Spring、Spring MVC、MyBatis 与 MySQL 的综合应用。