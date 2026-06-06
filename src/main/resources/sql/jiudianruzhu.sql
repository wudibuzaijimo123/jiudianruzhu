create database if not exists jiudianruzhu default character set utf8mb4 collate utf8mb4_general_ci;
use jiudianruzhu;

drop table if exists booking_order;
drop table if exists room;
drop table if exists room_type;
drop table if exists sys_user;
drop table if exists sys_admin;

create table sys_user (
    id bigint primary key auto_increment,
    username varchar(50) not null unique,
    password varchar(100) not null,
    real_name varchar(50),
    phone varchar(20) not null unique,
    id_card varchar(30),
    status tinyint not null default 1,
    login_error_count int not null default 0,
    lock_time datetime default null,
    create_time datetime not null default current_timestamp
);

create table sys_admin (
    id bigint primary key auto_increment,
    username varchar(50) not null unique,
    password varchar(100) not null,
    real_name varchar(50),
    status tinyint not null default 1
);

create table room_type (
    id bigint primary key auto_increment,
    type_name varchar(80) not null,
    category varchar(30),
    image_url varchar(500),
    price decimal(10,2) not null,
    original_price decimal(10,2),
    star_level varchar(30),
    rating decimal(2,1),
    distance_text varchar(80),
    bed_type varchar(80),
    capacity int not null default 2,
    breakfast varchar(30),
    facilities varchar(500),
    tags varchar(500),
    promotion varchar(100),
    description varchar(1000),
    status tinyint not null default 1,
    create_time datetime not null default current_timestamp
);

create table room (
    id bigint primary key auto_increment,
    room_type_id bigint not null,
    room_no varchar(30) not null unique,
    floor_no varchar(20),
    status varchar(30) not null default 'FREE',
    constraint fk_room_type foreign key (room_type_id) references room_type(id)
);

create table booking_order (
    id bigint primary key auto_increment,
    order_no varchar(40) not null unique,
    user_id bigint not null,
    room_type_id bigint not null,
    room_id bigint,
    guest_name varchar(50) not null,
    guest_id_card varchar(30) not null,
    guest_phone varchar(20) not null,
    checkin_date date not null,
    checkout_date date not null,
    nights int not null,
    total_amount decimal(10,2) not null,
    status varchar(30) not null,
    create_time datetime not null default current_timestamp,
    constraint fk_order_user foreign key (user_id) references sys_user(id),
    constraint fk_order_room_type foreign key (room_type_id) references room_type(id),
    constraint fk_order_room foreign key (room_id) references room(id)
);

create index idx_order_user on booking_order(user_id);
create index idx_order_status on booking_order(status);
create index idx_order_date on booking_order(checkin_date, checkout_date);
create index idx_room_type_status on room_type(status);
create index idx_room_status on room(status);

insert into sys_admin(username,password,real_name,status) values ('admin','123123','admin',1);
insert into sys_user(username,password,real_name,phone,id_card,status) values ('chenjiahao','123456','陈佳豪','13800000000','440100200001010000',1);

insert into room_type(type_name,category,image_url,price,original_price,star_level,rating,distance_text,bed_type,capacity,breakfast,facilities,tags,promotion,description,status) values
('惠选大床房','大床房','https://images.unsplash.com/photo-1631049307264-da0ec9d70304,https://images.unsplash.com/photo-1505691938895-1758d7feb511,https://images.unsplash.com/photo-1540555700478-4be289fbecef',114.00,149.00,'经济型',4.2,'距您直线450米','1.8米大床',2,'无早餐','空调、WiFi、独立卫浴、书桌','积分可抵,免费停车场,行李寄存','神券最高减至100','床品干净无褶皱，适合临时出行与学生党入住。',1),
('舒适双床房','双床房','https://images.unsplash.com/photo-1590490360182-c33d57733427,https://images.unsplash.com/photo-1566665797739-1674de7a421a,https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf',152.00,191.00,'舒适型',4.8,'距您直线2.1公里','1.2米双床',2,'含双早','会议室、叫醒服务、电视、独立卫浴','住就送37元券包,会议室,叫醒服务','夏日特惠立减71','房间配套一应俱全，适合同学结伴或家庭短住。',1),
('轻奢商务大床房','大床房','https://images.unsplash.com/photo-1611892440504-42a792e24d32,https://images.unsplash.com/photo-1582719478250-c89cae4dc85b,https://images.unsplash.com/photo-1591088398332-8a7791972843',238.00,298.00,'高档型',4.7,'距泉城广场1.8公里','1.8米大床',2,'含双早','空调、WiFi、沙发、办公桌、独立卫浴','商务出行,近地铁,含早餐','会员价再减30','空间宽敞，安静舒适，适合商务出差。',1),
('电竞开黑双人房','电竞房','https://images.unsplash.com/photo-1598550476439-6847785fcea6,https://images.unsplash.com/photo-1538481199705-c710c4e965fc,https://images.unsplash.com/photo-1542751371-adc38448a05e',268.00,329.00,'主题房',4.6,'距您直线1.2公里','1.5米双床',2,'不含早餐','双电脑、电竞椅、高速网络、独立卫浴','电竞酒店,高速网络,免费停车场','连住立减50','高刷电脑和舒适电竞椅，适合好友开黑。',1),
('亲子家庭房','亲子房','https://images.unsplash.com/photo-1560448204-e02f11c3d0e2,https://images.unsplash.com/photo-1584132967334-10e028bd69f7,https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd',318.00,399.00,'舒适型',4.9,'距大明湖2.6公里','1.8米大床+儿童床',3,'含早餐','儿童用品、电视、WiFi、独立卫浴','亲子酒店,多居室,含早餐','亲子专享优惠','适合家庭出游，空间充足，亲子用品齐全。',1),
('行政套房','套房','https://images.unsplash.com/photo-1578683010236-d716f9a3f461,https://images.unsplash.com/photo-1596394516093-501ba68a0ba6,https://images.unsplash.com/photo-1600585154340-be6161a56a0c',688.00,899.00,'豪华型',4.9,'距高铁站3.2公里','2米大床',2,'含双早','会客厅、浴缸、迷你吧、智能电视、城市景观','商务出行,会客厅,浴缸','高端套房限时优惠','高端套房，适合贵宾接待与商务住宿。',1),
('钟点休息房','钟点房','https://images.unsplash.com/photo-1598928636135-d146006ff4be,https://images.unsplash.com/photo-1551882547-ff40c63fe5fa,https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af',88.00,128.00,'经济型',4.3,'距您直线700米','1.5米大床',2,'无早餐','空调、WiFi、独立卫浴','钟点房,近地铁,免费取消','午间休息特惠','适合短时间休息，入住灵活。',1),
('温泉景观房','大床房','https://images.unsplash.com/photo-1582719478250-c89cae4dc85b,https://images.unsplash.com/photo-1571896349842-33c89424de2d,https://images.unsplash.com/photo-1507525428034-b723cf961d3e',428.00,558.00,'高档型',4.8,'距温泉汤池900米','1.8米大床',2,'含双早','温泉汤池、景观窗、浴缸、WiFi','温泉汤池,情侣约会,含早餐','情侣约会立减54','窗景开阔，温泉配套完善，适合休闲度假。',1);

insert into room(room_type_id,room_no,floor_no,status) values
(1,'301','3F','FREE'),(1,'302','3F','FREE'),(1,'303','3F','CLEANING'),
(2,'501','5F','FREE'),(2,'502','5F','FREE'),(2,'503','5F','REPAIR'),
(3,'601','6F','FREE'),(3,'602','6F','FREE'),
(4,'701','7F','FREE'),(4,'702','7F','FREE'),
(5,'401','4F','FREE'),(5,'402','4F','FREE'),
(6,'801','8F','FREE'),(6,'802','8F','FREE'),
(7,'201','2F','FREE'),(7,'202','2F','FREE'),
(8,'901','9F','FREE'),(8,'902','9F','FREE');
