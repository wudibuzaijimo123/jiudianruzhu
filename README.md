# 酒店预定管理系统

```bash
mvn tomcat7:run -DskipTests
```

基于 SSM（Spring + Spring MVC + MyBatis）框架开发的酒店预定管理系统，实现酒店房型浏览与筛选、在线预定、订单管理、后台房型/房间维护、入住/退房处理等功能。

## 技术栈2

| 类别 | 技术 |
|------|------|
| 语言 | Java 8 |
| 框架 | Spring 5.3.23, Spring MVC 5.3.23, MyBatis 3.5.11 |
| 数据库 | MySQL 8.0, Druid 连接池 |
| 前端 | JSP / JSTL / CSS |
| 构建 | Maven |
| 部署 | Tomcat 7+ / Tomcat 9 |
| 其他 | Lombok, Jackson, SLF4J |

## 项目结构

```
src/main/java/com/example/jiudianruzhu/
├── controller/              # 控制层
│   ├── HomeController.java  # 前台用户请求处理
│   └── AdminController.java # 后台管理员请求处理
├── entity/                  # 实体类
│   ├── User.java            # 前台用户
│   ├── Admin.java           # 后台管理员
│   ├── RoomType.java        # 房型
│   ├── Room.java            # 具体房间
│   └── BookingOrder.java    # 预定订单
├── mapper/                  # MyBatis 数据访问层（Mapper 接口）
├── service/                 # 业务接口
│   └── impl/                # 业务实现
└── util/                    # 工具类
    └── OrderNoUtil.java     # 订单号生成

src/main/resources/
├── db.properties            # 数据库连接配置
├── spring-context.xml       # Spring 核心配置
├── spring-mvc.xml           # Spring MVC 配置
├── spring-mybatis.xml       # MyBatis 整合配置
└── sql/
    └── jiudianruzhu.sql     # 数据库初始化脚本

src/main/webapp/
├── WEB-INF/
│   ├── jsp/
│   │   ├── admin/           # 后台管理页面
│   │   │   ├── login.jsp
│   │   │   ├── orders.jsp
│   │   │   ├── room-types.jsp
│   │   │   ├── rooms.jsp
│   │   │   └── users.jsp
│   │   └── user/            # 前台用户页面
│   │       ├── login.jsp
│   │       ├── register.jsp
│   │       ├── rooms.jsp
│   │       ├── room-detail.jsp
│   │       ├── book.jsp
│   │       ├── orders.jsp
│   │       ├── order-detail.jsp
│   │       └── profile.jsp
│   └── web.xml
└── static/
    ├── css/
    │   └── style.css
    └── js/
        └── click-effect.js
```

## 功能模块

### 前台用户

| 模块 | 功能 |
|------|------|
| 账号管理 | 用户注册、登录、退出、个人资料维护（姓名/手机/身份证） |
| 房型浏览 | 房型列表展示、按日期/分类/关键词/价格区间筛选、按价格/评分排序、房型详情查看 |
| 在线预定 | 选择房型与日期、填写入住人信息、提交订单 |
| 订单管理 | 我的订单列表、订单详情查看、取消未入住订单 |
| 防重复预定 | 同一账号在同一时间段内仅允许一张有效订单 |

### 后台管理员

| 模块 | 功能 |
|------|------|
| 登录 | 管理员后台登录/退出 |
| 房型管理 | 房型信息增删改、房型上下架控制 |
| 房间管理 | 具体房间增删、房间状态维护（空闲/已入住/清洁中/维修中） |
| 订单管理 | 全部订单检索（按订单号/手机号/状态筛选）、取消异常订单 |
| 入住管理 | 为订单分配房间、办理入住 |
| 退房管理 | 办理退房，房间状态自动变更为"清洁中" |
| 用户管理 | 前台用户账号查看与禁用/启用 |

## 业务流程

```
房型浏览 → 选择日期 → 查看详情 → 提交订单
    ↓
  系统校验：库存 / 重复预定 / 用户状态
    ↓
 支付（本系统为到店付款模式）
    ↓
  管理员后台办理入住（房间状态 → 已入住）
    ↓
  管理员后台办理退房（订单 → 已完成，房间 → 清洁中）
```

### 订单状态流转

| 状态 | 说明 |
|------|------|
| `BOOKED` | 已预订（待入住），用户可自行取消 |
| `CHECKED_IN` | 已入住 |
| `CHECKED_OUT` | 已完成（已退房） |
| `CANCELLED` | 已取消 |

### 房间状态

| 状态 | 说明 |
|------|------|
| `FREE` | 空闲 |
| `OCCUPIED` | 已入住 |
| `CLEANING` | 清洁中 |
| `REPAIR` | 维修中 |

## 数据库

### 连接配置

| 项目 | 值 |
|------|-----|
| 数据库名 | `jiudianruzhu` |
| Host | 127.0.0.1 |
| Port | 3306 |
| Username | root |
| Password | 输入你自己的数据库密码 |

### 核心数据表

| 表名 | 说明 |
|------|------|
| `sys_user` | 前台用户表（用户名/密码/姓名/手机/身份证/状态） |
| `sys_admin` | 后台管理员表（用户名/密码/姓名/状态） |
| `room_type` | 房型表（名称/分类/价格/评分/设施/描述/状态） |
| `room` | 具体房间表（所属房型/房间号/楼层/状态） |
| `booking_order` | 预定订单表（订单号/用户/房型/房间/入住信息/日期/金额/状态） |

### 初始化脚本

项目根目录下的 SQL 脚本：
```
src/main/resources/sql/jiudianruzhu.sql
```

## 测试账号

| 角色 | 账号 | 密码 |
|------|------|------|
| 前台用户 | user | 123456 |
| 后台管理员 | admin | 123123 |

## 快速开始

### 前提条件

- JDK 8+
- Maven 3+
- Apache Tomcat 7+ / 9
- MySQL 8.0+

### 运行步骤

1. 使用 MySQL 客户端连接数据库，执行 `src/main/resources/sql/jiudianruzhu.sql` 初始化数据库表结构与测试数据。
2. 使用 IntelliJ IDEA 打开项目，等待 Maven 依赖下载完成。
3. 配置 Tomcat 本地服务器，以 `war exploded` 方式部署。
4. 建议将 Application Context 设置为 `/jiudianruzhu`。
5. 启动 Tomcat。

### 访问地址

| 页面 | 地址 |
|------|------|
| 首页（房型列表） | http://localhost:8080/jiudianruzhu/rooms |
| 用户登录 | http://localhost:8080/jiudianruzhu/login |
| 用户注册 | http://localhost:8080/jiudianruzhu/register |
| 后台管理 | http://localhost:8080/jiudianruzhu/admin/login |

### Maven 插件启动（推荐）

项目已配置 `tomcat7-maven-plugin`，可通过 Maven 命令直接启动，无需额外配置 Tomcat：

```bash
mvn tomcat7:run -DskipTests
```

启动后访问基路径为 `/jiudianzhuru`（注意与 Idea 部署时的 `/jiudianruzhu` 不同）：
- 首页：http://localhost:8080/jiudianzhuru/rooms
- 后台：http://localhost:8080/jiudianzhuru/admin/login

## 项目要点

- 基于 **MyBatis 动态 SQL** 实现灵活的多条件房型筛选与订单检索
- 房型库存由 **系统动态计算**：根据已有订单的入住/退房日期区间匹配房间状态，实时得出可预订房间数量
- **前端点击特效**：页面接入点击涟漪动画效果，提升交互体验（`static/js/click-effect.js`）
- **订单号生成**：基于时间戳+随机数的唯一订单号生成策略（`util/OrderNoUtil.java`）
- 分层架构清晰：Controller → Service → Mapper，职责分明

## 说明

本项目基于 Spring、Spring MVC、MyBatis 与 MySQL 实现酒店预定管理功能。