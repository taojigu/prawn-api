
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- mysql -h 13.211.46.96 -p prawn -u prawnWorker -p < src/main/resources/prawn_db_v2_schema.sql
-- Drop the existing database if it exists
DROP DATABASE IF EXISTS prawn;

-- Create a new database
CREATE DATABASE prawn;

-- Use the new database
USE prawn;

# Dump of table tb_newbee_mall_admin_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_admin_user`;

CREATE TABLE `tb_newbee_mall_admin_user` (
  `admin_user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `login_user_name` varchar(50) NOT NULL COMMENT '管理员登陆名称',
  `login_password` varchar(50) NOT NULL COMMENT '管理员登陆密码',
  `nick_name` varchar(50) NOT NULL COMMENT '管理员显示昵称',
  `locked` tinyint(4) DEFAULT '0' COMMENT '是否锁定 0未锁定 1已锁定无法登陆',
  PRIMARY KEY (`admin_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

LOCK TABLES `tb_newbee_mall_admin_user` WRITE;
/*!40000 ALTER TABLE `tb_newbee_mall_admin_user` DISABLE KEYS */;

INSERT INTO `tb_newbee_mall_admin_user` (`admin_user_id`, `login_user_name`, `login_password`, `nick_name`, `locked`)
VALUES
	(1,'admin','e10adc3949ba59abbe56e057f20f883e','十三',0),
	(2,'newbee-admin1','e10adc3949ba59abbe56e057f20f883e','新蜂01',0),
	(3,'newbee-admin2','e10adc3949ba59abbe56e057f20f883e','新蜂02',0);

/*!40000 ALTER TABLE `tb_newbee_mall_admin_user` ENABLE KEYS */;
UNLOCK TABLES;

## Tables for prawn
# Dump of table tb_prawn_user
# ------------------------------------------------------------
DROP TABLE IF EXISTS `tb_prawn_user_token`;

CREATE TABLE `tb_prawn_user_token` (
  `user_id` bigint(20) NOT NULL COMMENT '用户主键id',
  `token` varchar(32) NOT NULL COMMENT 'token值(32位字符串)',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `expire_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'token过期时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `tb_prawn_user`;
CREATE TABLE `tb_prawn_user` (
    `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'prawn平台生成的用户id',
    `open_id` varchar(50) NOT NULL DEFAULT '' COMMENT '各个平台生成的用户id',
    `name` varchar(32) NOT NULL DEFAULT '' COMMENT '登陆名称',
    `employee_no` varchar(64) NOT NULL DEFAULT '' COMMENT '员工编号',
    `mobile` varchar(32) NOT NULL DEFAULT '' COMMENT '手机号',
    `email` varchar(32) NOT NULL DEFAULT '' COMMENT '电子邮件',
    `avatar` varchar(128) NOT NULL DEFAULT '' COMMENT '用户头像',
    `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '注销标识字段(0-正常 1-已注销)',
    `locked_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定标识字段(0-未锁定 1-已锁定)',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    `platform` tinyint(8) NOT NULL DEFAULT '0' COMMENT '来源平台：钉钉/企业微信',
    `org_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '组织id',
    `org_name` varchar(64) NOT NULL DEFAULT '' COMMENT '组织名称',
    PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `tb_prawn_product`;
CREATE TABLE `tb_prawn_product` (
    `product_id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
    `title` varchar(50) NOT NULL DEFAULT '' COMMENT '产品标题',
    `description` text NOT NULL  COMMENT '产品描述',
    `price` double NOT NULL DEFAULT '0' COMMENT '价格',
    `product_image` text NOT NULL  COMMENT '多个产品image url',
    `product_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '产品销售状态（0-默认，1-编辑中 2-销售中 3-已出售 4-撤销）',
    `keywords` varchar(80) NOT NULL DEFAULT '' COMMENT '产品关键字集合',
    `category_id` bigint(32) NOT NULL DEFAULT '0' COMMENT '产品分类ID',
    `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '注销标识字段(0-正常 1-已注销)',
    `locked_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定标识字段(0-未锁定 1-已锁定)',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后更新时间',
    `seller_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '卖家用户id',
    `seller_name` varchar(64) NOT NULL DEFAULT '' COMMENT '卖家名字',
    `org_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '卖家组织id',
    `org_name` varchar(64) NOT NULL DEFAULT '' COMMENT '卖家组织名称',
    `seller_employee_no` varchar(64) NOT NULL DEFAULT '' COMMENT '卖家员工编号',
    PRIMARY KEY (`product_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `tb_prawn_favorite`;
CREATE TABLE `tb_prawn_favorite` (
    `favorite_id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '收藏本身ID',
    `user_id` bigint(32) NOT NULL DEFAULT '0' COMMENT '收藏的用户Id',
    `product_id` bigint(32) NOT NULL DEFAULT '0' COMMENT '收藏的产品Id',
    `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '注销标识字段(0-正常 1-已注销)',
    `locked_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定标识字段(0-未锁定 1-已锁定)',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后更新时间',
    PRIMARY KEY (`favorite_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

# 发布产品订单表格
DROP TABLE IF EXISTS `tb_prawn_publish_product_order`;

CREATE TABLE `tb_prawn_publish_product_order` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单表主键id',
  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT '订单号',
  `seller_id` bigint(32) NOT NULL DEFAULT '0' COMMENT '用户主键id',
  `product_id` bigint(32) NOT NULL DEFAULT '0' COMMENT '对应的产品id',
  `cost` double NOT NULL DEFAULT '0' COMMENT '订单总价',
  `pay_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付状态:0.未支付,1.支付成功,-1:支付失败',
  `pay_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0.无 1.支付宝支付 2.微信支付',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `extra_info` varchar(100) NOT NULL DEFAULT '' COMMENT '订单body',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新修改时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





# Dump of table tb_newbee_mall_carousel
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_carousel`;

CREATE TABLE `tb_newbee_mall_carousel` (
  `carousel_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '首页轮播图主键id',
  `carousel_url` varchar(100) NOT NULL DEFAULT '' COMMENT '轮播图',
  `redirect_url` varchar(100) NOT NULL DEFAULT '''##''' COMMENT '点击后的跳转地址(默认不跳转)',
  `carousel_rank` int(11) NOT NULL DEFAULT '0' COMMENT '排序值(字段越大越靠前)',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` int(11) NOT NULL DEFAULT '0' COMMENT '创建者id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_user` int(11) NOT NULL DEFAULT '0' COMMENT '修改者id',
  PRIMARY KEY (`carousel_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

LOCK TABLES `tb_newbee_mall_carousel` WRITE;
/*!40000 ALTER TABLE `tb_newbee_mall_carousel` DISABLE KEYS */;

INSERT INTO `tb_newbee_mall_carousel` (`carousel_id`, `carousel_url`, `redirect_url`, `carousel_rank`, `is_deleted`, `create_time`, `create_user`, `update_time`, `update_user`)
VALUES
	(1,'https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/banner2.jpg','##',200,1,'2019-08-23 17:50:45',0,'2019-11-10 00:23:01',0),
	(2,'https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/banner1.png','https://juejin.im/book/5da2f9d4f265da5b81794d48/section/5da2f9d6f265da5b794f2189',13,0,'2019-11-29 00:00:00',0,'2019-11-29 00:00:00',0),
	(3,'https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/banner3.jpg','##',0,1,'2019-09-18 18:26:38',0,'2019-11-10 00:23:01',0),
	(5,'https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/banner2.png','https://juejin.im/book/5da2f9d4f265da5b81794d48/section/5da2f9d6f265da5b794f2189',0,0,'2019-11-29 00:00:00',0,'2019-11-29 00:00:00',0),
	(6,'https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/banner1.png','##',101,1,'2019-09-19 23:37:40',0,'2019-11-07 00:15:52',0),
	(7,'https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/banner2.png','##',99,1,'2019-09-19 23:37:58',0,'2019-10-22 00:15:01',0);

/*!40000 ALTER TABLE `tb_newbee_mall_carousel` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_newbee_mall_goods_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_goods_category`;

CREATE TABLE `tb_newbee_mall_goods_category` (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `category_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '分类级别(1-一级分类 2-二级分类 3-三级分类)',
  `parent_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '父分类id',
  `category_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `category_rank` int(11) NOT NULL DEFAULT '0' COMMENT '排序值(字段越大越靠前)',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` int(11) NOT NULL DEFAULT '0' COMMENT '创建者id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_user` int(11) DEFAULT '0' COMMENT '修改者id',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

LOCK TABLES `tb_newbee_mall_goods_category` WRITE;
/*!40000 ALTER TABLE `tb_newbee_mall_goods_category` DISABLE KEYS */;

INSERT INTO `tb_newbee_mall_goods_category` (`category_id`, `category_level`, `parent_id`, `category_name`, `category_rank`, `is_deleted`, `create_time`, `create_user`, `update_time`, `update_user`)
VALUES
	(15,1,0,'家电 数码 手机',100,0,'2019-09-11 18:45:40',0,'2019-11-20 23:18:13',0),
	(16,1,0,'女装 男装 穿搭',99,0,'2019-09-11 18:46:07',0,'2019-11-20 23:18:20',0),
	(17,2,15,'家电',10,0,'2019-09-11 18:46:32',0,'2019-09-11 18:46:32',0),
	(18,2,15,'数码',9,0,'2019-09-11 18:46:43',0,'2019-09-11 18:46:43',0),
	(19,2,15,'手机',8,0,'2019-09-11 18:46:52',0,'2019-09-11 18:46:52',0),
	(20,3,17,'生活电器',0,0,'2019-09-11 18:47:38',0,'2019-09-11 18:47:38',0),
	(21,3,17,'厨房电器',0,0,'2019-09-11 18:47:49',0,'2019-09-11 18:47:49',0),
	(22,3,17,'扫地机器人',0,0,'2019-09-11 18:47:58',0,'2019-09-11 18:47:58',0),
	(23,3,17,'吸尘器',0,0,'2019-09-11 18:48:06',0,'2019-09-11 18:48:06',0),
	(24,3,17,'取暖器',0,0,'2019-09-11 18:48:12',0,'2019-09-11 18:48:12',0),
	(25,3,17,'豆浆机',0,0,'2019-09-11 18:48:26',0,'2019-09-11 18:48:26',0),
	(26,3,17,'暖风机',0,0,'2019-09-11 18:48:40',0,'2019-09-11 18:48:40',0),
	(27,3,17,'加湿器',0,0,'2019-09-11 18:48:50',0,'2019-09-11 18:48:50',0),
	(28,3,17,'蓝牙音箱',0,0,'2019-09-11 18:48:57',0,'2019-09-11 18:48:57',0),
	(29,3,17,'烤箱',0,0,'2019-09-11 18:49:09',0,'2019-09-11 18:49:09',0),
	(30,3,17,'卷发器',0,0,'2019-09-11 18:49:19',0,'2019-09-11 18:49:19',0),
	(31,3,17,'空气净化器',0,0,'2019-09-11 18:49:30',0,'2019-09-11 18:49:30',0),
	(32,3,18,'游戏主机',0,0,'2019-09-11 18:49:50',0,'2019-09-11 18:49:50',0),
	(33,3,18,'数码精选',0,0,'2019-09-11 18:49:55',0,'2019-09-11 18:49:55',0),
	(34,3,18,'平板电脑',0,0,'2019-09-11 18:50:08',0,'2019-09-11 18:50:08',0),
	(35,3,18,'苹果 Apple',0,0,'2019-09-11 18:50:24',0,'2019-09-11 18:50:24',0),
	(36,3,18,'电脑主机',0,0,'2019-09-11 18:50:36',0,'2019-09-11 18:50:36',0),
	(37,3,18,'数码相机',0,0,'2019-09-11 18:50:57',0,'2019-09-11 18:50:57',0),
	(38,3,18,'电玩动漫',0,0,'2019-09-11 18:52:15',0,'2019-09-11 18:52:15',0),
	(39,3,18,'单反相机',0,0,'2019-09-11 18:52:26',0,'2019-09-11 18:52:26',0),
	(40,3,18,'键盘鼠标',0,0,'2019-09-11 18:52:46',0,'2019-09-11 18:52:46',0),
	(41,3,18,'无人机',0,0,'2019-09-11 18:53:01',0,'2019-09-11 18:53:01',0),
	(42,3,18,'二手电脑',0,0,'2019-09-11 18:53:08',0,'2019-09-11 18:53:08',0),
	(43,3,18,'二手手机',0,0,'2019-09-11 18:53:14',0,'2019-09-11 18:53:14',0),
	(44,3,19,'iPhone 11',89,0,'2019-09-11 18:53:49',0,'2019-09-11 18:54:38',0),
	(45,3,19,'荣耀手机',99,0,'2019-09-11 18:53:59',0,'2019-09-18 13:40:59',0),
	(46,3,19,'华为手机',98,0,'2019-09-11 18:54:20',0,'2019-09-18 13:40:51',0),
	(47,3,19,'苹果 iPhone',88,0,'2019-09-11 18:54:49',0,'2019-11-15 18:31:22',0),
	(48,3,19,'华为 Mate 20',79,0,'2019-09-11 18:55:03',0,'2019-09-11 18:55:13',0),
	(49,3,19,'华为 P30',97,0,'2019-09-11 18:55:22',0,'2019-09-11 18:55:22',0),
	(50,3,19,'华为 P30 Pro',0,1,'2019-09-11 18:55:32',0,'2019-09-11 18:55:32',0),
	(51,3,19,'小米手机',0,0,'2019-09-11 18:55:52',0,'2019-09-11 18:55:52',0),
	(52,3,19,'红米',0,1,'2019-09-11 18:55:58',0,'2019-09-11 18:55:58',0),
	(53,3,19,'OPPO',0,0,'2019-09-11 18:56:06',0,'2019-09-11 18:56:06',0),
	(54,3,19,'一加',0,0,'2019-09-11 18:56:12',0,'2019-09-11 18:56:12',0),
	(55,3,19,'小米 MIX',0,0,'2019-09-11 18:56:37',0,'2019-09-11 18:56:37',0),
	(56,3,19,'Reno',0,0,'2019-09-11 18:56:49',0,'2019-09-11 18:56:49',0),
	(57,3,19,'vivo',0,0,'2019-09-11 18:57:01',0,'2019-09-11 18:57:01',0),
	(58,3,19,'手机以旧换新',0,0,'2019-09-11 18:57:09',0,'2019-09-11 18:57:09',0),
	(59,1,0,'运动 户外 乐器',97,0,'2019-09-12 00:08:46',0,'2019-09-12 00:08:46',0),
	(60,1,0,'游戏 动漫 影视',96,0,'2019-09-12 00:09:00',0,'2019-09-12 00:09:00',0),
	(61,1,0,'家具 家饰 家纺',98,0,'2019-09-12 00:09:27',0,'2019-09-12 00:09:27',0),
	(62,1,0,'美妆 清洁 宠物',94,0,'2019-09-12 00:09:51',0,'2019-09-17 18:22:34',0),
	(63,1,0,'工具 装修 建材',93,0,'2019-09-12 00:10:07',0,'2019-09-12 00:10:07',0),
	(64,1,0,'test12',0,1,'2019-09-12 00:10:35',0,'2019-11-16 18:30:59',0),
	(65,1,0,'玩具 孕产 用品',0,0,'2019-09-12 00:11:17',0,'2019-09-12 00:11:17',0),
	(66,1,0,'鞋靴 箱包 配件',91,0,'2019-09-12 00:11:30',0,'2019-09-12 00:11:30',0),
	(67,2,16,'女装',10,0,'2019-09-12 00:15:19',0,'2019-09-12 00:15:19',0),
	(68,2,16,'男装',9,0,'2019-09-12 00:15:28',0,'2019-09-12 00:15:28',0),
	(69,2,16,'穿搭',8,0,'2019-09-12 00:15:35',0,'2019-09-12 00:15:35',0),
	(70,2,61,'家具',10,0,'2019-09-12 00:20:22',0,'2019-09-12 00:20:22',0),
	(71,2,61,'家饰',9,0,'2019-09-12 00:20:29',0,'2019-09-12 00:20:29',0),
	(72,2,61,'家纺',8,0,'2019-09-12 00:20:35',0,'2019-09-12 00:20:35',0),
	(73,2,59,'运动',10,0,'2019-09-12 00:20:49',0,'2019-09-12 00:20:49',0),
	(74,2,59,'户外',9,0,'2019-09-12 00:20:58',0,'2019-09-12 00:20:58',0),
	(75,2,59,'乐器',8,0,'2019-09-12 00:21:05',0,'2019-09-12 00:21:05',0),
	(76,3,67,'外套',10,0,'2019-09-12 00:21:55',0,'2019-09-12 00:21:55',0),
	(77,3,70,'沙发',10,0,'2019-09-12 00:22:21',0,'2019-09-12 00:22:21',0),
	(78,3,73,'跑鞋',10,0,'2019-09-12 00:22:42',0,'2019-09-12 00:22:42',0),
	(79,2,60,'游戏',10,0,'2019-09-12 00:23:13',0,'2019-09-12 00:23:13',0),
	(80,2,60,'动漫',9,0,'2019-09-12 00:23:21',0,'2019-09-12 00:23:21',0),
	(81,2,60,'影视',8,0,'2019-09-12 00:23:27',0,'2019-09-12 00:23:27',0),
	(82,3,79,'LOL',10,0,'2019-09-12 00:23:44',0,'2019-09-12 00:23:44',0),
	(83,2,62,'美妆',10,0,'2019-09-12 00:23:58',0,'2019-09-17 18:22:44',0),
	(84,2,62,'宠物',9,0,'2019-09-12 00:24:07',0,'2019-09-12 00:24:07',0),
	(85,2,62,'清洁',8,0,'2019-09-12 00:24:15',0,'2019-09-17 18:22:51',0),
	(86,3,83,'口红',10,0,'2019-09-12 00:24:38',0,'2019-09-17 18:23:08',0),
	(87,2,63,'工具',10,0,'2019-09-12 00:24:56',0,'2019-09-12 00:24:56',0),
	(88,2,63,'装修',9,0,'2019-09-12 00:25:05',0,'2019-09-12 00:25:05',0),
	(89,2,63,'建材',8,0,'2019-09-12 00:25:12',0,'2019-09-12 00:25:12',0),
	(90,3,87,'转换器',10,0,'2019-09-12 00:25:45',0,'2019-09-12 00:25:45',0),
	(91,2,64,'珠宝',10,0,'2019-09-12 00:26:10',0,'2019-09-12 00:26:10',0),
	(92,2,64,'金饰',9,0,'2019-09-12 00:26:18',0,'2019-09-12 00:26:18',0),
	(93,2,64,'眼镜',8,0,'2019-09-12 00:26:25',0,'2019-09-12 00:26:25',0),
	(94,3,91,'钻石',10,0,'2019-09-12 00:26:40',0,'2019-09-12 00:26:40',0),
	(95,2,66,'鞋靴',10,0,'2019-09-12 00:27:09',0,'2019-09-12 00:27:09',0),
	(96,2,66,'箱包',9,0,'2019-09-12 00:27:17',0,'2019-09-12 00:27:17',0),
	(97,2,66,'配件',8,0,'2019-09-12 00:27:23',0,'2019-09-12 00:27:23',0),
	(98,3,95,'休闲鞋',10,0,'2019-09-12 00:27:48',0,'2019-09-12 00:27:48',0),
	(99,3,83,'气垫',0,0,'2019-09-17 18:24:23',0,'2019-09-17 18:24:23',0),
	(100,3,83,'美白',0,0,'2019-09-17 18:24:36',0,'2019-09-17 18:24:36',0),
	(101,3,83,'隔离霜',0,0,'2019-09-17 18:27:04',0,'2019-09-17 18:27:04',0),
	(102,3,83,'粉底',0,0,'2019-09-17 18:27:19',0,'2019-09-17 18:27:19',0),
	(103,3,83,'腮红',0,0,'2019-09-17 18:27:24',0,'2019-09-17 18:27:24',0),
	(104,3,83,'睫毛膏',0,0,'2019-09-17 18:27:47',0,'2019-09-17 18:27:47',0),
	(105,3,83,'香水',0,1,'2019-09-17 18:28:16',0,'2019-09-17 18:28:16',0),
	(106,3,83,'面膜',0,1,'2019-09-17 18:28:21',0,'2019-09-17 18:28:21',0),
	(107,1,0,'2344',1,1,'2019-10-24 23:52:53',0,'2019-10-24 23:52:53',0),
	(108,1,0,'测试分类',50,1,'2019-11-07 22:59:24',0,'2019-11-15 18:10:46',0),
	(109,2,15,'xxx',0,0,'2019-11-07 23:08:17',0,'2019-11-07 23:08:17',0),
	(110,3,17,'wer',0,0,'2019-11-07 23:08:39',0,'2019-11-07 23:08:39',0),
	(111,1,0,'测试分类2',255,1,'2019-11-15 18:27:41',0,'2019-11-15 18:27:41',0),
	(112,2,111,'测试分类2-1',0,1,'2019-11-15 18:27:53',0,'2019-11-15 18:27:53',0),
	(113,1,0,'商品类目1',200,1,'2019-11-16 18:23:16',0,'2019-11-16 18:23:16',0),
	(114,1,0,'商品类目1',200,1,'2019-11-16 18:56:36',0,'2019-11-16 18:56:36',0),
	(115,2,65,'玩具',0,0,'2019-11-28 20:24:58',0,'2019-11-28 20:24:58',0),
	(116,3,115,'机器人',0,0,'2019-11-28 20:25:16',0,'2019-11-28 20:25:16',0);

/*!40000 ALTER TABLE `tb_newbee_mall_goods_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_newbee_mall_goods_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_goods_info`;

CREATE TABLE `tb_newbee_mall_goods_info` (
  `goods_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品表主键id',
  `goods_name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品名',
  `goods_intro` varchar(200) NOT NULL DEFAULT '' COMMENT '商品简介',
  `goods_category_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '关联分类id',
  `goods_cover_img` varchar(200) NOT NULL DEFAULT '/admin/dist/img/no-img.png' COMMENT '商品主图',
  `goods_carousel` varchar(500) NOT NULL DEFAULT '/admin/dist/img/no-img.png' COMMENT '商品轮播图',
  `goods_detail_content` text NOT NULL COMMENT '商品详情',
  `original_price` int(11) NOT NULL DEFAULT '1' COMMENT '商品价格',
  `selling_price` int(11) NOT NULL DEFAULT '1' COMMENT '商品实际售价',
  `stock_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品库存数量',
  `tag` varchar(20) NOT NULL DEFAULT '' COMMENT '商品标签',
  `goods_sell_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '商品上架状态 1-下架 0-上架',
  `create_user` int(11) NOT NULL DEFAULT '0' COMMENT '添加者主键id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品添加时间',
  `update_user` int(11) NOT NULL DEFAULT '0' COMMENT '修改者主键id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品修改时间',
  PRIMARY KEY (`goods_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

LOCK TABLES `tb_newbee_mall_goods_info` WRITE;
/*!40000 ALTER TABLE `tb_newbee_mall_goods_info` DISABLE KEYS */;

INSERT INTO `tb_newbee_mall_goods_info` (`goods_id`, `goods_name`, `goods_intro`, `goods_category_id`, `goods_cover_img`, `goods_carousel`, `goods_detail_content`, `original_price`, `selling_price`, `stock_num`, `tag`, `goods_sell_status`, `create_user`, `create_time`, `update_user`, `update_time`)
VALUES
	(10003,'无印良品 MUJI 基础润肤化妆水','滋润型 400ml',0,'/goods-img/87446ec4-e534-4b49-9f7d-9bea34665284.jpg','/goods-img/87446ec4-e534-4b49-9f7d-9bea34665284.jpg','商品介绍加载中...',100,100,1000,'',1,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10004,'无印良品 MUJI 柔和洁面泡沫','120g',0,'/goods-img/45854bdd-2ca5-423c-a609-3d336d9322b4.jpg','/goods-img/45854bdd-2ca5-423c-a609-3d336d9322b4.jpg','商品介绍加载中...',45,45,999,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10005,'无印良品 MUJI 基础润肤乳液','高保湿型 200ml',0,'/goods-img/7614ce78-0ebc-4275-a7cc-d16ad5f5f6ed.jpg','/goods-img/7614ce78-0ebc-4275-a7cc-d16ad5f5f6ed.jpg','商品介绍加载中...',83,83,998,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10006,'无印良品 MUJI 基础润肤乳液','滋润型 400ml',0,'/goods-img/ef75879d-3d3e-4bab-888d-1e4036491e11.jpg','/goods-img/ef75879d-3d3e-4bab-888d-1e4036491e11.jpg','商品介绍加载中...',100,100,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10007,'无印良品 MUJI 基础润肤化妆水','高保湿型 400ml',0,'/goods-img/558422d1-640e-442d-a073-2b2bdd95c4ed.jpg','/goods-img/558422d1-640e-442d-a073-2b2bdd95c4ed.jpg','商品介绍加载中...',127,127,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10008,'无印良品 MUJI 基础润肤化妆水','清爽型 200ml',0,'/goods-img/89660409-78b7-4d47-ae12-f94b3ce9664b.png','/goods-img/89660409-78b7-4d47-ae12-f94b3ce9664b.png','商品介绍加载中...',70,70,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10009,'无印良品 MUJI 男式','无侧缝法兰绒 睡衣 海军蓝 L',0,'/goods-img/f172c500-21d0-42e3-95ce-aa9b84a2ef49.jpg','/goods-img/f172c500-21d0-42e3-95ce-aa9b84a2ef49.jpg','商品介绍加载中...',398,199,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10010,'无印良品 MUJI 基础润肤洁面泡沫','200ml',0,'/goods-img/f87bdee1-ed48-4b49-b701-cc44f26a2699.jpg','/goods-img/f87bdee1-ed48-4b49-b701-cc44f26a2699.jpg','商品介绍加载中...',83,83,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10011,'无印良品 MUJI 平衡高保湿化妆水','新蜂精选',0,'/goods-img/16230038-bf86-4d4e-a11f-954b9ee4bab2.jpg','/goods-img/16230038-bf86-4d4e-a11f-954b9ee4bab2.jpg','商品介绍加载中...',130,65,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10012,'无印良品 MUJI 凝胶墨水圆珠笔','蓝黑色',0,'/goods-img/a952ecce-32e7-474e-9c1b-943962e0a580.jpg','/goods-img/a952ecce-32e7-474e-9c1b-943962e0a580.jpg','商品介绍加载中...',8,5,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10013,'无印良品 MUJI 平衡保湿乳霜','50g',0,'/goods-img/904c8aa1-0257-49e8-ad89-f48d2462db21.jpg','/goods-img/904c8aa1-0257-49e8-ad89-f48d2462db21.jpg','商品介绍加载中...',130,65,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10014,'无印良品 MUJI 基础润肤乳液','清爽型 200ml',0,'/goods-img/d66b6e0e-48d4-4503-8dd6-43b3c71f52a4.png','/goods-img/d66b6e0e-48d4-4503-8dd6-43b3c71f52a4.png','商品介绍加载中...',70,70,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10015,'无印良品 MUJI 平衡洁面泡沫','100g',0,'/goods-img/d0d8f6d1-1f2d-49f8-9099-0cdd94833581.jpg','/goods-img/d0d8f6d1-1f2d-49f8-9099-0cdd94833581.jpg','商品介绍加载中...',85,42,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10016,'无印良品 MUJI 基础润肤乳液','滋润型 200ml',0,'/goods-img/e553f566-5dc4-4648-be58-fd7112a47b10.jpg','/goods-img/e553f566-5dc4-4648-be58-fd7112a47b10.jpg','商品介绍加载中...',61,61,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10017,'无印良品 MUJI 便携式香薰机','新蜂精选',0,'/goods-img/a9c0d929-6f0b-4bc7-819c-e5015f447a9e.jpg','/goods-img/a9c0d929-6f0b-4bc7-819c-e5015f447a9e.jpg','商品介绍加载中...',200,200,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10018,'无印良品 MUJI 女式','粗棉线条纹长袖T恤 白色*横条 L',0,'/goods-img/38d5f694-2236-415d-80c8-4a1695e92d4e.jpg','/goods-img/38d5f694-2236-415d-80c8-4a1695e92d4e.jpg','商品介绍加载中...',198,70,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10019,'无印良品（MUJI） 聚丙烯化妆盒 1/2','半透明约150x220x86mm',0,'/goods-img/f6832ed7-cb01-48ab-987f-cd437b21be80.jpg','/goods-img/f6832ed7-cb01-48ab-987f-cd437b21be80.jpg','商品介绍加载中...',30,30,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10020,'无印良品 MUJI 聚丙烯','笔盒 大/约184*64*25㎜',0,'/goods-img/6c7f7a0d-4d73-406e-adcc-6f666ce4e2c9.jpg','/goods-img/6c7f7a0d-4d73-406e-adcc-6f666ce4e2c9.jpg','商品介绍加载中...',18,18,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10021,'无印良品（MUJI） 无针订书机 其他','新蜂精选',0,'/goods-img/cf19de8b-e94e-4513-aecd-a0b5c976b738.jpg','/goods-img/cf19de8b-e94e-4513-aecd-a0b5c976b738.jpg','商品介绍加载中...',52,52,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10022,'无印良品 MUJI 塑料橡皮','黑色 小',0,'/goods-img/d4f3299d-d526-4a81-ae9f-3b53e735075e.jpg','/goods-img/d4f3299d-d526-4a81-ae9f-3b53e735075e.jpg','商品介绍加载中...',4,4,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10023,'无印良品 MUJI 大容量基础乳液/高保湿型','400ml',0,'/goods-img/ea92b50a-67ba-4279-a71a-4e52e6a3219c.jpg','/goods-img/ea92b50a-67ba-4279-a71a-4e52e6a3219c.jpg','商品介绍加载中...',140,140,1000,'',0,0,'2019-09-18 13:18:47',0,'2019-09-18 13:18:47'),
	(10024,'无印良品 MUJI 基础润肤化妆水','滋润型 400ml',0,'/goods-img/beb26b1b-7a73-48c2-a9f7-727ad92401f6.jpg','/goods-img/beb26b1b-7a73-48c2-a9f7-727ad92401f6.jpg','商品介绍加载中...',100,100,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10025,'无印良品 MUJI 柔和洁面泡沫','120g',0,'/goods-img/bf1dc4d1-acc2-40c8-8091-1c6f35988643.jpg','/goods-img/bf1dc4d1-acc2-40c8-8091-1c6f35988643.jpg','商品介绍加载中...',45,45,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10026,'无印良品 MUJI 基础润肤乳液','高保湿型 200ml',0,'/goods-img/4059caa9-e0b3-4ac3-a494-b9e4c47e0185.jpg','/goods-img/4059caa9-e0b3-4ac3-a494-b9e4c47e0185.jpg','商品介绍加载中...',83,83,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10027,'无印良品 MUJI 基础润肤乳液','滋润型 400ml',0,'/goods-img/a4a4c981-da0f-4228-bcc7-97d970dc619c.jpg','/goods-img/a4a4c981-da0f-4228-bcc7-97d970dc619c.jpg','商品介绍加载中...',100,100,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10028,'无印良品 MUJI 基础润肤化妆水','高保湿型 400ml',0,'/goods-img/98b5c5b5-cc75-4dfb-8ec4-0a7f42af6183.jpg','/goods-img/98b5c5b5-cc75-4dfb-8ec4-0a7f42af6183.jpg','商品介绍加载中...',127,127,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10029,'无印良品 MUJI 基础润肤化妆水','清爽型 200ml',0,'/goods-img/71d1f469-b77b-473a-a31a-78fc97859b3a.png','/goods-img/71d1f469-b77b-473a-a31a-78fc97859b3a.png','商品介绍加载中...',70,70,999,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10030,'无印良品 MUJI 男式','无侧缝法兰绒 睡衣 海军蓝 L',0,'/goods-img/68bfbfd9-bc28-429a-ab2c-7fa62205ed7e.jpg','/goods-img/68bfbfd9-bc28-429a-ab2c-7fa62205ed7e.jpg','商品介绍加载中...',398,199,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10031,'无印良品 MUJI 基础润肤洁面泡沫','200ml',0,'/goods-img/679eb5a8-7689-4620-b072-63daeb8eb73a.jpg','/goods-img/679eb5a8-7689-4620-b072-63daeb8eb73a.jpg','商品介绍加载中...',83,83,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10032,'无印良品 MUJI 平衡高保湿化妆水','新蜂精选',0,'/goods-img/eb13afc6-8898-4a50-9f93-06dd2593c313.jpg','/goods-img/eb13afc6-8898-4a50-9f93-06dd2593c313.jpg','商品介绍加载中...',130,65,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10033,'无印良品 MUJI 凝胶墨水圆珠笔','蓝黑色',0,'/goods-img/85a893fe-c971-4f0b-aa0f-4c24b65b1c75.jpg','/goods-img/85a893fe-c971-4f0b-aa0f-4c24b65b1c75.jpg','商品介绍加载中...',8,5,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10034,'无印良品 MUJI 平衡保湿乳霜','50g',0,'/goods-img/65aed381-cde0-44ed-b345-5ebf1d74a13b.jpg','/goods-img/65aed381-cde0-44ed-b345-5ebf1d74a13b.jpg','商品介绍加载中...',130,65,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10035,'无印良品 MUJI 基础润肤乳液','清爽型 200ml',0,'/goods-img/1e09e1ed-435b-4f08-84d0-d88308a315ee.png','/goods-img/1e09e1ed-435b-4f08-84d0-d88308a315ee.png','商品介绍加载中...',70,70,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10036,'无印良品 MUJI 平衡洁面泡沫','100g',0,'/goods-img/dbc2ea2a-ee03-4366-a35e-6ebe66d02399.jpg','/goods-img/dbc2ea2a-ee03-4366-a35e-6ebe66d02399.jpg','商品介绍加载中...',85,42,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10037,'无印良品 MUJI 基础润肤乳液','滋润型 200ml',0,'/goods-img/9389914c-2860-4a75-b603-53ed5a4e0509.jpg','/goods-img/9389914c-2860-4a75-b603-53ed5a4e0509.jpg','商品介绍加载中...',61,61,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10038,'无印良品 MUJI 便携式香薰机','新蜂精选',0,'/goods-img/6ab010e2-5f1e-4512-bd22-4c2550915d4c.jpg','/goods-img/6ab010e2-5f1e-4512-bd22-4c2550915d4c.jpg','商品介绍加载中...',200,200,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10039,'无印良品 MUJI 女式','粗棉线条纹长袖T恤 白色*横条 L',0,'/goods-img/fab00903-7ff6-40ee-a9bc-3fbc2f0f0ffc.jpg','/goods-img/fab00903-7ff6-40ee-a9bc-3fbc2f0f0ffc.jpg','商品介绍加载中...',198,70,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10040,'无印良品（MUJI） 聚丙烯化妆盒 1/2','半透明约150x220x86mm',0,'/goods-img/ab725751-adb8-452a-86dd-cb3d21da794e.jpg','/goods-img/ab725751-adb8-452a-86dd-cb3d21da794e.jpg','商品介绍加载中...',30,30,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10041,'无印良品 MUJI 聚丙烯','笔盒 大/约184*64*25㎜',0,'/goods-img/9f623290-928c-498f-89e6-171372b394f2.jpg','/goods-img/9f623290-928c-498f-89e6-171372b394f2.jpg','商品介绍加载中...',18,18,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10042,'无印良品（MUJI） 无针订书机 其他','新蜂精选',0,'/goods-img/a7221688-3c37-4ac0-b07e-d8bde1525d1e.jpg','/goods-img/a7221688-3c37-4ac0-b07e-d8bde1525d1e.jpg','商品介绍加载中...',52,52,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10043,'无印良品 MUJI 塑料橡皮','黑色 小',0,'/goods-img/75e26af4-8f15-43f2-9407-50d641f82acb.jpg','/goods-img/75e26af4-8f15-43f2-9407-50d641f82acb.jpg','商品介绍加载中...',4,4,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10044,'无印良品 MUJI 大容量基础乳液/高保湿型','400ml',0,'/goods-img/69d55773-1b43-497b-af18-90f2cec7c93a.jpg','/goods-img/69d55773-1b43-497b-af18-90f2cec7c93a.jpg','商品介绍加载中...',140,140,1000,'',0,0,'2019-09-18 13:18:52',0,'2019-09-18 13:18:52'),
	(10045,'无印良品 MUJI 毛笔','黑色',0,'/goods-img/419ddb3c-1793-49c1-8953-77409a5d5bce.jpg','/goods-img/419ddb3c-1793-49c1-8953-77409a5d5bce.jpg','商品介绍加载中...',20,20,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10046,'无印良品 MUJI 塑料橡皮','白色 小',0,'/goods-img/e53cc7af-f81c-4752-aec8-007e807b2fc1.jpg','/goods-img/e53cc7af-f81c-4752-aec8-007e807b2fc1.jpg','商品介绍加载中...',4,4,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10047,'无印良品 MUJI 男式','无侧缝法兰绒 睡衣 深海军蓝X格子 L',0,'/goods-img/481e8994-20cb-4f6c-8b77-4eb8509eb3b9.jpg','/goods-img/481e8994-20cb-4f6c-8b77-4eb8509eb3b9.jpg','商品介绍加载中...',398,199,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10048,'无印良品 MUJI 荧光笔','蓝色',0,'/goods-img/012ebf2d-8c96-4641-8782-eab01c85d98f.jpg','/goods-img/012ebf2d-8c96-4641-8782-eab01c85d98f.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10049,'无印良品（MUJI） 钢制指甲刀 小','新蜂精选',0,'/goods-img/2c150720-4b3a-4d9e-9ce6-77eb4998e1f1.jpg','/goods-img/2c150720-4b3a-4d9e-9ce6-77eb4998e1f1.jpg','商品介绍加载中...',42,42,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10050,'无印良品 MUJI 长条诗笺型笔记表格','白色 40枚 14行',0,'/goods-img/e7d2ea3f-6703-4fcc-bbb4-ad9ef43a0ae2.jpg','/goods-img/e7d2ea3f-6703-4fcc-bbb4-ad9ef43a0ae2.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10051,'无印良品 MUJI PET喷雾小分装瓶100ml','新蜂精选',0,'/goods-img/0ec8c4a7-aedc-464d-9e23-d3e4acafdc73.jpg','/goods-img/0ec8c4a7-aedc-464d-9e23-d3e4acafdc73.jpg','商品介绍加载中...',30,30,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10052,'无印良品 MUJI 塑料橡皮','黑色 大',0,'/goods-img/ce8ff43c-e8b4-4c52-9de1-c983c97068f6.jpg','/goods-img/ce8ff43c-e8b4-4c52-9de1-c983c97068f6.jpg','商品介绍加载中...',7,7,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10053,'无印良品 MUJI 荧光笔','黄色',0,'/goods-img/79b38a89-b02a-4fd1-80c4-5cb426028536.jpg','/goods-img/79b38a89-b02a-4fd1-80c4-5cb426028536.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10054,'无印良品 MUJI 遮瑕膏','棒状 自然色',0,'/goods-img/ffa69c8e-f57f-4ef4-a2a0-3695d538d6c5.jpg','/goods-img/ffa69c8e-f57f-4ef4-a2a0-3695d538d6c5.jpg','商品介绍加载中...',42,42,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10055,'无印良品 MUJI 马桶刷/附盒子','白色',0,'/goods-img/9dd1cdfb-e7f9-4d3c-98df-933e2bc3f9a8.jpg','/goods-img/9dd1cdfb-e7f9-4d3c-98df-933e2bc3f9a8.jpg','商品介绍加载中...',70,70,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10056,'无印良品 MUJI 耐热玻璃_壶_大','透明',0,'/goods-img/0bc4f5ac-d601-421d-8131-81958a195705.jpg','/goods-img/0bc4f5ac-d601-421d-8131-81958a195705.jpg','商品介绍加载中...',150,150,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10057,'无印良品 MUJI 女式','平纹短袖衬衫 藏青色 M',0,'/goods-img/76b6a573-12a0-4c63-b2ae-e7193aff0fc8.jpg','/goods-img/76b6a573-12a0-4c63-b2ae-e7193aff0fc8.jpg','商品介绍加载中...',198,59,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10058,'无印良品 MUJI 基础润肤化妆水','清爽型 50ml',0,'/goods-img/af7f9b21-d782-4bad-8b1a-d86bbc4d224e.png','/goods-img/af7f9b21-d782-4bad-8b1a-d86bbc4d224e.png','商品介绍加载中...',28,22,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10059,'无印良品 MUJI 男式','无侧缝法兰绒 睡衣 炭灰色 M',0,'/goods-img/26e0c424-f22d-4d3d-9bd6-a7958a346ff9.jpg','/goods-img/26e0c424-f22d-4d3d-9bd6-a7958a346ff9.jpg','商品介绍加载中...',398,199,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10060,'无印良品（MUJI） PET分裝瓶','新蜂精选',0,'/goods-img/24bf1630-0339-4c22-ad19-37152c561e71.jpg','/goods-img/24bf1630-0339-4c22-ad19-37152c561e71.jpg','商品介绍加载中...',15,15,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10061,'无印良品 MUJI 女式','无侧缝法兰绒 睡衣 灰色 M',0,'/goods-img/e8e26306-0521-4843-9e07-70ebd2fa6405.jpg','/goods-img/e8e26306-0521-4843-9e07-70ebd2fa6405.jpg','商品介绍加载中...',398,199,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10062,'无印良品（MUJI） PE分裝瓶','新蜂精选',0,'/goods-img/9b3af7c2-57f5-48a7-bea5-603b2d145000.jpg','/goods-img/9b3af7c2-57f5-48a7-bea5-603b2d145000.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10063,'无印良品 MUJI 基础润肤化妆水','滋润型 200ml',0,'/goods-img/7577f3e0-f48b-47a9-96b7-de405a6aaf95.png','/goods-img/7577f3e0-f48b-47a9-96b7-de405a6aaf95.png','商品介绍加载中...',70,70,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10064,'无印良品 MUJI 男式','干爽 凉感珠地网眼编织V领短袖T恤 黑色 L',0,'/goods-img/cce2af31-07ea-4744-8d01-16dd01d68e5b.jpg','/goods-img/cce2af31-07ea-4744-8d01-16dd01d68e5b.jpg','商品介绍加载中...',98,29,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10065,'无印良品（MUJI） 聚丙烯化妆盒 半透明约150x220x169mm','新蜂精选',0,'/goods-img/6dc279ac-fef0-401c-8604-b18dc9a9f7ab.jpg','/goods-img/6dc279ac-fef0-401c-8604-b18dc9a9f7ab.jpg','商品介绍加载中...',40,40,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10066,'无印良品（MUJI） 散粉小 自然色','新蜂精选',0,'/goods-img/94764fac-f4ad-4ee8-8d26-21af0c09ea76.jpg','/goods-img/94764fac-f4ad-4ee8-8d26-21af0c09ea76.jpg','商品介绍加载中...',60,60,1000,'',0,0,'2019-09-18 13:19:02',0,'2019-09-18 13:19:02'),
	(10067,'无印良品 MUJI 毛笔','黑色',0,'/goods-img/9cd07460-8c0b-49e5-9741-5015a3576e8e.jpg','/goods-img/9cd07460-8c0b-49e5-9741-5015a3576e8e.jpg','商品介绍加载中...',20,20,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10068,'无印良品 MUJI 塑料橡皮','白色 小',0,'/goods-img/70529ced-527a-4b46-aafa-874107ff9ea5.jpg','/goods-img/70529ced-527a-4b46-aafa-874107ff9ea5.jpg','商品介绍加载中...',4,4,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10069,'无印良品 MUJI 男式','无侧缝法兰绒 睡衣 深海军蓝X格子 L',0,'/goods-img/174ec60d-7d2b-4043-a7a6-7383c3de1a11.jpg','/goods-img/174ec60d-7d2b-4043-a7a6-7383c3de1a11.jpg','商品介绍加载中...',398,199,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10070,'无印良品 MUJI 荧光笔','蓝色',0,'/goods-img/eef29d44-17f5-41dd-b0ba-c6f63d7bdac3.jpg','/goods-img/eef29d44-17f5-41dd-b0ba-c6f63d7bdac3.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10071,'无印良品（MUJI） 钢制指甲刀 小','新蜂精选',0,'/goods-img/f9964432-a9b7-45c2-ac6d-680130c2d7a7.jpg','/goods-img/f9964432-a9b7-45c2-ac6d-680130c2d7a7.jpg','商品介绍加载中...',42,42,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10072,'无印良品 MUJI 长条诗笺型笔记表格','白色 40枚 14行',0,'/goods-img/da1e4523-adb4-48e4-afa5-313346187690.jpg','/goods-img/da1e4523-adb4-48e4-afa5-313346187690.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10073,'无印良品 MUJI PET喷雾小分装瓶100ml','新蜂精选',0,'/goods-img/7f1eec3d-d8e5-4a18-a1a9-b81876dcaaf5.jpg','/goods-img/7f1eec3d-d8e5-4a18-a1a9-b81876dcaaf5.jpg','商品介绍加载中...',30,30,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10074,'无印良品 MUJI 塑料橡皮','黑色 大',0,'/goods-img/1ca16211-2b80-4006-ab60-e1a3cab4218c.jpg','/goods-img/1ca16211-2b80-4006-ab60-e1a3cab4218c.jpg','商品介绍加载中...',7,7,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10075,'无印良品 MUJI 荧光笔','黄色',0,'/goods-img/56eec806-2af3-4136-a9bf-2333455339e7.jpg','/goods-img/56eec806-2af3-4136-a9bf-2333455339e7.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10076,'无印良品 MUJI 遮瑕膏','棒状 自然色',0,'/goods-img/593b65a7-feae-45aa-837e-47d58bb27474.jpg','/goods-img/593b65a7-feae-45aa-837e-47d58bb27474.jpg','商品介绍加载中...',42,42,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10077,'无印良品 MUJI 马桶刷/附盒子','白色',0,'/goods-img/a9983f71-d818-459d-ad59-bbdd26bb533b.jpg','/goods-img/a9983f71-d818-459d-ad59-bbdd26bb533b.jpg','商品介绍加载中...',70,70,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10078,'无印良品 MUJI 耐热玻璃_壶_大','透明',0,'/goods-img/7f89c29e-d888-4ee0-92af-ca713a7871a4.jpg','/goods-img/7f89c29e-d888-4ee0-92af-ca713a7871a4.jpg','商品介绍加载中...',150,150,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10079,'无印良品 MUJI 女式','平纹短袖衬衫 藏青色 M',0,'/goods-img/0b1e57bf-b4fd-40df-9832-4749d7d69db9.jpg','/goods-img/0b1e57bf-b4fd-40df-9832-4749d7d69db9.jpg','商品介绍加载中...',198,59,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10080,'无印良品 MUJI 基础润肤化妆水','清爽型 50ml',0,'/goods-img/9b4af7cf-235a-4742-bdc3-9e8e656f245c.png','/goods-img/9b4af7cf-235a-4742-bdc3-9e8e656f245c.png','商品介绍加载中...',28,22,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10081,'无印良品 MUJI 男式','无侧缝法兰绒 睡衣 炭灰色 M',0,'/goods-img/8ddfc2de-3da3-4fad-86aa-7c570cb55212.jpg','/goods-img/8ddfc2de-3da3-4fad-86aa-7c570cb55212.jpg','商品介绍加载中...',398,199,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10082,'无印良品（MUJI） PET分裝瓶','新蜂精选',0,'/goods-img/e62d04e9-3ae2-431c-8538-becda89e0e84.jpg','/goods-img/e62d04e9-3ae2-431c-8538-becda89e0e84.jpg','商品介绍加载中...',15,15,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10083,'无印良品 MUJI 女式','无侧缝法兰绒 睡衣 灰色 M',0,'/goods-img/3078143f-1cdd-4f66-951b-2cf08af8c826.jpg','/goods-img/3078143f-1cdd-4f66-951b-2cf08af8c826.jpg','商品介绍加载中...',398,199,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10084,'无印良品（MUJI） PE分裝瓶','新蜂精选',0,'/goods-img/97aa8872-26df-473a-b0d7-f5021776cb52.jpg','/goods-img/97aa8872-26df-473a-b0d7-f5021776cb52.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10085,'无印良品 MUJI 基础润肤化妆水','滋润型 200ml',0,'/goods-img/954da201-0cbb-45d1-9cd1-17ce4d24cfb4.png','/goods-img/954da201-0cbb-45d1-9cd1-17ce4d24cfb4.png','商品介绍加载中...',70,70,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10086,'无印良品 MUJI 男式','干爽 凉感珠地网眼编织V领短袖T恤 黑色 L',0,'/goods-img/b584ea09-7aae-422e-8435-fdc38c948434.jpg','/goods-img/b584ea09-7aae-422e-8435-fdc38c948434.jpg','商品介绍加载中...',98,29,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10087,'无印良品（MUJI） 聚丙烯化妆盒 半透明约150x220x169mm','新蜂精选',0,'/goods-img/a0a45b44-82c9-4a58-a972-304bed0632bb.jpg','/goods-img/a0a45b44-82c9-4a58-a972-304bed0632bb.jpg','商品介绍加载中...',40,40,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10088,'无印良品（MUJI） 散粉小 自然色','新蜂精选',0,'/goods-img/a1b8ff33-ec01-494e-a1db-fb5158f3c168.jpg','/goods-img/a1b8ff33-ec01-494e-a1db-fb5158f3c168.jpg','商品介绍加载中...',60,60,1000,'',0,0,'2019-09-18 13:19:07',0,'2019-09-18 13:19:07'),
	(10089,'无印良品 MUJI 荧光笔','粉红色',0,'/goods-img/c5d6d952-c81b-436a-a345-feb4c5a20a7d.jpg','/goods-img/c5d6d952-c81b-436a-a345-feb4c5a20a7d.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10090,'无印良品（MUJI） PET小分装瓶100ml','新蜂精选',0,'/goods-img/2ffe59f3-559f-4e6f-810d-1b6fa4ac04e1.jpg','/goods-img/2ffe59f3-559f-4e6f-810d-1b6fa4ac04e1.jpg','商品介绍加载中...',30,30,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10091,'无印良品 MUJI 基础润肤洁面乳','150ml',0,'/goods-img/1f24d75a-0468-471a-a608-bd6788f4c1a1.jpg','/goods-img/1f24d75a-0468-471a-a608-bd6788f4c1a1.jpg','商品介绍加载中...',74,74,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10092,'无印良品 MUJI 基础润肤乳霜','其他 50g',0,'/goods-img/86e027b3-8868-4fa5-971b-49e827027e3e.jpg','/goods-img/86e027b3-8868-4fa5-971b-49e827027e3e.jpg','商品介绍加载中...',100,100,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10093,'无印良品 MUJI 基础润肤洁面泡沫(替换装)','180ml',0,'/goods-img/1aea34fa-f45e-4c3c-b73c-da1f92492c95.jpg','/goods-img/1aea34fa-f45e-4c3c-b73c-da1f92492c95.jpg','商品介绍加载中...',69,69,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10094,'无印良品 MUJI 保湿洁面啫喱','100g',0,'/goods-img/838fc0cb-b98f-4dca-bd68-581138b21a30.jpg','/goods-img/838fc0cb-b98f-4dca-bd68-581138b21a30.jpg','商品介绍加载中...',100,50,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10095,'无印良品 MUJI 小型超声波香薰机','其他',0,'/goods-img/30f05c92-a303-4b94-bb5e-22f3c65f3c37.jpg','/goods-img/30f05c92-a303-4b94-bb5e-22f3c65f3c37.jpg','商品介绍加载中...',250,250,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10096,'无印良品 MUJI 修正带','其他',0,'/goods-img/759427b3-b723-4917-b565-c0ae2003bf02.jpg','/goods-img/759427b3-b723-4917-b565-c0ae2003bf02.jpg','商品介绍加载中...',25,25,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10097,'无印良品 MUJI 聚丙烯','笔盒 小/约170*51*20㎜',0,'/goods-img/734f1604-e687-4cd1-8573-bb00e680e94e.jpg','/goods-img/734f1604-e687-4cd1-8573-bb00e680e94e.jpg','商品介绍加载中...',12,12,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10098,'无印良品 MUJI 乳液','50ml',0,'/goods-img/4eed1033-7728-477c-a29d-589bfd3ae3ce.jpg','/goods-img/4eed1033-7728-477c-a29d-589bfd3ae3ce.jpg','商品介绍加载中...',55,27,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10099,'无印良品 MUJI 男式','棉水洗 平纹短袖衬衫 白色 L',0,'/goods-img/d3fa11f3-6cfa-4958-b09c-584a62137b4b.jpg','/goods-img/d3fa11f3-6cfa-4958-b09c-584a62137b4b.jpg','商品介绍加载中...',178,89,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10100,'无印良品 MUJI 香/绿意','12支装/棒状',0,'/goods-img/829f2d09-1589-4f63-8376-d347c3cec620.jpg','/goods-img/829f2d09-1589-4f63-8376-d347c3cec620.jpg','商品介绍加载中...',32,32,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10101,'无印良品 MUJI 润肤乳霜(高保湿型)50g','50g',0,'/goods-img/1c70ddcb-ca69-40ed-a263-30880b2e2cac.jpg','/goods-img/1c70ddcb-ca69-40ed-a263-30880b2e2cac.jpg','商品介绍加载中...',159,159,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10102,'无印良品 MUJI 柔滑笔芯','黑色',0,'/goods-img/1db10d7c-3429-4ef2-ac41-2991af57f442.jpg','/goods-img/1db10d7c-3429-4ef2-ac41-2991af57f442.jpg','商品介绍加载中...',19,19,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10103,'无印良品 MUJI 铝制','挂钩/吸盘式_2个装 大/约宽4.5x高6cm 2个装',0,'/goods-img/bd0b92b4-c8ca-453a-b572-b3447083bddf.png','/goods-img/bd0b92b4-c8ca-453a-b572-b3447083bddf.png','商品介绍加载中...',25,25,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10104,'无印良品 MUJI 修正带','POM材质 替芯',0,'/goods-img/98ce17e1-890e-4eaf-856a-7fce8ffebc4c.jpg','/goods-img/98ce17e1-890e-4eaf-856a-7fce8ffebc4c.jpg','商品介绍加载中...',15,15,998,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10105,'无印良品 MUJI 压克力记录板夹','Ａ4用/220×310ｍｍ',0,'/goods-img/64d4e0b7-cd01-47f6-9081-4c2e7625e4f9.jpg','/goods-img/64d4e0b7-cd01-47f6-9081-4c2e7625e4f9.jpg','商品介绍加载中...',35,35,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10106,'无印良品（MUJI） 自然亲肤粉底液 自然透亮色','新蜂精选',0,'/goods-img/09576fcd-ea01-4b1d-bed4-be96b71f2c4e.jpg','/goods-img/09576fcd-ea01-4b1d-bed4-be96b71f2c4e.jpg','商品介绍加载中...',75,75,1000,'',0,0,'2019-09-18 13:19:17',0,'2019-09-18 13:19:17'),
	(10107,'无印良品 MUJI 荧光笔','粉红色',0,'/goods-img/04a8c325-d296-4f0e-ac6d-8cccba4dc90e.jpg','/goods-img/04a8c325-d296-4f0e-ac6d-8cccba4dc90e.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10108,'无印良品（MUJI） PET小分装瓶100ml','新蜂精选',0,'/goods-img/755a34a3-bc3e-4f04-8943-f79860012e78.jpg','/goods-img/755a34a3-bc3e-4f04-8943-f79860012e78.jpg','商品介绍加载中...',30,30,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10109,'无印良品 MUJI 基础润肤洁面乳','150ml',0,'/goods-img/e6a986ed-9b83-4649-9e72-3cf676c1f90e.jpg','/goods-img/e6a986ed-9b83-4649-9e72-3cf676c1f90e.jpg','商品介绍加载中...',74,74,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10110,'无印良品 MUJI 基础润肤乳霜','其他 50g',0,'/goods-img/30036561-a150-4ea7-9106-29bbea278909.jpg','/goods-img/30036561-a150-4ea7-9106-29bbea278909.jpg','商品介绍加载中...',100,100,999,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10111,'无印良品 MUJI 基础润肤洁面泡沫(替换装)','180ml',0,'/goods-img/aa37202c-68eb-4c84-b02c-171b3d11c0e8.jpg','/goods-img/aa37202c-68eb-4c84-b02c-171b3d11c0e8.jpg','商品介绍加载中...',69,69,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10112,'无印良品 MUJI 保湿洁面啫喱','100g',0,'/goods-img/0f724c0f-8888-4b75-8fe1-dc7dd8f2b7bd.jpg','/goods-img/0f724c0f-8888-4b75-8fe1-dc7dd8f2b7bd.jpg','商品介绍加载中...',100,50,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10113,'无印良品 MUJI 小型超声波香薰机','其他',0,'/goods-img/9608b59d-cbca-4b70-9f05-226fde41c51c.jpg','/goods-img/9608b59d-cbca-4b70-9f05-226fde41c51c.jpg','商品介绍加载中...',250,250,999,'呼吸品质生活',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10114,'无印良品 MUJI 修正带','其他',0,'/goods-img/d91a71e7-aada-4770-91c5-4da21e4b7ed9.jpg','/goods-img/d91a71e7-aada-4770-91c5-4da21e4b7ed9.jpg','商品介绍加载中...',25,25,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10115,'无印良品 MUJI 聚丙烯','笔盒 小/约170*51*20㎜',0,'/goods-img/d543ba0d-18d8-427a-87ea-99968b319440.jpg','/goods-img/d543ba0d-18d8-427a-87ea-99968b319440.jpg','商品介绍加载中...',12,12,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10116,'无印良品 MUJI 乳液','50ml',0,'/goods-img/cd6d91b0-69b2-4415-8560-4cbd2690cb50.jpg','/goods-img/cd6d91b0-69b2-4415-8560-4cbd2690cb50.jpg','商品介绍加载中...',55,27,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10117,'无印良品 MUJI 男式','棉水洗 平纹短袖衬衫 白色 L',0,'/goods-img/b08c94ac-cba2-4468-b3d0-03d9447f5bf2.jpg','/goods-img/b08c94ac-cba2-4468-b3d0-03d9447f5bf2.jpg','商品介绍加载中...',178,89,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10118,'无印良品 MUJI 香/绿意','12支装/棒状',0,'/goods-img/5a65f952-4141-47f8-8f8e-84120bbf74ea.jpg','/goods-img/5a65f952-4141-47f8-8f8e-84120bbf74ea.jpg','商品介绍加载中...',32,32,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10119,'无印良品 MUJI 润肤乳霜(高保湿型)50g','50g',0,'/goods-img/503ef53e-d4ac-4c4e-83a7-8a03ead0ecc8.jpg','/goods-img/503ef53e-d4ac-4c4e-83a7-8a03ead0ecc8.jpg','商品介绍加载中...',159,159,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10120,'无印良品 MUJI 柔滑笔芯','黑色',0,'/goods-img/aa83ce5b-2db1-4ecf-bc4f-f43c437894d7.jpg','/goods-img/aa83ce5b-2db1-4ecf-bc4f-f43c437894d7.jpg','商品介绍加载中...',19,19,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10121,'无印良品 MUJI 铝制','挂钩/吸盘式_2个装 大/约宽4.5x高6cm 2个装',0,'/goods-img/5c590548-9de3-47a3-8cb9-4d8f040a9635.png','/goods-img/5c590548-9de3-47a3-8cb9-4d8f040a9635.png','商品介绍加载中...',25,25,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10122,'无印良品 MUJI 修正带','POM材质 替芯',0,'/goods-img/93181f0b-c069-4542-be91-a63856cd12d1.jpg','/goods-img/93181f0b-c069-4542-be91-a63856cd12d1.jpg','商品介绍加载中...',15,15,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10123,'无印良品 MUJI 压克力记录板夹','Ａ4用/220×310ｍｍ',0,'/goods-img/45be1de3-447b-404b-9df8-ddf07fdc8647.jpg','/goods-img/45be1de3-447b-404b-9df8-ddf07fdc8647.jpg','商品介绍加载中...',35,35,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10124,'无印良品（MUJI） 自然亲肤粉底液 自然透亮色','新蜂精选',0,'/goods-img/7f905827-5765-40bc-a1b8-bedd9f407ced.jpg','/goods-img/7f905827-5765-40bc-a1b8-bedd9f407ced.jpg','商品介绍加载中...',75,75,1000,'',0,0,'2019-09-18 13:19:22',0,'2019-09-18 13:19:22'),
	(10125,'无印良品 MUJI PE小分装盒','透明 30g',0,'/goods-img/1d7f28bb-6597-48de-a6bb-2561697db883.jpg','/goods-img/1d7f28bb-6597-48de-a6bb-2561697db883.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10126,'无印良品 MUJI 保湿化妆液','新蜂精选',0,'/goods-img/53a089a9-e1d1-487e-974e-18bb4df41cf3.jpg','/goods-img/53a089a9-e1d1-487e-974e-18bb4df41cf3.jpg','商品介绍加载中...',160,80,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10127,'无印良品 MUJI 女式','棉弹力 高领T恤 深灰色 M',0,'/goods-img/53a6478b-4fd5-4add-b095-9fd4ad983a7b.jpg','/goods-img/53a6478b-4fd5-4add-b095-9fd4ad983a7b.jpg','商品介绍加载中...',128,40,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10128,'无印良品 MUJI 男式','棉水洗 牛津纽扣领短袖衬衫 白色 L',0,'/goods-img/561e9e6d-b130-468d-8328-36a5ff70cdfa.jpg','/goods-img/561e9e6d-b130-468d-8328-36a5ff70cdfa.jpg','商品介绍加载中...',178,89,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10129,'无印良品 MUJI 基础润肤乳液','高保湿型 50ml',0,'/goods-img/01514263-83b4-4ac7-aee3-5e5a2448414f.jpg','/goods-img/01514263-83b4-4ac7-aee3-5e5a2448414f.jpg','商品介绍加载中...',37,29,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10130,'MUJI 羽毛 靠垫','白色',0,'/goods-img/23e5ee1d-5bb7-4f2a-b4b5-4fbc9ca3c163.jpg','/goods-img/23e5ee1d-5bb7-4f2a-b4b5-4fbc9ca3c163.jpg','商品介绍加载中...',65,65,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10131,'无印良品（MUJI） 可携带用小卷尺 白色','新蜂精选',0,'/goods-img/a4d3a61e-b0d3-4c58-85d6-fddf1de85f66.jpg','/goods-img/a4d3a61e-b0d3-4c58-85d6-fddf1de85f66.jpg','商品介绍加载中...',28,28,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10132,'无印良品 MUJI 笔记本/5mm方格','暗灰色 B5/30张/线装',0,'/goods-img/38c25b00-a4fb-4893-aa8e-34ff76963397.jpg','/goods-img/38c25b00-a4fb-4893-aa8e-34ff76963397.jpg','商品介绍加载中...',9,9,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10133,'无印良品 MUJI 低重心铅笔','白色',0,'/goods-img/dc497882-61ea-4d4f-98fe-d2b2500eda01.jpg','/goods-img/dc497882-61ea-4d4f-98fe-d2b2500eda01.jpg','商品介绍加载中...',47,47,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10134,'无印良品（MUJI） 手动碎纸机','新蜂精选',0,'/goods-img/f6e1ce14-a590-4736-9d36-df5628bc4188.jpg','/goods-img/f6e1ce14-a590-4736-9d36-df5628bc4188.jpg','商品介绍加载中...',75,75,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10135,'无印良品 MUJI 女式','无袖衫 燕麦色 XL',0,'/goods-img/c2e30c9b-ce49-4824-824a-b7d3ae173340.jpg','/goods-img/c2e30c9b-ce49-4824-824a-b7d3ae173340.jpg','商品介绍加载中...',178,53,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10136,'无印良品 MUJI 女式','粗棉线长袖T恤 生成色 L',0,'/goods-img/4b1b98d5-359f-4025-85e3-f357b6e9724a.jpg','/goods-img/4b1b98d5-359f-4025-85e3-f357b6e9724a.jpg','商品介绍加载中...',198,70,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10137,'无印良品 MUJI 塑料浴室座椅/小','原色',0,'/goods-img/37053615-750d-486e-b218-358a7c1adb21.jpg','/goods-img/37053615-750d-486e-b218-358a7c1adb21.jpg','商品介绍加载中...',85,85,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10138,'无印良品（MUJI） 树脂携带型订书机 白色','新蜂精选',0,'/goods-img/21dd6bd9-c4bc-4e17-8fed-23775cebf361.jpg','/goods-img/21dd6bd9-c4bc-4e17-8fed-23775cebf361.jpg','商品介绍加载中...',42,42,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10139,'无印良品 MUJI 基础润肤乳液','滋润型',0,'/goods-img/b8978340-ff72-4b5a-a9d3-4b5610982764.jpg','/goods-img/b8978340-ff72-4b5a-a9d3-4b5610982764.jpg','商品介绍加载中...',28,22,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10140,'无印良品（MUJI） 控色隔离霜30g 浅蓝色','新蜂精选',0,'/goods-img/b2969d29-b073-48f3-aa9a-b8aeb08a98d6.jpg','/goods-img/b2969d29-b073-48f3-aa9a-b8aeb08a98d6.jpg','商品介绍加载中...',65,65,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10141,'无印良品 MUJI 女式','粗棉线条纹长袖T恤 黑*横条 L',0,'/goods-img/a905c374-3411-4ddd-9b84-7ecbc9b50620.jpg','/goods-img/a905c374-3411-4ddd-9b84-7ecbc9b50620.jpg','商品介绍加载中...',198,70,1000,'',0,0,'2019-09-18 13:19:30',0,'2019-09-18 13:19:30'),
	(10142,'无印良品 MUJI PE小分装盒','透明 30g',0,'/goods-img/2750405a-2e01-463d-a059-54644c67f7cc.jpg','/goods-img/2750405a-2e01-463d-a059-54644c67f7cc.jpg','商品介绍加载中...',10,10,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10143,'无印良品 MUJI 保湿化妆液','新蜂精选',0,'/goods-img/17656dd7-c0fb-431d-810a-5eb29d07c011.jpg','/goods-img/17656dd7-c0fb-431d-810a-5eb29d07c011.jpg','商品介绍加载中...',160,80,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10144,'无印良品 MUJI 女式','棉弹力 高领T恤 深灰色 M',0,'/goods-img/780e716a-7be8-4d94-b8b6-833b4d97e148.jpg','/goods-img/780e716a-7be8-4d94-b8b6-833b4d97e148.jpg','商品介绍加载中...',128,40,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10145,'无印良品 MUJI 男式','棉水洗 牛津纽扣领短袖衬衫 白色 L',0,'/goods-img/94f5b471-1148-4320-aa8a-68573706fd91.jpg','/goods-img/94f5b471-1148-4320-aa8a-68573706fd91.jpg','商品介绍加载中...',178,89,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10146,'无印良品 MUJI 基础润肤乳液','高保湿型 50ml',0,'/goods-img/a12dcb9c-bb36-4df9-b517-1578a03fe062.jpg','/goods-img/a12dcb9c-bb36-4df9-b517-1578a03fe062.jpg','商品介绍加载中...',37,29,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10147,'MUJI 羽毛 靠垫','白色',0,'/goods-img/0f701215-b782-40c7-8bbd-97b51be56461.jpg','/goods-img/0f701215-b782-40c7-8bbd-97b51be56461.jpg','商品介绍加载中...',65,65,982,'悠享惬意',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10148,'无印良品（MUJI） 可携带用小卷尺 白色','新蜂精选',0,'/goods-img/737afa41-1905-4dbc-ab33-95f8489dde5b.jpg','/goods-img/737afa41-1905-4dbc-ab33-95f8489dde5b.jpg','商品介绍加载中...',28,28,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10149,'无印良品 MUJI 笔记本/5mm方格','暗灰色 B5/30张/线装',0,'/goods-img/c6632420-ad7e-451b-a2a9-b02299653db1.jpg','/goods-img/c6632420-ad7e-451b-a2a9-b02299653db1.jpg','商品介绍加载中...',9,9,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10150,'无印良品 MUJI 低重心铅笔','白色',0,'/goods-img/060e3ace-71ca-44a2-9ded-73a05f186fcf.jpg','/goods-img/060e3ace-71ca-44a2-9ded-73a05f186fcf.jpg','商品介绍加载中...',47,47,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10151,'无印良品（MUJI） 手动碎纸机','新蜂精选',0,'/goods-img/58d831e4-07f4-44e2-a994-1a7d585452a1.jpg','/goods-img/58d831e4-07f4-44e2-a994-1a7d585452a1.jpg','商品介绍加载中...',75,75,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10152,'无印良品 MUJI 女式','无袖衫 燕麦色 XL',0,'/goods-img/f2aaadc0-ddda-4736-9826-2dbb2c533ea0.jpg','/goods-img/f2aaadc0-ddda-4736-9826-2dbb2c533ea0.jpg','商品介绍加载中...',178,53,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10153,'无印良品 MUJI 女式','粗棉线长袖T恤 生成色 L',0,'/goods-img/09c87218-d645-48e7-bbd5-54af5e77bf4b.jpg','/goods-img/09c87218-d645-48e7-bbd5-54af5e77bf4b.jpg','商品介绍加载中...',198,70,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10154,'无印良品 MUJI 塑料浴室座椅','原色',0,'/goods-img/15395057-94e9-4545-a8ee-8aee025f40c5.jpg','/goods-img/15395057-94e9-4545-a8ee-8aee025f40c5.jpg','商品介绍加载中...',85,85,999,'无印良品',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10155,'无印良品（MUJI） 树脂携带型订书机 白色','新蜂精选',0,'/goods-img/3b40971a-3f32-45cf-a99a-aada90ee8e33.jpg','/goods-img/3b40971a-3f32-45cf-a99a-aada90ee8e33.jpg','商品介绍加载中...',42,42,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10156,'无印良品 MUJI 基础润肤乳液','滋润型',0,'/goods-img/f65ef709-8fa8-4a3f-8abd-75a9b0492b14.jpg','/goods-img/f65ef709-8fa8-4a3f-8abd-75a9b0492b14.jpg','商品介绍加载中...',28,22,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10157,'无印良品（MUJI） 控色隔离霜30g 浅蓝色','新蜂精选',0,'/goods-img/66311489-b28b-41c3-ac34-540293df6e42.jpg','/goods-img/66311489-b28b-41c3-ac34-540293df6e42.jpg','商品介绍加载中...',65,65,1000,'',0,0,'2019-09-18 13:19:35',0,'2019-09-18 13:19:35'),
	(10158,'无印良品 女式粗棉线条纹长袖T恤','黑*横条 L',20,'/goods-img/5488564b-8335-4b0c-a5a4-52f3f03ee728.jpg','http://localhost:28089/goods-img/5488564b-8335-4b0c-a5a4-52f3f03ee728.jpg','商品介绍加载中...',198,70,994,'无印良品',0,0,'2019-09-18 13:19:35',0,'2019-09-18 17:50:19'),
	(10159,'Apple AirPods 配充电盒','苹果蓝牙耳机',0,'/goods-img/53c9f268-7cd4-4fac-909c-2dc066625655.jpg','/goods-img/53c9f268-7cd4-4fac-909c-2dc066625655.jpg','详情加载中...',1246,1246,982,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10160,'小米 Redmi AirDots','真无线蓝牙耳机|分体式耳机 |收纳充电盒 |蓝牙5.0 |按键防触控操作',51,'/goods-img/c47403f1-b706-453b-88d8-2bfdee0316be.jpg','/goods-img/c47403f1-b706-453b-88d8-2bfdee0316be.jpg','详情加载中...',129,129,996,'为自由发声',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10161,'荣耀原装三键线控带麦半入耳式耳机AM116(尊爵版)适用于华为荣耀手机','新蜂精选',0,'/goods-img/183481c3-47ff-4b2e-926f-b02b926ac02c.jpg','/goods-img/183481c3-47ff-4b2e-926f-b02b926ac02c.jpg','商品介绍加载中...',69,49,998,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10162,'诺基亚（NOKIA）BH-705 银白色 5.0真无线蓝牙耳机迷你运动跑步音乐商务入耳式安卓苹果手机蓝牙耳机','新蜂精选',0,'/goods-img/5e0d089b-fa91-410d-8ff2-9534eb6f627f.jpg','/goods-img/5e0d089b-fa91-410d-8ff2-9534eb6f627f.jpg','详情加载中...',499,499,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10163,'华为耳机原装半入耳式有线mate9p10plus8x荣耀v20v10nova2s9iv9p9play 【标准版】华为AM115 白色-热卖款','新蜂精选',0,'/goods-img/79e2b467-a075-46ef-ab43-aa0535f8e4c9.jpg','/goods-img/79e2b467-a075-46ef-ab43-aa0535f8e4c9.jpg','商品介绍加载中...',69,39,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10164,'Beats X 蓝牙无线','入耳式耳机 带麦可通话 -桀骜黑红（十周年版） MRQA2PA/A',0,'/goods-img/911531a4-39a6-4771-b26e-2ba4db1ebcda.jpg','/goods-img/911531a4-39a6-4771-b26e-2ba4db1ebcda.jpg','商品介绍加载中...',1168,799,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10165,'华为（ HUAWEI） 华为无线耳机','真无线蓝牙耳机 双耳蓝牙音乐耳机 Freebuds 2 无线耳机 陶瓷白',0,'/goods-img/e70a4f29-2269-466a-984e-01e018206c2e.jpg','/goods-img/e70a4f29-2269-466a-984e-01e018206c2e.jpg','详情加载中...',899,799,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10166,'【自营仓次日达】moloke真无线蓝牙耳机双耳适用于苹果华为小米 运动跑步入耳式oppo迷你商务耳机 【1:1尊享版】自动弹窗+无线充电+可触控（热卖）','新蜂精选',51,'/goods-img/70dc1586-13bd-4b4c-92a9-fe20aa1d531f.jpg','/goods-img/70dc1586-13bd-4b4c-92a9-fe20aa1d531f.jpg','商品介绍加载中...',359,199,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10167,'Beats Powerbeats Pro','完全无线高性能耳机 真无线蓝牙运动耳机 象牙白',0,'/goods-img/04441cd4-81c8-4ad9-a067-9d15422e508f.jpg','/goods-img/04441cd4-81c8-4ad9-a067-9d15422e508f.jpg','详情加载中...',1888,1888,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10168,'纽曼（Newmine）NM-LK06 全兼容线控音乐手机耳机 白色','新蜂精选',0,'/goods-img/ad53ea23-6974-4e44-b62d-eab498ce1d63.jpg','/goods-img/ad53ea23-6974-4e44-b62d-eab498ce1d63.jpg','商品介绍加载中...',9,9,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10169,'索尼（SONY）重低音立体声耳机MDR-XB55AP 黑色','新蜂精选',0,'/goods-img/01e1998d-f183-4e99-b8ba-7715727cf90b.jpg','/goods-img/01e1998d-f183-4e99-b8ba-7715727cf90b.jpg','*黑色实物偏灰，请以实物为准 Bass Booster低音增强器技术可呈现紧实深邃低频。 12 毫米驱动单元和110dB/mW 的高灵敏度，呈现高质感音效。 人体工学设计的倾斜入耳方式，让耳塞能够深入耳朵内部，呈现出色的隔音效果，同时带来舒适的佩戴感和高音质的享受。 耳塞能够深入耳朵内部，呈现出色的隔音效果，同时为您带来舒适的佩戴感和高音质的享受。 采用混合两种硬度硅胶的耳塞套： 核心部分使用硬质材料保持音质，减少因耳塞变形导致的声音失真； 外围部分柔软材料提高了耳塞密闭性，让您能长时间舒适佩戴。 *线控的可用性及操作因智能手机而异 耳机线表面细小沟壑，减少容易引起缠绕的摩擦，使导线不容易纠结在一起，方便欣赏音乐和携带。 防缠绕耳机线 盲点设计 便携袋 防尘滤网 导线滑块 4种尺寸耳塞套 摘下耳机的耳塞套，可见保护单元的网罩，用来防止异物和灰尘堵塞单元，使耳机经久耐听。 在左耳外壳和耳机线的连接处设有浮点，凭手指触摸就能判别左右耳，方便操作。 随机附赠收纳袋一只，保护你心爱的耳机。 利用导线滑块来调整左右耳机线的长度，也能够减少收纳耳机时容易出现的缠线现象 提供4对不同尺寸（SS、S、M、L）的耳塞套（M号出厂时已安装至耳机上），根据你的耳洞大小自由更换，获得良好的隔音效果，佩戴舒适。 ● 立体声耳机 ● 混合硅胶耳塞（SS/S/M/L 每种尺寸2个) *M号出厂时安装至本耳机。 ● 便携袋(×1) *EXTRA BASS 和 EXTRABASS 是索尼公司的商标',229,185,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10170,'索尼（SONY）WI-1000X Hi-Res颈挂式 入耳式','无线蓝牙耳机 高音质降噪耳机 手机通话 黑色',0,'/goods-img/1631a30b-287c-41da-bbbe-1a9b1b8d1552.jpg','/goods-img/1631a30b-287c-41da-bbbe-1a9b1b8d1552.jpg','详情加载中...',2399,1499,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10171,'小米耳机 圈铁Pro 入耳式有线运动音乐耳机耳麦','新蜂精选',51,'/goods-img/f3d269a4-5317-4b30-b164-1311f6c1f058.jpg','/goods-img/f3d269a4-5317-4b30-b164-1311f6c1f058.jpg','使用双动圈 + 动铁 三单元发声 ／ 均衡自然声音 高保真石墨烯振膜 ／ 25 道工序打磨 ／ 弹力磨砂线材 Pro 小米圈铁耳机 孕育万物的天空和大地，时刻传达着声音的释放与组合，更是寻找灵感的源头，鸟鸣、流水、雷响、风啸不同的声音互相交融，共同演奏出自然的本真。 小米圈铁耳机 Pro 使用双“动圈”单元+“动铁”单元，将三个单元共同融入到同一个耳机中，双“动圈”的醇厚低音，让声音更加扎实稳重，石墨烯材料的加入，则让声音的细节更为丰富。“动铁”的高音透亮，稳定自然，感受三频均衡的本色声音。随着声音的流淌，仿佛置身自然，听见这些细节，让声音一开始就感动内心。 双动圈+动铁，三单元发声，听见更多细节 为了可以真正实现高、中、低三频均衡，小米圈铁耳机 Pro  加入了双“动圈”单元，大动圈负责中低频，小动圈负责高频。在“动铁”单元的配合下，耳机的低频下潜深，中频声音扎实，而高频的细节展现更为丰富。那些刚刚好的声音，听在耳里，都在心里。 三频更均衡，声音更自然 我们听到的绝大多数乐器、人声，都在中低频段。为了让这部分声音更均衡、有感染力，我们都交由采用了石墨烯振膜的双动圈单元来负责，中低频更扎实，兼具丰富细节表现力。 石墨烯是目前自然界已知材料中轻薄、强度更高的材料，对声音的传导速度快，将它用作振膜材质，高频延展性能更好，细节丰富，声音清澈自然，更富穿透力。同时强度又是钢铁的100倍， 可以尽可能还原出电流信号， 真正发出高保真的好声音。 石墨烯振膜，让双动圈更有实力 小米圈铁耳机 Pro 的“动铁”单元依然采用自主研发的 \"衔铁＋驱动杆\" 结构，让声音细腻真实，更为稳定，在电容分频器的作用下，让高中低音衔接更好，失真更少。不论当你听何种音乐，细腻的感情都会被准确还原，听每首歌就像读每个故事，时刻感动自己。 动铁单元设计，高频解析好，细节不失真 好的音乐人将情感与生活用真实的方式，转化为音乐传递给每个人，每首歌都是一个故事，铭刻在各自的记忆中，为了让故事更好的表达，小米圈铁耳机 Pro 在科学客观调音的基础上，再次邀请到荣获 4 次格莱美大奖的 Luca Bignardi，为小米圈铁耳机 Pro 进行主观调音，为的就是让每个喜爱音乐的人能够真切的感受到每一个故事，跟随内心，娓娓道来... 多种科学调音，让声音更鲜活，更温暖 当耳机真正为声音服务时，设计将不再只是修饰耳机外观的道具，它将会成为辅助声音的一部分，小米圈铁耳机 Pro 采用圆润的设计风格，45° 斜角入耳设计，在满足舒适的同时更保证了声音的完整呈现。精密金属音腔设计，让音乐沉于耳畔，更有声音质感，弹力 TPE 磨砂线材的选用，让耳机线更为坚固耐用，确保耳机长久使用。一副好耳机，让声音和外表一起美好。 全新的外观设计，和声音一起美好 好的设计需要灵感，而灵感源于生活，为了锁住声音的灵感，小米圈铁耳机 Pro 将耳塞设计成45°斜角式入耳，贴合耳道，满足佩戴舒适感的同时尽可能减少外界声音干扰，毫无保留地听自己爱的音乐。 45°斜角入耳，舒适佩戴 小米圈铁耳机 Pro 的线控麦克风从耳机整体设计风格出发，金属磨砂弹头造型，精致小巧，指压按键圆润舒适，听歌的同时，更能感知指尖上的金属质感。 小米圈铁耳机 Pro 的耳机线材选取 TPE 材质，作为一种具有橡胶的高弹性材质， 触感柔软、耐温等特性，用它做成耳机线，将更为抗拉、耐用并且不易缠绕。让好音乐的陪伴更长久。 小米圈铁耳机 Pro 的耳塞选取奶嘴级硅胶材质，触感柔软顺滑，减少了耳塞对皮肤的刺激，让肌肤倍感亲密，同时提供四对不同尺寸的耳塞套，让佩戴者根据不同需求选择，带上它，向自己喜爱的音乐问好！ 用匠心打磨每一件产品，即使过程艰难复杂，也依然充满斗志，小米圈铁耳机 Pro 的诞生过程就是这样。25 道工序打造的金属音腔，每一处细节都精心打磨，一体成型钻石切割、细密 CD 纹雕刻、锆石喷砂、阳极氧化，千锤百炼，不放过每个细节，将金属打磨成入耳的艺术品，这就是小米圈铁耳机 Pro 对音乐执着，对好产品更要执着。 小米圈铁耳机 Pro 是铝合金音腔，采用了 CNC 钻石切割一刀成型工艺，加工精度高达0.01mm，这种工艺在对铝合金加工前都要进行工艺分析，选择合适的刀具及切削用量，将打磨成型，让耳机具有更细腻润泽的手感。 小米圈铁耳机 Pro 运用精密的 CD 纹处理，纹理细至 0.14mm，散发金属光泽，就像耳机的指纹一样。如此的精密打磨，只为让小米圈铁耳机 Pro 更具质感，让金属更光辉熠熠。 选用精细锆石喷砂，赋予小米圈铁耳机 Pro 细致均匀的外观，有效保证了耳机表面硬度，不易刮伤。出厂时，会在小米圈铁耳机 Pro 表层增加阳极处理，保证了美观程度和耐磨性，6μ的阳极厚度，坚固、耐磨，做传达好声音的艺术品。 拥有超过 700 项高于行业标准的苛刻测试，每一种测试都见证了小米圈铁耳机 Pro 的高品质， 从音乐品质到设计创新，再到匠心工艺，集合好耳机的所有亮点，都只为带给用户更好的音乐体验和使用感受，好的声音，一定需要千锤百炼 。',149,149,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10172,'Bose QuietControl 30','无线耳机 QC30耳塞式蓝牙降噪耳麦',0,'/goods-img/966a8b32-f547-457c-9161-009d3113d584.jpg','/goods-img/966a8b32-f547-457c-9161-009d3113d584.jpg','商品介绍加载中...',2498,2498,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10173,'Beats Solo3 Wireless','头戴式 蓝牙无线耳机 手机耳机 游戏耳机 - 桀骜黑红（十周年版） MRQC2PA/A',0,'/goods-img/72218e28-fc58-4aa0-b3cd-c1f2c764d25e.jpg','/goods-img/72218e28-fc58-4aa0-b3cd-c1f2c764d25e.jpg','商品介绍加载中...',2268,1698,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10174,'索尼（SONY）WH-1000XM3 高解析度无线蓝牙降噪 头戴式耳机（触控面板','智能降噪 长久续航）黑色',0,'/goods-img/4cc6c606-4d69-4f49-b10c-01cedeef813f.jpg','/goods-img/4cc6c606-4d69-4f49-b10c-01cedeef813f.jpg','详情加载中...',2899,2599,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10175,'雷蛇 Razer 北海巨妖标准版X','北海巨妖标准版升级款 头戴式游戏耳机 电竞耳麦 7.1 电脑手机耳机 黑色',0,'/goods-img/7345c467-6c2d-4f30-a73d-83d675d5208c.jpg','/goods-img/7345c467-6c2d-4f30-a73d-83d675d5208c.jpg','产品信息Product Information 产品规格Product Specifications 品牌介绍Brand Introduction 注意事项Warning & Caution 雷蛇产品在出厂时会进行检测，脚贴及USB接口处如有轻微划痕属于正常测试痕迹。 RAZER关于划痕的注意事项： 以上数据图片均为官方测试环境下结果，因使用环境/设备不同会存在一定的差异，仅供参考，数据请以实际为准！  1. 产品实物与外包装上的SN（序列号）必须一致； 2. 产品外包装不能严重破损，盒内的相关配件要齐全，不能有缺失； 3. 不能有明显的人为破损（表面有明显的人为划痕，使用及存在拆卸的痕迹）； 4. 防伪标签不得撕开或损毁。 RAZER关于7天无理由退换货的注意事项： ',349,299,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10176,'森海塞尔（Sennheiser）MomentumTrueWireless 真无线蓝牙hifi发烧入耳式耳机 蓝牙5.0','黑色',0,'/goods-img/efea018e-8ab0-47f9-a3d4-260c8cd2de5f.jpg','/goods-img/efea018e-8ab0-47f9-a3d4-260c8cd2de5f.jpg','聆听带来改变 真     无     线     蓝     牙     HiFi     耳     机 MOMENTUM 真无线 懂你所需 全新的 MOMENTUM 真无线耳机，高品质的声音质量传承 MOMENTUM 品质，成为一款具有重要技术成就的新产品。 这款性能优异的蓝牙耳机融合音频质量、佩戴舒适性和精致设计及工艺。 全新的 MOMENTUM 透明聆听功能 防水防泼溅 电池使用时长 （4+8小时） 精雕细琢 经典优雅 高品质声音质量 智能降噪 智能触控操作 支持蓝牙5.0技术 智能触控操作 支持蓝牙 5.0技术 MOMENTUM真无线耳机采用Sennheiser发烧级别7毫米动圈驱动单元，可确保饱满的立体声效果，带来高保真音质，为苛刻的听者带来出色的高保真度。 高品质声音质量 两侧触摸区域都有单独的控制功能，您可以轻松使用右耳耳机语音访问智能助手（如苹果 Siri或Google智能助手）。 轻轻点击或滑动触摸界面，使用自然语音命令即可播放音乐、接听电话。 支持蓝牙5.0技术及编解码技术（包括AAC、Qualcomm apt-XTM和apt-X低延迟），这款耳机带来出众的连接稳定性和音频流畅性。 真正的无线体验 轻松适配周围环境 MOMENTUM 真无线耳机让你更好地感知外部环境，透明聆听让你能听到周围的环境声，从而更好地感知周围的环境，不需要摘掉耳机就能融入到自然的交谈之中。甚至在嘈杂的环境中，电话呼叫和语音交互也能够通过双话筒波束成形技术得以实现。 智能交互 通过自动开启/关闭和智能暂停功能，可以检测到耳机何时被收起来或者不使用，从而节约能源。 你的世界由你把控 通过双击右耳耳机开/关透明聆听功能 打开透明聆听=接收周围环境音 关闭透明聆听=物理降噪模式，不接收周围音 不需要摘掉耳机就可轻松地与周围人进行交谈。 4种尺寸的耳垫可选，均符合人体工程学设计，防水防泼溅，能够满足用户舒适佩戴的需求。 个性定制舒适体验 MOMENTUM真无线拥有4小时电池续航时间，可通过其带有集成电源的小巧耳机盒进行充电，从而享受长达12（4+8）小时的全天聆听乐趣，并满足未来所需。 镀金充电接触点 可磁性吸附到充电盒上 高保真7毫米动圈驱动单元 带来出色的声音重放 金属镭射表面 具有触控功能 多色 LED指示灯 用于语音信号拾取和透明聆听功能的话筒 舒适的入耳式 硅胶耳垫 便捷充电盒持久续航 注重细节、富于美感，这款小巧、 靓丽而轻盈的耳机是技术与艺术的 结合。它既是声音重放技术的成就，更是你耳畔精美的配饰。 质感黑色外壳，闪烁的金属镭射表面，镀金的充电接触点——时尚与功能融合于标志性的设计之中，带来优雅和实用感。 Sennheiser智能控制 MOMENTUM 真无线耳机提供了更为智能和个性化的体验，可以通过新款Sennheiser智能控制应用进行优化，根据个人喜好，利用内置音频EQ对声音进行微调。免费下载，兼容iOS 版本 11.0 及以上版本和Android 版本 7.0 及以上版本 ，简便直观的控制界面，为您的耳机提供个性化的配置和升级等功能。 APP 下载方法 Android 版本 7.0 及以上版本 打开链接下载APP https://share.weiyun.com/54byqjn iOS 版本 11.0 及以上版本 打开APP Store搜索 Sennheiser smart control 下载APP',2399,2399,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10177,'Bose SoundSport Free','真无线蓝牙耳机--黑色 运动耳机 防掉落耳塞',0,'/goods-img/b3de8a39-e33c-432f-872f-46f4a1662498.jpg','/goods-img/b3de8a39-e33c-432f-872f-46f4a1662498.jpg','商品介绍加载中...',1699,1699,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10178,'华为原装降噪有线手机耳机Mate9 10P9P10Plus荣耀V9V10PlayNova2s9i8x 【送耳机收纳包】AM115半入耳式耳机-经典热卖款','新蜂精选',0,'/goods-img/d6565a7e-473b-4933-93c5-e646495c8c4c.jpg','/goods-img/d6565a7e-473b-4933-93c5-e646495c8c4c.jpg','详情加载中...',99,39,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10179,'Apple 采用Lightning/闪电接头的 EarPods','耳机',0,'/goods-img/bf6ccbc4-d0d0-4fbb-b975-4becb9cb38f4.jpg','/goods-img/bf6ccbc4-d0d0-4fbb-b975-4becb9cb38f4.jpg','详情加载中...',223,223,1000,'',0,0,'2019-09-18 13:21:28',0,'2019-09-18 13:21:28'),
	(10180,'Apple AirPods 配充电盒','苹果蓝牙耳机',0,'/goods-img/64768a8d-0664-4b29-88c9-2626578ffbd1.jpg','/goods-img/64768a8d-0664-4b29-88c9-2626578ffbd1.jpg','详情加载中...',1246,1246,993,'妙出新境界',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10181,'小米 Redmi AirDots','真无线蓝牙耳机|分体式耳机 |收纳充电盒 |蓝牙5.0 |按键防触控操作',51,'/goods-img/36d0fe8f-aa28-423c-81e7-82cab31b7598.jpg','/goods-img/36d0fe8f-aa28-423c-81e7-82cab31b7598.jpg','详情加载中...',129,129,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10182,'荣耀原装三键线控带麦半入耳式耳机AM116(尊爵版)适用于华为荣耀手机','新蜂精选',0,'/goods-img/6113a562-f3f1-408c-9b0d-78a84407caf7.jpg','/goods-img/6113a562-f3f1-408c-9b0d-78a84407caf7.jpg','商品介绍加载中...',69,49,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10183,'诺基亚（NOKIA）BH-705 银白色 5.0真无线蓝牙耳机迷你运动跑步音乐商务入耳式安卓苹果手机蓝牙耳机','新蜂精选',0,'/goods-img/abb13d3a-3445-4b26-b8e9-44cbec227b5d.jpg','/goods-img/abb13d3a-3445-4b26-b8e9-44cbec227b5d.jpg','详情加载中...',499,499,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10184,'华为耳机原装半入耳式有线mate9p10plus8x荣耀v20v10nova2s9iv9p9play 【标准版】华为AM115 白色-热卖款','新蜂精选',0,'/goods-img/fac9c3e9-4843-46d1-8668-7e2eac17ccf2.jpg','/goods-img/fac9c3e9-4843-46d1-8668-7e2eac17ccf2.jpg','商品介绍加载中...',69,39,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10185,'Beats X 蓝牙无线','入耳式耳机 带麦可通话 -桀骜黑红（十周年版） MRQA2PA/A',0,'/goods-img/25910a34-e026-4954-87b0-c379999e1dd0.jpg','/goods-img/25910a34-e026-4954-87b0-c379999e1dd0.jpg','商品介绍加载中...',1168,799,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10186,'华为（ HUAWEI） 华为无线耳机','真无线蓝牙耳机 双耳蓝牙音乐耳机 Freebuds 2 无线耳机 陶瓷白',0,'/goods-img/adf8cbc2-ccb9-408a-96d0-553848e111e9.jpg','/goods-img/adf8cbc2-ccb9-408a-96d0-553848e111e9.jpg','详情加载中...',899,799,999,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10187,'【自营仓次日达】moloke真无线蓝牙耳机双耳适用于苹果华为小米 运动跑步入耳式oppo迷你商务耳机 【1:1尊享版】自动弹窗+无线充电+可触控（热卖）','新蜂精选',51,'/goods-img/1e5645d1-24cb-48eb-9aaa-f729fa0db195.jpg','/goods-img/1e5645d1-24cb-48eb-9aaa-f729fa0db195.jpg','商品介绍加载中...',359,199,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10188,'Beats Powerbeats Pro','完全无线高性能耳机 真无线蓝牙运动耳机 象牙白',0,'/goods-img/e028c016-6793-49a3-8b0f-d0102a415d21.jpg','/goods-img/e028c016-6793-49a3-8b0f-d0102a415d21.jpg','详情加载中...',1888,1888,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10189,'纽曼（Newmine）NM-LK06 全兼容线控音乐手机耳机 白色','新蜂精选',0,'/goods-img/0b02244f-6908-4ccb-a9d2-ccb5a462e30e.jpg','/goods-img/0b02244f-6908-4ccb-a9d2-ccb5a462e30e.jpg','商品介绍加载中...',9,9,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10190,'索尼（SONY）重低音立体声耳机MDR-XB55AP 黑色','新蜂精选',0,'/goods-img/eec7b009-a9ff-45cd-a7be-4051eb7b3c22.jpg','/goods-img/eec7b009-a9ff-45cd-a7be-4051eb7b3c22.jpg','*黑色实物偏灰，请以实物为准 Bass Booster低音增强器技术可呈现紧实深邃低频。 12 毫米驱动单元和110dB/mW 的高灵敏度，呈现高质感音效。 人体工学设计的倾斜入耳方式，让耳塞能够深入耳朵内部，呈现出色的隔音效果，同时带来舒适的佩戴感和高音质的享受。 耳塞能够深入耳朵内部，呈现出色的隔音效果，同时为您带来舒适的佩戴感和高音质的享受。 采用混合两种硬度硅胶的耳塞套： 核心部分使用硬质材料保持音质，减少因耳塞变形导致的声音失真； 外围部分柔软材料提高了耳塞密闭性，让您能长时间舒适佩戴。 *线控的可用性及操作因智能手机而异 耳机线表面细小沟壑，减少容易引起缠绕的摩擦，使导线不容易纠结在一起，方便欣赏音乐和携带。 防缠绕耳机线 盲点设计 便携袋 防尘滤网 导线滑块 4种尺寸耳塞套 摘下耳机的耳塞套，可见保护单元的网罩，用来防止异物和灰尘堵塞单元，使耳机经久耐听。 在左耳外壳和耳机线的连接处设有浮点，凭手指触摸就能判别左右耳，方便操作。 随机附赠收纳袋一只，保护你心爱的耳机。 利用导线滑块来调整左右耳机线的长度，也能够减少收纳耳机时容易出现的缠线现象 提供4对不同尺寸（SS、S、M、L）的耳塞套（M号出厂时已安装至耳机上），根据你的耳洞大小自由更换，获得良好的隔音效果，佩戴舒适。 ● 立体声耳机 ● 混合硅胶耳塞（SS/S/M/L 每种尺寸2个) *M号出厂时安装至本耳机。 ● 便携袋(×1) *EXTRA BASS 和 EXTRABASS 是索尼公司的商标',229,185,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10191,'索尼（SONY）WI-1000X Hi-Res颈挂式 入耳式','无线蓝牙耳机 高音质降噪耳机 手机通话 黑色',0,'/goods-img/1c4adfba-f2f4-4ab3-8520-c28b0a437b7b.jpg','/goods-img/1c4adfba-f2f4-4ab3-8520-c28b0a437b7b.jpg','详情加载中...',2399,1499,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10192,'小米耳机 圈铁Pro 入耳式有线运动音乐耳机耳麦','新蜂精选',51,'/goods-img/b1530f7f-d286-4eb1-8d2b-3c2a74fa9f06.jpg','/goods-img/b1530f7f-d286-4eb1-8d2b-3c2a74fa9f06.jpg','使用双动圈 + 动铁 三单元发声 ／ 均衡自然声音 高保真石墨烯振膜 ／ 25 道工序打磨 ／ 弹力磨砂线材 Pro 小米圈铁耳机 孕育万物的天空和大地，时刻传达着声音的释放与组合，更是寻找灵感的源头，鸟鸣、流水、雷响、风啸不同的声音互相交融，共同演奏出自然的本真。 小米圈铁耳机 Pro 使用双“动圈”单元+“动铁”单元，将三个单元共同融入到同一个耳机中，双“动圈”的醇厚低音，让声音更加扎实稳重，石墨烯材料的加入，则让声音的细节更为丰富。“动铁”的高音透亮，稳定自然，感受三频均衡的本色声音。随着声音的流淌，仿佛置身自然，听见这些细节，让声音一开始就感动内心。 双动圈+动铁，三单元发声，听见更多细节 为了可以真正实现高、中、低三频均衡，小米圈铁耳机 Pro  加入了双“动圈”单元，大动圈负责中低频，小动圈负责高频。在“动铁”单元的配合下，耳机的低频下潜深，中频声音扎实，而高频的细节展现更为丰富。那些刚刚好的声音，听在耳里，都在心里。 三频更均衡，声音更自然 我们听到的绝大多数乐器、人声，都在中低频段。为了让这部分声音更均衡、有感染力，我们都交由采用了石墨烯振膜的双动圈单元来负责，中低频更扎实，兼具丰富细节表现力。 石墨烯是目前自然界已知材料中轻薄、强度更高的材料，对声音的传导速度快，将它用作振膜材质，高频延展性能更好，细节丰富，声音清澈自然，更富穿透力。同时强度又是钢铁的100倍， 可以尽可能还原出电流信号， 真正发出高保真的好声音。 石墨烯振膜，让双动圈更有实力 小米圈铁耳机 Pro 的“动铁”单元依然采用自主研发的 \"衔铁＋驱动杆\" 结构，让声音细腻真实，更为稳定，在电容分频器的作用下，让高中低音衔接更好，失真更少。不论当你听何种音乐，细腻的感情都会被准确还原，听每首歌就像读每个故事，时刻感动自己。 动铁单元设计，高频解析好，细节不失真 好的音乐人将情感与生活用真实的方式，转化为音乐传递给每个人，每首歌都是一个故事，铭刻在各自的记忆中，为了让故事更好的表达，小米圈铁耳机 Pro 在科学客观调音的基础上，再次邀请到荣获 4 次格莱美大奖的 Luca Bignardi，为小米圈铁耳机 Pro 进行主观调音，为的就是让每个喜爱音乐的人能够真切的感受到每一个故事，跟随内心，娓娓道来... 多种科学调音，让声音更鲜活，更温暖 当耳机真正为声音服务时，设计将不再只是修饰耳机外观的道具，它将会成为辅助声音的一部分，小米圈铁耳机 Pro 采用圆润的设计风格，45° 斜角入耳设计，在满足舒适的同时更保证了声音的完整呈现。精密金属音腔设计，让音乐沉于耳畔，更有声音质感，弹力 TPE 磨砂线材的选用，让耳机线更为坚固耐用，确保耳机长久使用。一副好耳机，让声音和外表一起美好。 全新的外观设计，和声音一起美好 好的设计需要灵感，而灵感源于生活，为了锁住声音的灵感，小米圈铁耳机 Pro 将耳塞设计成45°斜角式入耳，贴合耳道，满足佩戴舒适感的同时尽可能减少外界声音干扰，毫无保留地听自己爱的音乐。 45°斜角入耳，舒适佩戴 小米圈铁耳机 Pro 的线控麦克风从耳机整体设计风格出发，金属磨砂弹头造型，精致小巧，指压按键圆润舒适，听歌的同时，更能感知指尖上的金属质感。 小米圈铁耳机 Pro 的耳机线材选取 TPE 材质，作为一种具有橡胶的高弹性材质， 触感柔软、耐温等特性，用它做成耳机线，将更为抗拉、耐用并且不易缠绕。让好音乐的陪伴更长久。 小米圈铁耳机 Pro 的耳塞选取奶嘴级硅胶材质，触感柔软顺滑，减少了耳塞对皮肤的刺激，让肌肤倍感亲密，同时提供四对不同尺寸的耳塞套，让佩戴者根据不同需求选择，带上它，向自己喜爱的音乐问好！ 用匠心打磨每一件产品，即使过程艰难复杂，也依然充满斗志，小米圈铁耳机 Pro 的诞生过程就是这样。25 道工序打造的金属音腔，每一处细节都精心打磨，一体成型钻石切割、细密 CD 纹雕刻、锆石喷砂、阳极氧化，千锤百炼，不放过每个细节，将金属打磨成入耳的艺术品，这就是小米圈铁耳机 Pro 对音乐执着，对好产品更要执着。 小米圈铁耳机 Pro 是铝合金音腔，采用了 CNC 钻石切割一刀成型工艺，加工精度高达0.01mm，这种工艺在对铝合金加工前都要进行工艺分析，选择合适的刀具及切削用量，将打磨成型，让耳机具有更细腻润泽的手感。 小米圈铁耳机 Pro 运用精密的 CD 纹处理，纹理细至 0.14mm，散发金属光泽，就像耳机的指纹一样。如此的精密打磨，只为让小米圈铁耳机 Pro 更具质感，让金属更光辉熠熠。 选用精细锆石喷砂，赋予小米圈铁耳机 Pro 细致均匀的外观，有效保证了耳机表面硬度，不易刮伤。出厂时，会在小米圈铁耳机 Pro 表层增加阳极处理，保证了美观程度和耐磨性，6μ的阳极厚度，坚固、耐磨，做传达好声音的艺术品。 拥有超过 700 项高于行业标准的苛刻测试，每一种测试都见证了小米圈铁耳机 Pro 的高品质， 从音乐品质到设计创新，再到匠心工艺，集合好耳机的所有亮点，都只为带给用户更好的音乐体验和使用感受，好的声音，一定需要千锤百炼 。',149,149,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10193,'Bose QuietControl 30','无线耳机 QC30耳塞式蓝牙降噪耳麦',0,'/goods-img/02cf272e-9062-4d4b-8b7f-7058f0472efa.jpg','/goods-img/02cf272e-9062-4d4b-8b7f-7058f0472efa.jpg','商品介绍加载中...',2498,2498,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10194,'Beats Solo3 Wireless','头戴式 蓝牙无线耳机 手机耳机 游戏耳机 - 桀骜黑红（十周年版） MRQC2PA/A',0,'/goods-img/af77eaba-fd00-4ec8-b0e6-928372a0741d.jpg','/goods-img/af77eaba-fd00-4ec8-b0e6-928372a0741d.jpg','商品介绍加载中...',2268,1698,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10195,'索尼 WH-1000XM3 头戴式耳机','高解析度无线蓝牙降噪（触控面板 智能降噪 长久续航）黑色',20,'/goods-img/0dc503b2-90a2-4971-9723-c085a1844b76.jpg','http://localhost:28089/goods-img/0dc503b2-90a2-4971-9723-c085a1844b76.jpg','详情加载中...',2899,2599,988,'智能降噪 长久续航',0,0,'2019-09-18 13:21:35',0,'2019-09-18 17:42:20'),
	(10196,'雷蛇 Razer 北海巨妖标准版X','北海巨妖标准版升级款 头戴式游戏耳机 电竞耳麦 7.1 电脑手机耳机 黑色',0,'/goods-img/0cc81546-1408-4140-af95-0341a7778b6c.jpg','/goods-img/0cc81546-1408-4140-af95-0341a7778b6c.jpg','产品信息Product Information 产品规格Product Specifications 品牌介绍Brand Introduction 注意事项Warning & Caution 雷蛇产品在出厂时会进行检测，脚贴及USB接口处如有轻微划痕属于正常测试痕迹。 RAZER关于划痕的注意事项： 以上数据图片均为官方测试环境下结果，因使用环境/设备不同会存在一定的差异，仅供参考，数据请以实际为准！  1. 产品实物与外包装上的SN（序列号）必须一致； 2. 产品外包装不能严重破损，盒内的相关配件要齐全，不能有缺失； 3. 不能有明显的人为破损（表面有明显的人为划痕，使用及存在拆卸的痕迹）； 4. 防伪标签不得撕开或损毁。 RAZER关于7天无理由退换货的注意事项： ',349,299,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10197,'森海塞尔（Sennheiser）MomentumTrueWireless 真无线蓝牙hifi发烧入耳式耳机 蓝牙5.0','黑色',0,'/goods-img/768e79e1-e875-4691-855d-262346451d22.jpg','/goods-img/768e79e1-e875-4691-855d-262346451d22.jpg','聆听带来改变 真     无     线     蓝     牙     HiFi     耳     机 MOMENTUM 真无线 懂你所需 全新的 MOMENTUM 真无线耳机，高品质的声音质量传承 MOMENTUM 品质，成为一款具有重要技术成就的新产品。 这款性能优异的蓝牙耳机融合音频质量、佩戴舒适性和精致设计及工艺。 全新的 MOMENTUM 透明聆听功能 防水防泼溅 电池使用时长 （4+8小时） 精雕细琢 经典优雅 高品质声音质量 智能降噪 智能触控操作 支持蓝牙5.0技术 智能触控操作 支持蓝牙 5.0技术 MOMENTUM真无线耳机采用Sennheiser发烧级别7毫米动圈驱动单元，可确保饱满的立体声效果，带来高保真音质，为苛刻的听者带来出色的高保真度。 高品质声音质量 两侧触摸区域都有单独的控制功能，您可以轻松使用右耳耳机语音访问智能助手（如苹果 Siri或Google智能助手）。 轻轻点击或滑动触摸界面，使用自然语音命令即可播放音乐、接听电话。 支持蓝牙5.0技术及编解码技术（包括AAC、Qualcomm apt-XTM和apt-X低延迟），这款耳机带来出众的连接稳定性和音频流畅性。 真正的无线体验 轻松适配周围环境 MOMENTUM 真无线耳机让你更好地感知外部环境，透明聆听让你能听到周围的环境声，从而更好地感知周围的环境，不需要摘掉耳机就能融入到自然的交谈之中。甚至在嘈杂的环境中，电话呼叫和语音交互也能够通过双话筒波束成形技术得以实现。 智能交互 通过自动开启/关闭和智能暂停功能，可以检测到耳机何时被收起来或者不使用，从而节约能源。 你的世界由你把控 通过双击右耳耳机开/关透明聆听功能 打开透明聆听=接收周围环境音 关闭透明聆听=物理降噪模式，不接收周围音 不需要摘掉耳机就可轻松地与周围人进行交谈。 4种尺寸的耳垫可选，均符合人体工程学设计，防水防泼溅，能够满足用户舒适佩戴的需求。 个性定制舒适体验 MOMENTUM真无线拥有4小时电池续航时间，可通过其带有集成电源的小巧耳机盒进行充电，从而享受长达12（4+8）小时的全天聆听乐趣，并满足未来所需。 镀金充电接触点 可磁性吸附到充电盒上 高保真7毫米动圈驱动单元 带来出色的声音重放 金属镭射表面 具有触控功能 多色 LED指示灯 用于语音信号拾取和透明聆听功能的话筒 舒适的入耳式 硅胶耳垫 便捷充电盒持久续航 注重细节、富于美感，这款小巧、 靓丽而轻盈的耳机是技术与艺术的 结合。它既是声音重放技术的成就，更是你耳畔精美的配饰。 质感黑色外壳，闪烁的金属镭射表面，镀金的充电接触点——时尚与功能融合于标志性的设计之中，带来优雅和实用感。 Sennheiser智能控制 MOMENTUM 真无线耳机提供了更为智能和个性化的体验，可以通过新款Sennheiser智能控制应用进行优化，根据个人喜好，利用内置音频EQ对声音进行微调。免费下载，兼容iOS 版本 11.0 及以上版本和Android 版本 7.0 及以上版本 ，简便直观的控制界面，为您的耳机提供个性化的配置和升级等功能。 APP 下载方法 Android 版本 7.0 及以上版本 打开链接下载APP https://share.weiyun.com/54byqjn iOS 版本 11.0 及以上版本 打开APP Store搜索 Sennheiser smart control 下载APP',2399,2399,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10198,'Bose SoundSport Free','真无线蓝牙耳机--黑色 运动耳机 防掉落耳塞',0,'/goods-img/d3370c50-e853-4546-a032-35073eb192ff.jpg','/goods-img/d3370c50-e853-4546-a032-35073eb192ff.jpg','商品介绍加载中...',1699,1699,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10199,'华为原装降噪有线手机耳机Mate9 10P9P10Plus荣耀V9V10PlayNova2s9i8x 【送耳机收纳包】AM115半入耳式耳机-经典热卖款','新蜂精选',0,'/goods-img/0cff5ace-7ab9-43a7-91fe-fb3550829577.jpg','/goods-img/0cff5ace-7ab9-43a7-91fe-fb3550829577.jpg','详情加载中...',99,39,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10200,'Apple 采用Lightning/闪电接头的 EarPods','耳机',0,'/goods-img/7b8bcf01-0abe-4155-b1f4-e57a6b8fc36a.jpg','/goods-img/7b8bcf01-0abe-4155-b1f4-e57a6b8fc36a.jpg','详情加载中...',223,223,1000,'',0,0,'2019-09-18 13:21:35',0,'2019-09-18 13:21:35'),
	(10201,'迪奥（Dior）烈艳蓝金唇膏滋润999# 3.5g 经典正红色','(口红 保湿滋润 气质显白 不挑皮) （新老包装随机）',0,'/goods-img/6b0bd268-40b1-4abf-a19b-95df7cb4d722.jpg','/goods-img/6b0bd268-40b1-4abf-a19b-95df7cb4d722.jpg','商品介绍加载中...',500,315,999,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10202,'迪奥（Dior）烈艳蓝金唇膏-哑光999# 3.5g 传奇红（口红','雾面质地 显色持久 显白 正红色 李佳琦推荐）',86,'/goods-img/d8d4ac7e-7189-459a-aef2-7116f723cb0b.jpg','/goods-img/d8d4ac7e-7189-459a-aef2-7116f723cb0b.jpg','详情加载中...',400,315,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10203,'海囤全球 魅可（MAC)经典唇膏 子弹头口红3g','Chili 秀智色/小辣椒色',86,'/goods-img/18aca3b8-d024-47d3-a971-fb51d374b1ae.jpg','/goods-img/18aca3b8-d024-47d3-a971-fb51d374b1ae.jpg','详情加载中...',170,155,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10204,'卡姿兰（Carslan）轻甜唇爱随心盒1.4g*4(13#暧昧 16#炽烈 18#嫉妒','19#欲望 唇盒 口红 七夕礼物 情人节礼物)',0,'/goods-img/44c8198e-f63a-45e0-8eff-789338de65f8.jpg','/goods-img/44c8198e-f63a-45e0-8eff-789338de65f8.jpg','关联销售入口 1 (1) 商品介绍加载中...',99,89,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10205,'【联名限量版】MANSLY口红套装中国风口红情人节女朋友生日礼物唇釉彩妆女磁扣锦绣红妆口红礼盒彩妆 锦绣红妆口红礼盒（6支）','新蜂精选',86,'/goods-img/c081314e-8f67-44f9-a27e-aad6c3f29343.jpg','/goods-img/c081314e-8f67-44f9-a27e-aad6c3f29343.jpg','商品介绍加载中...',295,295,995,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10206,'迪奥（Dior）滋润999礼盒套装（烈艳蓝金999#3.5g 经典正红色+香氛小样1ml*3+礼盒）（小样和礼盒款式随机）','新蜂精选',0,'/goods-img/39c69481-6d13-4d84-bc1e-7dca612667f0.jpg','/goods-img/39c69481-6d13-4d84-bc1e-7dca612667f0.jpg','商品介绍加载中...',379,379,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10207,'圣罗兰（YSL）莹亮纯魅唇膏12#（圆管口红）4.5g 斩男色','新蜂精选',86,'/goods-img/b4335e82-c9e1-4264-92e4-e324a601fedb.jpg','/goods-img/b4335e82-c9e1-4264-92e4-e324a601fedb.jpg','详情加载中...',320,320,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10208,'圣罗兰（YSL）纯口红1#（正红色）3.8g','新蜂精选',86,'/goods-img/57d0bf26-0a0c-4027-8a2b-deeaa29905ee.jpg','/goods-img/57d0bf26-0a0c-4027-8a2b-deeaa29905ee.jpg','详情加载中...',350,320,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10209,'纪梵希高定香榭天鹅绒唇膏306#(小羊皮口红 法式红 雾面哑光','持久锁色）新老包装随机发货',86,'/goods-img/f30bd8cb-aadd-43aa-8615-2c4795ee7f5f.jpg','/goods-img/f30bd8cb-aadd-43aa-8615-2c4795ee7f5f.jpg','详情加载中...',355,355,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10210,'【联名款】MANSLY口红套装红鸾心动口红礼盒中国风开运红情人节女朋友生日礼物唇釉颐和园同款彩妆口红 红鸾心动口红礼盒（6支）','新蜂精选',86,'/goods-img/f128ad98-fe4d-4264-96e3-6393b6cc98f1.jpg','/goods-img/f128ad98-fe4d-4264-96e3-6393b6cc98f1.jpg','商品介绍加载中...',195,195,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10211,'海囤全球 迪奥（Dior）烈艳蓝金唇膏 口红','3.5g 999号 正红色',86,'/goods-img/8fcdb86b-e826-4c1b-af3c-33a9d590c4b0.jpg','/goods-img/8fcdb86b-e826-4c1b-af3c-33a9d590c4b0.jpg','详情加载中...',410,258,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10212,'圣罗兰（YSL）纯口红13#（正橘色）3.8g','新蜂精选',86,'/goods-img/53a4a428-8ca2-4d19-937d-15d18f324237.jpg','/goods-img/53a4a428-8ca2-4d19-937d-15d18f324237.jpg','详情加载中...',320,320,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10213,'海囤全球 魅可（MAC)磨砂系列 雾面丝绒哑光子弹头口红','3g 316 devoted to chili 泫雅色',86,'/goods-img/2da55bd1-046f-4ac2-b1b9-56ab00bb9db1.jpg','/goods-img/2da55bd1-046f-4ac2-b1b9-56ab00bb9db1.jpg','详情加载中...',249,165,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10214,'【情人礼物】香奈儿Chanel 口红/唇膏可可小姐水亮/丝绒系列润唇保湿口红配玫瑰花礼盒 丝绒系列','43#斩男色',86,'/goods-img/247722ea-c87a-4283-806c-bc9fe57f2253.jpg','/goods-img/247722ea-c87a-4283-806c-bc9fe57f2253.jpg','详情加载中...',299,298,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10215,'迪奥（Dior）口红礼盒套装（烈艳蓝金唇膏哑光#999 3.5g正红色+香氛小样1ml*3随机+随机礼盒样式）','新蜂精选',86,'/goods-img/ab1a0ced-954c-4857-92f4-f7c833d9d54a.jpg','/goods-img/ab1a0ced-954c-4857-92f4-f7c833d9d54a.jpg','商品介绍加载中...',379,379,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10216,'圣罗兰（YSL）纯口红52# 3.8g','新蜂精选',86,'/goods-img/1eefadae-5f62-4abd-b283-077e7b6d9193.jpg','/goods-img/1eefadae-5f62-4abd-b283-077e7b6d9193.jpg','详情加载中...',340,320,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10217,'海囤全球 汤姆福特 TOM','FORD TF口红 经典黑金唇膏 3g 16 SCARLET ROUGE 复古番茄红',0,'/goods-img/da12f5cf-2728-446a-a3bd-b78baf7056ff.jpg','/goods-img/da12f5cf-2728-446a-a3bd-b78baf7056ff.jpg','详情加载中...',429,375,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10218,'迪奥（Dior）烈艳蓝金口红唇膏 028# 3.5g','珊瑚红 (滋润保湿 持久显色 粉嫩少女 摩洛哥王妃 幸运色)',86,'/goods-img/7030b9b6-b650-4d9d-9446-e27dab8afa1f.jpg','/goods-img/7030b9b6-b650-4d9d-9446-e27dab8afa1f.jpg','详情加载中...',400,315,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10219,'迪奥（Dior）烈艳蓝金唇膏520# 3.5g 玫瑰红(口红','缎光 滋润保湿 长效持妆 玫红色 斩男色 告白色 粉红色)',86,'/goods-img/96a91f11-e634-4e28-be13-db8b4732463e.jpg','/goods-img/96a91f11-e634-4e28-be13-db8b4732463e.jpg','详情加载中...',360,315,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10220,'海囤全球 迪奥（Dior）烈艳蓝金唇膏 口红','3.5g 999号 哑光-经典正红',86,'/goods-img/fe048831-384d-46b2-beec-5549f7902c11.jpg','/goods-img/fe048831-384d-46b2-beec-5549f7902c11.jpg','详情加载中...',410,255,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10221,'欧莱雅（LOREAL）纷泽滋润唇膏RC301复古魅红3.7g（金管 口红女 滋润显色）','新蜂精选',86,'/goods-img/b7495e02-fc4c-417a-8101-ccfc75a5a475.jpg','/goods-img/b7495e02-fc4c-417a-8101-ccfc75a5a475.jpg','品牌介绍Brand Description         巴黎欧莱雅通过将科技和美丽的结合，不断谋求创新、研发新的产品配方，以合理的价格，为消费者提供品质的产品和服务。自1907年安全合成染发剂的诞生，如今巴黎欧莱雅的产品已从染发剂扩展到了护肤、彩妆等诸多领域，在中国，巴黎欧莱雅的五大产品线为护肤系列、彩妆系列、家用染发系列、洗护发系列及男士护肤系列。为了将美的产品融于美的文化、艺术、理念，将“从指尖到发梢”的美丽带给全世界的人们，巴黎欧莱雅在全世界范围精心选择各行业明星，组成“梦之队”来见证巴黎欧莱雅的实力，从各个不同的角度来讲述巴黎欧莱雅美丽无疆界的气势，并使“巴黎欧莱雅，你值得拥有！”“Because you are worth it！”的美丽概念成为一种文化！',135,99,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10222,'阿玛尼(Armani) 口红女士唇釉 生日礼物/表白礼物','红管#405番茄红 【李佳琪推荐omg】',86,'/goods-img/75fdac25-1cfa-4a9b-957d-805ac706f32c.jpg','/goods-img/75fdac25-1cfa-4a9b-957d-805ac706f32c.jpg','商品介绍加载中...',366,285,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10223,'美宝莲（MAYBELLINE）绝色持久唇膏雾感哑光系列R09PM 3.9g（女皇色口红新老包装）','新蜂精选',86,'/goods-img/1055e30e-3d98-4dca-8b79-8d0b5a09a37b.jpg','/goods-img/1055e30e-3d98-4dca-8b79-8d0b5a09a37b.jpg','商品介绍加载中...',122,106,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10224,'【专柜正品】迪奥999Dior口红唇膏烈艳蓝金 哑光滋润520/888/999送礼礼品套装 烈艳蓝金','844#橘红色赠礼盒礼袋',86,'/goods-img/7b52a7bc-0ecf-41c4-b079-d162511c9530.jpg','/goods-img/7b52a7bc-0ecf-41c4-b079-d162511c9530.jpg','商品介绍加载中...',339,260,1000,'',0,0,'2019-09-18 13:24:47',0,'2019-09-18 13:24:47'),
	(10225,'迪奥（Dior）烈艳蓝金唇膏滋润999# 3.5g 经典正红色','(口红 保湿滋润 气质显白 不挑皮) （新老包装随机）',0,'/goods-img/bb05b83f-bb91-4300-b78f-23986ba8c0dd.jpg','/goods-img/bb05b83f-bb91-4300-b78f-23986ba8c0dd.jpg','商品介绍加载中...',500,315,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10226,'迪奥（Dior）烈艳蓝金唇膏-哑光999# 3.5g 传奇红（口红','雾面质地 显色持久 显白 正红色 李佳琦推荐）',86,'/goods-img/67280dcf-bf32-49c1-b99b-9d86bb2ffaac.jpg','/goods-img/67280dcf-bf32-49c1-b99b-9d86bb2ffaac.jpg','详情加载中...',400,315,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10227,'海囤全球 魅可（MAC)经典唇膏 子弹头口红3g','Chili 秀智色/小辣椒色',86,'/goods-img/2b678c5d-820c-4174-bc0c-5a65ff9501b6.jpg','/goods-img/2b678c5d-820c-4174-bc0c-5a65ff9501b6.jpg','详情加载中...',170,155,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10228,'卡姿兰（Carslan）轻甜唇爱随心盒1.4g*4(13#暧昧 16#炽烈 18#嫉妒','19#欲望 唇盒 口红 七夕礼物 情人节礼物)',0,'/goods-img/3f513cd6-bb5f-407d-8550-24550873d83b.jpg','/goods-img/3f513cd6-bb5f-407d-8550-24550873d83b.jpg','关联销售入口 1 (1) 商品介绍加载中...',99,89,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10229,'【联名限量版】MANSLY口红套装中国风口红情人节女朋友生日礼物唇釉彩妆女磁扣锦绣红妆口红礼盒彩妆 锦绣红妆口红礼盒（6支）','新蜂精选',86,'/goods-img/d82ba7f0-6c92-4254-bfb2-71b3f8b1dfda.jpg','/goods-img/d82ba7f0-6c92-4254-bfb2-71b3f8b1dfda.jpg','商品介绍加载中...',295,295,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10230,'迪奥（Dior）滋润999礼盒套装（烈艳蓝金999#3.5g 经典正红色+香氛小样1ml*3+礼盒）（小样和礼盒款式随机）','新蜂精选',0,'/goods-img/f6b1195a-3231-4e81-a676-866ee838748f.jpg','/goods-img/f6b1195a-3231-4e81-a676-866ee838748f.jpg','商品介绍加载中...',379,379,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10231,'圣罗兰（YSL）莹亮纯魅唇膏12#（圆管口红）4.5g 斩男色','新蜂精选',86,'/goods-img/359bb052-5fea-4390-bbe6-4cb9e1c19273.jpg','/goods-img/359bb052-5fea-4390-bbe6-4cb9e1c19273.jpg','详情加载中...',320,320,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10232,'圣罗兰（YSL）纯口红1#（正红色）3.8g','新蜂精选',86,'/goods-img/a42498e5-d912-447b-9360-0659d2d55c42.jpg','/goods-img/a42498e5-d912-447b-9360-0659d2d55c42.jpg','详情加载中...',350,320,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10233,'纪梵希高定香榭天鹅绒唇膏306#','(小羊皮口红 法式红 雾面哑光 持久锁色）新老包装随机发货',86,'/goods-img/04949c0e-87df-445b-96dd-29e7fc69f734.jpg','http://localhost:28089/goods-img/04949c0e-87df-445b-96dd-29e7fc69f734.jpg','详情加载中...',355,355,1000,'雾面哑光 持久锁色',0,0,'2019-09-18 13:25:08',0,'2019-09-18 17:40:58'),
	(10234,'【联名款】MANSLY口红套装红鸾心动口红礼盒中国风开运红情人节女朋友生日礼物唇釉颐和园同款彩妆口红 红鸾心动口红礼盒（6支）','新蜂精选',86,'/goods-img/a9cd71ad-2db0-4876-9ead-c51233040220.jpg','/goods-img/a9cd71ad-2db0-4876-9ead-c51233040220.jpg','商品介绍加载中...',195,195,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10235,'海囤全球 迪奥（Dior）烈艳蓝金唇膏 口红','3.5g 999号 正红色',86,'/goods-img/49d2acf7-55e5-4293-a7da-5929740e1168.jpg','/goods-img/49d2acf7-55e5-4293-a7da-5929740e1168.jpg','详情加载中...',410,258,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10236,'圣罗兰（YSL）纯口红13#（正橘色）3.8g','新蜂精选',86,'/goods-img/b0142d40-6adb-4d64-b5b2-6e4a34656990.jpg','/goods-img/b0142d40-6adb-4d64-b5b2-6e4a34656990.jpg','详情加载中...',320,320,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10237,'MAC 雾面丝绒哑光子弹头口红','磨砂系列 3g 316 devoted to chili 泫雅色',86,'/goods-img/1930d79b-88bd-4c5c-8510-0697c9ad2578.jpg','http://localhost:28089/goods-img/1930d79b-88bd-4c5c-8510-0697c9ad2578.jpg','详情加载中...',249,165,992,'雾面丝绒哑光',0,0,'2019-09-18 13:25:08',0,'2019-09-18 17:41:42'),
	(10238,'【情人礼物】香奈儿Chanel 口红/唇膏可可小姐水亮/丝绒系列润唇保湿口红配玫瑰花礼盒 丝绒系列','43#斩男色',86,'/goods-img/70219912-838c-487b-8c3c-761b00de80e9.jpg','/goods-img/70219912-838c-487b-8c3c-761b00de80e9.jpg','详情加载中...',299,298,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10239,'迪奥（Dior）口红礼盒套装（烈艳蓝金唇膏哑光#999 3.5g正红色+香氛小样1ml*3随机+随机礼盒样式）','新蜂精选',86,'/goods-img/cbce65ee-28b3-4822-895a-38243ee506e7.jpg','/goods-img/cbce65ee-28b3-4822-895a-38243ee506e7.jpg','商品介绍加载中...',379,379,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10240,'圣罗兰（YSL）纯口红52# 3.8g','新蜂精选',86,'/goods-img/abff57bf-247b-4881-9589-e1336049c3ba.jpg','/goods-img/abff57bf-247b-4881-9589-e1336049c3ba.jpg','详情加载中...',340,320,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10241,'海囤全球 汤姆福特 TOM','FORD TF口红 经典黑金唇膏 3g 16 SCARLET ROUGE 复古番茄红',0,'/goods-img/ba0cd1e9-cded-427b-8692-e8e2a0d00e9f.jpg','/goods-img/ba0cd1e9-cded-427b-8692-e8e2a0d00e9f.jpg','详情加载中...',429,375,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10242,'迪奥（Dior）烈艳蓝金口红唇膏 028# 3.5g','珊瑚红 (滋润保湿 持久显色 粉嫩少女 摩洛哥王妃 幸运色)',86,'/goods-img/ea87e780-ed4c-447d-bd22-e88e4742721e.jpg','/goods-img/ea87e780-ed4c-447d-bd22-e88e4742721e.jpg','详情加载中...',400,315,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10243,'迪奥（Dior）烈艳蓝金唇膏520# 3.5g 玫瑰红(口红','缎光 滋润保湿 长效持妆 玫红色 斩男色 告白色 粉红色)',86,'/goods-img/dde0b711-58b0-49fb-972c-7a71d6ec30f1.jpg','/goods-img/dde0b711-58b0-49fb-972c-7a71d6ec30f1.jpg','详情加载中...',360,315,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10244,'海囤全球 迪奥（Dior）烈艳蓝金唇膏 口红','3.5g 999号 哑光-经典正红',86,'/goods-img/79247aeb-2903-47b0-a711-ac94e22ddd54.jpg','/goods-img/79247aeb-2903-47b0-a711-ac94e22ddd54.jpg','详情加载中...',410,255,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10245,'欧莱雅（LOREAL）纷泽滋润唇膏RC301复古魅红3.7g（金管 口红女 滋润显色）','新蜂精选',86,'/goods-img/3b420562-b449-448d-ae50-e20aab136e1b.jpg','/goods-img/3b420562-b449-448d-ae50-e20aab136e1b.jpg','品牌介绍Brand Description         巴黎欧莱雅通过将科技和美丽的结合，不断谋求创新、研发新的产品配方，以合理的价格，为消费者提供品质的产品和服务。自1907年安全合成染发剂的诞生，如今巴黎欧莱雅的产品已从染发剂扩展到了护肤、彩妆等诸多领域，在中国，巴黎欧莱雅的五大产品线为护肤系列、彩妆系列、家用染发系列、洗护发系列及男士护肤系列。为了将美的产品融于美的文化、艺术、理念，将“从指尖到发梢”的美丽带给全世界的人们，巴黎欧莱雅在全世界范围精心选择各行业明星，组成“梦之队”来见证巴黎欧莱雅的实力，从各个不同的角度来讲述巴黎欧莱雅美丽无疆界的气势，并使“巴黎欧莱雅，你值得拥有！”“Because you are worth it！”的美丽概念成为一种文化！',135,99,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10246,'阿玛尼(Armani) 口红女士唇釉 生日礼物/表白礼物','红管#405番茄红 【李佳琪推荐omg】',86,'/goods-img/db866c68-e526-42cf-a0b5-520254f30b76.jpg','/goods-img/db866c68-e526-42cf-a0b5-520254f30b76.jpg','商品介绍加载中...',366,285,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10247,'美宝莲（MAYBELLINE）绝色持久唇膏雾感哑光系列R09PM 3.9g（女皇色口红新老包装）','新蜂精选',86,'/goods-img/63d0a187-627d-4edb-870e-717969ad2bd0.jpg','/goods-img/63d0a187-627d-4edb-870e-717969ad2bd0.jpg','商品介绍加载中...',122,106,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10248,'【专柜正品】迪奥999Dior口红唇膏烈艳蓝金 哑光滋润520/888/999送礼礼品套装 烈艳蓝金','844#橘红色赠礼盒礼袋',86,'/goods-img/9822b4a5-9fd2-435b-bdd1-5bbcdc6fdfdf.jpg','/goods-img/9822b4a5-9fd2-435b-bdd1-5bbcdc6fdfdf.jpg','商品介绍加载中...',339,260,1000,'',0,0,'2019-09-18 13:25:08',0,'2019-09-18 13:25:08'),
	(10249,'Apple Macbook Air 13.3 ','Core i5 8G 128G SSD 笔记本电脑 轻薄本 银色 MQD32CH/A',0,'/goods-img/2d827a7e-fb30-493d-840a-cb21766814fd.jpg','/goods-img/2d827a7e-fb30-493d-840a-cb21766814fd.jpg','商品介紹頁面素材由Apple提供',6928,5999,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10250,'Apple 2019款 Macbook Pro 13.3','【带触控栏】八代i5 8G 256G RP645显卡 银色 苹果笔记本电脑 MUHR2CH/A',0,'/goods-img/465936e0-40ad-4968-b868-4bea20c7beec.jpg','/goods-img/465936e0-40ad-4968-b868-4bea20c7beec.jpg','商品介紹頁面素材由Apple提供',11499,10699,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10251,'Apple MacBook Air 13.3 ','Core i5 8G 256G SSD 银色 笔记本电脑 轻薄本 Z0UU00056原MQD42CH/A',0,'/goods-img/a4132109-8f18-4399-affd-a81fad6902c8.jpg','/goods-img/a4132109-8f18-4399-affd-a81fad6902c8.jpg','商品介紹頁面素材由Apple提供',7999,7168,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10252,'Apple 2019款 MacBook Air 13.3 ','Retina屏 八代i5 8G 256G SSD 银色 笔记本电脑 轻薄本 MVFL2CH/A',0,'/goods-img/65b62668-3be5-48b0-a40c-bd05826a38c2.jpg','/goods-img/65b62668-3be5-48b0-a40c-bd05826a38c2.jpg','商品介紹頁面素材由Apple提供',10399,9799,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10253,'Apple 2019款 MacBook Air 13.3 ','Retina屏 八代i5 8G 128G SSD 深空灰 笔记本电脑 轻薄本 MVFH2CH/A',0,'/goods-img/cb899039-a705-473d-9785-f245a6ed4d89.jpg','/goods-img/cb899039-a705-473d-9785-f245a6ed4d89.jpg','商品介紹頁面素材由Apple提供',8899,8499,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10254,'Apple 2019款 MacBook Air 13.3 ','Retina屏 八代i5 8G 128G SSD 银色 笔记本电脑 轻薄本 MVFK2CH/A',0,'/goods-img/7810bc9d-236f-4386-a0ef-45a831b49bf2.jpg','/goods-img/7810bc9d-236f-4386-a0ef-45a831b49bf2.jpg','商品介紹頁面素材由Apple提供',8899,8499,993,'再次倾心',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10255,'Apple MacBook Air 13.3 ','| 定制升级 Core i7 8G 128G SSD硬盘 银色 笔记本电脑 轻薄本 Z0UU00022',0,'/goods-img/53019ece-5e61-4de9-8eac-e1f00a4ef7e3.jpg','/goods-img/53019ece-5e61-4de9-8eac-e1f00a4ef7e3.jpg','商品介绍加载中...',8056,6968,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10256,'Apple 2019款 Macbook Pro 13.3','【带触控栏】八代i5 8G 256G RP645显卡 深空灰 苹果笔记本电脑 MUHP2CH/A',0,'/goods-img/f08404a7-0459-4289-aa60-dd1735c95bbe.jpg','/goods-img/f08404a7-0459-4289-aa60-dd1735c95bbe.jpg','商品介紹頁面素材由Apple提供',11499,10699,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10257,'苹果（Apple） MacBook Air','苹果笔记本电脑 13.3英寸轻薄本 购买套餐更实惠 2017款/i5/8GB/128GB/D32',0,'/goods-img/83740c28-473c-4954-b0dc-3cadab5a87d1.jpg','/goods-img/83740c28-473c-4954-b0dc-3cadab5a87d1.jpg','商品介绍加载中...',6200,5488,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10258,'Apple 2019款 MacBook Air 13.3 ','Retina屏 八代i5 8G 256G SSD 深空灰 笔记本电脑 轻薄本 MVFJ2CH/A',0,'/goods-img/78957148-4c0c-4194-bc46-7360d7b1aa65.jpg','/goods-img/78957148-4c0c-4194-bc46-7360d7b1aa65.jpg','商品介紹頁面素材由Apple提供',10399,9799,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10259,'Apple 2019新品 Macbook Pro 13.3','【带触控栏】八代i5 8G 256G 深空灰 笔记本电脑 轻薄本 MV962CH/A',0,'/goods-img/85787c16-8443-4db0-9cae-a811a20a0832.jpg','/goods-img/85787c16-8443-4db0-9cae-a811a20a0832.jpg','商品介紹頁面素材由Apple提供',13899,12999,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10260,'Apple 2019款 MacBook Air 13.3 ','Retina屏 八代i5 8G 256G SSD 金色 苹果笔记本电脑 轻薄本 MVFN2CH/A',0,'/goods-img/82bdafc6-5828-495e-b77c-21598938b896.jpg','/goods-img/82bdafc6-5828-495e-b77c-21598938b896.jpg','商品介紹頁面素材由Apple提供',10399,9799,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10261,'APPLE 苹果2018年19新款MacBook air笔记本电脑13.3英寸超薄笔记本','金色 i5/8GB内存/128GB闪存【19新款】',0,'/goods-img/270cdf75-8a7f-410e-8f2f-8eeba24f0503.jpg','/goods-img/270cdf75-8a7f-410e-8f2f-8eeba24f0503.jpg','商品介绍加载中...',8899,7888,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10262,'Apple 2019新品 Macbook Pro 15.4','【带触控栏】全新九代六核i7 16G 256G 深空灰 笔记本电脑轻薄本MV902CH/A',0,'/goods-img/7928eb46-9e1c-420e-a8ab-6c358d01891b.jpg','/goods-img/7928eb46-9e1c-420e-a8ab-6c358d01891b.jpg','商品介紹頁面素材由Apple提供',18199,17099,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10263,'APPLE 苹果MacBook air苹果笔记本电脑13.3英寸超薄笔记本','标配+防水手提包+苹果原装鼠标版（下单送大礼包） i5+8GB内存+128GB闪存【D32】',0,'/goods-img/11968b35-9431-4b1c-a648-6ff46945ebf4.jpg','/goods-img/11968b35-9431-4b1c-a648-6ff46945ebf4.jpg','商品介绍加载中...',6988,5988,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10264,'APPLE苹果 MacBook Air13.3英寸轻薄笔记本电脑2017款','官方标配【购套餐版送大礼包】 i5+8GB内存+128GB闪存【D32】',0,'/goods-img/fb08ec83-2960-47f7-8679-8b78896c30d5.jpg','/goods-img/fb08ec83-2960-47f7-8679-8b78896c30d5.jpg','商品介绍加载中...',6188,5488,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10265,'Apple 2019款 MacBook Air 13.3 ','Retina屏 八代i5 8G 128G SSD 金色 笔记本电脑 轻薄本 MVFM2CH/A',0,'/goods-img/50748763-c0d6-4e73-80e5-864818fa3246.jpg','/goods-img/50748763-c0d6-4e73-80e5-864818fa3246.jpg','商品介紹頁面素材由Apple提供',8899,8499,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10266,'Apple 2019款 Macbook Pro 13.3','【带触控栏】八代i5 8G 128G RP645显卡 深空灰 苹果笔记本电脑 MUHN2CH/A',0,'/goods-img/fe9e33a1-fbd0-4278-931f-825fef4ffb62.jpg','/goods-img/fe9e33a1-fbd0-4278-931f-825fef4ffb62.jpg','商品介紹頁面素材由Apple提供',9999,9499,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10267,'Apple MacBook Air 13.3 ','定制升级 Core i7 8G 256G SSD硬盘 银色 笔记本电脑 轻薄本 Z0UU0004J',0,'/goods-img/0340d6b2-54bf-42a2-96f4-f35c5f47bb2d.jpg','/goods-img/0340d6b2-54bf-42a2-96f4-f35c5f47bb2d.jpg','商品介紹頁面素材由Apple提供',9656,8499,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10268,'Apple 2019新品 Macbook Pro 15.4','【带触控栏】九代八核i9 16G 512G 深空灰 笔记本电脑 轻薄本 MV912CH/A',0,'/goods-img/33a29216-08d6-445b-b979-12d5de81d634.jpg','/goods-img/33a29216-08d6-445b-b979-12d5de81d634.jpg','商品介紹頁面素材由Apple提供',21399,20399,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10269,'Apple 2019新品 Macbook Pro 13.3','【带触控栏】八代i5 8G 256G 银色 笔记本电脑 轻薄本 MV992CH/A',0,'/goods-img/a2afdb6c-69a7-4081-bd09-62174f9f5624.jpg','/goods-img/a2afdb6c-69a7-4081-bd09-62174f9f5624.jpg','商品介紹頁面素材由Apple提供  ',13899,12999,999,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10270,'Apple Macbook Pro 13.3','【带触控栏】Core i5 8G 512G SSD 银色 笔记本电脑 轻薄本 MR9V2CH/A',0,'/goods-img/4da4fa5d-ee2d-4496-9950-e53b102f0e8e.jpg','/goods-img/4da4fa5d-ee2d-4496-9950-e53b102f0e8e.jpg','商品介绍加载中...',14999,13068,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10271,'Apple 2019新品 Macbook Pro 15.4','【带触控栏】全新九代六核i7 16G 256G 银色 笔记本电脑 轻薄本 MV922CH/A',0,'/goods-img/49c9f6f8-11c2-4f57-98b9-daf12715b938.jpg','/goods-img/49c9f6f8-11c2-4f57-98b9-daf12715b938.jpg','商品介紹頁面素材由Apple提供',18199,17099,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10272,'Apple 2019新品 Macbook Pro 13.3','【带触控栏】八代i5 8G 512G 银色 笔记本电脑 轻薄本 MV9A2CH/A',0,'/goods-img/9dd28614-7a17-4876-8cdd-232caf4154bc.jpg','/goods-img/9dd28614-7a17-4876-8cdd-232caf4154bc.jpg','商品介紹頁面素材由Apple提供',15499,14499,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10273,'Apple 2019新品 Macbook Pro 15.4','【带触控栏】九代八核i9 16G 512G 银色 笔记本电脑 轻薄本 MV932CH/A',0,'/goods-img/2dcd61b8-f434-40ee-928f-c6e4ae934db8.jpg','/goods-img/2dcd61b8-f434-40ee-928f-c6e4ae934db8.jpg','商品介紹頁面素材由Apple提供',21399,20399,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10274,'【新品首发】苹果Apple MacBook Pro13.3英寸2019新款18/17苹果笔记本电脑','19款灰色/256G/带bar/MUHP2CH/A',0,'/goods-img/4dbbfbf1-80c0-4389-a02e-ca19fbeb5340.jpg','/goods-img/4dbbfbf1-80c0-4389-a02e-ca19fbeb5340.jpg','商品介绍加载中...',12580,10488,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10275,'【新品首发】苹果Apple MacBook Pro13.3英寸2019新款18/17苹果笔记本电脑','19款灰色/128G/带bar/MUHN2CH/A',0,'/goods-img/3b095a66-4001-4c69-9026-2e09139b5f11.jpg','/goods-img/3b095a66-4001-4c69-9026-2e09139b5f11.jpg','商品介绍加载中...',10100,9088,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10276,'Apple 2019新品 Macbook Pro 13.3','【带触控栏】八代i5 8G 512G 深空灰 苹果笔记本电脑 轻薄本 MV972CH/A',0,'/goods-img/82fb6b31-1afe-4bcb-a243-5205ed32d3ee.jpg','/goods-img/82fb6b31-1afe-4bcb-a243-5205ed32d3ee.jpg','商品介紹頁面素材由Apple提供',15499,14499,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10277,'Apple Macbook Pro 13.3','【无触控栏】Core i5 8G 256G SSD 银色 笔记本电脑 轻薄本 MPXU2CH/A',0,'/goods-img/73a8c7e9-40af-4e0a-9826-5f6374361e61.jpg','/goods-img/73a8c7e9-40af-4e0a-9826-5f6374361e61.jpg','商品介绍加载中...',11299,10199,1000,'',0,0,'2019-09-18 13:25:52',0,'2019-09-18 13:25:52'),
	(10278,'Apple iPhone 11 (A2223)','64GB 黑色 移动联通电信4G手机 双卡双待',47,'/goods-img/4755f3e5-257c-424c-a5f4-63908061d6d9.jpg','http://localhost:28089/goods-img/4755f3e5-257c-424c-a5f4-63908061d6d9.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',5499,5499,1000,'2019 新品',0,0,'2019-09-18 13:27:13',0,'2019-09-18 14:28:39'),
	(10279,'Apple iPhone 11 (A2223)','128GB 白色 移动联通电信4G手机 双卡双待',47,'/goods-img/a0d09f94-9c46-4ee1-aaef-dfd132e7543e.jpg','/goods-img/a0d09f94-9c46-4ee1-aaef-dfd132e7543e.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',5999,5999,997,'2019 新品',0,0,'2019-09-18 13:27:13',0,'2019-09-18 14:35:30'),
	(10280,'Apple iPhone 11 (A2223)','128GB 紫色 移动联通电信4G手机 双卡双待',47,'/goods-img/8dfe8ea9-2279-4132-a72b-4f8a52d002a4.jpg','/goods-img/8dfe8ea9-2279-4132-a72b-4f8a52d002a4.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',5999,5999,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10281,'Apple iPhone 11 (A2223)','64GB 红色 移动联通电信4G手机 双卡双待',47,'/goods-img/7368f461-fd0a-4f37-bc8b-31d8ad3d6e95.jpg','/goods-img/7368f461-fd0a-4f37-bc8b-31d8ad3d6e95.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',5499,5499,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10282,'Apple iPhone 11 (A2223)','64GB 黄色 移动联通电信4G手机 双卡双待',47,'/goods-img/cea55d85-b11e-4639-88ab-9403b05ce1e8.jpg','/goods-img/cea55d85-b11e-4639-88ab-9403b05ce1e8.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',5499,5499,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10283,'Apple iPhone 11 (A2223)','256GB 绿色 移动联通电信4G手机 双卡双待',47,'/goods-img/075a188a-9045-45f0-9c67-1e42e0552aa2.jpg','/goods-img/075a188a-9045-45f0-9c67-1e42e0552aa2.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',6799,6799,994,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10284,'Apple iPhone XR (A2108)','128GB 黑色 移动联通电信4G手机 双卡双待',47,'/goods-img/23ac3107-6309-40c8-bd28-164eb1186b62.jpg','/goods-img/23ac3107-6309-40c8-bd28-164eb1186b62.jpg','商品介绍加载中...',5599,5099,991,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10285,'Apple iPhone XR (A2108)','128GB 白色 移动联通电信4G手机 双卡双待',47,'/goods-img/3f47c376-c603-43fc-bfe5-2daa985ff423.jpg','/goods-img/3f47c376-c603-43fc-bfe5-2daa985ff423.jpg','商品介绍加载中...',5599,5099,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10286,'Apple iPhone XR (A2108)','128GB 红色 移动联通电信4G手机 双卡双待',47,'/goods-img/56cef3d7-41e6-4aad-825d-a3d423e74dfd.jpg','/goods-img/56cef3d7-41e6-4aad-825d-a3d423e74dfd.jpg','商品介绍加载中...',5599,5099,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10287,'Apple iPhone XR (A2108)','128GB 珊瑚色 移动联通电信4G手机 双卡双待',47,'/goods-img/c2e3b2e4-1fc8-43f3-b133-6f4eae7faa5d.jpg','/goods-img/c2e3b2e4-1fc8-43f3-b133-6f4eae7faa5d.jpg','商品介绍加载中...',5599,5199,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10288,'Apple iPhone XR (A2108)','128GB 蓝色 移动联通电信4G手机 双卡双待',47,'/goods-img/2f5079e9-57f3-490a-8d3d-5fd64207939d.jpg','/goods-img/2f5079e9-57f3-490a-8d3d-5fd64207939d.jpg','商品介绍加载中...',5599,5199,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10289,'Apple iPhone XR (A2108)','128GB 黄色 移动联通电信4G手机 双卡双待',47,'/goods-img/b1259d73-7c5a-4eca-81eb-53a4e9bcc77e.jpg','/goods-img/b1259d73-7c5a-4eca-81eb-53a4e9bcc77e.jpg','商品介绍加载中...',5599,5199,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10290,'Apple iPhone 11 Pro','Max (A2220) 64GB 暗夜绿色 移动联通电信4G手机 双卡双待',47,'/goods-img/0656b280-66d9-430b-9d0d-e48bf379d89a.jpg','/goods-img/0656b280-66d9-430b-9d0d-e48bf379d89a.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',9599,9599,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10291,'Apple iPhone 11 Pro','Max (A2220) 256GB 深空灰色 移动联通电信4G手机 双卡双待',47,'/goods-img/77ce1f09-3900-4eff-8d97-e67fa8193a84.jpg','/goods-img/77ce1f09-3900-4eff-8d97-e67fa8193a84.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',10899,10899,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10292,'Apple iPhone 11 Pro','Max (A2220) 64GB 金色 移动联通电信4G手机 双卡双待',47,'/goods-img/e45be404-d582-4c1e-80e8-48073327551e.jpg','/goods-img/e45be404-d582-4c1e-80e8-48073327551e.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',9599,9599,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10293,'Apple iPhone 11 Pro','Max (A2220) 512GB 银色 移动联通电信4G手机 双卡双待',47,'/goods-img/76670f49-4556-40ae-b485-3b25dcdcb636.jpg','/goods-img/76670f49-4556-40ae-b485-3b25dcdcb636.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',12699,12699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10294,'Apple iPhone 7 (A1660)','128G 黑色 移动联通电信4G手机',47,'/goods-img/101abd40-e9a2-4ab0-9f4e-16569c9dbf82.jpg','/goods-img/101abd40-e9a2-4ab0-9f4e-16569c9dbf82.jpg','商品介绍加载中...',3199,2949,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10295,'Apple iPhone 7 (A1660)','128G 玫瑰金色 移动联通电信4G手机',47,'/goods-img/6229468b-bcb7-4415-880a-aea3eef4eea2.jpg','/goods-img/6229468b-bcb7-4415-880a-aea3eef4eea2.jpg','商品介绍加载中...',3199,2929,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10296,'Apple iPhone 7 (A1660)','128G 金色 移动联通电信4G手机',47,'/goods-img/1f5bb955-fbe7-451a-b12c-3e2115c53020.jpg','/goods-img/1f5bb955-fbe7-451a-b12c-3e2115c53020.jpg','商品介绍加载中...',3199,2929,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10297,'Apple iPhone 7 (A1660)','128G 银色 移动联通电信4G手机',47,'/goods-img/9fc3c48f-c8e2-426b-915a-c32b0e72998d.jpg','/goods-img/9fc3c48f-c8e2-426b-915a-c32b0e72998d.jpg','商品介绍加载中...',3199,2929,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10298,'Apple iPhone XS Max','(A2104) 256GB 深空灰色 移动联通电信4G手机 双卡双待',47,'/goods-img/ec4af4a5-0a53-4246-bd88-919b0541a55c.jpg','/goods-img/ec4af4a5-0a53-4246-bd88-919b0541a55c.jpg','详情加载中...',9599,8999,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10299,'Apple iPhone XS Max','(A2104) 256GB 金色 移动联通电信4G手机 双卡双待',47,'/goods-img/b7d2373a-5a8c-4be5-a4ce-57b408c6d9f2.jpg','/goods-img/b7d2373a-5a8c-4be5-a4ce-57b408c6d9f2.jpg','商品介绍加载中...',9599,8999,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10300,'Apple iPhone XS Max','(A2104) 256GB 银色 移动联通电信4G手机 双卡双待',47,'/goods-img/837aaf40-5797-4929-b162-a248bfe73b36.jpg','/goods-img/837aaf40-5797-4929-b162-a248bfe73b36.jpg','商品介绍加载中...',9599,8999,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10301,'Apple iPhone 8 (A1863)','64GB 深空灰色 移动联通电信4G手机',47,'/goods-img/8ab049d8-5b2e-4b69-bef0-013bec414598.jpg','/goods-img/8ab049d8-5b2e-4b69-bef0-013bec414598.jpg','商品介绍加载中...',3699,3499,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10302,'Apple iPhone 8 (A1863)','64GB 银色 移动联通电信4G手机',47,'/goods-img/eaeb6faf-2ead-4f5d-84d2-1629686a492c.jpg','/goods-img/eaeb6faf-2ead-4f5d-84d2-1629686a492c.jpg','商品介绍加载中...',3699,3499,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10303,'Apple iPhone 8 (A1863)','64GB 金色 移动联通电信4G手机',47,'/goods-img/0611528c-73c8-4114-a1d8-d9387e771284.jpg','/goods-img/0611528c-73c8-4114-a1d8-d9387e771284.jpg','商品介绍加载中...',3699,3499,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10304,'Apple iPhone 7 Plus','(A1661) 128G 黑色 移动联通电信4G手机',47,'/goods-img/dbafc182-23b7-442c-b9cb-0ea825a659a9.jpg','/goods-img/dbafc182-23b7-442c-b9cb-0ea825a659a9.jpg','商品介绍加载中...',4199,3699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10305,'Apple iPhone 7 Plus','(A1661) 128G 玫瑰金色 移动联通电信4G手机',47,'/goods-img/c227df08-9a26-430a-88a5-72c1e4da5b6e.jpg','/goods-img/c227df08-9a26-430a-88a5-72c1e4da5b6e.jpg','商品介绍加载中...',4199,3699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10306,'Apple iPhone 7 Plus','(A1661) 128G 金色 移动联通电信4G手机',47,'/goods-img/bf58f29f-75ed-411e-8255-3b9f802634f2.jpg','/goods-img/bf58f29f-75ed-411e-8255-3b9f802634f2.jpg','商品介绍加载中...',4199,3699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10307,'Apple iPhone 7 Plus','(A1661) 128G 银色 移动联通电信4G手机',47,'/goods-img/dfab7fee-e787-423d-9771-67e05b03b358.jpg','/goods-img/dfab7fee-e787-423d-9771-67e05b03b358.jpg','商品介绍加载中...',4199,3699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10308,'Apple iPhone XS (A2099)','64GB 金色 移动联通4G手机',47,'/goods-img/b3ff5475-9519-4d94-8f07-5840bb796e60.jpg','/goods-img/b3ff5475-9519-4d94-8f07-5840bb796e60.jpg','详情加载中...',7299,6299,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10309,'Apple iPhone XS (A2099)','64GB 深空灰色 移动联通4G手机',47,'/goods-img/7cc8d012-cfaa-45c4-ba35-70ca46c8bd66.jpg','/goods-img/7cc8d012-cfaa-45c4-ba35-70ca46c8bd66.jpg','详情加载中...',7299,6299,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10310,'Apple iPhone XS (A2099)','256GB 银色 移动联通4G手机',47,'/goods-img/776b459b-e981-434f-bbf7-635cafab7418.jpg','/goods-img/776b459b-e981-434f-bbf7-635cafab7418.jpg','详情加载中...',10099,7699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10311,'Apple iPhone 8 Plus','(A1899) 64GB 深空灰色 移动联通4G手机',47,'/goods-img/8eb2e38b-84e1-4f31-9dae-841800f68038.jpg','/goods-img/8eb2e38b-84e1-4f31-9dae-841800f68038.jpg','商品介绍加载中...',4599,3999,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10312,'Apple iPhone 8 Plus','(A1864) 64GB 金色 移动联通电信4G手机',47,'/goods-img/58c6a2c3-d3f7-4b0a-b4ae-e649b1032087.jpg','/goods-img/58c6a2c3-d3f7-4b0a-b4ae-e649b1032087.jpg','商品介绍加载中...',4799,4399,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10313,'Apple iPhone 8 Plus','(A1864) 64GB 银色 移动联通电信4G手机',47,'/goods-img/2839c451-3eaf-4820-8a15-1858ce339407.jpg','/goods-img/2839c451-3eaf-4820-8a15-1858ce339407.jpg','商品介绍加载中...',4799,4399,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10314,'Apple 苹果 iPhone xr','手机 双卡双待 黑色 全网通64G',47,'/goods-img/35bbe123-c822-457c-aaf0-fdcd861bc06d.jpg','/goods-img/35bbe123-c822-457c-aaf0-fdcd861bc06d.jpg','商品介绍加载中...',6199,4598,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10315,'Apple 苹果 iPhone xr','手机 双卡双待 白色 全网通64G',47,'/goods-img/0e565b23-554e-45d3-ac62-a2fb25be7f2c.jpg','/goods-img/0e565b23-554e-45d3-ac62-a2fb25be7f2c.jpg','商品介绍加载中...',6199,4658,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10316,'Apple 苹果 iPhone xr','手机 双卡双待 蓝色 全网通64G',47,'/goods-img/c08b6ddc-735f-4d2c-b47f-1f0e7f62a9b1.jpg','/goods-img/c08b6ddc-735f-4d2c-b47f-1f0e7f62a9b1.jpg','商品介绍加载中...',6199,4698,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10317,'Apple 苹果 iPhone xr','手机 双卡双待 黄色 全网通64G',47,'/goods-img/c09636de-93b1-444e-b00e-668506676443.jpg','/goods-img/c09636de-93b1-444e-b00e-668506676443.jpg','商品介绍加载中...',6199,4698,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10318,'Apple 苹果 iPhone xr','手机 双卡双待 红色 全网通128G',47,'/goods-img/b26d8460-7ab5-4006-ba5c-e212ee0f31bd.jpg','/goods-img/b26d8460-7ab5-4006-ba5c-e212ee0f31bd.jpg','商品介绍加载中...',6699,5038,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10319,'Apple 苹果 iPhone xr','手机 双卡双待 珊瑚色 全网通64G',47,'/goods-img/fab7cf40-9b7d-4141-8227-9ce7e02e8330.jpg','/goods-img/fab7cf40-9b7d-4141-8227-9ce7e02e8330.jpg','商品介绍加载中...',6199,4698,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10320,'Apple iPhone 11 Pro','(A2217) 256GB 暗夜绿色 移动联通电信4G手机 双卡双待',47,'/goods-img/0025ad55-e260-4a00-be79-fa5b8c5ac0de.jpg','/goods-img/0025ad55-e260-4a00-be79-fa5b8c5ac0de.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',9999,9999,990,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10321,'Apple iPhone 11 Pro','(A2217) 64GB 深空灰色 移动联通电信4G手机 双卡双待',47,'/goods-img/d0abbd2a-19ca-4ae7-9b3c-1eb4eb77c565.jpg','/goods-img/d0abbd2a-19ca-4ae7-9b3c-1eb4eb77c565.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',8699,8699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10322,'Apple iPhone 11 Pro','(A2217) 64GB 银色 移动联通电信4G手机 双卡双待',47,'/goods-img/7d192eff-938f-4e6d-8952-9d405707033e.jpg','/goods-img/7d192eff-938f-4e6d-8952-9d405707033e.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',8699,8699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10323,'【换修无忧年付版】Apple iPhone 11 Pro','(A2217) 512GB 金色 移动联通电信4G手机 双卡双待',47,'/goods-img/38b3f3a9-7056-45a3-b183-ad46dc71f493.jpg','/goods-img/38b3f3a9-7056-45a3-b183-ad46dc71f493.jpg','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-0.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-1.png\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/iphone-11-2.png\" /> \n	</div>\n</div>',12598,12598,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10324,'Apple 苹果 iPhone 6s','Plus 4G手机 金色 全网通 128G',47,'/goods-img/22febff2-db52-4f7a-8d16-414e755e788b.jpg','/goods-img/22febff2-db52-4f7a-8d16-414e755e788b.jpg','商品介绍加载中...',3599,2918,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10325,'Apple 苹果 iPhone 6s','Plus 4G手机 玫瑰金 全网通 128G',47,'/goods-img/dfb0d434-4d59-4fda-896a-1ebd9e4d9ece.jpg','/goods-img/dfb0d434-4d59-4fda-896a-1ebd9e4d9ece.jpg','商品介绍加载中...',3599,2918,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10326,'Apple 苹果 iPhone 6s','Plus 4G手机 深空灰 全网通 128G',47,'/goods-img/d3a4b902-8010-4619-89e4-96cb88e6d4e4.jpg','/goods-img/d3a4b902-8010-4619-89e4-96cb88e6d4e4.jpg','商品介绍加载中...',3599,2888,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10327,'Apple 苹果 iPhone 6s','Plus 4G手机 银色 全网通 128G',47,'/goods-img/b4b7e7d3-b7ba-4917-a1f9-70c52f28df9d.jpg','/goods-img/b4b7e7d3-b7ba-4917-a1f9-70c52f28df9d.jpg','商品介绍加载中...',3599,2988,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10328,'【二手9成新】Apple iPhone XSmax 苹果XSmax','国行二手手机 XS Max 深空灰 64G',47,'/goods-img/0514e529-6b3e-40d5-9183-84088ddb55e1.jpg','/goods-img/0514e529-6b3e-40d5-9183-84088ddb55e1.jpg','商品介绍加载中...',7766,6088,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10329,'【二手9成新】Apple iPhone XSmax 苹果XSmax','国行二手手机 XS Max 金色 64G',47,'/goods-img/a0dfd1ad-61ed-43ee-add4-74bdfea1d6c1.jpg','/goods-img/a0dfd1ad-61ed-43ee-add4-74bdfea1d6c1.jpg','商品介绍加载中...',14999,6088,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10330,'【二手9成新】Apple iPhone XSmax 苹果XSmax','国行二手手机 XS Max 银色 256G',47,'/goods-img/87b66719-fc17-4c97-a954-de8a78b42a09.jpg','/goods-img/87b66719-fc17-4c97-a954-de8a78b42a09.jpg','商品介绍加载中...',14999,6938,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10331,'【二手9成新】Apple iPhone 6s Plus','苹果6sPlus 二手手机（送一年碎屏险） 玫瑰金色 64G 全网通',47,'/goods-img/5b132b57-24e4-4d65-9cb8-3299dc0e9ed6.png','/goods-img/5b132b57-24e4-4d65-9cb8-3299dc0e9ed6.png','商品介绍加载中...',1799,1468,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10332,'【二手9成新】Apple iPhone 6s Plus','苹果6sPlus 二手手机（送一年碎屏险） 金色 64G 全网通',47,'/goods-img/f289ec14-e0e2-481e-a703-39eec00a1b15.png','/goods-img/f289ec14-e0e2-481e-a703-39eec00a1b15.png','商品介绍加载中...',1799,1499,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10333,'【二手9成新】Apple iPhone 6s Plus','苹果6sPlus 二手手机（送一年碎屏险） 银色 64G 全网通',47,'/goods-img/084208d0-4dc2-4f1a-aff4-4114616dfae1.png','/goods-img/084208d0-4dc2-4f1a-aff4-4114616dfae1.png','商品介绍加载中...',1799,1599,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10334,'【二手9成新】Apple iPhone 6s Plus','苹果6sPlus 二手手机（送一年碎屏险） 深空灰色 64G 全网通',47,'/goods-img/8a598420-0052-4551-b00a-b288b6c22a48.png','/goods-img/8a598420-0052-4551-b00a-b288b6c22a48.png','商品介绍加载中...',1799,1638,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10335,'Apple 苹果 iPhone xr','手机 双卡双待 白色 全网通 64G',47,'/goods-img/6110a187-511f-45d0-8b59-ea2a75546a45.jpg','/goods-img/6110a187-511f-45d0-8b59-ea2a75546a45.jpg','商品介绍加载中...',5499,4699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10336,'Apple 苹果 iPhone xr','手机 双卡双待 黑色 全网通 128G',47,'/goods-img/41b10e86-857c-435c-b86d-d822e35450ab.jpg','/goods-img/41b10e86-857c-435c-b86d-d822e35450ab.jpg','商品介绍加载中...',5699,5079,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10337,'Apple 苹果 iPhone xr','手机 双卡双待 蓝色 全网通 64G',47,'/goods-img/d38bcaab-7a0a-4f86-ad75-60ac74a308e6.jpg','/goods-img/d38bcaab-7a0a-4f86-ad75-60ac74a308e6.jpg','商品介绍加载中...',5499,4699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10338,'Apple 苹果 iPhone xr','手机 双卡双待 黄色 全网通 128G',47,'/goods-img/73fc7cb9-5b43-4bce-a2b3-a82516773de0.jpg','/goods-img/73fc7cb9-5b43-4bce-a2b3-a82516773de0.jpg','商品介绍加载中...',5699,5079,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10339,'Apple 苹果 iPhone xr','手机 双卡双待 珊瑚色 全网通 64G',47,'/goods-img/00e53d76-db08-4ae2-864f-ca1cd7c8c32b.jpg','/goods-img/00e53d76-db08-4ae2-864f-ca1cd7c8c32b.jpg','商品介绍加载中...',5499,4699,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10340,'【二手95新】Apple iPhonex XSmax苹果x xsmax','国行 二手手机 XS max金色 64G 全网通',47,'/goods-img/5b9acfd4-7808-4b3b-bf5c-4b367667418c.jpg','/goods-img/5b9acfd4-7808-4b3b-bf5c-4b367667418c.jpg','商品介绍加载中...',12999,6088,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10341,'【二手95新】Apple iPhonex XSmax苹果x xsmax','国行 二手手机 XS 金色 64G 全网通',47,'/goods-img/cd2b481d-a4a2-4bc0-a4e1-784a28c37ef9.jpg','/goods-img/cd2b481d-a4a2-4bc0-a4e1-784a28c37ef9.jpg','商品介绍加载中...',12999,5299,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10342,'【二手95新】Apple iPhonex XSmax苹果x xsmax','国行 二手手机 XS max灰色 256G 全网通',47,'/goods-img/1d866674-4e57-483a-955f-5fd1a4f5d921.jpg','/goods-img/1d866674-4e57-483a-955f-5fd1a4f5d921.jpg','商品介绍加载中...',12999,6938,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10343,'【二手95新】Apple iPhonex XSmax苹果x xsmax','国行 二手手机 XS max银色 64G 全网通',47,'/goods-img/3f3e086e-e4be-464f-9c20-760430cab2df.jpg','/goods-img/3f3e086e-e4be-464f-9c20-760430cab2df.jpg','商品介绍加载中...',12999,6088,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10344,'【二手95新】Apple iPhonex XSmax苹果x xsmax','国行 二手手机 XS 灰色 64G 全网通',47,'/goods-img/4a4a0820-aad5-47d4-a926-f040fd090c96.jpg','/goods-img/4a4a0820-aad5-47d4-a926-f040fd090c96.jpg','商品介绍加载中...',12999,5299,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10345,'【二手95新】Apple iPhonex XSmax苹果x xsmax','国行 二手手机 XS 银色 64G 全网通',47,'/goods-img/a6b87d83-5ba7-4683-be17-43ab9aa043e3.jpg','/goods-img/a6b87d83-5ba7-4683-be17-43ab9aa043e3.jpg','商品介绍加载中...',12999,5299,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10346,'【二手9成新】Apple iPhone X 苹果X','二手手机 深空灰色 64G 全网通',47,'/goods-img/3cd13e20-2a00-4049-8768-0ba662df7e40.jpg','/goods-img/3cd13e20-2a00-4049-8768-0ba662df7e40.jpg','商品介绍加载中...',3989,3989,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10347,'【二手9成新】Apple iPhone X 苹果X','二手手机 银色 64G 全网通',47,'/goods-img/fc3db752-e0dc-4ae7-bac3-fd60ab8a1e17.jpg','/goods-img/fc3db752-e0dc-4ae7-bac3-fd60ab8a1e17.jpg','商品介绍加载中...',4008,4008,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10348,'【二手9成新】苹果7Plus手机 Apple iPhone7Plus 苹果7P','二手手机 磨砂黑 128G 全网通',47,'/goods-img/24b442e2-1bdd-4350-bbab-4e4d3d3445f1.jpg','/goods-img/24b442e2-1bdd-4350-bbab-4e4d3d3445f1.jpg','商品介绍加载中...',2899,2399,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10349,'【二手9成新】苹果7Plus手机 Apple iPhone7Plus 苹果7P','二手手机 亮黑色 128G 全网通',47,'/goods-img/7601e13f-de8e-449c-84be-65fbc7280cfc.png','/goods-img/7601e13f-de8e-449c-84be-65fbc7280cfc.png','商品介绍加载中...',2899,2399,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10350,'【二手9成新】苹果7Plus手机 Apple iPhone7Plus 苹果7P','二手手机 玫瑰金 128G 全网通',47,'/goods-img/771bc653-485b-4c5d-bca3-c84d3e90020d.jpg','/goods-img/771bc653-485b-4c5d-bca3-c84d3e90020d.jpg','商品介绍加载中...',2666,2399,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10351,'【二手9成新】苹果7Plus手机 Apple iPhone7Plus 苹果7P','二手手机 金色 128G 全网通',47,'/goods-img/5a170339-acb4-4890-bd08-bb109864e853.jpg','/goods-img/5a170339-acb4-4890-bd08-bb109864e853.jpg','商品介绍加载中...',2739,2399,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10352,'【二手9成新】苹果7Plus手机 Apple iPhone7Plus 苹果7P','二手手机 银色 128G 全网通',47,'/goods-img/a419ebb4-18a5-4295-9404-0593dd215ad0.jpg','/goods-img/a419ebb4-18a5-4295-9404-0593dd215ad0.jpg','商品介绍加载中...',2699,2466,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10353,'【二手9成新】Apple iPhone X 苹果X','二手手机 全网通 深空灰 64G',47,'/goods-img/4f666eee-c2c7-459c-934e-b32714d1e1c4.png','/goods-img/4f666eee-c2c7-459c-934e-b32714d1e1c4.png','商品介绍加载中...',5188,3956,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10354,'【二手9成新】苹果8Plus手机 Apple iPhone 8Plus','苹果8P 二手手机 深空灰 64G 全网通',47,'/goods-img/ada8e547-dca3-47fc-8aab-35884575090a.jpg','/goods-img/ada8e547-dca3-47fc-8aab-35884575090a.jpg','商品介绍加载中...',3888,3199,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10355,'【二手9成新】苹果8Plus手机 Apple iPhone 8Plus','苹果8P 二手手机 金色 64G 全网通',47,'/goods-img/76a2e417-2f15-412f-ab73-3a5eb2a7d2d1.jpg','/goods-img/76a2e417-2f15-412f-ab73-3a5eb2a7d2d1.jpg','商品介绍加载中...',3550,3199,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10356,'【二手9成新】苹果8Plus手机 Apple iPhone 8Plus','苹果8P 二手手机 银色 64G 全网通',47,'/goods-img/5bfb8955-0b1c-4652-b162-a9b91b71211a.jpg','/goods-img/5bfb8955-0b1c-4652-b162-a9b91b71211a.jpg','商品介绍加载中...',3499,3238,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10357,'【二手9成新】苹果8Plus手机 Apple iPhone 8Plus','苹果8P 二手手机 中国红 64G 全网通',47,'/goods-img/d31193ee-04c1-4bac-8a91-1a4690a396be.jpg','/goods-img/d31193ee-04c1-4bac-8a91-1a4690a396be.jpg','商品介绍加载中...',3438,3299,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10358,'【二手9成新】Apple iPhoneX 苹果X 二手苹果x手机','深空灰 64G全网通',47,'/goods-img/b9264842-cd50-4d6f-a4a5-e8cc9dd483a4.png','/goods-img/b9264842-cd50-4d6f-a4a5-e8cc9dd483a4.png','商品介绍加载中...',4799,3989,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10359,'【二手9成新】Apple iPhoneX 苹果X 二手苹果x手机','银色 64G全网通',47,'/goods-img/58e9a125-61c1-416b-b17f-99cda431a202.png','/goods-img/58e9a125-61c1-416b-b17f-99cda431a202.png','商品介绍加载中...',4799,4016,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10360,'【二手95新】Apple iPhone XS 苹果xs','国行全网通二手手机 银色 全网通 64G',47,'/goods-img/5a732ada-1fdb-48f1-b106-666159565a94.jpg','/goods-img/5a732ada-1fdb-48f1-b106-666159565a94.jpg','商品介绍加载中...',9999,5299,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10361,'【二手95新】Apple iPhone XS 苹果xs','国行全网通二手手机 金色 全网通 256G',47,'/goods-img/f9e9b321-4b25-40c5-af6d-d9f3fe74a053.jpg','/goods-img/f9e9b321-4b25-40c5-af6d-d9f3fe74a053.jpg','商品介绍加载中...',9999,6008,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10362,'【二手9成新】Apple iPhone X 苹果x','二手手机 X 银色 256G 全网通',47,'/goods-img/8da60128-fcc7-46ed-98b6-0066c69624c0.png','/goods-img/8da60128-fcc7-46ed-98b6-0066c69624c0.png','商品介绍加载中...',5058,4639,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10363,'【二手9成新】Apple iPhone X 苹果x','国行全网通二手手机 X 灰色 64G 全网通',47,'/goods-img/8aca87a3-65dd-4c42-91c7-bbbd10fcf7a6.jpg','/goods-img/8aca87a3-65dd-4c42-91c7-bbbd10fcf7a6.jpg','商品介绍加载中...',6999,3999,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10364,'【二手9成新】Apple iPhone X 苹果x','国行全网通二手手机 X 银色 64G 全网通',47,'/goods-img/fdec1b37-9a2f-46ea-af03-5091d83e546a.jpg','/goods-img/fdec1b37-9a2f-46ea-af03-5091d83e546a.jpg','商品介绍加载中...',6999,4078,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10365,'【二手9成新】Apple iPhone XR 苹果xr','二手手机双卡双待 白色 128G 全网通',47,'/goods-img/9834bb8d-fe1c-4218-a624-4a25aecb0676.jpg','/goods-img/9834bb8d-fe1c-4218-a624-4a25aecb0676.jpg','商品介绍加载中...',5888,4299,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10366,'【二手9成新】Apple iPhone XR 苹果xr','二手手机双卡双待 蓝色 128G 全网通',47,'/goods-img/3993feaa-0365-4d7e-9cc5-dcf583243ca3.jpg','/goods-img/3993feaa-0365-4d7e-9cc5-dcf583243ca3.jpg','商品介绍加载中...',5888,4399,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10367,'【二手9成新】Apple iPhone XR 苹果xr','二手手机双卡双待 黑色 64G 全网通',47,'/goods-img/ba9cf789-60a8-48db-8329-97c3fc13a061.jpg','/goods-img/ba9cf789-60a8-48db-8329-97c3fc13a061.jpg','商品介绍加载中...',5888,4055,1000,'',0,0,'2019-09-18 13:27:13',0,'2019-09-18 13:27:13'),
	(10689,'荣耀Play3 6.39英寸魅眼全视屏 4000mAh大电池 真4800万AI三摄','麒麟710F自研芯片 全网通4GB+64GB 幻夜黑',45,'/goods-img/9aa34959-cd60-418f-b42e-aa7243b6869c.jpg','/goods-img/9aa34959-cd60-418f-b42e-aa7243b6869c.jpg','详情加载中...',999,999,999,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10690,'华为 HUAWEI 畅享10 Plus','超高清全视屏前置悬浮式镜头4800万超广角AI三摄 4GB+128GB幻夜黑全网通双4G手机',46,'/goods-img/2613a582-460c-4c2b-bbc0-6c7dbf501bd2.jpg','/goods-img/2613a582-460c-4c2b-bbc0-6c7dbf501bd2.jpg','详情加载中...',1499,1499,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10691,'华为 HUAWEI 畅享10 Plus','超高清全视屏前置悬浮式镜头4800万超广角AI三摄 4GB+128GB翡冷翠全网通双4G手机',46,'/goods-img/21b0751b-f6ae-4a57-8fb8-61e007395c43.jpg','/goods-img/21b0751b-f6ae-4a57-8fb8-61e007395c43.jpg','商品介绍加载中...',1499,1499,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10692,'华为 HUAWEI 畅享10 Plus','超高清全视屏前置悬浮式镜头4800万超广角AI三摄 6GB+128GB天空之境全网通双4G手机',46,'/goods-img/3f68538f-3b56-4e98-9676-99139857428c.jpg','/goods-img/3f68538f-3b56-4e98-9676-99139857428c.jpg','详情加载中...',1799,1799,999,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10693,'荣耀10青春版 幻彩渐变 2400万AI自拍 全网通版4GB+64GB','渐变蓝 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/f8ab28c3-8e04-49a0-ba05-2e6a3ae7211f.jpg','/goods-img/f8ab28c3-8e04-49a0-ba05-2e6a3ae7211f.jpg','详情加载中...',1099,999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10694,'荣耀10青春版 幻彩渐变 2400万AI自拍 全网通版4GB+64GB','幻夜黑 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/de654f42-d58d-4336-8edd-da01c3523449.jpg','/goods-img/de654f42-d58d-4336-8edd-da01c3523449.jpg','详情加载中...',1099,999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10695,'荣耀10青春版 幻彩渐变 2400万AI自拍 全网通版4GB+64GB','渐变红 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/87254a42-9fdf-4e68-a11e-e8e2eef28d2c.jpg','/goods-img/87254a42-9fdf-4e68-a11e-e8e2eef28d2c.jpg','详情加载中...',1099,999,997,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10696,'荣耀10青春版 幻彩渐变 2400万AI自拍 全网通版4GB+64GB','铃兰白 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/81b7060a-7274-4bff-86c0-72d5fc7ff383.jpg','/goods-img/81b7060a-7274-4bff-86c0-72d5fc7ff383.jpg','详情加载中...',1099,999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10697,'荣耀8X 千元屏霸 91%屏占比 2000万AI双摄','4GB+64GB 幻夜黑 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/d7f74e8f-5c52-422b-ac99-a8d691830494.jpg','/goods-img/d7f74e8f-5c52-422b-ac99-a8d691830494.jpg','详情加载中...',1399,999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10698,'荣耀8X 千元屏霸 91%屏占比 2000万AI双摄','4GB+64GB 幻影蓝 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/7031c07e-a70f-4f6d-9e2d-d0af31e3393a.jpg','/goods-img/7031c07e-a70f-4f6d-9e2d-d0af31e3393a.jpg','详情加载中...',1399,999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10699,'荣耀8X 千元屏霸 91%屏占比 2000万AI双摄','4GB+64GB 魅海蓝 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/b7bfcc28-98c2-4cb4-8ce3-afe4c482b674.jpg','/goods-img/b7bfcc28-98c2-4cb4-8ce3-afe4c482b674.jpg','详情加载中...',1399,999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10700,'荣耀8X 千元屏霸 91%屏占比 2000万AI双摄','4GB+64GB 魅焰红 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/6a160b96-9b4a-4844-b335-feb31b1f5d8c.jpg','/goods-img/6a160b96-9b4a-4844-b335-feb31b1f5d8c.jpg','详情加载中...',1399,999,992,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10701,'荣耀8X 千元屏霸 91%屏占比 2000万AI双摄','4GB+64GB 梦幻紫 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/8ccc13ec-96fe-4488-a604-526601548c9e.jpg','/goods-img/8ccc13ec-96fe-4488-a604-526601548c9e.jpg','详情加载中...',1399,999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10702,'华为 HUAWEI P30 超感光徕卡三摄麒麟980AI智能芯片全面屏屏内指纹版手机8GB+128GB天空之境全网通双4G手机','新蜂精选',46,'/goods-img/edb7e8ef-7785-418b-a75e-dfed2aa74e39.jpg','/goods-img/edb7e8ef-7785-418b-a75e-dfed2aa74e39.jpg','详情加载中...',4288,3988,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10703,'华为 HUAWEI P30 超感光徕卡三摄麒麟980AI智能芯片全面屏屏内指纹版手机8GB+128GB亮黑色全网通双4G手机','新蜂精选',46,'/goods-img/e13294f7-9ab0-42dc-afb1-9f41c59436cf.jpg','/goods-img/e13294f7-9ab0-42dc-afb1-9f41c59436cf.jpg','商品介绍加载中...',4288,3988,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10704,'华为 HUAWEI P30 超感光徕卡三摄麒麟980AI智能芯片全面屏屏内指纹版手机8GB+128GB珠光贝母全网通双4G手机','新蜂精选',46,'/goods-img/b9e6d770-06dd-40f4-9ae5-31103cec6e5f.jpg','/goods-img/b9e6d770-06dd-40f4-9ae5-31103cec6e5f.jpg','详情加载中...',4288,3988,999,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10705,'华为 HUAWEI P30 超感光徕卡三摄麒麟980AI智能芯片全面屏屏内指纹版手机8GB+128GB极光色全网通双4G手机','新蜂精选',46,'/goods-img/20312f4e-da4f-49b9-8150-ab54f0302915.jpg','/goods-img/20312f4e-da4f-49b9-8150-ab54f0302915.jpg','商品介绍加载中...',4288,3988,997,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10706,'华为 HUAWEI P30 超感光徕卡三摄麒麟980AI智能芯片全面屏屏内指纹版手机8GB+128GB赤茶橘全网通双4G手机','新蜂精选',46,'/goods-img/192b1727-bcab-4bdf-8494-182f8ec5b2e6.jpg','/goods-img/192b1727-bcab-4bdf-8494-182f8ec5b2e6.jpg','商品介绍加载中...',4288,3988,993,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10707,'荣耀20i 3200万AI自拍 超广角三摄 全网通版6GB+64GB','渐变蓝 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/74146e03-42d1-453c-843d-b02d8bcc24f4.jpg','/goods-img/74146e03-42d1-453c-843d-b02d8bcc24f4.jpg','详情加载中...',1399,1299,996,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10708,'荣耀20i 3200万AI自拍 超广角三摄 全网通版6GB+64GB','渐变红 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/4c066fc2-3a58-44df-9dc6-8465b25f92ef.jpg','/goods-img/4c066fc2-3a58-44df-9dc6-8465b25f92ef.jpg','详情加载中...',1399,1299,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10709,'荣耀20i 3200万AI自拍 超广角三摄 全网通版6GB+64GB','幻夜黑 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/525bdd6e-848b-4e02-b19f-1a08fdb87faa.jpg','/goods-img/525bdd6e-848b-4e02-b19f-1a08fdb87faa.jpg','详情加载中...',1399,1299,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10710,'荣耀9X 麒麟810 4000mAh超强续航 4800万超清夜拍','6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝',45,'/goods-img/7b8b7da7-f154-453e-a6a6-ea2f5e7d8b4a.jpg','/goods-img/7b8b7da7-f154-453e-a6a6-ea2f5e7d8b4a.jpg','详情加载中...',1599,1599,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10711,'荣耀9X 麒麟810 4000mAh超强续航 4800万超清夜拍','6.59英寸升降全面屏 全网通6GB+64GB 幻夜黑',45,'/goods-img/d30f7986-bc0f-4ea8-8fbb-94c6bae248f5.jpg','/goods-img/d30f7986-bc0f-4ea8-8fbb-94c6bae248f5.jpg','详情加载中...',1599,1599,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10712,'荣耀9X 麒麟810 4000mAh超强续航 4800万超清夜拍','6.59英寸升降全面屏 全网通4GB+64GB 魅焰红',45,'/goods-img/95b5df3b-cfec-40bb-8ead-35e0fe7fb7b2.jpg','/goods-img/95b5df3b-cfec-40bb-8ead-35e0fe7fb7b2.jpg','详情加载中...',1399,1399,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10713,'荣耀20 李现同款 4800万超广角AI四摄 3200W美颜自拍','麒麟Kirin980全网通版8GB+128GB 蓝水翡翠 全面屏手机',45,'/goods-img/2469b8fa-8117-4409-a8d6-3b52a33b3e51.jpg','/goods-img/2469b8fa-8117-4409-a8d6-3b52a33b3e51.jpg','详情加载中...',2699,2499,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10714,'荣耀20 李现同款 4800万超广角AI四摄 3200W美颜自拍','麒麟Kirin980全网通版8GB+128GB 幻夜黑 全面屏手机',45,'/goods-img/474e2ef0-2321-4363-ab31-7a838546f172.jpg','/goods-img/474e2ef0-2321-4363-ab31-7a838546f172.jpg','详情加载中...',2699,2499,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10715,'荣耀20 李现同款 4800万超广角AI四摄 3200W美颜自拍','麒麟Kirin980全网通版8GB+128GB 冰岛白 全面屏手机',45,'/goods-img/77d87d20-4fc7-441c-82a8-baf9089fc3ad.jpg','/goods-img/77d87d20-4fc7-441c-82a8-baf9089fc3ad.jpg','详情加载中...',2699,2499,997,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10716,'荣耀20 李现同款 4800万超广角AI四摄 3200W美颜自拍','麒麟Kirin980全网通版8GB+128GB 幻影蓝 全面屏手机',45,'/goods-img/1a200710-8c41-4411-8edf-a49575807a08.jpg','/goods-img/1a200710-8c41-4411-8edf-a49575807a08.jpg','详情加载中...',2699,2499,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10717,'荣耀20 PRO 李现同款 4800万全焦段AI四摄','双光学防抖 麒麟980 全网通4G 8GB+128GB 冰岛幻境 拍照手机',45,'/goods-img/391cd4e6-6071-41ea-a6fc-d983b30a5470.jpg','/goods-img/391cd4e6-6071-41ea-a6fc-d983b30a5470.jpg','详情加载中...',3199,2899,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10718,'荣耀20 PRO 李现同款 4800万全焦段AI四摄','双光学防抖 麒麟980 全网通4G 8GB+128GB 蓝水翡翠 拍照手机',45,'/goods-img/5d7ee18f-ca20-4d72-a803-dc5b03bd80e2.jpg','/goods-img/5d7ee18f-ca20-4d72-a803-dc5b03bd80e2.jpg','详情加载中...',3199,2899,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10719,'荣耀20 PRO 李现同款 4800万全焦段AI四摄','双光学防抖 麒麟980 全网通4G 8GB+128GB 幻夜星河 拍照手机',45,'/goods-img/e1505375-d00d-4cd8-a090-a13490b430d5.jpg','/goods-img/e1505375-d00d-4cd8-a090-a13490b430d5.jpg','详情加载中...',3199,2899,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10720,'荣耀20 PRO × MOSCHINO联名版','4800万全焦段AI四摄 双光学防抖 麒麟980 8GB+256GB 黑色',45,'/goods-img/0ae89667-8a69-4efc-b8d8-c0ebaf56753a.jpg','/goods-img/0ae89667-8a69-4efc-b8d8-c0ebaf56753a.jpg','详情加载中...',3799,3799,997,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10721,'华为 HUAWEI 畅享 9S','6GB+64GB 幻夜黑 全网通 2400万超广角三摄珍珠屏大存储 移动联通电信4G手机 双卡双待',46,'/goods-img/1b96ae9b-8c56-465e-9e82-ff712305e2d9.jpg','/goods-img/1b96ae9b-8c56-465e-9e82-ff712305e2d9.jpg','详情加载中...',1499,1199,994,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10722,'华为 HUAWEI 畅享 9S','6GB+64GB 极光蓝 全网通 2400万超广角三摄珍珠屏大存储 移动联通电信4G手机 双卡双待',46,'/goods-img/b49530f5-fe13-42b3-9ca9-6f1367e0f8f8.jpg','/goods-img/b49530f5-fe13-42b3-9ca9-6f1367e0f8f8.jpg','详情加载中...',1499,1199,995,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10723,'华为 HUAWEI 畅享 9S','6GB+64GB 珊瑚红 全网通 2400万超广角三摄珍珠屏大存储 移动联通电信4G手机 双卡双待',46,'/goods-img/84397a4c-ff06-4f08-bad5-bd4d5f8e23ff.jpg','/goods-img/84397a4c-ff06-4f08-bad5-bd4d5f8e23ff.jpg','详情加载中...',1499,1199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10724,'荣耀V20 游戏手机 麒麟980芯片 魅眼全视屏','4800万深感相机 6GB+128GB 幻夜黑 移动联通电信4G全面屏手机',45,'/goods-img/7a58b5b2-0101-4a55-9872-d7765f08cf19.jpg','/goods-img/7a58b5b2-0101-4a55-9872-d7765f08cf19.jpg','详情加载中...',2199,2099,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10725,'荣耀V20 游戏手机 麒麟980芯片 魅眼全视屏','4800万深感相机 6GB+128GB 魅海蓝 移动联通电信4G全面屏手机',45,'/goods-img/5dd6b4de-0b39-48fc-9285-7356c22edf7b.jpg','/goods-img/5dd6b4de-0b39-48fc-9285-7356c22edf7b.jpg','详情加载中...',2199,2099,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10726,'荣耀V20 游戏手机 麒麟980芯片 魅眼全视屏','4800万深感相机 6GB+128GB 幻影蓝 移动联通电信4G全面屏手机',45,'/goods-img/c5a6593b-ef49-42fd-b330-0be8021362d8.jpg','/goods-img/c5a6593b-ef49-42fd-b330-0be8021362d8.jpg','详情加载中...',2199,2099,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10727,'荣耀V20 游戏手机 麒麟980芯片 魅眼全视屏','4800万深感相机 6GB+128GB 魅丽红 移动联通电信4G全面屏手机',45,'/goods-img/b57f705a-ef7f-4a9f-a244-3fc980e17555.jpg','/goods-img/b57f705a-ef7f-4a9f-a244-3fc980e17555.jpg','详情加载中...',2199,2099,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10728,'荣耀V20 游戏手机 麒麟980芯片 魅眼全视屏','4800万深感相机 6GB+128GB 幻影红 移动联通电信4G全面屏手机',45,'/goods-img/3dd91f7d-8f89-4e8a-a808-fa556ee1ceb3.jpg','/goods-img/3dd91f7d-8f89-4e8a-a808-fa556ee1ceb3.jpg','详情加载中...',2199,2099,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10729,'华为 HUAWEI P20 AI智慧徕卡双摄全面屏游戏手机','6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待',46,'/goods-img/f8edc81a-8fbd-425b-8ed7-d6b4c14ec6a1.jpg','/goods-img/f8edc81a-8fbd-425b-8ed7-d6b4c14ec6a1.jpg','商品介绍加载中...',3088,2799,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10730,'华为 HUAWEI P20 AI智慧徕卡双摄全面屏游戏手机','6GB+64GB 极光色 全网通移动联通电信4G手机 双卡双待',46,'/goods-img/c17c5292-2c20-4196-88e3-7ea813530db5.jpg','/goods-img/c17c5292-2c20-4196-88e3-7ea813530db5.jpg','商品介绍加载中...',2788,2679,997,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10731,'华为 HUAWEI P20 AI智慧徕卡双摄全面屏游戏手机','6GB+64GB 宝石蓝 全网通移动联通电信4G手机 双卡双待',46,'/goods-img/b43bcd55-3709-4c32-b3a2-5b59c80f3610.jpg','/goods-img/b43bcd55-3709-4c32-b3a2-5b59c80f3610.jpg','商品介绍加载中...',2788,2699,999,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10732,'华为 HUAWEI P20 AI智慧全面屏','6GB+64GB 极光闪蝶色 全网通版 移动联通电信4G手机 双卡双待',46,'/goods-img/3b183d9a-ac01-4bed-a7bb-1ddeba6ad416.jpg','/goods-img/3b183d9a-ac01-4bed-a7bb-1ddeba6ad416.jpg','详情加载中...',2788,2679,999,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10733,'华为 HUAWEI P20 AI智慧全面屏','6GB+64GB 珠光贝母色 全网通版 移动联通电信4G手机 双卡双待',46,'/goods-img/28e94d5d-9ccc-4843-a296-2747530037ce.jpg','/goods-img/28e94d5d-9ccc-4843-a296-2747530037ce.jpg','详情加载中...',3388,2988,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10734,'华为 HUAWEI P20 AI智慧徕卡双摄全面屏游戏手机','6GB+128GB 香槟金 全网通移动联通电信4G手机 双卡双待',46,'/goods-img/0b11241e-4d6b-44ea-afb0-e029d1b5a54d.jpg','/goods-img/0b11241e-4d6b-44ea-afb0-e029d1b5a54d.jpg','商品介绍加载中...',3888,3888,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10735,'荣耀20S 李现同款 3200万人像超级夜景 4800万超广角AI三摄','麒麟810旗舰级芯片 全网通版6GB+128GB 蝶羽蓝',45,'/goods-img/8883043d-bef3-442c-9ccf-af9c03510c5d.jpg','/goods-img/8883043d-bef3-442c-9ccf-af9c03510c5d.jpg','详情加载中...',1899,1899,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10736,'华为 HUAWEI 畅享MAX 4GB+64GB','幻夜黑 全网通版 珍珠屏杜比全景声大电池 移动联通电信4G手机 双卡双待',46,'/goods-img/522ed5b9-bcae-401f-9933-d2e957bb3384.jpg','/goods-img/522ed5b9-bcae-401f-9933-d2e957bb3384.jpg','商品介绍加载中...',1199,999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10737,'华为 HUAWEI 畅享MAX 4GB+64GB','琥珀棕 全网通版 珍珠屏杜比全景声大电池 移动联通电信4G手机 双卡双待',46,'/goods-img/36bdfdb9-21b1-46d5-9534-8b3873c9b6d9.jpg','/goods-img/36bdfdb9-21b1-46d5-9534-8b3873c9b6d9.jpg','商品介绍加载中...',1199,999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10738,'华为 HUAWEI 畅享MAX 4GB+128GB','天际白 全网通版 珍珠屏杜比全景声大电池 移动联通电信4G手机 双卡双待',46,'/goods-img/51fa04cf-1c05-49ee-8dea-0c1757ff32c4.jpg','/goods-img/51fa04cf-1c05-49ee-8dea-0c1757ff32c4.jpg','商品介绍加载中...',1899,1399,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10739,'华为 HUAWEI P30 Pro','超感光徕卡四摄10倍混合变焦麒麟980芯片屏内指纹 8GB+128GB极光色全网通版双4G手机',46,'/goods-img/65c8e729-aeca-4780-977b-4d0d39d4aa2e.jpg','/goods-img/65c8e729-aeca-4780-977b-4d0d39d4aa2e.jpg','商品介绍加载中...',5488,4988,999,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10740,'华为 HUAWEI P30 Pro','超感光徕卡四摄10倍混合变焦麒麟980芯片屏内指纹 8GB+128GB亮黑色全网通版双4G手机',46,'/goods-img/bc90bb1e-494a-44d4-b180-42a994ec80fc.jpg','/goods-img/bc90bb1e-494a-44d4-b180-42a994ec80fc.jpg','商品介绍加载中...',5488,4988,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10741,'华为 HUAWEI P30 Pro','超感光徕卡四摄10倍混合变焦麒麟980芯片屏内指纹 8GB+128GB珠光贝母全网通版双4G手机',46,'/goods-img/a6f309b7-765a-4407-be71-bbd5b764d448.jpg','/goods-img/a6f309b7-765a-4407-be71-bbd5b764d448.jpg','商品介绍加载中...',5488,4988,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10742,'华为 HUAWEI P30 Pro','超感光徕卡四摄10倍混合变焦麒麟980芯片屏内指纹 8GB+256GB天空之境全网通版双4G手机',46,'/goods-img/dda1d575-cdac-4eb4-a118-3834490166f7.jpg','/goods-img/dda1d575-cdac-4eb4-a118-3834490166f7.jpg','商品介绍加载中...',5988,5488,946,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10743,'华为 HUAWEI P30 Pro','超感光徕卡四摄10倍混合变焦麒麟980芯片屏内指纹 8GB+256GB墨玉蓝全网通版双4G手机',46,'/goods-img/8755a735-baa1-4f17-a9bd-30c4f4f1451b.jpg','/goods-img/8755a735-baa1-4f17-a9bd-30c4f4f1451b.jpg','详情加载中...',5988,5488,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10744,'华为 HUAWEI P30 Pro','超感光徕卡四摄10倍混合变焦麒麟980芯片屏内指纹 8GB+128GB赤茶橘全网通版双4G手机',46,'/goods-img/44e78820-86f3-429d-94af-64f6af308846.jpg','/goods-img/44e78820-86f3-429d-94af-64f6af308846.jpg','商品介绍加载中...',5488,4988,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10745,'华为 HUAWEI P30 Pro','超感光徕卡四摄10倍混合变焦麒麟980芯片屏内指纹 8GB+128GB嫣紫色全网通版双4G手机',46,'/admin/dist/img/no-img.png','/admin/dist/img/no-img.png','详情加载中...',5488,4988,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10746,'华为 HUAWEI nova 5','Pro 前置3200万人像超级夜景4800万AI四摄麒麟980芯片8GB+128GB绮境森林全网通双4G手机',46,'/goods-img/2948815e-043a-4f47-896f-7f6ccf916369.jpg','/goods-img/2948815e-043a-4f47-896f-7f6ccf916369.jpg','详情加载中...',2999,2999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10747,'华为 HUAWEI nova 5','Pro 前置3200万人像超级夜景4800万AI四摄麒麟980芯片8GB+128GB亮黑色全网通双4G手机',46,'/goods-img/df1bea42-9172-4cd5-9fc5-f35bb736108f.jpg','/goods-img/df1bea42-9172-4cd5-9fc5-f35bb736108f.jpg','详情加载中...',2999,2999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10748,'华为 HUAWEI nova 5','Pro 前置3200万人像超级夜景4800万AI四摄麒麟980芯片 8GB+128GB仲夏紫全网通双4G手机',46,'/goods-img/ab6f8463-794f-4f40-87b8-d01e6260ff1c.jpg','/goods-img/ab6f8463-794f-4f40-87b8-d01e6260ff1c.jpg','详情加载中...',2999,2999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10749,'华为 HUAWEI nova 5','Pro 前置3200万人像超级夜景4800万AI四摄麒麟980芯片8GB+128GB苏音蓝全网通双4G手机',46,'/goods-img/98e90b6e-2a5d-462d-8cd1-44699144a0b5.jpg','/goods-img/98e90b6e-2a5d-462d-8cd1-44699144a0b5.jpg','详情加载中...',2999,2999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10750,'华为 HUAWEI nova 5','Pro 前置3200万人像超级夜景4800万AI四摄麒麟980芯片8GB+128GB珊瑚橙全网通双4G手机',46,'/goods-img/ec0bafed-d651-4be7-b2aa-13e84248219a.jpg','/goods-img/ec0bafed-d651-4be7-b2aa-13e84248219a.jpg','详情加载中...',2999,2999,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10751,'华为 HUAWEI nova 5','Pro 前置3200万人像超级夜景4800万AI四摄麒麟980芯片8GB+256GB仲夏紫星耀礼盒版全网通',46,'/goods-img/83f39052-5a1c-4769-a7db-cf2bd53d2a29.jpg','/goods-img/83f39052-5a1c-4769-a7db-cf2bd53d2a29.jpg','详情加载中...',3799,3599,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10752,'华为 HUAWEI nova 5i','后置AI四摄 极点全面屏 前置2400万高清摄像头 8GB+128GB 苏音蓝 全网通双卡双待',46,'/goods-img/4b2bffff-ec0b-42e0-8152-ada9a121ad31.jpg','/goods-img/4b2bffff-ec0b-42e0-8152-ada9a121ad31.jpg','商品介绍加载中...',2199,2199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10753,'华为 HUAWEI nova 5i','后置AI四摄 极点全面屏 前置2400万高清摄像头 8GB+128GB 幻夜黑 全网通双卡双待',46,'/goods-img/04dce482-ff0e-483c-b324-dfc030b6cdd1.jpg','/goods-img/04dce482-ff0e-483c-b324-dfc030b6cdd1.jpg','商品介绍加载中...',2199,2199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10754,'华为 HUAWEI nova 5i','后置AI四摄 极点全面屏 前置2400万高清摄像头 8GB+128GB 蜜语红 全网通双卡双待',46,'/goods-img/b5e139d3-ea6b-4874-9ccc-c18aca44a8bc.jpg','/goods-img/b5e139d3-ea6b-4874-9ccc-c18aca44a8bc.jpg','商品介绍加载中...',2199,2199,996,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10755,'荣耀9X PRO 麒麟810液冷散热 4000mAh超强续航','4800万超广角夜拍三摄 6.59英寸全网通8GB+128GB 幻影紫',45,'/goods-img/86bd80cd-140b-474c-8277-3747332f61b3.jpg','/goods-img/86bd80cd-140b-474c-8277-3747332f61b3.jpg','详情加载中...',2199,2199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10756,'荣耀9X PRO 麒麟810液冷散热 4000mAh超强续航','4800万超广角夜拍三摄 6.59英寸全网通8GB+128GB 幻夜黑',45,'/goods-img/3b008be9-e906-4364-8aa0-0df2e670dbd2.jpg','/goods-img/3b008be9-e906-4364-8aa0-0df2e670dbd2.jpg','详情加载中...',2199,2199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10757,'荣耀畅玩8C两天一充 莱茵护眼 刘海屏 全网通版4GB+32GB','极光蓝 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/7f7d2343-6743-490b-baec-3e0a76d061e5.jpg','/goods-img/7f7d2343-6743-490b-baec-3e0a76d061e5.jpg','详情加载中...',899,799,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10758,'荣耀畅玩8C两天一充 莱茵护眼 刘海屏 全网通版4GB+32GB','铂光金 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/b163ca1b-7deb-4b15-818a-dc765c852305.jpg','/goods-img/b163ca1b-7deb-4b15-818a-dc765c852305.jpg','详情加载中...',899,799,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10759,'荣耀畅玩8C两天一充 莱茵护眼 刘海屏 全网通版4GB+32GB','星云紫 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/f949289a-4c51-4159-a754-871da347e1e5.jpg','/goods-img/f949289a-4c51-4159-a754-871da347e1e5.jpg','详情加载中...',899,799,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10760,'荣耀畅玩8C两天一充 莱茵护眼 刘海屏 全网通版4GB+64GB','幻夜黑 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/27c3c018-95c5-429f-9ad7-be0fedd78329.jpg','/goods-img/27c3c018-95c5-429f-9ad7-be0fedd78329.jpg','详情加载中...',1399,1099,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10761,'荣耀畅玩8C两天一充 莱茵护眼 刘海屏 全网通版4GB+64GB','幻影蓝 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/61224f59-e11a-4005-84dc-cadfdd4162f6.jpg','/goods-img/61224f59-e11a-4005-84dc-cadfdd4162f6.jpg','详情加载中...',1399,1099,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10762,'华为 HUAWEI 畅享8e 青春版','2GB+32GB全面屏 金色 全网通版 移动联通电信4G手机 双卡双待',46,'/goods-img/af23223e-56fa-4aa7-b832-c55c713fa604.jpg','/goods-img/af23223e-56fa-4aa7-b832-c55c713fa604.jpg','商品介绍加载中...',699,549,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10763,'华为 HUAWEI 畅享8e青春 2GB+32GB全面屏','黑色 全网通版 移动联通电信4G手机 双卡双待',46,'/goods-img/bf64e22d-1cd3-40b0-9ce1-cc944e35d2d4.jpg','/goods-img/bf64e22d-1cd3-40b0-9ce1-cc944e35d2d4.jpg','商品介绍加载中...',699,549,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10764,'华为 HUAWEI 畅享8e青春 2GB+32GB全面屏','蓝色 全网通版 移动联通电信4G手机 双卡双待',46,'/goods-img/70f9ecf9-4859-45de-8f67-5afbdba6735c.jpg','/goods-img/70f9ecf9-4859-45de-8f67-5afbdba6735c.jpg','商品介绍加载中...',699,549,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10765,'华为 HUAWEI nova 4e','3200万立体美颜AI超广角三摄珍珠屏6GB+128GB雀翎蓝全网通版双4G手机',46,'/goods-img/55b997f9-fa22-40b0-8b33-429760c2af49.jpg','/goods-img/55b997f9-fa22-40b0-8b33-429760c2af49.jpg','商品介绍加载中...',1999,1799,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10766,'华为 HUAWEI nova 4e','3200万立体美颜AI超广角三摄珍珠屏6GB+128GB幻夜黑全网通版双4G手机',46,'/goods-img/8d675ec6-efe0-4ca6-8f83-193820b07256.jpg','/goods-img/8d675ec6-efe0-4ca6-8f83-193820b07256.jpg','商品介绍加载中...',1999,1799,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10767,'华为 HUAWEI nova 4e','3200万立体美颜AI超广角三摄珍珠屏6GB+128GB珍珠白全网通版双4G手机',46,'/goods-img/c8ce9a44-7b40-48b2-91cb-2a1607561b4a.jpg','/goods-img/c8ce9a44-7b40-48b2-91cb-2a1607561b4a.jpg','商品介绍加载中...',1999,1799,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10768,'华为 HUAWEI 畅享9 Plus','4GB+64GB 极光紫 全网通 四摄超清全面屏大电池 移动联通电信4G手机 双卡双待',46,'/goods-img/5ea16713-f6ae-4fa7-a53d-1700c29cb3d3.jpg','/goods-img/5ea16713-f6ae-4fa7-a53d-1700c29cb3d3.jpg','详情加载中...',1299,1199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10769,'华为 HUAWEI 畅享9 Plus','4GB+64GB 幻夜黑 全网通 四摄超清全面屏大电池 移动联通电信4G手机 双卡双待',46,'/goods-img/39e4b0c8-c4c5-4162-8a32-3bb9bb483503.jpg','/goods-img/39e4b0c8-c4c5-4162-8a32-3bb9bb483503.jpg','详情加载中...',1299,1199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10770,'华为 HUAWEI 畅享9 Plus','4GB+64GB 宝石蓝 全网通 四摄超清全面屏大电池 移动联通电信4G手机 双卡双待',46,'/goods-img/ca2bb115-c75e-475b-93ab-c2436f31aa16.jpg','/goods-img/ca2bb115-c75e-475b-93ab-c2436f31aa16.jpg','详情加载中...',1299,1199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10771,'华为 HUAWEI 畅享9 Plus','4GB+64GB 樱语粉 全网通 四摄超清全面屏大电池 移动联通电信4G手机 双卡双待',46,'/goods-img/65e953c4-1d29-423a-b7d7-4276c4d42aaa.jpg','/goods-img/65e953c4-1d29-423a-b7d7-4276c4d42aaa.jpg','详情加载中...',1299,1199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10772,'华为 HUAWEI nova 3i','全面屏高清四摄游戏手机4GB+128GB 亮黑色 移动4G+ 移动联通电信4G手机双卡双待',46,'/goods-img/2252c604-ced3-4e92-b58b-15402ae7be2c.jpg','/goods-img/2252c604-ced3-4e92-b58b-15402ae7be2c.jpg','详情加载中...',1399,1299,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10773,'华为 HUAWEI nova 3i','全面屏高清四摄游戏手机4GB+128GB 蓝楹紫 移动4G+ 移动联通电信4G手机双卡双待',46,'/goods-img/a17dc2b3-17dc-4be7-a04d-12a3fa62de31.jpg','/goods-img/a17dc2b3-17dc-4be7-a04d-12a3fa62de31.jpg','详情加载中...',1399,1299,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10774,'华为 HUAWEI nova 5i','Pro 前置3200万人像超级夜景4800万AI四摄极点全面屏6GB+128GB翡冷翠全网通双4G手机',46,'/goods-img/e3f32e21-1208-481d-bfcd-8447de78043b.jpg','/goods-img/e3f32e21-1208-481d-bfcd-8447de78043b.jpg','商品介绍加载中...',2199,2149,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10775,'华为 HUAWEI nova 5i','Pro 前置3200万人像超级夜景4800万AI四摄极点全面屏6GB+128GB幻夜黑全网通双4G手机',46,'/goods-img/1eb1e40c-7f38-47ed-a839-d43c1d0b79a8.jpg','/goods-img/1eb1e40c-7f38-47ed-a839-d43c1d0b79a8.jpg','详情加载中...',2199,2149,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10776,'华为 HUAWEI nova 5i','Pro 前置3200万人像超级夜景4800万AI四摄极点全面屏6GB+128GB极光色全网通双4G手机',46,'/goods-img/80f05e0d-0d06-4aa8-bca5-0d39a2365b4b.jpg','/goods-img/80f05e0d-0d06-4aa8-bca5-0d39a2365b4b.jpg','详情加载中...',2199,2149,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10777,'华为 HUAWEI Mate 20','麒麟980AI智能芯片全面屏超微距影像超大广角徕卡三摄6GB+128GB亮黑色全网通版双4G手机',46,'/goods-img/9024ab8a-be67-4459-8414-8d84225851a7.jpg','/goods-img/9024ab8a-be67-4459-8414-8d84225851a7.jpg','商品介绍加载中...',3799,3699,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10778,'华为 HUAWEI Mate 20','麒麟980AI智能芯片全面屏超微距影像超大广角徕卡三摄6GB+128GB极光色全网通版双4G手机',46,'/goods-img/940a6c56-9f7b-4008-8679-c7ef5a44d695.jpg','/goods-img/940a6c56-9f7b-4008-8679-c7ef5a44d695.jpg','商品介绍加载中...',3799,3699,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10779,'华为 HUAWEI Mate 20','麒麟980AI智能芯片全面屏超微距影像超大广角徕卡三摄6GB+64GB翡冷翠全网通版双4G手机',46,'/goods-img/08f9a912-f049-4cf8-a839-115fc6582398.jpg','/goods-img/08f9a912-f049-4cf8-a839-115fc6582398.jpg','商品介绍加载中...',3299,3199,991,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10780,'华为 HUAWEI Mate 20','麒麟980AI智能芯片全面屏超微距影像超大广角徕卡三摄6GB+128GB宝石蓝全网通版双4G手机',46,'/goods-img/5d57e0ba-1bc7-45a7-9677-f501e0384442.jpg','/goods-img/5d57e0ba-1bc7-45a7-9677-f501e0384442.jpg','商品介绍加载中...',3799,3699,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10781,'华为 HUAWEI 麦芒 8','超广角AI三摄 高清珍珠屏 大存储 6GB+128GB 极光蓝 全网通双4G手机',46,'/goods-img/bde7fc16-fb6b-42b0-8950-13ff287c3cd3.jpg','/goods-img/bde7fc16-fb6b-42b0-8950-13ff287c3cd3.jpg','详情加载中...',1899,1699,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10782,'华为 HUAWEI 麦芒 8','超广角AI三摄 高清珍珠屏 大存储 6GB+128GB 幻夜黑 全网通双4G手机',46,'/goods-img/e299773e-14e4-4168-adab-514f6c6d35ed.jpg','/goods-img/e299773e-14e4-4168-adab-514f6c6d35ed.jpg','商品介绍加载中...',1899,1699,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10783,'华为 HUAWEI 麦芒 8','超广角AI三摄 高清珍珠屏 大存储 6GB+128GB 宝石蓝 全网通双4G手机',46,'/goods-img/2a3fb7d2-cb76-47b2-88c6-db0f869b5718.jpg','/goods-img/2a3fb7d2-cb76-47b2-88c6-db0f869b5718.jpg','商品介绍加载中...',1899,1699,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10784,'荣耀8X Max 骁龙660 7.12英寸90%屏占比珍珠屏','6GB+64GB 魅海蓝 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/c0763005-4e67-4861-98f2-e6a550ec4d87.jpg','/goods-img/c0763005-4e67-4861-98f2-e6a550ec4d87.jpg','详情加载中...',1799,1199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10785,'荣耀8X Max 骁龙660 7.12英寸90%屏占比珍珠屏','6GB+64GB 幻夜黑 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/aea7760b-d950-4f64-8db9-ef055f15d234.jpg','/goods-img/aea7760b-d950-4f64-8db9-ef055f15d234.jpg','详情加载中...',1799,1199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10786,'荣耀8X Max 骁龙660 7.12英寸90%屏占比珍珠屏','6GB+64GB 魅焰红 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/f5e2d2e7-541a-44fa-ad5c-4f15f48ebfc9.jpg','/goods-img/f5e2d2e7-541a-44fa-ad5c-4f15f48ebfc9.jpg','详情加载中...',1799,1199,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10787,'华为 HUAWEI Mate 10','4GB+64GB 亮黑色 移动4G+手机 双卡双待',46,'/goods-img/b67a4ac6-7766-4995-8110-1bd442ec0797.jpg','/goods-img/b67a4ac6-7766-4995-8110-1bd442ec0797.jpg','商品介绍加载中...',1799,1799,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10788,'华为 HUAWEI 畅享9 3GB+32GB','极光蓝 高清珍珠屏 AI长续航 全网通标配版 移动联通电信4G手机',46,'/goods-img/bd8b2d93-c251-46b8-9990-77baaf3075f3.jpg','/goods-img/bd8b2d93-c251-46b8-9990-77baaf3075f3.jpg','商品介绍加载中...',999,799,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10789,'华为 HUAWEI 畅享9 3GB+32GB','幻夜黑 高清珍珠屏 AI长续航 全网通标配版 移动联通电信4G手机',46,'/goods-img/71ae1ce8-38e8-4da3-8fa1-5e8157a12685.jpg','/goods-img/71ae1ce8-38e8-4da3-8fa1-5e8157a12685.jpg','商品介绍加载中...',999,799,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10790,'华为 HUAWEI 畅享9 4GB+64GB','极光紫 高清珍珠屏 AI长续航 全网通高配版 移动联通电信4G手机',46,'/goods-img/371386b8-ddf4-4fc1-985e-ef0e1a076710.jpg','/goods-img/371386b8-ddf4-4fc1-985e-ef0e1a076710.jpg','商品介绍加载中...',1099,1099,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10791,'华为 HUAWEI 畅享9 4GB+64GB','珊瑚红 高清珍珠屏 AI长续航 全网通高配版 移动联通电信4G手机',46,'/goods-img/60392ae1-d076-47b5-a00d-b2278e01ccb5.jpg','/goods-img/60392ae1-d076-47b5-a00d-b2278e01ccb5.jpg','商品介绍加载中...',1099,1099,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10792,'荣耀畅玩8A 6.09英寸珍珠全面屏 震撼大音量 3GB+32GB','幻夜黑 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/0a592388-1535-4f9f-8201-ecb78c48bb3d.jpg','/goods-img/0a592388-1535-4f9f-8201-ecb78c48bb3d.jpg','详情加载中...',799,649,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10793,'荣耀畅玩8A 6.09英寸珍珠全面屏 震撼大音量 3GB+32GB','极光蓝 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/fd218943-8f6f-4fb8-91a4-d6216cc5afdc.jpg','/goods-img/fd218943-8f6f-4fb8-91a4-d6216cc5afdc.jpg','详情加载中...',799,649,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10794,'荣耀畅玩8A 6.09英寸珍珠全面屏 震撼大音量 3GB+32GB','魅焰红 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/54641753-d8e7-45da-8c6c-81192552cf15.jpg','/goods-img/54641753-d8e7-45da-8c6c-81192552cf15.jpg','详情加载中...',799,649,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10795,'荣耀畅玩8A 6.09英寸珍珠全面屏 震撼大音量 3GB+32GB','铂光金 移动联通电信4G全面屏手机 双卡双待',45,'/goods-img/7b65ad3d-74a4-4322-8653-6bda47a8b4eb.jpg','/goods-img/7b65ad3d-74a4-4322-8653-6bda47a8b4eb.jpg','详情加载中...',799,649,1000,'',0,0,'2019-09-18 13:37:44',0,'2019-09-18 13:37:44'),
	(10796,'Redmi K20Pro 骁龙855 索尼4800万超广角三摄','AMOLED弹出式全面屏 8GB+256GB 碳纤黑 游戏智能手机 小米 红米',0,'/goods-img/2a05cc6a-3eea-42f9-ab97-2e2529a72099.jpg','/goods-img/2a05cc6a-3eea-42f9-ab97-2e2529a72099.jpg','商品介绍加载中...',2999,2699,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10797,'小米9 Pro 5G 全面屏游戏拍照新品手机','新蜂精选',51,'/goods-img/d5fc8bec-0add-48d3-b73b-349a0375e8dc.jpg','/goods-img/d5fc8bec-0add-48d3-b73b-349a0375e8dc.jpg','详情加载中...',9999,9999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10798,'【新品抢购】Redmi Note8 4800万全场景四摄 4000mAh长续航','高通骁龙665 18W快充 小金刚品质保证 4GB+64GB 梦幻蓝 游戏智能手机 小米 红米',0,'/goods-img/e4e4c543-6d9a-4b19-bedf-3f40024cb710.jpg','/goods-img/e4e4c543-6d9a-4b19-bedf-3f40024cb710.jpg','商品介绍加载中...',999,999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10799,'【新品抢购】Redmi Note8 4800万全场景四摄 4000mAh长续航','高通骁龙665 18W快充 小金刚品质保证 4GB+64GB 皓月白 游戏智能手机 小米 红米',0,'/goods-img/87e0f6ab-45ef-4710-a5f4-e57a470b6b26.jpg','/goods-img/87e0f6ab-45ef-4710-a5f4-e57a470b6b26.jpg','详情加载中...',999,999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10800,'【新品抢购】Redmi Note8 4800万全场景四摄 4000mAh长续航','高通骁龙665 18W快充 小金刚品质保证 4GB+64GB 曜石黑 游戏智能手机 小米 红米',0,'/goods-img/4a5c5b20-2dd3-4343-a6d1-31195c9edea4.jpg','/goods-img/4a5c5b20-2dd3-4343-a6d1-31195c9edea4.jpg','详情加载中...',999,999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10801,'Redmi Note7 4800万双摄千元机 满血骁龙660','18个月超长质保 4000mAh超长续航 6GB+64GB 镜花水月 游戏智能手机 小米 红米',0,'/goods-img/30ef1f51-f958-486f-8d79-f48f6d8293dd.jpg','/goods-img/30ef1f51-f958-486f-8d79-f48f6d8293dd.jpg','详情加载中...',1199,1099,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10802,'Redmi Note7 4800万双摄千元机 满血骁龙660','18个月超长质保 4000mAh超长续航 6GB+64GB 亮黑色 游戏智能手机 小米 红米',0,'/goods-img/92beacb0-f692-42ff-a20f-8fecd2b0c046.jpg','/goods-img/92beacb0-f692-42ff-a20f-8fecd2b0c046.jpg','*相机默认1200w，如何设置4800w？ 打开相机 — 右滑切换到“专业”模式 — 点击屏幕左上方的“48MP”，打开4800万超清。 *如何设置全面屏模式？ 点击设置 — 点击全面屏 — 进入全面屏设置会出现两个选项，可以选择经典导航也可以选择全面屏手势。选择全面屏手势，可进行手势学习，使用全面屏模式进行操作 *是否支持OTG功能？ 支持。 *红米Note7出厂预装版本是Andriod 9.0吗？ 该商品首批出厂操作系统：MIUI 10 (Andriod 9.0)。 *有呼吸灯吗？是否支持NFC？ 是否支持收音机？ 有呼吸灯，不支持NFC，支持收音机。 *4800万模式是否支持AI场景识别，能否有快速切换方式介绍？ 4800万模式下不支持AI场景识别，普通相机模式下可支持AI识别。 *是否支持王者荣耀Vulkan 模式？ 目前暂不支持王者荣耀Vulkan模式。      Redmi 红米Note 7 常见问题',1199,1099,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10803,'Redmi Note7 4800万双摄千元机 满血骁龙660','18个月超长质保 4000mAh超长续航 6GB+64GB 暮光金 游戏智能手机 小米 红米',0,'/goods-img/0cf95c37-2665-4894-bd42-5f8de06c6d94.jpg','/goods-img/0cf95c37-2665-4894-bd42-5f8de06c6d94.jpg','*相机默认1200w，如何设置4800w？ 打开相机 — 右滑切换到“专业”模式 — 点击屏幕左上方的“48MP”，打开4800万超清。 *如何设置全面屏模式？ 点击设置 — 点击全面屏 — 进入全面屏设置会出现两个选项，可以选择经典导航也可以选择全面屏手势。选择全面屏手势，可进行手势学习，使用全面屏模式进行操作 *是否支持OTG功能？ 支持。 *红米Note7出厂预装版本是Andriod 9.0吗？ 该商品首批出厂操作系统：MIUI 10 (Andriod 9.0)。 *有呼吸灯吗？是否支持NFC？ 是否支持收音机？ 有呼吸灯，不支持NFC，支持收音机。 *4800万模式是否支持AI场景识别，能否有快速切换方式介绍？ 4800万模式下不支持AI场景识别，普通相机模式下可支持AI识别。 *是否支持王者荣耀Vulkan 模式？ 目前暂不支持王者荣耀Vulkan模式。      Redmi 红米Note 7 常见问题',1199,1099,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10804,'Redmi Note7 4800万双摄千元机 满血骁龙660','4000mAh超长续航 6GB+64GB 梦幻蓝 游戏智能手机 小米 红米',0,'/goods-img/f6c46245-b957-41ed-b235-133c17cba7f9.jpg','/goods-img/f6c46245-b957-41ed-b235-133c17cba7f9.jpg','*相机默认1200w，如何设置4800w？ 打开相机 — 右滑切换到“专业”模式 — 点击屏幕左上方的“48MP”，打开4800万超清。 *如何设置全面屏模式？ 点击设置 — 点击全面屏 — 进入全面屏设置会出现两个选项，可以选择经典导航也可以选择全面屏手势。选择全面屏手势，可进行手势学习，使用全面屏模式进行操作 *是否支持OTG功能？ 支持。 *红米Note7出厂预装版本是Andriod 9.0吗？ 该商品首批出厂操作系统：MIUI 10 (Andriod 9.0)。 *有呼吸灯吗？是否支持NFC？ 是否支持收音机？ 有呼吸灯，不支持NFC，支持收音机。 *4800万模式是否支持AI场景识别，能否有快速切换方式介绍？ 4800万模式下不支持AI场景识别，普通相机模式下可支持AI识别。 *是否支持王者荣耀Vulkan 模式？ 目前暂不支持王者荣耀Vulkan模式。      Redmi 红米Note 7 常见问题',1199,1099,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10805,'【新品抢购】Redmi Note8Pro 6400万全场景四摄 液冷游戏芯','4500mAh长续航 NFC 18W快充 红外遥控 6GB+64GB 贝母白 游戏智能手机 小米 红米',0,'/goods-img/54985ce7-1df6-442f-9a28-0ff0bab924bd.jpg','/goods-img/54985ce7-1df6-442f-9a28-0ff0bab924bd.jpg','详情加载中...',1399,1399,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10806,'【新品抢购】Redmi Note8Pro 6400万全场景四摄 液冷游戏芯','4500mAh长续航 NFC 18W快充 红外遥控 6GB+128GB 冰翡翠 游戏智能手机 小米 红米',0,'/goods-img/e3de1717-e373-4544-9f1e-057a91fd2595.jpg','/goods-img/e3de1717-e373-4544-9f1e-057a91fd2595.jpg','详情加载中...',1599,1599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10807,'【新品抢购】Redmi Note8Pro 6400万全场景四摄 液冷游戏芯','4500mAh长续航 NFC 18W快充 红外遥控 6GB+64GB 电光灰 游戏智能手机 小米 红米',0,'/goods-img/a1552f03-58ab-4b05-91ec-7df52af18a66.jpg','/goods-img/a1552f03-58ab-4b05-91ec-7df52af18a66.jpg','详情加载中...',1399,1399,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10808,'Redmi Note7Pro 索尼4800万超清双摄 骁龙675','18个月超长质保 4000mAh超长续航 6GB+128GB 亮黑色 游戏智能手机 小米 红米',0,'/goods-img/647470fa-85b1-4626-99d0-d5b7512c8f23.jpg','/goods-img/647470fa-85b1-4626-99d0-d5b7512c8f23.jpg','详情加载中...',1399,1399,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10809,'Redmi Note7pro 索尼4800万超清双摄 骁龙675','18个月超长质保 4000mAh超长续航 6GB+128GB 镜花水月 游戏智能手机 小米 红米',0,'/goods-img/edb8a694-84a5-47da-9bae-30f7a69d2c63.jpg','/goods-img/edb8a694-84a5-47da-9bae-30f7a69d2c63.jpg','详情加载中...',1399,1399,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10810,'Redmi Note7Pro 索尼4800万超清双摄 骁龙675','18个月超长质保 4000mAh超长续航 6GB+128GB 梦幻蓝 游戏智能手机 小米 红米',0,'/goods-img/c76edfa6-c16e-45b9-9119-46d300739112.jpg','/goods-img/c76edfa6-c16e-45b9-9119-46d300739112.jpg','商品介绍加载中...',1399,1399,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10811,'Redmi Note7Pro 索尼4800万超清双摄 骁龙675','18个月超长质保 4000mAh超长续航 6GB+128GB 暮光金 游戏智能手机 小米 红米',0,'/goods-img/bf0c2d17-3630-4709-af38-d7bd14a76f22.jpg','/goods-img/bf0c2d17-3630-4709-af38-d7bd14a76f22.jpg','详情加载中...',1399,1399,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10812,'Redmi 7A 4000mAh超长续航 AI人脸解锁','骁龙8核 标配10W充电器 整机防泼溅 3GB+32GB 磨砂黑 游戏智能手机 小米 红米',0,'/goods-img/28c56015-cb20-44cb-86fb-246ad509e828.jpg','/goods-img/28c56015-cb20-44cb-86fb-246ad509e828.jpg','详情加载中...',699,599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10813,'Redmi 7A 4000mAh超长续航 AI人脸解锁','骁龙8核 标配10W充电器 整机防泼溅 3GB+32GB 晨曦蓝 游戏智能手机 小米 红米',0,'/goods-img/d845c984-f749-4f22-86a5-558677b1322c.jpg','/goods-img/d845c984-f749-4f22-86a5-558677b1322c.jpg','详情加载中...',699,599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10814,'Redmi 7A 4000mAh超长续航 AI人脸解锁','骁龙8核 标配10W充电器 整机防泼溅 3GB+32GB 雾光金 游戏智能手机 小米 红米',0,'/goods-img/56ac4c58-8742-40c8-b130-83b4d2925a8c.jpg','/goods-img/56ac4c58-8742-40c8-b130-83b4d2925a8c.jpg','详情加载中...',599,599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10815,'Redmi 7 4000mAh超长续航 骁龙632','1200万AI双摄 18个月超长质保 AI人脸解锁 3GB+32GB 亮黑色 游戏智能手机 小米 红米',0,'/goods-img/0647d1b4-d19a-4424-b6ac-68344addacb4.jpg','/goods-img/0647d1b4-d19a-4424-b6ac-68344addacb4.jpg','详情加载中...',699,699,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10816,'Redmi 7 4000mAh超长续航 骁龙632','1200万AI双摄 18个月超长质保 AI人脸解锁 3GB+32GB 魅夜红 游戏智能手机 小米 红米',0,'/goods-img/711c54f0-f9d0-472e-b61b-94e25c628599.jpg','/goods-img/711c54f0-f9d0-472e-b61b-94e25c628599.jpg','详情加载中...',699,699,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10817,'Redmi 7 4000mAh超长续航 骁龙632','1200万AI双摄 18个月超长质保 AI人脸解锁 3GB+32GB 梦幻蓝 游戏智能手机 小米 红米',0,'/goods-img/c8c97b68-3ba6-4f97-8940-d04c9e7c7302.jpg','/goods-img/c8c97b68-3ba6-4f97-8940-d04c9e7c7302.jpg','商品介绍加载中...',699,699,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10818,'小米MIX2S 骁龙845 AI感光双摄 四曲面陶瓷全面屏','白色 多功能 NFC 6GB+128GB 游戏智能拍照手机',51,'/goods-img/d423bb5c-60c8-4b66-bd72-3490b5d6461b.jpg','/goods-img/d423bb5c-60c8-4b66-bd72-3490b5d6461b.jpg','商品介绍加载中...',2099,1799,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10819,'小米MIX2S 骁龙845 AI感光双摄 四曲面陶瓷全面屏','黑色 多功能 NFC 6GB+128GB 游戏智能拍照手机',51,'/goods-img/9a554cae-5bec-4964-992f-e2f4de192e2c.jpg','/goods-img/9a554cae-5bec-4964-992f-e2f4de192e2c.jpg','商品介绍加载中...',2099,1799,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10820,'小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855','全网通4G 双卡双待 水滴全面屏拍照智能游戏手机',51,'/goods-img/55a6dc67-1ed9-421a-9782-acdfa9c123e1.jpg','/goods-img/55a6dc67-1ed9-421a-9782-acdfa9c123e1.jpg','商品介绍加载中...',2799,2599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10821,'小米9 4800万超广角三摄 8GB+256GB 透明版','骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机',51,'/goods-img/54249648-d37b-4b22-80dc-243e58ed56a1.jpg','/goods-img/54249648-d37b-4b22-80dc-243e58ed56a1.jpg','详情加载中...',3699,3699,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10822,'小米9 4800万超广角三摄 8GB+128GB 深空灰','骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机',51,'/goods-img/e8087861-89fd-43af-b64d-290864b0fe35.jpg','/goods-img/e8087861-89fd-43af-b64d-290864b0fe35.jpg','详情加载中...',2999,2799,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10823,'小米9 4800万超广角三摄 8GB+128GB 全息幻彩紫','骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机',51,'/goods-img/7a406989-061b-4f69-baa1-6fa499aa091d.jpg','/goods-img/7a406989-061b-4f69-baa1-6fa499aa091d.jpg','详情加载中...',2999,2799,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10824,'小米CC9e 索尼4800万旗舰相机 3200万美颜自拍 4030mAh','屏幕指纹 白色恋人 6GB+64GB 游戏智能拍照手机',51,'/goods-img/8fc9776e-9393-421d-998c-e516b3877dba.jpg','/goods-img/8fc9776e-9393-421d-998c-e516b3877dba.jpg','详情加载中...',1399,1299,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10825,'小米CC9e 索尼4800万旗舰相机 3200万美颜自拍 4030mAh','屏幕指纹 暗夜王子 6GB+64GB 游戏智能拍照手机',51,'/goods-img/033685d7-bf11-4389-9e52-ef5a51182306.jpg','/goods-img/033685d7-bf11-4389-9e52-ef5a51182306.jpg','详情加载中...',1399,1299,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10826,'小米CC9e 索尼4800万旗舰相机 3200万美颜自拍 4030mAh','屏幕指纹 深蓝星球 6GB+64GB 游戏智能拍照手机',51,'/goods-img/e8dba692-7fda-4f42-b0ee-6f51ca7dc77d.jpg','/goods-img/e8dba692-7fda-4f42-b0ee-6f51ca7dc77d.jpg','商品介绍加载中...',1399,1299,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10827,'小米CC9 3200万美颜自拍 索尼4800万超清三摄 多功能NFC','4030mAh 深蓝星球 6GB+64GB 游戏智能拍照手机',51,'/goods-img/387afca1-a14a-4ab8-9d99-120b7095029c.jpg','/goods-img/387afca1-a14a-4ab8-9d99-120b7095029c.jpg','详情加载中...',1799,1799,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10828,'小米CC9 3200万美颜自拍 索尼4800万超清三摄 多功能NFC','4030mAh 白色恋人 6GB+64GB 游戏智能拍照手机',51,'/goods-img/f96f376e-8341-4bad-ad2a-b3f12486958a.jpg','/goods-img/f96f376e-8341-4bad-ad2a-b3f12486958a.jpg','详情加载中...',1799,1799,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10829,'小米CC9 3200万美颜自拍 索尼4800万超清三摄 多功能NFC','4030mAh 暗夜王子 6GB+128GB 游戏智能拍照手机',51,'/goods-img/4c148e8e-7e26-4c74-a3d3-f5f37ae9248d.jpg','/goods-img/4c148e8e-7e26-4c74-a3d3-f5f37ae9248d.jpg','详情加载中...',1999,1999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10830,'小米CC9美图定制版 索尼4800万AI三摄 3200万美颜自拍 全身美型','多功能NFC 8GB+256GB 游戏智能拍照手机',51,'/goods-img/92482741-3637-4cd3-91ff-cc5aeb0d3316.jpg','/goods-img/92482741-3637-4cd3-91ff-cc5aeb0d3316.jpg','商品介绍加载中...',2599,2599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10831,'小米Play 流光渐变AI双摄 6GB+128GB 梦幻蓝','移动4G+ 双卡双待 小水滴全面屏拍照游戏智能手机',51,'/goods-img/f0b19f6c-6a8b-4128-8e5d-2e4953331c46.jpg','/goods-img/f0b19f6c-6a8b-4128-8e5d-2e4953331c46.jpg','详情加载中...',999,999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10832,'小米Play 流光渐变AI双摄 6GB+128GB 黑色','移动4G+ 双卡双待 小水滴全面屏拍照游戏智能手机',51,'/goods-img/e39da33d-1b55-4e97-b8e6-824ac2cd1062.jpg','/goods-img/e39da33d-1b55-4e97-b8e6-824ac2cd1062.jpg','详情加载中...',999,999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10833,'小米Play 流光渐变AI双摄 6GB+64GB 暮光金','全网通4G 双卡双待 小水滴全面屏拍照游戏智能手机',51,'/goods-img/2a93185a-8d3b-4908-af8c-c17db78e2fb0.jpg','/goods-img/2a93185a-8d3b-4908-af8c-c17db78e2fb0.jpg','详情加载中...',899,899,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10834,'小米9SE 骁龙712 索尼4800万超广角三摄 5.97英寸舒适握感','全息幻彩蓝 8GB+128GB 游戏智能拍照手机',51,'/goods-img/b28f3eac-0091-442f-90f3-68914bf947c7.jpg','/goods-img/b28f3eac-0091-442f-90f3-68914bf947c7.jpg','详情加载中...',2099,1899,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10835,'小米9 SE 4800万超广角三摄 骁龙712','水滴全面屏 游戏智能拍照手机 6GB+64GB 深空灰 全网通4G 双卡双待',51,'/goods-img/ef8370c4-ed8e-497f-9e10-185de4d01fe9.jpg','/goods-img/ef8370c4-ed8e-497f-9e10-185de4d01fe9.jpg','详情加载中...',1799,1599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10836,'小米9SE 骁龙712 索尼4800万超广角三摄 5.97英寸舒适握感','全息幻彩紫 8GB+128GB 游戏智能拍照手机',51,'/goods-img/f436d00b-2253-4dcc-8b4a-d82e99af275a.jpg','/goods-img/f436d00b-2253-4dcc-8b4a-d82e99af275a.jpg','详情加载中...',2099,1999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10837,'小米MIX3 骁龙845AIE AI 双摄','磁动力滑盖全面屏 三星 AMOLED屏幕 黑色 8GB+128GB 游戏智能拍照手机',51,'/goods-img/3bfc7c72-b56a-4088-8acf-e01e830ce72a.jpg','/goods-img/3bfc7c72-b56a-4088-8acf-e01e830ce72a.jpg','商品介绍加载中...',2599,2599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10838,'Redmi K20 索尼4800万超广角三摄 AMOLED弹出式全面屏','第七代屏下指纹 6GB+128GB 冰川蓝 游戏智能手机 小米 红米',0,'/goods-img/ed860c53-955b-4cfd-b605-a8b4bb959e2f.jpg','/goods-img/ed860c53-955b-4cfd-b605-a8b4bb959e2f.jpg','详情加载中...',1999,1799,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10839,'Redmi K20 索尼4800万超广角三摄 AMOLED弹出式全面屏','第七代屏下指纹 6GB+128GB 火焰红 游戏智能手机 小米 红米',0,'/goods-img/8e64ea39-5477-482c-a200-2c12fdeff004.jpg','/goods-img/8e64ea39-5477-482c-a200-2c12fdeff004.jpg','详情加载中...',1999,1799,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10840,'Redmi K20 索尼4800万超广角三摄 AMOLED弹出式全面屏','第七代屏下指纹 6GB+128GB 碳纤黑 游戏智能手机 小米 红米',0,'/goods-img/38a69084-0bc4-479e-a5ba-aed135dee974.jpg','/goods-img/38a69084-0bc4-479e-a5ba-aed135dee974.jpg','商品介绍加载中...',1999,1799,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10841,'红米6A 1300万高清相机 AI人脸解锁 12nm高性能处理器','3GB+32GB 流沙金 游戏智能手机 小米',0,'/goods-img/6c77e8f9-11d8-42c3-925e-4396d0d3709f.jpg','/goods-img/6c77e8f9-11d8-42c3-925e-4396d0d3709f.jpg','详情加载中...',649,599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10842,'红米6A 1300万高清相机 AI人脸解锁 12nm高性能处理器','3GB+32GB 铂银灰 游戏智能手机 小米',0,'/goods-img/17b2eb9f-7289-45f8-b26a-114ec29ceb3c.jpg','/goods-img/17b2eb9f-7289-45f8-b26a-114ec29ceb3c.jpg','详情加载中...',649,599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10843,'小米 红米6A 全网通版 2GB内存','樱花粉 16GB 移动联通电信4G手机 双卡双待',51,'/goods-img/1ba819c2-dc89-41d9-86a9-4649418972da.jpg','/goods-img/1ba819c2-dc89-41d9-86a9-4649418972da.jpg','商品介绍加载中...',549,549,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10844,'红米6A 1300万高清相机 AI人脸解锁 12nm高性能处理器','3GB+32GB 巴厘蓝 游戏智能手机 小米',0,'/goods-img/1ef84d7e-d804-4064-9140-a53607aa8df2.jpg','/goods-img/1ef84d7e-d804-4064-9140-a53607aa8df2.jpg','详情加载中...',649,599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10845,'小米Max3 5500mAh充电宝级电量 AI双摄 全金属机身','骁龙八核处理器 蓝色 6GB+128GB 游戏智能拍照手机',51,'/goods-img/b6c3eea7-9d34-4ac0-ba66-2fde6f26253b.jpg','/goods-img/b6c3eea7-9d34-4ac0-ba66-2fde6f26253b.jpg','详情加载中...',1599,1499,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10846,'小米Max3 5500mAh充电宝级电量 AI双摄 全金属机身','骁龙八核处理器 黑色 6GB+128GB 游戏智能拍照手机',51,'/goods-img/30574476-f5bc-4f3c-80f6-4da22ea48f48.jpg','/goods-img/30574476-f5bc-4f3c-80f6-4da22ea48f48.jpg','详情加载中...',1599,1499,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10847,'小米Max3 5500mAh充电宝级电量 AI双摄 全金属机身','骁龙八核处理器 金色 6GB+128GB 游戏智能拍照手机',51,'/goods-img/114e92f8-bf78-481e-8d8a-9936d026d9d4.jpg','/goods-img/114e92f8-bf78-481e-8d8a-9936d026d9d4.jpg','详情加载中...',1599,1499,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10848,'Redmi Note8 4800万全场景四摄 4000mAh长续航','高通骁龙665 18W快充 小金刚品质保证 4GB+64GB 梦幻蓝 游戏智能手机 小米 红米',0,'/goods-img/8d3ebf2d-8da7-478c-bd6c-e7a869fdde97.jpg','/goods-img/8d3ebf2d-8da7-478c-bd6c-e7a869fdde97.jpg','商品介绍加载中...',999,999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10849,'Redmi Note8 4800万全场景四摄 4000mAh长续航','高通骁龙665 18W快充 小金刚品质保证 4GB+64GB 皓月白 游戏智能手机 小米 红米',0,'/goods-img/b4ff98bc-ad00-48f7-ac64-0d52780d4c48.jpg','/goods-img/b4ff98bc-ad00-48f7-ac64-0d52780d4c48.jpg','商品介绍加载中...',999,999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10850,'Redmi Note8 4800万全场景四摄 4000mAh长续航','高通骁龙665 18W快充 小金刚品质保证 4GB+64GB 曜石黑 游戏智能手机 小米 红米',0,'/goods-img/b82cc8fd-075b-44d3-b211-8ea633fe2ffe.jpg','/goods-img/b82cc8fd-075b-44d3-b211-8ea633fe2ffe.jpg','商品介绍加载中...',999,999,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10851,'小米（MI） 小米8青春版 手机 深空灰','全网通 6G+128G',51,'/goods-img/52425573-6311-4877-bad8-1c04bf01e9d3.jpg','/goods-img/52425573-6311-4877-bad8-1c04bf01e9d3.jpg','商品介绍加载中...',1599,1168,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10852,'小米（MI） 小米8青春版 手机 梦幻蓝','全网通 4G+128G',51,'/goods-img/8c1c9fb2-26aa-4fa0-b9ce-cf278d827fa6.jpg','/goods-img/8c1c9fb2-26aa-4fa0-b9ce-cf278d827fa6.jpg','商品介绍加载中...',1599,1599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10853,'小米（MI） 小米8青春版 手机 暮光金','全网通 6G+64G',51,'/goods-img/bd94d7e0-f56f-4b7f-8653-b8a4e267bd15.jpg','/goods-img/bd94d7e0-f56f-4b7f-8653-b8a4e267bd15.jpg','商品介绍加载中...',1299,1068,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10854,'小米 红米Note8 pro 手机【6400万四摄','液冷游戏芯】 冰翡翠 全网通6+128',51,'/goods-img/42913aa4-4a49-4121-9c80-3434c12d0ac9.jpg','/goods-img/42913aa4-4a49-4121-9c80-3434c12d0ac9.jpg','商品介绍加载中...',1799,1599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10855,'小米 红米Note8 pro 手机【6400万四摄','液冷游戏芯】 贝母白 全网通6+128',51,'/goods-img/777ebd38-965d-4c77-970e-f1e25022255f.jpg','/goods-img/777ebd38-965d-4c77-970e-f1e25022255f.jpg','商品介绍加载中...',1799,1599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10856,'小米 红米Note8 pro 手机【6400万四摄','液冷游戏芯】 电光灰 全网通6+128',51,'/goods-img/db21f41b-34ac-4bc7-a50f-1f812b1522d1.jpg','/goods-img/db21f41b-34ac-4bc7-a50f-1f812b1522d1.jpg','商品介绍加载中...',1799,1599,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10857,'小米（MI） 小米8 游戏手机 黑','6GB+64GB',51,'/goods-img/63588dfb-f85f-41a2-8198-c7ae66aa0261.png','/goods-img/63588dfb-f85f-41a2-8198-c7ae66aa0261.png','商品介绍加载中...',1698,1568,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10858,'小米（MI） 小米8 游戏手机 白','6GB+64GB',51,'/goods-img/d55d6e4a-99e7-4a3d-86a4-9b3899a63b42.png','/goods-img/d55d6e4a-99e7-4a3d-86a4-9b3899a63b42.png','商品介绍加载中...',1698,1568,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10859,'小米（MI） 小米8 游戏手机 蓝','8GB+128GB',51,'/goods-img/5a2a90aa-fe2c-4bb0-8d8d-1ac1613f453a.png','/goods-img/5a2a90aa-fe2c-4bb0-8d8d-1ac1613f453a.png','商品介绍加载中...',1998,1868,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10860,'小米（MI） 小米8 游戏手机 金','6GB+128GB',51,'/goods-img/c1cdb555-f605-4226-906a-022483612319.png','/goods-img/c1cdb555-f605-4226-906a-022483612319.png','商品介绍加载中...',1898,1838,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10861,'小米（MI） 小米8青春版 手机 深空灰','全网通(6G+128G)',51,'/goods-img/fafda3af-7741-47f2-936e-c0d9030fbf5b.png','/goods-img/fafda3af-7741-47f2-936e-c0d9030fbf5b.png','商品介绍加载中...',1188,1188,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10862,'小米（MI） 小米8青春版 手机 梦幻蓝','全网通(6G+64G)',51,'/goods-img/ef5ac8cb-5d4e-4dc6-bece-27c9ff5a2e1c.png','/goods-img/ef5ac8cb-5d4e-4dc6-bece-27c9ff5a2e1c.png','商品介绍加载中...',1388,1388,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10863,'小米（MI） 小米8青春版 手机 暮光金','全网通(6G+128G)',51,'/goods-img/d8b30b9f-faa4-4a0d-84bc-53b9c4745977.png','/goods-img/d8b30b9f-faa4-4a0d-84bc-53b9c4745977.png','商品介绍加载中...',1578,1578,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10864,'小米 红米Redmi 7 全网通4G','双卡双待 幻彩渐变AI双摄 水滴全面屏拍照游戏智能手机 梦幻蓝 4GB+64GB',51,'/goods-img/18ce5224-c98d-4a9c-a024-5ac5b6f9a2d7.jpg','/goods-img/18ce5224-c98d-4a9c-a024-5ac5b6f9a2d7.jpg','商品介绍加载中...',1200,808,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10865,'小米 红米Redmi 7 全网通4G','双卡双待 幻彩渐变AI双摄 水滴全面屏拍照游戏智能手机 亮黑色 4GB+64GB',51,'/goods-img/f7a9a98d-9e3f-4443-b8a7-5612bcd7c1d0.jpg','/goods-img/f7a9a98d-9e3f-4443-b8a7-5612bcd7c1d0.jpg','商品介绍加载中...',1200,818,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10866,'小米 红米Redmi 7 全网通4G','双卡双待 幻彩渐变AI双摄 水滴全面屏拍照游戏智能手机 魅夜红 4GB+64GB',51,'/goods-img/02523f49-742b-4c45-b59b-f550fe5a60ae.jpg','/goods-img/02523f49-742b-4c45-b59b-f550fe5a60ae.jpg','商品介绍加载中...',1200,818,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10867,'小米 小米8屏幕指纹版 手机 黑色','全网通(6G + 128G )',51,'/goods-img/35b9c185-2ca6-4052-af40-2abd2157f200.png','/goods-img/35b9c185-2ca6-4052-af40-2abd2157f200.png','产品信息Product Information',2099,1808,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10868,'小米 小米8屏幕指纹版 手机 透明版','全网通(8G + 128G)',51,'/goods-img/fcd1faf9-10b5-4318-b92b-36105be8752f.png','/goods-img/fcd1faf9-10b5-4318-b92b-36105be8752f.png','产品信息Product Information',2499,2028,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10869,'小米 小米8屏幕指纹版 手机 暮光金','全网通(6G + 128G )',51,'/goods-img/e9818435-c510-4042-91e1-734a818a2577.png','/goods-img/e9818435-c510-4042-91e1-734a818a2577.png','产品信息Product Information',2099,2099,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10870,'小米 红米6 全网通版 3GB内存','流沙金 32GB 移动联通电信4G手机 双卡双待',51,'/goods-img/515706fb-a5f8-4d72-a08e-7523cf4ea113.jpg','/goods-img/515706fb-a5f8-4d72-a08e-7523cf4ea113.jpg','商品介绍加载中...',699,699,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10871,'小米 红米6 3GB+32GB 铂银灰','全网通4G手机 双卡双待 老人机 智能拍照手机',51,'/goods-img/bcec0048-e992-4e57-9aaf-ddbd9fe852ce.jpg','/goods-img/bcec0048-e992-4e57-9aaf-ddbd9fe852ce.jpg','商品介绍加载中...',699,699,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10872,'小米（MI） 小米8屏幕指纹版 全面屏游戏手机 曜石黑（屏幕指纹版）','6G+128G',51,'/goods-img/e1c2b06f-fd06-4242-acb7-9ebd7179181b.png','/goods-img/e1c2b06f-fd06-4242-acb7-9ebd7179181b.png','商品介绍加载中...',2199,1818,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10873,'小米（MI） 小米8屏幕指纹版 全面屏游戏手机 透明版(屏幕指纹版)','8G+128G',51,'/goods-img/314274fc-1ee0-474d-bbb5-b9c70a8a9573.png','/goods-img/314274fc-1ee0-474d-bbb5-b9c70a8a9573.png','商品介绍加载中...',2599,2018,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10874,'小米（MI） 小米8屏幕指纹版 全面屏游戏手机 暮光金(屏幕指纹版)','8G+128G',51,'/goods-img/c2905bd8-bd68-4672-bada-b8a202a9327e.png','/goods-img/c2905bd8-bd68-4672-bada-b8a202a9327e.png','商品介绍加载中...',2599,2058,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10875,'小米8 游戏手机 全面屏 黑色','全网通(6G+64G)',51,'/goods-img/5afd1749-a3bc-41c2-90b2-928ede8aedda.jpg','/goods-img/5afd1749-a3bc-41c2-90b2-928ede8aedda.jpg','商品介绍加载中...',1799,1558,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10876,'小米8 游戏手机 全面屏 白色','全网通(6G+64G)',51,'/goods-img/a96dd5bc-2d74-4d57-9336-45a8ac09a363.jpg','/goods-img/a96dd5bc-2d74-4d57-9336-45a8ac09a363.jpg','商品介绍加载中...',1799,1550,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10877,'小米8 游戏手机 全面屏 白色','全网通(6G+128G)',51,'/goods-img/25e44283-a440-4e64-bb27-1887370c3d2e.jpg','/goods-img/25e44283-a440-4e64-bb27-1887370c3d2e.jpg','商品介绍加载中...',1999,1798,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10878,'小米8 游戏手机 全面屏 金色','全网通(6G+128G)',51,'/goods-img/6b5e5711-8ae6-4f66-bd22-30c9be85d3c6.jpg','/goods-img/6b5e5711-8ae6-4f66-bd22-30c9be85d3c6.jpg','商品介绍加载中...',1999,1849,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10879,'小米8 游戏手机 全面屏 黑色','全网通(6G+128G)',51,'/goods-img/040a3aa6-1699-4eca-ac67-5021cc419979.jpg','/goods-img/040a3aa6-1699-4eca-ac67-5021cc419979.jpg','商品介绍加载中...',1999,1849,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10880,'小米8 游戏手机 全面屏 金色','全网通(6G+64G)',51,'/goods-img/47c28778-88a4-42fd-bb4d-c93fe8df36b5.jpg','/goods-img/47c28778-88a4-42fd-bb4d-c93fe8df36b5.jpg','商品介绍加载中...',1799,1598,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10881,'小米8 游戏手机 全面屏 屏幕指纹版','暮光金 全网通(8G+128G)',51,'http://localhost:28089/admin/dist/img/no-img.png','http://localhost:28089/admin/dist/img/no-img.png','商品介绍加载中...',3799,2199,1000,'1',0,0,'2019-09-18 13:38:32',0,'2019-09-24 19:46:59'),
	(10882,'小米8 游戏手机 全面屏 蓝色','全网通(6G+64G)',51,'/admin/dist/img/no-img.png','/admin/dist/img/no-img.png','商品介绍加载中...',1799,1598,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10883,'小米8 游戏手机 全面屏 金色','全网通(6G+256G)',51,'/admin/dist/img/no-img.png','/admin/dist/img/no-img.png','商品介绍加载中...',3199,2158,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10884,'小米8 游戏手机 全面屏 白色','全网通(6G+256G)',51,'/admin/dist/img/no-img.png','/admin/dist/img/no-img.png','商品介绍加载中...',3199,2158,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10885,'小米8 游戏手机 全面屏 蓝色','全网通(6G+256G)',51,'/admin/dist/img/no-img.png','/admin/dist/img/no-img.png','商品介绍加载中...',3199,2158,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10886,'小米8 游戏手机 全面屏 黑色','全网通(6G+256G)',51,'/admin/dist/img/no-img.png','/admin/dist/img/no-img.png','商品介绍加载中...',3199,3199,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10887,'小米8 游戏手机 全面屏 透明探索版','全网通(8G+128G)',51,'/admin/dist/img/no-img.png','/admin/dist/img/no-img.png','商品介绍加载中...',4299,4299,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-19 08:47:09'),
	(10888,'小米8 游戏手机 全面屏 屏幕指纹版','暮光金 全网通(6G+128G)',51,'/admin/dist/img/no-img.png','/admin/dist/img/no-img.png','商品介绍加载中...',3399,3399,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-19 08:47:09'),
	(10889,'小米8 游戏手机 全面屏 蓝色','全网通(6G+128G)',51,'/admin/dist/img/no-img.png','/admin/dist/img/no-img.png','商品介绍加载中...',1849,1849,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-19 08:47:09'),
	(10890,'小米 红米7 手机 Redmi7','AI双摄 拍照游戏手机 全网通双卡双待 亮黑色 4G+64G 全网通',51,'/goods-img/b6084354-1841-4241-ba7b-7e97186a9076.jpg','/goods-img/b6084354-1841-4241-ba7b-7e97186a9076.jpg','详情加载中...',1299,808,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-18 13:38:32'),
	(10891,'小米 红米7 手机 Redmi7','AI双摄 拍照游戏手机 全网通双卡双待 魅夜红 4G+64G 全网通',51,'/goods-img/7b4e03b1-eca7-42f5-8dda-14d02d3ab318.jpg','/goods-img/7b4e03b1-eca7-42f5-8dda-14d02d3ab318.jpg','详情加载中...',1009,818,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-22 23:33:12'),
	(10892,'小米 红米7 手机 Redmi7','AI双摄 拍照游戏手机 全网通双卡双待 梦幻蓝 3G+32G 全网通',51,'/goods-img/7bca8b59-35f3-480a-a95d-99efcbb8cfda.jpg','/goods-img/7bca8b59-35f3-480a-a95d-99efcbb8cfda.jpg','详情加载中...',787,715,1000,'',0,0,'2019-09-18 13:38:32',0,'2019-09-22 23:33:12'),
	(10893,'HUAWEI Mate 30 Pro 双4000万徕卡电影四摄','超曲面OLED环幕屏 8GB+256GB 全网通4G版（星河银）',0,'/goods-img/mate30p2.png','/goods-img/mate30p2.png','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\r\n<div style=\"margin:0px;padding:0px;text-align:center;\">\r\n	<br />\r\n</div>\r\n	</div>\r\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\r\n	<div style=\"margin:0px auto;padding:0px;\">\r\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/huawei-1.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/huawei-3.jpg\" /> \r\n	</div>\r\n</div>',5399,5399,995,'重构想象',0,0,'2019-09-19 23:17:39',0,'2019-09-19 23:17:39'),
	(10894,'HUAWEI Mate 30 Pro','超曲面OLED环幕屏 8GB+128GB 全网通4G版（翡冷翠）',0,'/goods-img/mate30p3.png','/goods-img/mate30p3.png','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\r\n<div style=\"margin:0px;padding:0px;text-align:center;\">\r\n	<br />\r\n</div>\r\n	</div>\r\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\r\n	<div style=\"margin:0px auto;padding:0px;\">\r\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/huawei-1.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/huawei-3.jpg\" /> \r\n	</div>\r\n</div>',5399,5399,989,'重构想象',0,0,'2019-09-19 23:20:24',0,'2019-09-19 23:20:24'),
	(10895,'HUAWEI Mate 30 4000万超感光徕卡影像','OLED全面屏 8GB+128GB 全网通4G版 （罗兰紫）',46,'/goods-img/mate30-3.png','http://localhost:28089/goods-img/mate30-3.png','<div id=\"activity_header\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n<div style=\"margin:0px;padding:0px;text-align:center;\">\n	<br />\n</div>\n	</div>\n<div id=\"J-detail-content\" style=\"margin:0px;padding:0px;color:#666666;font-family:tahoma, arial, \" background-color:#ffffff;\"=\"\">\n	<div style=\"margin:0px auto;padding:0px;\">\n		<img class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/huawei-1.jpg\" /><img border=\"0\" class=\"\" src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/huawei-3.jpg\" /> \n	</div>\n</div>',3999,3999,990,'重构想象',0,0,'2019-09-19 23:22:22',0,'2019-11-27 00:16:03'),
	(10900,'牛逼的相机','黑色',37,'/upload/20191124_17163050.jpg','http://localhost:28089/upload/20191124_17163050.jpg','牛逼的相机',9999,7999,200,'定格美好',0,0,'2019-11-24 17:10:34',0,'2019-11-27 00:16:03'),
	(10901,'华为mate x 5G 折叠屏手机(新品)','科技新物种，定义未来',46,'/upload/20191124_18032027.png','http://localhost:28089/upload/20191124_18032027.png','<img src=\"http://localhost:28089/upload/20191124_18023057.png\" alt=\"\" />',59999,19998,100,'前所未见，惊世首演',0,0,'2019-11-24 17:57:18',0,'2019-11-27 00:16:03'),
	(10902,'华为 HUAWEI P40 冰霜银 全网通5G手机','麒麟990 5G SoC芯片 5000万超感知徕卡三摄 30倍数字变焦 6GB+128GB',46,'https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/p40-silver.png','https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/p40-silver.png','<img src=\"https://newbee-mall.oss-cn-beijing.aliyuncs.com/images/p40-detail.jpg\" alt=\"\" />',4399,4299,2000,'超感知影像',0,0,'2020-03-27 10:07:37',0,'2020-05-15 17:18:30');

/*!40000 ALTER TABLE `tb_newbee_mall_goods_info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_newbee_mall_index_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_index_config`;

CREATE TABLE `tb_newbee_mall_index_config` (
  `config_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '首页配置项主键id',
  `config_name` varchar(50) NOT NULL DEFAULT '' COMMENT '显示字符(配置搜索时不可为空，其他可为空)',
  `config_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1-搜索框热搜 2-搜索下拉框热搜 3-(首页)热销商品 4-(首页)新品上线 5-(首页)为你推荐',
  `goods_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品id 默认为0',
  `redirect_url` varchar(100) NOT NULL DEFAULT '##' COMMENT '点击后的跳转地址(默认不跳转)',
  `config_rank` int(11) NOT NULL DEFAULT '0' COMMENT '排序值(字段越大越靠前)',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` int(11) NOT NULL DEFAULT '0' COMMENT '创建者id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新修改时间',
  `update_user` int(11) DEFAULT '0' COMMENT '修改者id',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_newbee_mall_index_config` WRITE;
/*!40000 ALTER TABLE `tb_newbee_mall_index_config` DISABLE KEYS */;

INSERT INTO `tb_newbee_mall_index_config` (`config_id`, `config_name`, `config_type`, `goods_id`, `redirect_url`, `config_rank`, `is_deleted`, `create_time`, `create_user`, `update_time`, `update_user`)
VALUES
	(1,'热销商品 iPhone XR',3,10284,'##',10,0,'2019-09-18 17:04:56',0,'2019-09-18 17:04:56',0),
	(2,'热销商品 华为 Mate20',3,10779,'##',100,0,'2019-09-18 17:05:27',0,'2019-09-18 17:05:27',0),
	(3,'热销商品 荣耀8X',3,10700,'##',300,0,'2019-09-18 17:08:02',0,'2019-09-18 17:08:02',0),
	(4,'热销商品 Apple AirPods',3,10159,'##',101,0,'2019-09-18 17:08:56',0,'2019-09-18 17:08:56',0),
	(5,'新品上线 Macbook Pro',4,10269,'##',100,0,'2019-09-18 17:10:36',0,'2019-09-18 17:10:36',0),
	(6,'新品上线 荣耀 9X Pro',4,10755,'##',100,1,'2019-09-18 17:11:05',0,'2019-12-14 16:04:26',0),
	(7,'新品上线 iPhone 11',4,10283,'##',102,0,'2019-09-18 17:11:44',0,'2019-09-18 17:11:44',0),
	(8,'新品上线 iPhone 11 Pro',4,10320,'##',101,0,'2019-09-18 17:11:58',0,'2019-09-18 17:11:58',0),
	(9,'新品上线 华为无线耳机',4,10186,'##',100,1,'2019-09-18 17:12:29',0,'2019-12-14 16:04:26',0),
	(10,'纪梵希高定香榭天鹅绒唇膏',5,10233,'##',98,0,'2019-09-18 17:47:23',0,'2019-09-18 17:47:23',0),
	(11,'MAC 磨砂系列',5,10237,'##',100,0,'2019-09-18 17:47:44',0,'2019-09-18 17:47:44',0),
	(12,'索尼 WH-1000XM3',5,10195,'##',102,0,'2019-09-18 17:48:00',0,'2019-09-18 17:48:00',0),
	(13,'Apple AirPods',5,10180,'##',101,0,'2019-09-18 17:49:11',0,'2019-09-18 17:49:11',0),
	(14,'小米 Redmi AirDots',5,10160,'##',100,0,'2019-09-18 17:49:28',0,'2019-09-18 17:49:28',0),
	(15,'2019 MacBookAir 13',5,10254,'##',100,0,'2019-09-18 17:50:18',0,'2019-09-18 17:50:18',0),
	(16,'女式粗棉线条纹长袖T恤',5,10158,'##',99,0,'2019-09-18 17:52:03',0,'2019-09-18 17:52:03',0),
	(17,'塑料浴室座椅',5,10154,'##',100,0,'2019-09-18 17:52:19',0,'2019-09-18 17:52:19',0),
	(18,'靠垫',5,10147,'##',101,0,'2019-09-18 17:52:50',0,'2019-09-18 17:52:50',0),
	(19,'小型超声波香薰机',5,10113,'##',100,0,'2019-09-18 17:54:07',0,'2019-09-18 17:54:07',0),
	(20,'11',5,1,'##',0,1,'2019-09-19 08:31:11',0,'2019-09-19 08:31:20',0),
	(21,'热销商品 华为 P30',3,10742,'##',200,0,'2019-09-19 23:23:38',0,'2019-09-19 23:23:38',0),
	(22,'新品上线 华为Mate30 Pro',4,10893,'##',200,0,'2019-09-19 23:26:05',0,'2019-09-19 23:26:05',0),
	(23,'新品上线 华为 Mate 30',4,10895,'##',199,0,'2019-09-19 23:26:32',0,'2019-09-19 23:26:32',0),
	(24,'华为 Mate 30 Pro',5,10894,'##',101,0,'2019-09-19 23:27:00',0,'2019-09-19 23:27:00',0),
	(25,'4123',3,20,'##',0,1,'2019-10-24 23:53:03',0,'2019-10-24 23:53:35',0),
	(26,'42341',3,4324,'##',0,1,'2019-10-24 23:53:09',0,'2019-10-24 23:54:12',0),
	(27,'432443',3,10,'##',0,1,'2019-10-24 23:53:14',0,'2019-10-24 23:54:12',0),
	(28,'rqwer',3,23,'##',12,1,'2019-10-25 00:41:33',0,'2019-10-25 00:44:16',0),
	(29,'新品上线 华为 matex',4,10901,'##',12,0,'2019-12-14 15:53:34',0,'2019-12-14 15:53:34',0);

/*!40000 ALTER TABLE `tb_newbee_mall_index_config` ENABLE KEYS */;
UNLOCK TABLES;

# Dump of table tb_newbee_mall_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_order`;

CREATE TABLE `tb_newbee_mall_order` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单表主键id',
  `order_no` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号',
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户主键id',
  `total_price` int(11) NOT NULL DEFAULT '1' COMMENT '订单总价',
  `pay_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付状态:0.未支付,1.支付成功,-1:支付失败',
  `pay_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0.无 1.支付宝支付 2.微信支付',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `order_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单状态:0.待支付 1.已支付 2.配货完成 3:出库成功 4.交易成功 -1.手动关闭 -2.超时关闭 -3.商家关闭',
  `extra_info` varchar(100) NOT NULL DEFAULT '' COMMENT '订单body',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新修改时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table tb_newbee_mall_order_address
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_order_address`;

CREATE TABLE `tb_newbee_mall_order_address` (
  `order_id` bigint(20) NOT NULL,
  `user_name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `user_phone` varchar(11) NOT NULL DEFAULT '' COMMENT '收货人手机号',
  `province_name` varchar(32) NOT NULL DEFAULT '' COMMENT '省',
  `city_name` varchar(32) NOT NULL DEFAULT '' COMMENT '城',
  `region_name` varchar(32) NOT NULL DEFAULT '' COMMENT '区',
  `detail_address` varchar(64) NOT NULL DEFAULT '' COMMENT '收件详细地址(街道/楼宇/单元)',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单收货地址关联表';

# Dump of table tb_newbee_mall_order_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_order_item`;

CREATE TABLE `tb_newbee_mall_order_item` (
  `order_item_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单关联购物项主键id',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单主键id',
  `goods_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '关联商品id',
  `goods_name` varchar(200) NOT NULL DEFAULT '' COMMENT '下单时商品的名称(订单快照)',
  `goods_cover_img` varchar(200) NOT NULL DEFAULT '' COMMENT '下单时商品的主图(订单快照)',
  `selling_price` int(11) NOT NULL DEFAULT '1' COMMENT '下单时商品的价格(订单快照)',
  `goods_count` int(11) NOT NULL DEFAULT '1' COMMENT '数量(订单快照)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`order_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table tb_newbee_mall_shopping_cart_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_shopping_cart_item`;

CREATE TABLE `tb_newbee_mall_shopping_cart_item` (
  `cart_item_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '购物项主键id',
  `user_id` bigint(20) NOT NULL COMMENT '用户主键id',
  `goods_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '关联商品id',
  `goods_count` int(11) NOT NULL DEFAULT '1' COMMENT '数量(最大为5)',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新修改时间',
  PRIMARY KEY (`cart_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table tb_newbee_mall_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_user`;

CREATE TABLE `tb_newbee_mall_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户主键id',
  `nick_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `login_name` varchar(11) NOT NULL DEFAULT '' COMMENT '登陆名称(默认为手机号)',
  `password_md5` varchar(32) NOT NULL DEFAULT '' COMMENT 'MD5加密后的密码',
  `introduce_sign` varchar(100) NOT NULL DEFAULT '' COMMENT '个性签名',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '注销标识字段(0-正常 1-已注销)',
  `locked_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定标识字段(0-未锁定 1-已锁定)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

LOCK TABLES `tb_newbee_mall_user` WRITE;
/*!40000 ALTER TABLE `tb_newbee_mall_user` DISABLE KEYS */;

INSERT INTO `tb_newbee_mall_user` (`user_id`, `nick_name`, `login_name`, `password_md5`, `introduce_sign`, `is_deleted`, `locked_flag`, `create_time`)
VALUES
	(1,'十三','13700002703','e10adc3949ba59abbe56e057f20f883e','我不怕千万人阻挡，只怕自己投降',0,0,'2020-05-22 08:44:57'),
	(6,'陈尼克','13711113333','e10adc3949ba59abbe56e057f20f883e','测试用户陈尼克',0,0,'2020-05-22 08:44:57');

/*!40000 ALTER TABLE `tb_newbee_mall_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_newbee_mall_user_address
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_user_address`;

CREATE TABLE `tb_newbee_mall_user_address` (
  `address_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户主键id',
  `user_name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `user_phone` varchar(11) NOT NULL DEFAULT '' COMMENT '收货人手机号',
  `default_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否为默认 0-非默认 1-是默认',
  `province_name` varchar(32) NOT NULL DEFAULT '' COMMENT '省',
  `city_name` varchar(32) NOT NULL DEFAULT '' COMMENT '城',
  `region_name` varchar(32) NOT NULL DEFAULT '' COMMENT '区',
  `detail_address` varchar(64) NOT NULL DEFAULT '' COMMENT '收件详细地址(街道/楼宇/单元)',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收货地址表';

# Dump of table tb_newbee_mall_user_token
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_user_token`;

CREATE TABLE `tb_newbee_mall_user_token` (
  `user_id` bigint(20) NOT NULL COMMENT '用户主键id',
  `token` varchar(32) NOT NULL COMMENT 'token值(32位字符串)',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `expire_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'token过期时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table tb_newbee_mall_user_token
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_newbee_mall_admin_user_token`;

CREATE TABLE `tb_newbee_mall_admin_user_token` (
  `admin_user_id` bigint(20) NOT NULL COMMENT '用户主键id',
  `token` varchar(32) NOT NULL COMMENT 'token值(32位字符串)',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `expire_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'token过期时间',
  PRIMARY KEY (`admin_user_id`),
  UNIQUE KEY `uq_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

