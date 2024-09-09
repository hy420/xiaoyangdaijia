﻿# Host: 139.198.104.58  (Version 5.7.38)
# Date: 2023-11-24 15:07:48
# Generator: MySQL-Front 6.1  (Build 1.26)


#
# Database "daijia_coupon"
#

CREATE DATABASE IF NOT EXISTS `daijia_coupon`;
USE `daijia_coupon`;

#
# Structure for table "coupon_info"
#

CREATE TABLE `coupon_info`
(
    `id`               bigint(20)     NOT NULL AUTO_INCREMENT COMMENT 'id',
    `coupon_type`      tinyint(3)     NOT NULL DEFAULT '1' COMMENT '优惠卷类型 1 现金券 2 折扣',
    `name`             varchar(100)            DEFAULT NULL COMMENT '优惠卷名字',
    `amount`           decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '金额',
    `discount`         decimal(10, 2)          DEFAULT NULL COMMENT '折扣：取值[1 到 10]',
    `condition_amount` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '使用门槛 0->没门槛',
    `publish_count`    int(11)        NOT NULL DEFAULT '1' COMMENT '发行数量，0->无限制',
    `per_limit`        int(11)        NOT NULL DEFAULT '1' COMMENT '每人限领张数，0-不限制 1-限领1张 2-限领2张',
    `use_count`        int(11)        NOT NULL DEFAULT '0' COMMENT '已使用数量',
    `receive_count`    int(11)        NOT NULL DEFAULT '0' COMMENT '领取数量',
    `expire_time`      datetime                DEFAULT NULL COMMENT '过期时间',
    `description`      varchar(255)            DEFAULT NULL COMMENT '优惠券描述',
    `status`           tinyint(1)              DEFAULT NULL COMMENT '状态[0-未发布，1-已发布， -1-已过期]',
    `create_time`      timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`      timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`       tinyint(3)     NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 11
  DEFAULT CHARSET = utf8 COMMENT ='优惠券信息';

#
# Data for table "coupon_info"
#

INSERT INTO `coupon_info`
VALUES (1, 2, '九折卷', 0.00, 9.00, 0.00, 100, 1, 0, 0, '2024-12-31 00:00:00', '九折卷，无门槛，全场通用', 1, '2023-09-19 15:51:42',
        '2023-11-22 15:13:51', 0),
       (2, 1, '5元通用卷', 5.00, NULL, 0.00, 100, 1, 0, 2, '2024-12-31 00:00:00', '5元通用卷，无门槛，全场通用', 1,
        '2023-10-27 14:04:12', '2023-11-22 15:20:50', 0),
       (3, 1, '10元现金卷', 10.00, NULL, 30.00, 100, 1, 0, 0, '2024-12-31 00:00:00', '10元现金卷，满30元可用', 1,
        '2023-10-27 14:04:56', '2023-11-22 15:18:33', 0),
       (4, 2, '八折卷', 0.00, 8.00, 50.00, 100, 0, 0, 0, '2024-12-31 00:00:00', '八折卷，满50元可用，无限领取', 1,
        '2023-10-27 14:06:30', '2023-11-22 11:28:33', 0),
       (5, 1, '8元通用卷', 8.00, NULL, 0.00, 100, 2, 0, 2, '2024-12-31 00:00:00', '8元通用卷，无门槛，每人可领2张', 1,
        '2023-10-27 14:07:32', '2023-11-22 15:20:49', 0);

#
# Structure for table "customer_coupon"
#

CREATE TABLE `customer_coupon`
(
    `id`           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
    `coupon_id`    bigint(20)          DEFAULT NULL COMMENT '优惠券ID',
    `customer_id`  bigint(20)          DEFAULT NULL COMMENT '乘客ID',
    `status`       tinyint(3)          DEFAULT NULL COMMENT '优化券状态（1：未使用 2：已使用）',
    `receive_time` datetime            DEFAULT NULL COMMENT '领取时间',
    `used_time`    datetime            DEFAULT NULL COMMENT '使用时间',
    `order_id`     bigint(20)          DEFAULT NULL COMMENT '订单id',
    `expire_time`  datetime            DEFAULT NULL COMMENT '过期时间',
    `create_time`  timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`  timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`   tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`),
    KEY `idx_coupon_id` (`coupon_id`),
    KEY `idx_customer_id` (`customer_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='乘客优惠券关联表';

#
# Data for table "customer_coupon"
#

#
# Structure for table "undo_log"
#

CREATE TABLE `undo_log`
(
    `id`            bigint(20)   NOT NULL AUTO_INCREMENT,
    `branch_id`     bigint(20)   NOT NULL,
    `xid`           varchar(100) NOT NULL,
    `context`       varchar(128) NOT NULL,
    `rollback_info` longblob     NOT NULL,
    `log_status`    int(11)      NOT NULL,
    `log_created`   datetime     NOT NULL,
    `log_modified`  datetime     NOT NULL,
    `ext`           varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

#
# Data for table "undo_log"
#


#
# Database "daijia_customer"
#

CREATE DATABASE IF NOT EXISTS `daijia_customer`;
USE `daijia_customer`;

#
# Structure for table "customer_info"
#

CREATE TABLE `customer_info`
(
    `id`          bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '主键',
    `wx_open_id`  varchar(200) NOT NULL DEFAULT '' COMMENT '微信openId',
    `nickname`    varchar(200)          DEFAULT '' COMMENT '客户昵称',
    `gender`      char(1)      NOT NULL DEFAULT '1' COMMENT '性别',
    `avatar_url`  varchar(200)          DEFAULT NULL COMMENT '头像',
    `phone`       char(11)              DEFAULT NULL COMMENT '电话',
    `status`      tinyint(3)            DEFAULT '1' COMMENT '1有效，2禁用',
    `create_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3)   NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uni_open_id` (`wx_open_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='客户表';

#
# Data for table "customer_info"
#

#
# Structure for table "customer_login_log"
#

CREATE TABLE `customer_login_log`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
    `customer_id` varchar(50)         DEFAULT '' COMMENT '客户id',
    `ipaddr`      varchar(128)        DEFAULT '' COMMENT '登录IP地址',
    `status`      tinyint(1)          DEFAULT '1' COMMENT '登录状态',
    `msg`         varchar(255)        DEFAULT '' COMMENT '提示信息',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_time` timestamp  NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`),
    KEY `idx_customer_id` (`customer_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='客户登录记录';

#
# Data for table "customer_login_log"
#


#
# Structure for table "undo_log"
#

CREATE TABLE `undo_log`
(
    `id`            bigint(20)   NOT NULL AUTO_INCREMENT,
    `branch_id`     bigint(20)   NOT NULL,
    `xid`           varchar(100) NOT NULL,
    `context`       varchar(128) NOT NULL,
    `rollback_info` longblob     NOT NULL,
    `log_status`    int(11)      NOT NULL,
    `log_created`   datetime     NOT NULL,
    `log_modified`  datetime     NOT NULL,
    `ext`           varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

#
# Data for table "undo_log"
#


#
# Database "daijia_dispatch"
#

CREATE DATABASE IF NOT EXISTS `daijia_dispatch`;
USE `daijia_dispatch`;

#
# Structure for table "order_job"
#

CREATE TABLE `order_job`
(
    `id`          bigint(11) NOT NULL AUTO_INCREMENT,
    `order_id`    bigint(20) NOT NULL DEFAULT '0' COMMENT '订单id',
    `job_id`      bigint(11) NOT NULL DEFAULT '0' COMMENT '任务id',
    `parameter`   text COMMENT '参数',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_order_id` (`order_id`),
    UNIQUE KEY `uni_job_id` (`job_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='订单与任务的关联表';

#
# Data for table "order_job"
#

#
# Structure for table "undo_log"
#

CREATE TABLE `undo_log`
(
    `id`            bigint(20)   NOT NULL AUTO_INCREMENT,
    `branch_id`     bigint(20)   NOT NULL,
    `xid`           varchar(100) NOT NULL,
    `context`       varchar(128) NOT NULL,
    `rollback_info` longblob     NOT NULL,
    `log_status`    int(11)      NOT NULL,
    `log_created`   datetime     NOT NULL,
    `log_modified`  datetime     NOT NULL,
    `ext`           varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

#
# Data for table "undo_log"
#

#
# Structure for table "xxl_job_log"
#

CREATE TABLE `xxl_job_log`
(
    `id`          bigint(11) NOT NULL AUTO_INCREMENT,
    `job_id`      bigint(11) NOT NULL DEFAULT '0' COMMENT '任务id',
    `status`      int(11)    NOT NULL DEFAULT '1' COMMENT '任务状态    0：失败    1：成功',
    `error`       text COMMENT '失败信息',
    `times`       int(11)    NOT NULL DEFAULT '0' COMMENT '耗时(单位：毫秒)',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`),
    KEY `idx_job_id` (`job_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

#
# Data for table "xxl_job_log"
#

#
# Database "daijia_driver"
#

CREATE DATABASE IF NOT EXISTS `daijia_driver`;
USE `daijia_driver`;

#
# Structure for table "driver_account"
#

CREATE TABLE `driver_account`
(
    `id`                  bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '编号',
    `driver_id`           bigint(20)     NOT NULL DEFAULT '0' COMMENT '司机id',
    `total_amount`        decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '账户总金额',
    `lock_amount`         decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '锁定金额',
    `available_amount`    decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '可用金额',
    `total_income_amount` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '总收入',
    `total_pay_amount`    decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '总支出',
    `create_time`         timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`         timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`          tinyint(3)     NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uni_driver_id` (`driver_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='司机账户';

#
# Data for table "driver_account"
#


#
# Structure for table "driver_account_detail"
#

CREATE TABLE `driver_account_detail`
(
    `id`          bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '编号',
    `driver_id`   bigint(20)     NOT NULL DEFAULT '0' COMMENT '司机id',
    `content`     varchar(100)   NOT NULL DEFAULT '' COMMENT '交易内容',
    `trade_type`  varchar(10)    NOT NULL DEFAULT '' COMMENT '交易类型：1-奖励 2-补贴 3-提现',
    `amount`      decimal(16, 2) NOT NULL DEFAULT '0.00' COMMENT '金额',
    `trade_no`    varchar(50)             DEFAULT NULL COMMENT '交易编号',
    `create_time` timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  varchar(2)     NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    KEY `idx_driver_id` (`driver_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='司机账户明细';

#
# Data for table "driver_account_detail"
#


#
# Structure for table "driver_face_recognition"
#

CREATE TABLE `driver_face_recognition`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `driver_id`   bigint(20) NOT NULL DEFAULT '0' COMMENT '司机id',
    `face_date`   date                DEFAULT NULL COMMENT '识别日期',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `idx_driver_id` (`driver_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='司机人脸识别记录表';

#
# Data for table "driver_face_recognition"
#

#
# Structure for table "driver_info"
#

CREATE TABLE `driver_info`
(
    `id`                        bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '主键',
    `wx_open_id`                varchar(200)   NOT NULL DEFAULT '' COMMENT '微信openId',
    `nickname`                  varchar(200)   NOT NULL COMMENT '昵称',
    `avatar_url`                varchar(200)            DEFAULT NULL COMMENT '头像',
    `phone`                     char(11)                DEFAULT NULL COMMENT '电话',
    `name`                      varchar(20)             DEFAULT NULL COMMENT '姓名',
    `gender`                    char(1)        NOT NULL DEFAULT '1' COMMENT '性别 1:男 2：女',
    `birthday`                  date                    DEFAULT NULL COMMENT '生日',
    `idcard_no`                 varchar(18)             DEFAULT NULL COMMENT '身份证号码',
    `idcard_address`            varchar(200)            DEFAULT NULL COMMENT '身份证地址',
    `idcard_expire`             date                    DEFAULT NULL COMMENT '身份证有效期',
    `idcard_front_url`          varchar(200)            DEFAULT NULL COMMENT '身份证正面',
    `idcard_back_url`           varchar(200)            DEFAULT NULL COMMENT '身份证背面',
    `idcard_hand_url`           varchar(200)            DEFAULT NULL COMMENT '手持身份证',
    `driver_license_class`      varchar(20)             DEFAULT NULL COMMENT '准驾车型',
    `driver_license_no`         varchar(100)            DEFAULT NULL COMMENT '驾驶证证件号',
    `driver_license_expire`     date                    DEFAULT NULL COMMENT '驾驶证有效期',
    `driver_license_issue_date` date                    DEFAULT NULL COMMENT '驾驶证初次领证日期',
    `driver_license_front_url`  varchar(200)            DEFAULT NULL COMMENT '驾驶证正面',
    `driver_license_back_url`   varchar(200)            DEFAULT NULL COMMENT '行驶证副页正面',
    `driver_license_hand_url`   varchar(200)            DEFAULT NULL COMMENT '手持驾驶证',
    `contact_name`              varchar(20)             DEFAULT NULL COMMENT '紧急联系人',
    `contact_phone`             char(11)                DEFAULT NULL COMMENT '紧急联系人电话',
    `contact_relationship`      varchar(20)             DEFAULT NULL COMMENT '紧急联系人关系',
    `face_model_id`             varchar(100)            DEFAULT NULL COMMENT '腾讯云人脸模型id',
    `job_no`                    varchar(50)             DEFAULT NULL COMMENT '司机工号',
    `score`                     decimal(10, 2) NOT NULL DEFAULT '9.00' COMMENT '评分',
    `order_count`               int(11)        NOT NULL DEFAULT '0' COMMENT '订单量统计',
    `auth_status`               tinyint(3)     NOT NULL DEFAULT '0' COMMENT '认证状态 0:未认证  1：审核中 2：认证通过 -1：认证未通过',
    `status`                    tinyint(3)     NOT NULL DEFAULT '1' COMMENT '状态，1正常，2禁用',
    `create_time`               timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`               timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`                tinyint(3)     NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='司机表';

#
# Data for table "driver_info"
#

#
# Structure for table "driver_login_log"
#

CREATE TABLE `driver_login_log`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
    `driver_id`   varchar(50)         DEFAULT '' COMMENT '司机id',
    `ipaddr`      varchar(128)        DEFAULT '' COMMENT '登录IP地址',
    `status`      tinyint(1)          DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
    `msg`         varchar(255)        DEFAULT '' COMMENT '提示信息',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_time` timestamp  NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`),
    KEY `idx_driver_id` (`driver_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='司机登录记录';

#
# Data for table "driver_login_log"
#


#
# Structure for table "driver_set"
#

CREATE TABLE `driver_set`
(
    `id`              bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '主键',
    `driver_id`       bigint(20)     NOT NULL COMMENT '司机ID',
    `service_status`  tinyint(3)     NOT NULL DEFAULT '0' COMMENT '服务状态 1：开始接单 0：未接单',
    `order_distance`  decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '订单里程设置',
    `accept_distance` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '接单里程设置',
    `is_auto_accept`  tinyint(3)     NOT NULL DEFAULT '0' COMMENT '是否自动接单',
    `create_time`     timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`     timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`      tinyint(3)     NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uni_driver_id` (`driver_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='司机设置表';

#
# Data for table "driver_set"
#

#
# Structure for table "undo_log"
#

CREATE TABLE `undo_log`
(
    `id`            bigint(20)   NOT NULL AUTO_INCREMENT,
    `branch_id`     bigint(20)   NOT NULL,
    `xid`           varchar(100) NOT NULL,
    `context`       varchar(128) NOT NULL,
    `rollback_info` longblob     NOT NULL,
    `log_status`    int(11)      NOT NULL,
    `log_created`   datetime     NOT NULL,
    `log_modified`  datetime     NOT NULL,
    `ext`           varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

#
# Data for table "undo_log"
#


#
# Database "daijia_order"
#

CREATE DATABASE IF NOT EXISTS `daijia_order`;
USE `daijia_order`;

#
# Structure for table "order_bill"
#

CREATE TABLE `order_bill`
(
    `id`                         bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '主键',
    `order_id`                   bigint(20)     NOT NULL COMMENT '订单ID',
    `fee_rule_id`                varchar(255)            DEFAULT NULL COMMENT '费用规则id',
    `total_amount`               decimal(10, 2)          DEFAULT '0.00' COMMENT '总金额',
    `pay_amount`                 decimal(10, 2)          DEFAULT '0.00' COMMENT '应付款金额',
    `distance_fee`               decimal(10, 2)          DEFAULT '0.00' COMMENT '里程费',
    `wait_fee`                   decimal(10, 2)          DEFAULT '0.00' COMMENT '等时费用',
    `long_distance_fee`          decimal(10, 2)          DEFAULT '0.00' COMMENT '远程费',
    `toll_fee`                   decimal(10, 2)          DEFAULT '0.00' COMMENT '路桥费',
    `parking_fee`                decimal(10, 2)          DEFAULT '0.00' COMMENT '停车费',
    `other_fee`                  decimal(10, 2)          DEFAULT '0.00' COMMENT '其他费用',
    `favour_fee`                 decimal(10, 2)          DEFAULT '0.00' COMMENT '顾客好处费',
    `reward_fee`                 decimal(10, 2)          DEFAULT '0.00' COMMENT '系统奖励费',
    `reward_rule_id`             bigint(20)              DEFAULT NULL COMMENT '系统奖励规则id',
    `coupon_amount`              decimal(10, 2)          DEFAULT NULL COMMENT '优惠券金额',
    `base_distance`              smallint(6)    NOT NULL DEFAULT '0' COMMENT '基础里程（公里）',
    `base_distance_fee`          decimal(10, 2)          DEFAULT NULL COMMENT '基础里程费',
    `exceed_distance`            varchar(255)            DEFAULT NULL COMMENT '超出基础里程的里程（公里）',
    `exceed_distance_price`      decimal(10, 2)          DEFAULT NULL COMMENT '超出基础里程的价格',
    `base_wait_minute`           smallint(6)    NOT NULL DEFAULT '0' COMMENT '基础等时分钟',
    `exceed_wait_minute`         smallint(6)             DEFAULT NULL COMMENT '超出基础等时的分钟',
    `exceed_wait_minute_price`   decimal(10, 2)          DEFAULT NULL COMMENT '超出基础分钟的价格',
    `base_long_distance`         smallint(6)    NOT NULL DEFAULT '0' COMMENT '基础远途里程（公里）',
    `exceed_long_distance`       decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '超出基础远程里程的里程',
    `exceed_long_distance_price` decimal(10, 2)          DEFAULT NULL COMMENT '超出基础远程里程的价格',
    `create_time`                timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`                timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`                 tinyint(3)     NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uni_order_id` (`order_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='订单账单表';

#
# Data for table "order_bill"
#

#
# Structure for table "order_comment"
#

CREATE TABLE `order_comment`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `order_id`    bigint(20) NOT NULL COMMENT '订单ID',
    `driver_id`   bigint(20) NOT NULL COMMENT '司机ID',
    `customer_id` bigint(20) NOT NULL COMMENT '顾客ID',
    `rate`        tinyint(4) NOT NULL COMMENT '评分，1星~5星',
    `remark`      varchar(200)        DEFAULT NULL COMMENT '备注',
    `status`      tinyint(4) NOT NULL COMMENT '状态，1未申诉，2已申诉，3申诉失败，4申诉成功',
    `instance_id` varchar(100)        DEFAULT NULL COMMENT '申诉工作流ID',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `idx_order_id` (`order_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='订单评价表';

#
# Data for table "order_comment"
#


#
# Structure for table "order_info"
#

CREATE TABLE `order_info`
(
    `id`                    bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '主键',
    `customer_id`           bigint(20)     NOT NULL DEFAULT '0' COMMENT '客户ID',
    `order_no`              varchar(50)    NOT NULL DEFAULT '' COMMENT '订单号',
    `start_location`        varchar(200)   NOT NULL DEFAULT '' COMMENT '起始地点',
    `start_point_longitude` decimal(10, 7) NOT NULL DEFAULT '0.0000000' COMMENT '起始地点经度',
    `start_point_latitude`  decimal(10, 7) NOT NULL DEFAULT '0.0000000' COMMENT '起始点伟度',
    `end_location`          varchar(200)   NOT NULL DEFAULT '' COMMENT '结束地点',
    `end_point_longitude`   decimal(10, 7) NOT NULL DEFAULT '0.0000000' COMMENT '结束地点经度',
    `end_point_latitude`    decimal(10, 7) NOT NULL DEFAULT '0.0000000' COMMENT '结束地点经度',
    `expect_distance`       decimal(10, 2)          DEFAULT NULL COMMENT '预估里程',
    `real_distance`         decimal(10, 2)          DEFAULT NULL COMMENT '实际里程',
    `expect_amount`         decimal(10, 2)          DEFAULT NULL COMMENT '预估订单金额',
    `real_amount`           decimal(10, 2)          DEFAULT NULL COMMENT '实际订单金额',
    `favour_fee`            decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '顾客好处费',
    `driver_id`             bigint(20)              DEFAULT NULL COMMENT '司机ID',
    `accept_time`           datetime                DEFAULT NULL COMMENT '司机接单时间',
    `arrive_time`           datetime                DEFAULT NULL COMMENT '司机到达时间',
    `start_service_time`    datetime                DEFAULT NULL COMMENT '开始服务时间',
    `end_service_time`      datetime                DEFAULT NULL COMMENT '结束服务时间',
    `pay_time`              datetime                DEFAULT NULL COMMENT '微信付款时间',
    `cancel_rule_id`        bigint(20)              DEFAULT NULL COMMENT '订单取消规则ID',
    `car_license`           varchar(20)    NOT NULL DEFAULT '' COMMENT '车牌号',
    `car_type`              varchar(20)    NOT NULL DEFAULT '' COMMENT '车型',
    `car_front_url`         varchar(200)            DEFAULT NULL COMMENT '司机到达拍照：车前照',
    `car_back_url`          varchar(200)            DEFAULT NULL COMMENT '司机到达拍照：车后照',
    `transaction_id`        varchar(50)             DEFAULT NULL COMMENT '微信支付订单号',
    `job_id`                bigint(20)              DEFAULT NULL,
    `status`                tinyint(3)     NOT NULL DEFAULT '1' COMMENT '订单状态：1等待接单，2已接单，3司机已到达，4开始代驾，5结束代驾，6未付款，7已付款，8订单已结束，9顾客撤单，10司机撤单，11事故关闭，12其他',
    `remark`                varchar(200)            DEFAULT NULL COMMENT '订单备注信息',
    `create_time`           timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`           timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`            tinyint(3)     NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uni_order_no` (`order_no`),
    KEY `idx_customer_id` (`customer_id`),
    KEY `idx_driver_id` (`driver_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='订单表';

#
# Data for table "order_info"
#

#
# Structure for table "order_monitor"
#

CREATE TABLE `order_monitor`
(
    `id`          int(11)    NOT NULL AUTO_INCREMENT COMMENT '编号',
    `order_id`    bigint(20) NOT NULL DEFAULT '0' COMMENT '订单ID',
    `file_num`    int(11)    NOT NULL DEFAULT '0' COMMENT '文件个数',
    `audit_num`   int(3)     NOT NULL DEFAULT '0' COMMENT '需要审核的个数',
    `is_alarm`    tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否报警',
    `status`      tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_order_id` (`order_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='订单监控表';

#
# Data for table "order_monitor"
#


#
# Structure for table "order_monitor_record"
#

CREATE TABLE `order_monitor_record`
(
    `id`          int(11)      NOT NULL AUTO_INCREMENT COMMENT '编号',
    `order_id`    bigint(20)            DEFAULT NULL COMMENT '订单ID',
    `file_url`    varchar(200) NOT NULL DEFAULT '0' COMMENT '文件路径',
    `content`     text         NOT NULL COMMENT '内容',
    `result`      tinyint(3)            DEFAULT NULL COMMENT '审核结果',
    `keywords`    text COMMENT '风险关键词',
    `status`      tinyint(3)            DEFAULT NULL COMMENT '状态',
    `create_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3)   NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    KEY `idx_order_id` (`order_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='订单监控记录表';

#
# Data for table "order_monitor_record"
#


#
# Structure for table "order_profitsharing"
#

CREATE TABLE `order_profitsharing`
(
    `id`              bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '主键',
    `order_id`        bigint(20)     NOT NULL COMMENT '订单ID',
    `rule_id`         bigint(20)     NOT NULL COMMENT '规则ID',
    `order_amount`    decimal(10, 2)          DEFAULT NULL COMMENT '订单金额',
    `payment_rate`    decimal(10, 2)          DEFAULT NULL COMMENT '微信支付平台费率',
    `payment_fee`     decimal(10, 2)          DEFAULT NULL COMMENT '微信支付平台费用',
    `driver_tax_rate` decimal(10, 2)          DEFAULT NULL COMMENT '代驾司机代缴个税税率',
    `driver_tax_fee`  decimal(10, 2)          DEFAULT NULL COMMENT '代驾司机税率支出费用',
    `platform_income` decimal(10, 2)          DEFAULT NULL COMMENT '平台分账收入',
    `driver_income`   decimal(10, 2) NOT NULL COMMENT '司机分账收入',
    `status`          tinyint(3)     NOT NULL DEFAULT '1' COMMENT '分账状态，1未分账，2已分账',
    `create_time`     timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`     timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`      tinyint(3)     NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uni_order_id` (`order_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='订单分账表';

#
# Data for table "order_profitsharing"
#

#
# Structure for table "order_status_log"
#

CREATE TABLE `order_status_log`
(
    `id`           bigint(11) NOT NULL AUTO_INCREMENT,
    `order_id`     bigint(11)          DEFAULT NULL,
    `order_status` varchar(11)         DEFAULT NULL,
    `operate_time` datetime            DEFAULT NULL,
    `create_time`  timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`  timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`   tinyint(3) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    KEY `idx_order_id` (`order_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='订单状态日志记录表';

#
# Data for table "order_status_log"
#

#
# Structure for table "order_track"
#

CREATE TABLE `order_track`
(
    `id`          int(11)    NOT NULL AUTO_INCREMENT COMMENT '编号',
    `order_id`    bigint(20)          DEFAULT NULL COMMENT '订单id',
    `driver_id`   bigint(20) NOT NULL DEFAULT '0' COMMENT '司机id',
    `customer_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '客户id',
    `longitude`   decimal(10, 7)      DEFAULT NULL COMMENT '经度',
    `latitude`    decimal(10, 7)      DEFAULT NULL COMMENT '纬度',
    `speed`       decimal(10, 2)      DEFAULT NULL COMMENT '速度',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    KEY `uniq_order_no` (`driver_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='订单追踪表';

#
# Data for table "order_track"
#


#
# Structure for table "undo_log"
#

CREATE TABLE `undo_log`
(
    `id`            bigint(20)   NOT NULL AUTO_INCREMENT,
    `branch_id`     bigint(20)   NOT NULL,
    `xid`           varchar(100) NOT NULL,
    `context`       varchar(128) NOT NULL,
    `rollback_info` longblob     NOT NULL,
    `log_status`    int(11)      NOT NULL,
    `log_created`   datetime     NOT NULL,
    `log_modified`  datetime     NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

#
# Data for table "undo_log"
#


#
# Database "daijia_payment"
#

CREATE DATABASE IF NOT EXISTS `daijia_payment`;
USE `daijia_payment`;

#
# Structure for table "payment_info"
#

CREATE TABLE `payment_info`
(
    `id`               int(11)     NOT NULL AUTO_INCREMENT COMMENT '编号',
    `customer_open_id` varchar(50)          DEFAULT NULL COMMENT '乘客微信openid',
    `driver_open_id`   varchar(50)          DEFAULT NULL COMMENT '司机微信openid',
    `order_no`         varchar(50) NOT NULL DEFAULT '0' COMMENT '订单号',
    `pay_way`          tinyint(3)  NOT NULL DEFAULT '0' COMMENT '付款方式：1-微信',
    `transaction_id`   varchar(50)          DEFAULT NULL COMMENT '微信支付订单号',
    `amount`           decimal(10, 2)       DEFAULT NULL COMMENT '支付金额',
    `content`          varchar(200)         DEFAULT NULL COMMENT '交易内容',
    `payment_status`   tinyint(3)           DEFAULT NULL COMMENT '支付状态：0-未支付 1-已支付',
    `callback_time`    datetime             DEFAULT NULL COMMENT '回调时间',
    `callback_content` text COMMENT '回调信息',
    `create_time`      timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`      timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`       tinyint(3)  NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_order_no` (`order_no`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='付款信息表';

#
# Data for table "payment_info"
#


#
# Structure for table "profitsharing_info"
#

CREATE TABLE `profitsharing_info`
(
    `id`              int(11)     NOT NULL AUTO_INCREMENT COMMENT '编号',
    `driver_id`       bigint(20)           DEFAULT NULL COMMENT '司机id',
    `order_no`        varchar(50) NOT NULL DEFAULT '0' COMMENT '订单号',
    `transaction_id`  varchar(50)          DEFAULT NULL COMMENT '微信支付订单号',
    `out_trade_no`    varchar(50)          DEFAULT NULL COMMENT '商户分账单号',
    `amount`          decimal(10, 2)       DEFAULT NULL COMMENT '司机分账金额',
    `state`           varchar(10)          DEFAULT NULL COMMENT '分账单状态 PROCESSING：处理中  FINISHED：分账完成',
    `respone_content` text COMMENT '返回信息',
    `create_time`     timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`     timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`      tinyint(3)  NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_order_no` (`order_no`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='分账信息表';

#
# Data for table "profitsharing_info"
#


#
# Structure for table "undo_log"
#

CREATE TABLE `undo_log`
(
    `id`            bigint(20)   NOT NULL AUTO_INCREMENT,
    `branch_id`     bigint(20)   NOT NULL,
    `xid`           varchar(100) NOT NULL,
    `context`       varchar(128) NOT NULL,
    `rollback_info` longblob     NOT NULL,
    `log_status`    int(11)      NOT NULL,
    `log_created`   datetime     NOT NULL,
    `log_modified`  datetime     NOT NULL,
    `ext`           varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

#
# Data for table "undo_log"
#


#
# Database "daijia_rule"
#

CREATE DATABASE IF NOT EXISTS `daijia_rule`;
USE `daijia_rule`;

#
# Structure for table "cancel_rule"
#

CREATE TABLE `cancel_rule`
(
    `id`          bigint(11)   NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`        varchar(200) NOT NULL COMMENT '规则名称',
    `rule`        text         NOT NULL COMMENT '规则代码',
    `status`      tinyint(4)   NOT NULL DEFAULT '2' COMMENT '状态代码，1有效，2关闭',
    `create_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_time` timestamp    NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3)   NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='订单取消规则表';

#
# Data for table "cancel_rule"
#


#
# Structure for table "fee_rule"
#

CREATE TABLE `fee_rule`
(
    `id`          bigint(11)   NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`        varchar(200) NOT NULL COMMENT '规则名称',
    `rule`        text         NOT NULL COMMENT '规则代码',
    `status`      tinyint(3)   NOT NULL DEFAULT '1' COMMENT '状态代码，1有效，2关闭',
    `create_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_time` timestamp    NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3)   NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='代驾费用规则表';

#
# Data for table "fee_rule"
#

#
# Structure for table "profitsharing_rule"
#

CREATE TABLE `profitsharing_rule`
(
    `id`          bigint(11)   NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`        varchar(200) NOT NULL COMMENT '规则名称',
    `rule`        text         NOT NULL COMMENT '规则代码',
    `status`      tinyint(4)   NOT NULL DEFAULT '2' COMMENT '状态代码，1有效，2关闭',
    `create_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_time` timestamp    NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3)   NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='分账规则表';

#
# Data for table "profitsharing_rule"
#

#
# Structure for table "reward_rule"
#

CREATE TABLE `reward_rule`
(
    `id`          bigint(11)   NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`        varchar(200) NOT NULL COMMENT '规则名称',
    `rule`        text         NOT NULL COMMENT '规则代码',
    `status`      tinyint(3)   NOT NULL DEFAULT '1' COMMENT '状态代码，1有效，2关闭',
    `create_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_time` timestamp    NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3)   NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='奖励规则表';

#
# Data for table "reward_rule"
#

#
# Structure for table "undo_log"
#

CREATE TABLE `undo_log`
(
    `id`            bigint(20)   NOT NULL AUTO_INCREMENT,
    `branch_id`     bigint(20)   NOT NULL,
    `xid`           varchar(100) NOT NULL,
    `context`       varchar(128) NOT NULL,
    `rollback_info` longblob     NOT NULL,
    `log_status`    int(11)      NOT NULL,
    `log_created`   datetime     NOT NULL,
    `log_modified`  datetime     NOT NULL,
    `ext`           varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

#
# Data for table "undo_log"
#


#
# Database "daijia_system"
#

CREATE DATABASE IF NOT EXISTS `daijia_system`;
USE `daijia_system`;

#
# Structure for table "sys_dept"
#

CREATE TABLE `sys_dept`
(
    `id`          bigint(20)  NOT NULL AUTO_INCREMENT,
    `name`        varchar(50) NOT NULL DEFAULT '' COMMENT '部门名称',
    `parent_id`   bigint(20)           DEFAULT '0' COMMENT '上级部门id',
    `tree_path`   varchar(255)         DEFAULT ',' COMMENT '树结构',
    `sort_value`  int(11)              DEFAULT '1' COMMENT '排序',
    `leader`      varchar(20)          DEFAULT NULL COMMENT '负责人',
    `phone`       varchar(11)          DEFAULT NULL COMMENT '电话',
    `status`      tinyint(1)           DEFAULT '1' COMMENT '状态（1正常 0停用）',
    `create_time` timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_time` timestamp   NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3)  NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 2020
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='组织机构';

#
# Data for table "sys_dept"
#

INSERT INTO `sys_dept`
VALUES (1, '硅谷集团有限公司', 0, ',1,', 1, '张老师', '15659090912', 1, '2022-05-24 16:13:13', '2023-06-06 15:49:37', 0),
       (10, '北京校区', 1, ',1,10,', 1, '李老师', '18790007789', 1, '2022-05-24 16:13:15', '2022-05-24 16:13:15', 0),
       (20, '上海校区', 1, ',1,20,', 1, '王老师', '15090987678', 1, '2022-05-25 14:02:25', '2022-05-25 14:02:25', 0),
       (30, '深圳校区', 1, ',1,30,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:24', '2022-05-25 14:02:24', 0),
       (1010, '教学部分', 10, ',1,10,1010,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:24', '2022-05-25 14:02:24', 0),
       (1020, '运营部门', 10, ',1,10,1020,', 1, '王老师', '15090987678', 1, '2022-05-25 14:02:29', '2022-05-25 14:02:29', 0),
       (1021, 'Java学科', 1010, ',1,10,1010,1021,', 1, '王老师', '15090987678', 1, '2022-05-24 16:13:31',
        '2022-05-24 16:13:31', 0),
       (1022, '大数据学科', 1010, ',1,10,1010,1022,', 1, '王老师', '15090987678', 1, '2022-05-25 14:02:22',
        '2022-05-25 14:02:22', 0),
       (1024, '前端学科', 1010, ',1,10,1010,1024,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:22',
        '2022-05-25 14:02:22', 0),
       (1025, '客服', 1020, ',1,10,1020,1025,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:23', '2022-05-25 14:02:23',
        0),
       (1026, '网站推广', 1020, ',1,10,1020,1026,', 1, '王老师', '15090987678', 1, '2023-04-21 11:24:00',
        '2023-04-21 11:24:00', 0),
       (1027, '线下运营', 1020, ',1,10,1020,1027,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:26',
        '2022-05-25 14:02:26', 0),
       (1028, '设计', 1020, ',1,10,1020,1028,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:27', '2022-05-25 14:02:27',
        0),
       (2012, '教学部门', 20, ',1,20,2012,', 1, '王老师', '18909890765', 1, '2022-05-24 16:13:51', '2022-05-24 16:13:51', 0),
       (2013, '教学部门', 30, ',1,30,2013,', 1, '李老师', '18567867895', 1, '2022-05-24 16:13:50', '2022-05-24 16:13:50', 0),
       (2016, 'Java学科', 2012, ',1,20,2012,2012,', 1, '张老师', '15090909909', 1, '2022-05-25 10:51:12',
        '2022-05-25 10:51:12', 0),
       (2017, '大数据学科', 2012, ',1,20,2012,2012,', 1, '李老师', '15090980989', 1, '2022-05-27 09:11:54', NULL, 0),
       (2018, '测试22', 1, ',1,1,', 1, '测试22', '12322', 1, '2022-05-24 16:13:13', '2023-05-27 09:40:03', 0),
       (2019, '测试2', 1, ',1,1,', 1, '测试2', '123', 1, '2023-05-27 09:39:47', '2023-05-27 09:39:47', 1);

#
# Structure for table "sys_login_log"
#

CREATE TABLE `sys_login_log`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
    `username`    varchar(50)         DEFAULT '' COMMENT '用户账号',
    `ipaddr`      varchar(128)        DEFAULT '' COMMENT '登录IP地址',
    `status`      tinyint(1)          DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
    `msg`         varchar(255)        DEFAULT '' COMMENT '提示信息',
    `access_time` datetime            DEFAULT NULL COMMENT '访问时间',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_time` timestamp  NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 14
  DEFAULT CHARSET = utf8 COMMENT ='系统访问记录';

#
# Data for table "sys_login_log"
#

INSERT INTO `sys_login_log`
VALUES (1, 'admin', '0:0:0:0:0:0:0:1', 1, '登录成功', NULL, '2022-06-10 11:24:14', NULL, 0),
       (2, 'admin', '127.0.0.1', 1, '登录成功', NULL, '2022-06-10 11:53:43', NULL, 0),
       (3, 'wanggang', '0:0:0:0:0:0:0:1', 1, '登录成功', NULL, '2023-04-21 11:29:37', NULL, 0),
       (4, 'admin', '117.173.208.179', 1, '登录成功', NULL, '2023-05-23 09:12:31', NULL, 0),
       (5, 'admin', '117.173.208.179', 1, '登录成功', NULL, '2023-05-23 09:12:44', NULL, 0),
       (6, 'admin', '117.173.208.179', 1, '登录成功', NULL, '2023-05-23 09:17:18', NULL, 0),
       (7, 'admin', '117.173.208.179', 1, '登录成功', NULL, '2023-05-23 09:23:58', NULL, 0),
       (8, 'admin', '117.173.208.179', 1, '登录成功', NULL, '2023-05-23 09:27:41', NULL, 0),
       (9, 'admin', '117.173.64.167', 1, '登录成功', NULL, '2023-05-31 11:10:50', NULL, 0),
       (10, 'admin', '117.173.64.167', 1, '登录成功', NULL, '2023-05-31 11:15:00', NULL, 0),
       (11, 'admin', '117.173.64.167', 1, '登录成功', NULL, '2023-05-31 11:21:41', NULL, 0),
       (12, 'admin', '154.9.225.83', 1, '登录成功', NULL, '2023-06-02 17:14:51', NULL, 0),
       (13, 'admin', '0:0:0:0:0:0:0:1', 1, '登录成功', NULL, '2023-10-08 10:34:50', NULL, 0);

#
# Structure for table "sys_menu"
#

CREATE TABLE `sys_menu`
(
    `id`          bigint(20)  NOT NULL AUTO_INCREMENT COMMENT '编号',
    `parent_id`   bigint(20)  NOT NULL DEFAULT '0' COMMENT '所属上级',
    `name`        varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
    `type`        tinyint(3)  NOT NULL DEFAULT '0' COMMENT '类型(0:目录,1:菜单,2:按钮)',
    `path`        varchar(100)         DEFAULT NULL COMMENT '路由地址',
    `component`   varchar(100)         DEFAULT NULL COMMENT '组件路径',
    `perms`       varchar(100)         DEFAULT NULL COMMENT '权限标识',
    `icon`        varchar(100)         DEFAULT NULL COMMENT '图标',
    `sort_value`  int(11)              DEFAULT NULL COMMENT '排序',
    `active_menu` varchar(255)         DEFAULT NULL COMMENT '高亮的 path',
    `is_hide`     tinyint(1)  NOT NULL DEFAULT '0',
    `status`      tinyint(4)           DEFAULT NULL COMMENT '状态(0:禁止,1:正常)',
    `create_time` timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`  tinyint(3)  NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`),
    KEY `idx_parent_id` (`parent_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 63
  DEFAULT CHARSET = utf8mb4 COMMENT ='菜单表';

#
# Data for table "sys_menu"
#

INSERT INTO `sys_menu`
VALUES (2, 0, '系统管理', 0, '/system/user', '', NULL, 'Setting', 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-31 11:26:20', 0),
       (3, 2, '用户管理', 1, '/system/user', '/system/user/user', '', 'UserFilled', 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-31 11:26:43', 0),
       (4, 2, '角色管理', 1, '/system/role', '/system/role/role', '', 'UserFilled', 2, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-31 11:26:55', 0),
       (5, 2, '菜单管理', 1, '/system/permission', '/system/permission/permission', '', 'Menu', 3, NULL, 0, 1,
        '2021-05-31 18:05:37', '2023-05-31 11:27:15', 0),
       (6, 3, '查看列表', 2, NULL, NULL, 'bnt.sysUser.list', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-31 11:33:44', 0),
       (7, 3, '添加', 2, NULL, NULL, 'bnt.sysUser.add', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37', '2023-05-26 15:09:18',
        0),
       (8, 3, '修改', 2, NULL, NULL, 'bnt.sysUser.update', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-26 15:09:18', 0),
       (9, 3, '删除', 2, NULL, NULL, 'bnt.sysUser.remove', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-26 15:09:19', 0),
       (10, 4, '查看列表', 2, NULL, NULL, 'bnt.sysRole.list', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-31 11:34:23', 0),
       (11, 4, '添加', 2, NULL, NULL, 'bnt.sysRole.add', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-26 15:09:20', 0),
       (12, 4, '修改', 2, NULL, NULL, 'bnt.sysRole.update', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-26 15:09:21', 0),
       (13, 4, '删除', 2, NULL, NULL, 'bnt.sysRole.remove', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-26 15:09:21', 0),
       (14, 5, '查看列表', 2, NULL, NULL, 'bnt.sysMenu.list', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-31 11:34:37', 0),
       (15, 5, '添加', 2, NULL, NULL, 'bnt.sysMenu.add', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-26 15:09:22', 0),
       (16, 5, '修改', 2, NULL, NULL, 'bnt.sysMenu.update', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-26 15:09:22', 0),
       (17, 5, '删除', 2, NULL, NULL, 'bnt.sysMenu.remove', NULL, 1, NULL, 0, 1, '2021-05-31 18:05:37',
        '2023-05-26 15:09:23', 0),
       (18, 3, '分配角色', 2, NULL, NULL, 'bnt.sysUser.assignRole', NULL, 1, NULL, 0, 1, '2022-05-23 17:14:32',
        '2023-05-31 17:05:15', 1),
       (19, 4, '分配权限', 2, 'assignAuth', 'system/sysRole/assignAuth', 'bnt.sysRole.assignAuth', NULL, 1, NULL, 1, 1,
        '2022-05-23 17:18:14', '2023-05-31 16:15:36', 1),
       (20, 2, '部门管理', 1, '/system/department', '/system/department/department', '', 'Menu', 4, NULL, 0, 1,
        '2022-05-24 10:07:05', '2023-05-31 11:27:52', 0),
       (21, 20, '查看列表', 2, NULL, NULL, 'bnt.sysDept.list', NULL, 1, NULL, 0, 1, '2022-05-24 10:07:44',
        '2023-05-31 11:34:47', 0),
       (22, 2, '岗位管理', 1, '/system/post', '/system/post/post', '', 'Menu', 5, NULL, 0, 1, '2022-05-24 10:25:30',
        '2023-05-31 11:28:07', 0),
       (23, 22, '查看列表', 2, NULL, NULL, 'bnt.sysPost.list', NULL, 1, NULL, 0, 1, '2022-05-24 10:25:45',
        '2023-05-31 11:35:00', 0),
       (24, 20, '添加', 2, NULL, NULL, 'bnt.sysDept.add', NULL, 1, NULL, 0, 1, '2022-05-25 15:31:27',
        '2023-05-26 15:09:26', 0),
       (25, 20, '修改', 2, NULL, NULL, 'bnt.sysDept.update', NULL, 1, NULL, 0, 1, '2022-05-25 15:31:41',
        '2023-05-26 15:09:26', 0),
       (26, 20, '删除', 2, NULL, NULL, 'bnt.sysDept.remove', NULL, 1, NULL, 0, 1, '2022-05-25 15:31:59',
        '2023-05-26 15:09:27', 0),
       (27, 22, '添加', 2, NULL, NULL, 'bnt.sysPost.add', NULL, 1, NULL, 0, 1, '2022-05-25 15:32:44',
        '2023-05-26 15:09:27', 0),
       (28, 22, '修改', 2, NULL, NULL, 'bnt.sysPost.update', NULL, 1, NULL, 0, 1, '2022-05-25 15:32:58',
        '2023-05-26 15:09:27', 0),
       (29, 22, '删除', 2, NULL, NULL, 'bnt.sysPost.remove', NULL, 1, NULL, 0, 1, '2022-05-25 15:33:11',
        '2023-05-26 15:09:28', 0),
       (30, 34, '操作日志', 1, '/system/log/operationLog', '/system/log/operationLog/operationLog', '', 'DocumentRemove', 7,
        NULL, 0, 1, '2022-05-26 16:09:59', '2023-05-31 11:28:52', 0),
       (31, 30, '查看列表', 2, NULL, NULL, 'bnt.sysOperLog.list', NULL, 1, NULL, 0, 1, '2022-05-26 16:10:17',
        '2023-05-31 11:35:13', 0),
       (32, 34, '登录日志', 1, '/system/log/loginLog', '/system/log/loginLog/loginLog', '', 'DocumentRemove', 8, NULL, 0, 1,
        '2022-05-26 16:36:13', '2023-05-31 11:29:03', 0),
       (33, 32, '查看列表', 2, NULL, NULL, 'bnt.sysLoginLog.list', NULL, 1, NULL, 0, 1, '2022-05-26 16:36:31',
        '2023-05-31 11:35:21', 0),
       (34, 2, '日志管理', 0, '/system/log', '/system/log/operationLog', '', 'Document', 6, NULL, 0, 1,
        '2022-05-31 13:23:07', '2023-05-31 11:28:35', 0),
       (36, 2, '测试', 2, NULL, NULL, 'ces', NULL, 1, NULL, 0, 1, '2023-05-26 17:27:53', '2023-05-26 17:41:40', 1),
       (37, 2, '测试', 2, NULL, NULL, 'ces', NULL, 1, NULL, 0, 1, '2023-05-26 17:30:40', '2023-05-26 17:42:06', 1),
       (38, 2, 'bnt.sysUser.list', 2, NULL, NULL, 'bnt.sysUser.list', NULL, 1, NULL, 0, 1, '2023-05-26 17:32:30',
        '2023-05-26 17:42:11', 1),
       (39, 4, 'ces', 0, NULL, 'ces1', NULL, NULL, 1, NULL, 0, 1, '2023-05-26 17:33:36', '2023-05-31 08:56:51', 1),
       (40, 0, 'ces', 0, 'ce', 'ce', NULL, 'Aim', 1, 'ce', 0, 1, '2023-05-26 17:41:53', '2023-05-31 08:44:32', 1),
       (41, 3, '分配角色', 2, NULL, NULL, 'bnt.sysUser.assignRole', NULL, 1, NULL, 0, 1, '2023-05-31 11:38:14',
        '2023-05-31 17:04:06', 0),
       (42, 4, '分配权限', 2, NULL, NULL, 'bnt.sysRole.assignAuth', NULL, 1, NULL, 0, 1, '2023-05-31 11:40:30',
        '2023-05-31 16:16:00', 0),
       (43, 4, '测试', 2, NULL, NULL, '测试', NULL, 1, NULL, 0, 1, '2023-05-31 11:43:59', '2023-05-31 11:44:42', 1),
       (44, 4, '分配测试', 2, NULL, NULL, 'bnt.sysRole.demo', NULL, 1, NULL, 0, 1, '2023-05-31 11:45:01',
        '2023-05-31 11:45:11', 1),
       (45, 0, '专辑管理', 0, '/album/albumList', NULL, NULL, 'Film', 1, NULL, 0, 1, '2023-05-31 13:59:44',
        '2023-05-31 13:59:44', 0),
       (46, 45, '专辑列表', 1, '/album/albumList', '/album/albumList/albumList', NULL, 'List', 1, NULL, 0, 1,
        '2023-05-31 14:01:32', '2023-05-31 14:01:32', 0),
       (47, 46, '专辑详情', 2, '/album/showAlbumDetails', '/album/albumList/showAlbumDetails', 'bnt.album.viewDetail',
        'Document', 1, '/album/albumList', 1, 1, '2023-05-31 14:03:35', '2023-05-31 14:23:53', 0),
       (48, 46, '查看专辑详情', 2, NULL, NULL, 'bnt.sysUser.viewDetail', NULL, 1, NULL, 0, 1, '2023-05-31 14:13:22',
        '2023-05-31 14:25:01', 1),
       (49, 46, '通过/不通过', 2, NULL, NULL, 'bnt.album.passAndNotPass', NULL, 1, NULL, 0, 1, '2023-05-31 14:26:10',
        '2023-05-31 14:26:10', 0),
       (50, 0, '订单管理', 0, '/order/orderList', '', NULL, 'DocumentCopy', 1, NULL, 0, 1, '2023-05-31 14:27:33',
        '2023-05-31 14:46:50', 0),
       (51, 50, '订单列表', 0, '/order/orderList', '/order/orderList/orderList', NULL, 'List', 1, NULL, 0, 1,
        '2023-05-31 14:43:50', '2023-05-31 18:18:32', 0),
       (52, 51, '订单详情', 2, '/order/showOrderDetails', '/order/orderList/showOrderDetails', 'bnt.order.viewOrderDetail',
        NULL, 1, NULL, 1, 1, '2023-05-31 14:45:04', '2023-05-31 14:45:04', 0),
       (53, 0, '会员管理', 0, '/member/memberList', '', NULL, 'UserFilled', 1, NULL, 0, 1, '2023-05-31 14:46:13',
        '2023-06-03 18:14:58', 0),
       (54, 53, '会员列表', 1, '/member/memberList', '/member/memberList/memberList', NULL, 'UserFilled', 1, NULL, 0, 1,
        '2023-05-31 14:47:31', '2023-05-31 14:47:31', 0),
       (55, 45, '声音管理', 0, '/album/trackList', '/album/trackList/trackList', NULL, 'Headset', 1, NULL, 0, 1,
        '2023-05-31 14:53:48', '2023-05-31 14:57:43', 0),
       (56, 55, '声音列表', 1, '/album/trackList', '/album/trackList/trackList', NULL, 'Headset', 1, NULL, 0, 1,
        '2023-05-31 14:54:16', '2023-05-31 14:54:16', 0),
       (57, 55, '声音详情', 2, '/album/showTrackDetails', '/album/trackList/showTrackDetails', 'bnt.track.viewTrackDetail',
        NULL, 1, '/album/trackList', 1, 1, '2023-05-31 14:55:53', '2023-05-31 19:14:51', 1),
       (58, 45, '分类管理', 1, '/album/category', '/album/category/category', NULL, 'Menu', 1, NULL, 0, 1,
        '2023-05-31 14:59:23', '2023-05-31 14:59:55', 0),
       (59, 45, '分类属性管理', 1, '/album/categoryAttribute', '/album/categoryAttribute/categoryAttribute', NULL, 'Grid', 1,
        NULL, 0, 1, '2023-05-31 15:00:27', '2023-05-31 15:00:27', 0),
       (60, 51, 'ces', 2, NULL, NULL, 'ces', NULL, 1, NULL, 0, 1, '2023-05-31 18:15:44', '2023-05-31 18:39:38', 1),
       (61, 56, '通过/不通过', 2, NULL, '', 'bnt.track.passAndNotPass', NULL, 1, '', 0, 1, '2023-05-31 19:13:21',
        '2023-05-31 19:13:52', 0),
       (62, 56, '声音详情', 2, '/album/showTrackDetails', '/album/trackList/showTrackDetails', 'bnt.track.viewTrackDetail',
        NULL, 1, '/album/trackList', 1, 1, '2023-05-31 19:14:42', '2023-05-31 19:14:42', 0);

#
# Structure for table "sys_oper_log"
#

CREATE TABLE `sys_oper_log`
(
    `id`             bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
    `title`          varchar(50)         DEFAULT '' COMMENT '模块标题',
    `business_type`  varchar(20)         DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
    `method`         varchar(100)        DEFAULT '' COMMENT '方法名称',
    `request_method` varchar(10)         DEFAULT '' COMMENT '请求方式',
    `operator_type`  varchar(20)         DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
    `oper_name`      varchar(50)         DEFAULT '' COMMENT '操作人员',
    `dept_name`      varchar(50)         DEFAULT '' COMMENT '部门名称',
    `oper_url`       varchar(255)        DEFAULT '' COMMENT '请求URL',
    `oper_ip`        varchar(128)        DEFAULT '' COMMENT '主机地址',
    `oper_param`     varchar(2000)       DEFAULT '' COMMENT '请求参数',
    `json_result`    varchar(2000)       DEFAULT '' COMMENT '返回参数',
    `status`         int(1)              DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
    `error_msg`      varchar(2000)       DEFAULT '' COMMENT '错误消息',
    `oper_time`      datetime            DEFAULT NULL COMMENT '操作时间',
    `create_time`    timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_time`    timestamp  NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`     tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 268
  DEFAULT CHARSET = utf8 COMMENT ='操作日志记录';

#
# Data for table "sys_oper_log"
#

INSERT INTO `sys_oper_log`
VALUES (1, '角色管理', '1', 'com.yang.auth.controller.SysRoleController.save()', 'POST', '1', 'admin', '',
        '/admin/auth/sysRole/save', '', '{\"param\":{},\"roleCode\":\"\",\"roleName\":\"test\",\"id\":5}',
        '{\"code\":200,\"message\":\"成功\"}', 0, '', NULL, '2022-05-26 15:59:44', NULL, 0),
       (2, '角色管理', 'DELETE', 'com.yang.auth.controller.SysRoleController.remove()', 'DELETE', 'MANAGE', 'admin', '',
        '/admin/auth/sysRole/remove/5', '', '', '{\"code\":200,\"message\":\"成功\"}', 0, '', NULL, '2022-05-26 16:05:27',
        NULL, 0),
       (3, '角色管理', 'DELETE', 'com.yang.auth.controller.SysRoleController.remove()', 'DELETE', 'MANAGE', 'admin', '',
        '/admin/auth/sysRole/remove/4', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL,
        '2022-05-26 16:52:40', NULL, 0),
       (4, '角色管理', 'UPDATE', 'com.yang.auth.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin', '',
        '/admin/auth/sysRole/update', '127.0.0.1',
        '{\"isDeleted\":0,\"createTime\":1622507920000,\"param\":{},\"roleCode\":\"\",\"roleName\":\"普通管理员\",\"description\":\"普通管理员\",\"updateTime\":1645670566000,\"id\":2}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 08:47:54', NULL, 0),
       (5, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '',
        '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"SysRole\",\"select\":false,\"level\":3,\"updateTime\":1653287810000,\"type\":1,\"parentId\":2,\"isDeleted\":0,\"children\":[{\"code\":\"btn.SysRole.list\",\"select\":false,\"level\":4,\"updateTime\":1622460772000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"id\":10},{\"code\":\"btn.SysRole.add\",\"select\":false,\"level\":4,\"updateTime\":1653547976000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"id\":11},{\"code\":\"btn.SysRole.update\",\"select\":false,\"level\":4,\"updateTime\":1653547981000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"id\":12},{\"code\":\"btn.SysRole.remove\",\"select\":false,\"level\":4,\"updateTime\":1622507874000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"id\":13},{\"code\":\"btn.SysRole.assignAuth\",\"select\":false,\"level\":4,\"toCode\":\"AssignAuth\",\"updateTime\":1653376735000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"id\":19}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"id\":4}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 08:48:08', NULL, 0),
       (6, '岗位管理', 'UPDATE', 'com.yang.auth.controller.SysPostController.updateById()', 'PUT', 'MANAGE', 'admin', '',
        '/admin/auth/sysPost/update', '127.0.0.1',
        '{\"isDeleted\":0,\"createTime\":1653359648000,\"param\":{},\"name\":\"总经理\",\"description\":\"2\",\"postCode\":\"zjl\",\"id\":6,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 08:56:29', NULL, 0),
       (7, '岗位管理', 'INSERT', 'com.yang.auth.controller.SysPostController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/auth/sysPost/save', '127.0.0.1',
        '{\"param\":{},\"name\":\"网咨\",\"description\":\"\",\"postCode\":\"wz\",\"id\":7,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 08:56:37', NULL, 0),
       (8, '岗位管理', 'DELETE', 'com.yang.auth.controller.SysPostController.remove()', 'DELETE', 'MANAGE', 'admin', '',
        '/admin/auth/sysPost/remove/7', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL,
        '2022-05-27 08:56:41', NULL, 0),
       (9, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '',
        '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"btn.sysDept.list\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653358064000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"id\":21}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:02:49', NULL, 0),
       (10, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"btn.sysDept.add\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653463887000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"id\":24}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:02:55', NULL, 0),
       (11, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"btn.sysDept.update\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653463901000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"id\":25}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:03:01', NULL, 0),
       (12, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"btn.sysDept.remove\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653463919000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"id\":26}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:03:07', NULL, 0),
       (13, '部门管理', 'UPDATE', 'com.yang.auth.controller.SysDeptController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysDept/update', '127.0.0.1',
        '{\"leader\":\"张老师\",\"updateTime\":1653447072000,\"parentId\":2012,\"sortValue\":1,\"isDeleted\":0,\"createTime\":1653447072000,\"param\":{},\"phone\":\"15090909909\",\"name\":\"Java学科\",\"id\":2016,\"treePath\":\",1,20,2012,2012,\",\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:11:28', NULL, 0),
       (14, '部门管理', 'INSERT', 'com.yang.auth.controller.SysDeptController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/auth/sysDept/save', '127.0.0.1',
        '{\"leader\":\"李老师\",\"parentId\":2012,\"param\":{},\"phone\":\"15090980989\",\"name\":\"大数据学科\",\"id\":2017,\"treePath\":\",1,20,2012,2012,\"}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:11:54', NULL, 0),
       (15, '部门管理', 'UPDATE', 'com.yang.auth.controller.SysDeptController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysDept/update', '127.0.0.1',
        '{\"leader\":\"李老师\",\"parentId\":2012,\"sortValue\":1,\"isDeleted\":0,\"createTime\":1653613914000,\"param\":{},\"phone\":\"15090980989\",\"name\":\"大数据学科\",\"id\":2017,\"treePath\":\",1,20,2012,2012,\",\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:16:38', NULL, 0),
       (16, '角色管理', 'UPDATE', 'com.yang.auth.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysRole/update', '127.0.0.1',
        '{\"isDeleted\":0,\"createTime\":1622507920000,\"param\":{},\"roleCode\":\"COMMON\",\"roleName\":\"普通管理员\",\"description\":\"普通管理员\",\"updateTime\":1645670566000,\"id\":2}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:28:15', NULL, 0),
       (17, '角色管理', 'INSERT', 'com.yang.auth.controller.SysRoleController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/auth/sysRole/save', '127.0.0.1', '{\"param\":{},\"roleCode\":\"\",\"roleName\":\"用户管理员\",\"id\":6}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 10:42:18', NULL, 0),
       (18, '角色管理', 'UPDATE', 'com.yang.auth.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysRole/update', '127.0.0.1',
        '{\"isDeleted\":0,\"createTime\":1653619337000,\"param\":{},\"roleCode\":\"\",\"roleName\":\"用户管理员\",\"updateTime\":1653619337000,\"id\":6}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 10:43:59', NULL, 0),
       (19, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysUser\",\"select\":false,\"level\":3,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysUser/list\",\"sortValue\":1,\"component\":\"auth/sysUser/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysUser.list\",\"select\":false,\"level\":4,\"updateTime\":1653957062000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"id\":6,\"status\":1},{\"code\":\"bnt.sysUser.add\",\"select\":false,\"level\":4,\"updateTime\":1653957062000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"id\":7,\"status\":1},{\"code\":\"bnt.sysUser.update\",\"select\":false,\"level\":4,\"updateTime\":1653957062000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"id\":8,\"status\":1},{\"code\":\"bnt.sysUser.remove\",\"select\":false,\"level\":4,\"updateTime\":1653957062000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"id\":9,\"status\":1},{\"code\":\"bnt.sysUser.assignRole\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1653297272000,\"param\":{},\"name\":\"分配角色\",\"id\":18,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"用户管理\",\"perms\":\"bnt.sysUser.list\",\"id\":3,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:14:26', NULL, 0),
       (20, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysRole\",\"select\":false,\"level\":3,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysRole/list\",\"sortValue\":0,\"component\":\"auth/sysRole/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysRole.list\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysRole.list\",\"id\":10,\"status\":1},{\"code\":\"bnt.sysRole.add\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysRole.add\",\"id\":11,\"status\":1},{\"code\":\"bnt.sysRole.update\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysRole.update\",\"id\":12,\"status\":1},{\"code\":\"bnt.sysRole.remove\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysRole.remove\",\"id\":13,\"status\":1},{\"code\":\"bnt.sysRole.assignAuth\",\"select\":false,\"level\":4,\"toCode\":\"assignAuth\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"perms\":\" bnt.sysRole.list\",\"id\":4,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:18:12', NULL, 0),
       (21, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysMenu\",\"select\":false,\"level\":3,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysMenu/list\",\"sortValue\":0,\"component\":\"auth/sysMenu/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysMenu.list\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysMenu.list\",\"id\":14,\"status\":1},{\"code\":\"bnt.sysMenu.add\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysMenu.add\",\"id\":15,\"status\":1},{\"code\":\"bnt.sysMenu.update\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysMenu.update\",\"id\":16,\"status\":1},{\"code\":\"bnt.sysMenu.remove\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysMenu.remove\",\"id\":17,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"菜单管理\",\"perms\":\"bnt.sysMenu.list\",\"id\":5,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:18:37', NULL, 0),
       (22, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysDept\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysDept/list\",\"sortValue\":0,\"component\":\"auth/sysDept/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysDept.list\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.list\",\"id\":21,\"status\":1},{\"code\":\"bnt.sysDept.add\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysDept.add\",\"id\":24,\"status\":1},{\"code\":\"bnt.sysDept.update\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysDept.update\",\"id\":25,\"status\":1},{\"code\":\"bnt.sysDept.remove\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysDept.remove\",\"id\":26,\"status\":1}],\"createTime\":1653358025000,\"param\":{},\"name\":\"部门管理\",\"perms\":\"bnt.sysDept.list\",\"id\":20,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:19:04', NULL, 0),
       (23, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysPost\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysPost/list\",\"sortValue\":0,\"component\":\"auth/sysPost/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysPost.list\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653359145000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysPost.list\",\"id\":23,\"status\":1},{\"code\":\"bnt.sysPost.add\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463964000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysPost.add\",\"id\":27,\"status\":1},{\"code\":\"bnt.sysPost.update\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463978000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysPost.update\",\"id\":28,\"status\":1},{\"code\":\"bnt.sysPost.remove\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463991000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysPost.remove\",\"id\":29,\"status\":1}],\"createTime\":1653359130000,\"param\":{},\"name\":\"岗位管理\",\"perms\":\"bnt.sysPost.list\",\"id\":22,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:19:23', NULL, 0),
       (24, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysOperLog\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysOperLog/list\",\"sortValue\":0,\"component\":\"auth/sysOperLog/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysOperLog.list\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":30,\"isDeleted\":0,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"bnt.sysOperLog.list\",\"id\":30,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:19:40', NULL, 0),
       (25, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysLoginLog\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysLoginLog/list\",\"sortValue\":0,\"component\":\"auth/sysLoginLog/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysLoginLog.list\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":32,\"isDeleted\":0,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\" bnt.sysLoginLog.list\",\"id\":32,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:20:09', NULL, 0),
       (26, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysUser\",\"select\":false,\"level\":2,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysUser\",\"sortValue\":1,\"component\":\"auth/sysUser/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysUser.list\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysUser.list\",\"id\":6,\"status\":1},{\"code\":\"bnt.sysUser.add\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysUser.add\",\"id\":7,\"status\":1},{\"code\":\"bnt.sysUser.update\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysUser.update\",\"id\":8,\"status\":1},{\"code\":\"bnt.sysUser.remove\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysUser.remove\",\"id\":9,\"status\":1},{\"code\":\"bnt.sysUser.assignRole\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1653297272000,\"param\":{},\"name\":\"分配角色\",\"perms\":\"bnt.sysUser.assignRole\",\"id\":18,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"用户管理\",\"perms\":\"bnt.sysUser.list\",\"id\":3,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:41:35', NULL, 0),
       (27, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysRole\",\"select\":false,\"level\":2,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysRole\",\"sortValue\":0,\"component\":\"auth/sysRole/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysRole.list\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysRole.list\",\"id\":10,\"status\":1},{\"code\":\"bnt.sysRole.add\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysRole.add\",\"id\":11,\"status\":1},{\"code\":\"bnt.sysRole.update\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysRole.update\",\"id\":12,\"status\":1},{\"code\":\"bnt.sysRole.remove\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysRole.remove\",\"id\":13,\"status\":1},{\"code\":\"bnt.sysRole.assignAuth\",\"select\":false,\"level\":3,\"toCode\":\"assignAuth\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"perms\":\" bnt.sysRole.list\",\"id\":4,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:41:42', NULL, 0),
       (28, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysMenu\",\"select\":false,\"level\":2,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysMenu\",\"sortValue\":0,\"component\":\"auth/sysMenu/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysMenu.list\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysMenu.list\",\"id\":14,\"status\":1},{\"code\":\"bnt.sysMenu.add\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysMenu.add\",\"id\":15,\"status\":1},{\"code\":\"bnt.sysMenu.update\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysMenu.update\",\"id\":16,\"status\":1},{\"code\":\"bnt.sysMenu.remove\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysMenu.remove\",\"id\":17,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"菜单管理\",\"perms\":\"bnt.sysMenu.list\",\"id\":5,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:41:51', NULL, 0),
       (29, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysDept\",\"select\":false,\"level\":2,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysDept\",\"sortValue\":0,\"component\":\"auth/sysDept/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysDept.list\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.list\",\"id\":21,\"status\":1},{\"code\":\"bnt.sysDept.add\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysDept.add\",\"id\":24,\"status\":1},{\"code\":\"bnt.sysDept.update\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysDept.update\",\"id\":25,\"status\":1},{\"code\":\"bnt.sysDept.remove\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysDept.remove\",\"id\":26,\"status\":1}],\"createTime\":1653358025000,\"param\":{},\"name\":\"部门管理\",\"perms\":\"bnt.sysDept.list\",\"id\":20,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:41:58', NULL, 0),
       (30, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysPost\",\"select\":false,\"level\":2,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysPost\",\"sortValue\":0,\"component\":\"auth/sysPost/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysPost.list\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653359145000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysPost.list\",\"id\":23,\"status\":1},{\"code\":\"bnt.sysPost.add\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463964000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysPost.add\",\"id\":27,\"status\":1},{\"code\":\"bnt.sysPost.update\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463978000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysPost.update\",\"id\":28,\"status\":1},{\"code\":\"bnt.sysPost.remove\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463991000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysPost.remove\",\"id\":29,\"status\":1}],\"createTime\":1653359130000,\"param\":{},\"name\":\"岗位管理\",\"perms\":\"bnt.sysPost.list\",\"id\":22,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:42:04', NULL, 0),
       (31, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysOperLog\",\"select\":false,\"level\":2,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysOperLog\",\"sortValue\":0,\"component\":\"auth/sysOperLog/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysOperLog.list\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":30,\"isDeleted\":0,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"bnt.sysOperLog.list\",\"id\":30,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:42:09', NULL, 0),
       (32, '菜单管理', 'UPDATE', 'com.yang.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/auth/sysMenu/update', '127.0.0.1',
        '{\"code\":\"sysLoginLog\",\"select\":false,\"level\":2,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysLoginLog\",\"sortValue\":0,\"component\":\"auth/sysLoginLog/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysLoginLog.list\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":32,\"isDeleted\":0,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\" bnt.sysLoginLog.list\",\"id\":32,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:42:15', NULL, 0),
       (33, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"icon\":\"\",\"type\":0,\"parentId\":2,\"path\":\"log\",\"sortValue\":1,\"component\":\"\",\"param\":{},\"name\":\"日志管理\",\"perms\":\"\",\"id\":34,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 13:23:07', NULL, 0),
       (34, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"visible\":1,\"icon\":\"\",\"type\":0,\"parentId\":0,\"path\":\"order\",\"sortValue\":1,\"component\":\"Layout\",\"param\":{},\"name\":\"订单管理\",\"perms\":\"\",\"id\":35,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 13:57:50', NULL, 0),
       (35, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"visible\":1,\"icon\":\"\",\"type\":1,\"parentId\":35,\"path\":\"orderInfo\",\"sortValue\":1,\"component\":\"order/orderInfo/list\",\"param\":{},\"name\":\"订单列表\",\"perms\":\"bnt.orderInfo.list\",\"id\":36,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 13:58:37', NULL, 0),
       (36, '岗位管理', 'INSERT', 'com.yang.system.controller.SysPostController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysPost/save', '127.0.0.1',
        '{\"param\":{},\"name\":\"运营总监\",\"description\":\"\",\"postCode\":\"yyzj\",\"id\":8,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-08 17:14:21', NULL, 0),
       (37, '角色管理', 'INSERT', 'com.yang.system.controller.SysRoleController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysRole/save', '127.0.0.1', '{\"param\":{},\"roleCode\":\"\",\"roleName\":\"\",\"id\":8}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-08 17:39:04', NULL, 0),
       (38, '角色管理', 'UPDATE', 'com.yang.system.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysRole/update', '127.0.0.1',
        '{\"isDeleted\":0,\"createTime\":1654681144000,\"param\":{},\"roleCode\":\"\",\"roleName\":\"\",\"updateTime\":1654681144000,\"id\":8}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-08 17:39:08', NULL, 0),
       (39, '角色管理', 'UPDATE', 'com.yang.system.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysRole/update', '127.0.0.1',
        '{\"isDeleted\":0,\"createTime\":1654681144000,\"param\":{},\"roleCode\":\"\",\"roleName\":\"\",\"updateTime\":1654681144000,\"id\":8}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-08 17:39:41', NULL, 0),
       (40, '角色管理', 'UPDATE', 'com.yang.system.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysRole/update', '127.0.0.1',
        '{\"isDeleted\":0,\"createTime\":1654681144000,\"param\":{},\"roleCode\":\"yhgly\",\"roleName\":\"用户管理员\",\"updateTime\":1654681144000,\"id\":8}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-08 17:42:46', NULL, 0),
       (41, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-phone\",\"type\":0,\"parentId\":0,\"path\":\"order\",\"sortValue\":1,\"component\":\"Layout\",\"param\":{},\"name\":\"订单管理\",\"perms\":\"\",\"id\":35,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:50:13', NULL, 0),
       (42, '菜单管理', 'UPDATE', 'com.yang.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/update', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-phone\",\"updateTime\":1654735813000,\"type\":0,\"parentId\":0,\"path\":\"order\",\"sortValue\":1,\"component\":\"Layout\",\"isDeleted\":0,\"children\":[],\"createTime\":1654735813000,\"param\":{},\"name\":\"订单管理\",\"perms\":\"\",\"id\":35,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:50:22', NULL, 0),
       (43, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-s-help\",\"type\":1,\"parentId\":35,\"path\":\"orderInfo\",\"sortValue\":1,\"component\":\"order/orderInfo/list\",\"param\":{},\"name\":\"订单列表\",\"perms\":\"bnt.orderInfo.list\",\"id\":36,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:51:22', NULL, 0),
       (44, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"icon\":\"\",\"type\":2,\"parentId\":36,\"path\":\"\",\"sortValue\":1,\"component\":\"\",\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.add\",\"id\":37,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:52:37', NULL, 0),
       (45, '菜单管理', 'DELETE', 'com.yang.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/remove/37', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL,
        '2022-06-09 08:53:01', NULL, 0),
       (46, '菜单管理', 'DELETE', 'com.yang.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/remove/36', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL,
        '2022-06-09 08:53:04', NULL, 0),
       (47, '菜单管理', 'DELETE', 'com.yang.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/remove/35', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL,
        '2022-06-09 08:53:06', NULL, 0),
       (48, '菜单管理', 'UPDATE', 'com.yang.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/update', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-s-custom\",\"updateTime\":1654737767000,\"type\":1,\"parentId\":2,\"path\":\"sysUser\",\"sortValue\":1,\"component\":\"system/sysUser/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":3,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysUser.list\",\"id\":6,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":3,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysUser.add\",\"id\":7,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":3,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysUser.update\",\"id\":8,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":3,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysUser.remove\",\"id\":9,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":3,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653297272000,\"param\":{},\"name\":\"分配角色\",\"perms\":\"bnt.sysUser.assignRole\",\"id\":18,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"用户管理\",\"perms\":\"\",\"id\":3,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:01', NULL, 0),
       (49, '菜单管理', 'UPDATE', 'com.yang.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/update', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-user-solid\",\"updateTime\":1654737768000,\"type\":1,\"parentId\":2,\"path\":\"sysRole\",\"sortValue\":1,\"component\":\"system/sysRole/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysRole.list\",\"id\":10,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysRole.add\",\"id\":11,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysRole.update\",\"id\":12,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysRole.remove\",\"id\":13,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"path\":\"\",\"sortValue\":1,\"component\":\"\",\"isDeleted\":0,\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"perms\":\"\",\"id\":4,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:10', NULL, 0),
       (50, '菜单管理', 'UPDATE', 'com.yang.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/update', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-s-unfold\",\"updateTime\":1654737769000,\"type\":1,\"parentId\":2,\"path\":\"sysMenu\",\"sortValue\":1,\"component\":\"system/sysMenu/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":5,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysMenu.list\",\"id\":14,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":5,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysMenu.add\",\"id\":15,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":5,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysMenu.update\",\"id\":16,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":5,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysMenu.remove\",\"id\":17,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"菜单管理\",\"perms\":\"\",\"id\":5,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:21', NULL, 0),
       (51, '菜单管理', 'UPDATE', 'com.yang.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/update', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-s-operation\",\"updateTime\":1654737776000,\"type\":1,\"parentId\":2,\"path\":\"sysDept\",\"sortValue\":1,\"component\":\"system/sysDept/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":20,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.list\",\"id\":21,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":20,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysDept.add\",\"id\":24,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":20,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysDept.update\",\"id\":25,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":20,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysDept.remove\",\"id\":26,\"status\":1}],\"createTime\":1653358025000,\"param\":{},\"name\":\"部门管理\",\"perms\":\"\",\"id\":20,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:28', NULL, 0),
       (52, '菜单管理', 'UPDATE', 'com.yang.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/update', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-more-outline\",\"updateTime\":1654737777000,\"type\":1,\"parentId\":2,\"path\":\"sysPost\",\"sortValue\":1,\"component\":\"system/sysPost/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":22,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653359145000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysPost.list\",\"id\":23,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":22,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463964000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysPost.add\",\"id\":27,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":22,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463978000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysPost.update\",\"id\":28,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":22,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463991000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysPost.remove\",\"id\":29,\"status\":1}],\"createTime\":1653359130000,\"param\":{},\"name\":\"岗位管理\",\"perms\":\"\",\"id\":22,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:35', NULL, 0),
       (53, '菜单管理', 'UPDATE', 'com.yang.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/update', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-tickets\",\"updateTime\":1653974966000,\"type\":0,\"parentId\":2,\"path\":\"log\",\"sortValue\":1,\"component\":\"ParentView\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737785000,\"type\":1,\"parentId\":34,\"path\":\"sysOperLog\",\"sortValue\":1,\"component\":\"system/sysOperLog/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":30,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"\",\"id\":30,\"status\":1},{\"select\":false,\"updateTime\":1654737787000,\"type\":1,\"parentId\":34,\"path\":\"sysLoginLog\",\"sortValue\":1,\"component\":\"system/sysLoginLog/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":32,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\"\",\"id\":32,\"status\":1}],\"createTime\":1653974587000,\"param\":{},\"name\":\"日志管理\",\"perms\":\"\",\"id\":34,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:46', NULL, 0),
       (54, '菜单管理', 'UPDATE', 'com.yang.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/update', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-document-remove\",\"updateTime\":1654737785000,\"type\":1,\"parentId\":34,\"path\":\"sysOperLog\",\"sortValue\":1,\"component\":\"system/sysOperLog/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":30,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"\",\"id\":30,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:55', NULL, 0),
       (55, '菜单管理', 'UPDATE', 'com.yang.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/update', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-s-goods\",\"updateTime\":1654737787000,\"type\":1,\"parentId\":34,\"path\":\"sysLoginLog\",\"sortValue\":1,\"component\":\"system/sysLoginLog/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":32,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\"\",\"id\":32,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:25:07', NULL, 0),
       (56, '用户管理', 'DELETE', 'com.yang.system.controller.SysUserController.remove()', 'DELETE', 'MANAGE', 'admin',
        '', '/admin/system/sysUser/remove/4', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL,
        '2022-06-09 09:25:21', NULL, 0),
       (57, '菜单管理', 'UPDATE', 'com.yang.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/update', '127.0.0.1',
        '{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"path\":\"assignAuth\",\"sortValue\":1,\"component\":\"system/sysRole/assignAuth\",\"isDeleted\":0,\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:26:07', NULL, 0),
       (58, '角色管理', 'ASSGIN', 'com.yang.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE', 'admin',
        '', '/admin/system/sysMenu/doAssign', '127.0.0.1', '{\"roleId\":2,\"menuIdList\":[2,3,6,7,8,5,14,20,21]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:26:34', NULL, 0),
       (59, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-s-help\",\"type\":0,\"parentId\":0,\"path\":\"vod\",\"sortValue\":1,\"component\":\"Layout\",\"param\":{},\"name\":\"点播管理\",\"perms\":\"\",\"id\":35,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-10 15:26:53', NULL, 0),
       (60, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"icon\":\"el-icon-phone\",\"type\":1,\"parentId\":35,\"path\":\"teacher/list\",\"sortValue\":1,\"component\":\"vod/teacher/list\",\"param\":{},\"name\":\"讲师列表\",\"perms\":\"\",\"id\":36,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-10 15:27:38', NULL, 0),
       (61, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"icon\":\"\",\"type\":2,\"parentId\":36,\"path\":\"teacher/create\",\"sortValue\":1,\"component\":\"vod/teacher/form\",\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.teacher.add\",\"id\":37,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-10 15:28:27', NULL, 0),
       (62, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"icon\":\"\",\"type\":2,\"parentId\":36,\"path\":\"teacher/edit/:id\",\"sortValue\":1,\"component\":\"vod/teacher/form\",\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.teacher.update\",\"id\":38,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-10 15:29:13', NULL, 0),
       (63, '菜单管理', 'INSERT', 'com.yang.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '',
        '/admin/system/sysMenu/save', '127.0.0.1',
        '{\"select\":false,\"icon\":\"\",\"type\":2,\"parentId\":36,\"path\":\"\",\"sortValue\":1,\"component\":\"\",\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.teacher.list\",\"id\":39,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-10 15:35:30', NULL, 0),
       (64, '审批专辑', 'STATUS', 'com.yang.tingshu.album.controller.AlbumInfoController.approve()', 'GET', 'MANAGE',
        'admin', '', '/admin/album/albumInfo/approve/1592/0301', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-23 11:45:35', NULL, 0),
       (65, '审批专辑', 'STATUS', 'com.yang.tingshu.album.controller.AlbumInfoController.approve()', 'GET', 'MANAGE',
        'admin', '', '/admin/album/albumInfo/approve/1586/0301', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-23 11:48:01', NULL, 0),
       (66, '审批专辑', 'STATUS', 'com.yang.tingshu.album.controller.AlbumInfoController.approve()', 'GET', 'MANAGE',
        'admin', '', '/admin/album/albumInfo/approve/1586/0301', '154.9.225.83', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-23 11:48:29', NULL, 0),
       (67, '审批专辑', 'STATUS', 'com.yang.tingshu.album.controller.AlbumInfoController.approve()', 'GET', 'MANAGE',
        'admin', '', '/admin/album/albumInfo/approve/1592/0302', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-23 11:50:40', NULL, 0),
       (68, '审批专辑', 'STATUS', 'com.yang.tingshu.album.controller.AlbumInfoController.approve()', 'GET', 'MANAGE',
        'admin', '', '/admin/album/albumInfo/approve/1592/0301', '154.9.225.83', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-23 11:52:11', NULL, 0),
       (69, '审批专辑', 'STATUS', 'com.yang.tingshu.album.controller.AlbumInfoController.approve()', 'GET', 'MANAGE',
        'admin', '', '/admin/album/albumInfo/approve/1592/0302', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-23 11:53:36', NULL, 0),
       (70, '审批专辑', 'STATUS', 'com.yang.tingshu.album.controller.AlbumInfoController.approve()', 'GET', 'MANAGE',
        'admin', '', '/admin/album/albumInfo/approve/1592/0302', '154.9.225.83', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-23 14:47:51', NULL, 0),
       (71, '审批专辑', 'STATUS', 'com.yang.tingshu.album.controller.AlbumInfoController.approve()', 'GET', 'MANAGE',
        'admin', '', '/admin/album/albumInfo/approve/1592/0301', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-23 14:48:15', NULL, 0),
       (72, '审批声音', 'STATUS', 'com.yang.tingshu.album.controller.TrackInfoController.approve()', 'GET', 'MANAGE',
        'admin', '', '/admin/album/trackInfo/approve/51941/0502', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-23 15:21:05', NULL, 0),
       (73, '审批声音', 'STATUS', 'com.yang.tingshu.album.controller.TrackInfoController.approve()', 'GET', 'MANAGE',
        'admin', '', '/admin/album/trackInfo/approve/51941/0501', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-23 15:21:19', NULL, 0),
       (74, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET', 'MANAGE',
        'admin', '', '/admin/system/sysUser/updateStatus/2/1', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}',
        1, '', NULL, '2023-05-24 15:22:01', NULL, 0),
       (75, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET', 'MANAGE',
        'admin', '', '/admin/system/sysUser/updateStatus/1/1', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}',
        1, '', NULL, '2023-05-24 15:22:05', NULL, 0),
       (76, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET', 'MANAGE',
        'admin', '', '/admin/system/sysUser/updateStatus/3/1', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}',
        1, '', NULL, '2023-05-24 15:22:07', NULL, 0),
       (77, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET', 'MANAGE',
        'admin', '', '/admin/system/sysUser/updateStatus/3/0', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}',
        1, '', NULL, '2023-05-24 15:22:54', NULL, 0),
       (78, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET', 'MANAGE',
        'admin', '', '/admin/system/sysUser/updateStatus/3/1', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}',
        1, '', NULL, '2023-05-24 15:22:58', NULL, 0),
       (79, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET', 'MANAGE',
        'admin', '', '/admin/system/sysUser/updateStatus/3/0', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}',
        1, '', NULL, '2023-05-24 15:23:12', NULL, 0),
       (80, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET', 'MANAGE',
        'admin', '', '/admin/system/sysUser/updateStatus/3/1', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}',
        1, '', NULL, '2023-05-24 15:23:17', NULL, 0),
       (81, '用户管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysUserController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysUser/update', '154.9.225.93',
        '{\"deptName\":\"大数据学科\",\"deptId\":1022,\"headUrl\":\"http://r61cnlsfq.hn-bkt.clouddn.com/b09b3467-3d99-437a-bd2e-dd8c9be92bb8\",\"postId\":6,\"roleList\":[],\"password\":\"96e79218965eb72c92a549dd5a330112\",\"createTime\":1644287738000,\"param\":{},\"phone\":\"15010546381\",\"postName\":\"总经理\",\"name\":\"王倩倩1\",\"id\":2,\"status\":1,\"username\":\"wangqq\"}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-24 16:51:07', NULL, 0),
       (82, '用户管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysUserController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysUser/update', '154.9.225.83',
        '{\"deptName\":\"大数据学科\",\"deptId\":1022,\"headUrl\":\"http://r61cnlsfq.hn-bkt.clouddn.com/b09b3467-3d99-437a-bd2e-dd8c9be92bb8\",\"postId\":6,\"roleList\":[],\"password\":\"96e79218965eb72c92a549dd5a330112\",\"createTime\":1644287738000,\"param\":{},\"phone\":\"15010546381\",\"postName\":\"总经理\",\"name\":\"王倩倩\",\"id\":2,\"status\":1,\"username\":\"wangqq\"}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-24 16:51:22', NULL, 0),
       (83, '用户管理', 'INSERT', 'com.yang.tingshu.system.controller.SysUserController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysUser/save', '154.9.225.93',
        '{\"deptId\":1022,\"postId\":6,\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"param\":{},\"phone\":\"17796639675\",\"name\":\"ceshi\",\"id\":4,\"username\":\"ceshi\"}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-24 18:20:43', NULL, 0),
       (84, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET', 'MANAGE',
        'admin', '', '/admin/system/sysUser/updateStatus/4/0', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}',
        1, '', NULL, '2023-05-24 18:20:47', NULL, 0),
       (85, '角色管理', 'DELETE', 'com.yang.tingshu.system.controller.SysRoleController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysRole/remove/4', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-24 18:22:00', NULL, 0),
       (86, '角色管理', 'DELETE', 'com.yang.tingshu.system.controller.SysRoleController.batchRemove()', 'DELETE',
        'MANAGE', 'admin', '', '/admin/system/sysRole/batchRemove', '154.9.225.83', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-24 18:22:25', NULL, 0),
       (87, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET', 'MANAGE',
        'admin', '', '/admin/system/sysUser/updateStatus/4/1', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}',
        1, '', NULL, '2023-05-24 18:22:32', NULL, 0),
       (88, '角色管理', 'DELETE', 'com.yang.tingshu.system.controller.SysRoleController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysRole/remove/4', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-24 18:22:35', NULL, 0),
       (89, '角色管理', 'DELETE', 'com.yang.tingshu.system.controller.SysRoleController.batchRemove()', 'DELETE',
        'MANAGE', 'admin', '', '/admin/system/sysRole/batchRemove', '154.9.225.83', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-24 18:22:46', NULL, 0),
       (90, '用户管理', 'INSERT', 'com.yang.tingshu.system.controller.SysUserController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysUser/save', '154.9.225.83',
        '{\"deptId\":1024,\"postId\":6,\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"param\":{},\"phone\":\"17796639677\",\"name\":\"ceshi2\",\"id\":5,\"username\":\"ceshi2\"}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-24 18:26:08', NULL, 0),
       (91, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET', 'MANAGE',
        'admin', '', '/admin/system/sysUser/updateStatus/5/0', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}',
        1, '', NULL, '2023-05-24 18:26:11', NULL, 0),
       (92, '用户管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysRoleController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/doAssign', '154.9.225.93', '{\"roleIdList\":[3],\"userId\":5}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 09:03:08', NULL, 0),
       (93, '用户管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysRoleController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/doAssign', '154.9.225.93', '{\"roleIdList\":[1,2,3],\"userId\":5}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 09:04:15', NULL, 0),
       (94, '用户管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysRoleController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/doAssign', '154.9.225.93', '{\"roleIdList\":[3,1,2],\"userId\":5}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 09:04:24', NULL, 0),
       (95, '角色管理', 'DELETE', 'com.yang.tingshu.system.controller.SysRoleController.batchRemove()', 'DELETE',
        'MANAGE', 'admin', '', '/admin/system/sysRole/batchRemove', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 09:04:34', NULL, 0),
       (96, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '1.203.111.24',
        '{\"roleId\":3,\"menuIdList\":[2,3,6,7,8,9,18,4,10,11,12,13,19,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:04:54', NULL, 0),
       (97, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '1.203.111.24',
        '{\"roleId\":3,\"menuIdList\":[2,3,6,7,8,9,18,4,10,11,12,13,19,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:05:03', NULL, 0),
       (98, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '1.203.111.24',
        '{\"roleId\":3,\"menuIdList\":[2,3,6,7,8,9,18,4,10,11,12,13,19,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:05:45', NULL, 0),
       (99, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '1.203.111.24', '{\"roleId\":3,\"menuIdList\":[3,6,7,8,9,18]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:05:52', NULL, 0),
       (100, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '1.203.111.24',
        '{\"roleId\":3,\"menuIdList\":[2,3,6,7,8,9,18,4,10,11,12,13,19,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:05:59', NULL, 0),
       (101, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '1.203.111.24',
        '{\"roleId\":2,\"menuIdList\":[4,10,11,12,13,19]}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL,
        '2023-05-26 11:12:08', NULL, 0),
       (102, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '1.203.111.24', '{\"roleId\":2,\"menuIdList\":[11,12,13,19]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:12:12', NULL, 0),
       (103, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '1.203.111.24',
        '{\"roleId\":2,\"menuIdList\":[2,3,6,7,8,9,18,4,10,11,12,13,19,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:12:22', NULL, 0),
       (104, '角色管理', 'INSERT', 'com.yang.tingshu.system.controller.SysRoleController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/save', '1.203.111.24',
        '{\"param\":{},\"roleCode\":\"ces\",\"roleName\":\"测试\",\"id\":9}', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-26 11:20:19', NULL, 0),
       (105, '角色管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysRoleController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysRole/update', '1.203.111.24',
        '{\"createTime\":1685071219000,\"param\":{},\"roleCode\":\"ces2\",\"roleName\":\"测试2\",\"id\":9}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:20:23', NULL, 0),
       (106, '角色管理', 'DELETE', 'com.yang.tingshu.system.controller.SysRoleController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysRole/remove/9', '1.203.111.24', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-26 11:20:32', NULL, 0),
       (107, '角色管理', 'DELETE', 'com.yang.tingshu.system.controller.SysRoleController.batchRemove()', 'DELETE',
        'MANAGE', 'admin', '', '/admin/system/sysRole/batchRemove', '1.203.111.24', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:24:00', NULL, 0),
       (108, '角色管理', 'INSERT', 'com.yang.tingshu.system.controller.SysRoleController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/save', '1.203.111.24',
        '{\"param\":{},\"roleCode\":\"1\",\"roleName\":\"测试\",\"id\":10}', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-26 11:24:18', NULL, 0),
       (109, '角色管理', 'DELETE', 'com.yang.tingshu.system.controller.SysRoleController.batchRemove()', 'DELETE',
        'MANAGE', 'admin', '', '/admin/system/sysRole/batchRemove', '1.203.111.24', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:24:25', NULL, 0),
       (110, '角色管理', 'INSERT', 'com.yang.tingshu.system.controller.SysRoleController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/save', '1.203.111.24',
        '{\"param\":{},\"roleCode\":\"1\",\"roleName\":\"测试\",\"id\":11}', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-26 11:24:33', NULL, 0),
       (111, '角色管理', 'DELETE', 'com.yang.tingshu.system.controller.SysRoleController.batchRemove()', 'DELETE',
        'MANAGE', 'admin', '', '/admin/system/sysRole/batchRemove', '1.203.111.24', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:24:41', NULL, 0),
       (112, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '1.203.111.24',
        '{\"roleId\":2,\"menuIdList\":[7,8,9,18,4,10,11,12,13,19,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:32:29', NULL, 0),
       (113, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '1.203.111.24',
        '{\"roleId\":2,\"menuIdList\":[2,3,6,7,8,9,18,4,10,11,12,13,19,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 11:32:36', NULL, 0),
       (114, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '1.203.111.24',
        '{\"select\":false,\"icon\":\"el-icon-s-custom\",\"type\":1,\"parentId\":2,\"path\":\"sysUser\",\"sortValue\":1,\"component\":\"system/sysUser/list\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":3,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysUser.list\",\"id\":6,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysUser.add\",\"id\":7,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysUser.update\",\"id\":8,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysUser.remove\",\"id\":9,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"sortValue\":1,\"children\":[],\"createTime\":1653297272000,\"param\":{},\"name\":\"分配角色\",\"perms\":\"bnt.sysUser.assignRole\",\"id\":18,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"用户管理\",\"perms\":\"\",\"id\":3,\"status\":0}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 14:06:17', NULL, 0),
       (115, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '1.203.111.24',
        '{\"select\":false,\"icon\":\"el-icon-s-custom\",\"type\":1,\"parentId\":2,\"path\":\"sysUser\",\"sortValue\":1,\"component\":\"system/sysUser/list\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":3,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysUser.list\",\"id\":6,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysUser.add\",\"id\":7,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysUser.update\",\"id\":8,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysUser.remove\",\"id\":9,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"sortValue\":1,\"children\":[],\"createTime\":1653297272000,\"param\":{},\"name\":\"分配角色\",\"perms\":\"bnt.sysUser.assignRole\",\"id\":18,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"用户管理\",\"perms\":\"\",\"id\":3,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 14:06:21', NULL, 0),
       (116, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":2,\"isHide\":0,\"sortValue\":1,\"param\":{},\"name\":\"测试\",\"perms\":\"ces\",\"id\":36,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 17:27:53', NULL, 0),
       (117, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":2,\"isHide\":0,\"sortValue\":1,\"param\":{},\"name\":\"测试\",\"perms\":\"ces\",\"id\":37,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 17:30:40', NULL, 0),
       (118, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":2,\"isHide\":0,\"sortValue\":1,\"param\":{},\"name\":\"bnt.sysUser.list\",\"perms\":\"bnt.sysUser.list\",\"id\":38,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 17:32:30', NULL, 0),
       (119, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"type\":0,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"component\":\"ces1\",\"param\":{},\"name\":\"ces\",\"id\":39,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 17:33:37', NULL, 0),
       (120, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/36', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-26 17:41:40', NULL, 0),
       (121, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"icon\":\"AddLocation\",\"type\":0,\"parentId\":0,\"isHide\":0,\"path\":\"ce\",\"sortValue\":1,\"component\":\"ce\",\"activeMenu\":\"ce\",\"param\":{},\"name\":\"ces\",\"id\":40,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 17:41:53', NULL, 0),
       (122, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/37', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-26 17:42:06', NULL, 0),
       (123, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/38', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-26 17:42:11', NULL, 0),
       (124, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"AlarmClock\",\"type\":0,\"parentId\":0,\"isHide\":0,\"path\":\"ce\",\"sortValue\":1,\"component\":\"ce\",\"activeMenu\":\"ce\",\"children\":[],\"createTime\":1685094113000,\"param\":{},\"name\":\"ces\",\"id\":40,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 17:42:20', NULL, 0),
       (125, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Aim\",\"type\":0,\"parentId\":0,\"isHide\":0,\"path\":\"ce\",\"sortValue\":1,\"component\":\"ce\",\"activeMenu\":\"ce\",\"children\":[],\"createTime\":1685094113000,\"param\":{},\"name\":\"ces\",\"id\":40,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-26 18:21:34', NULL, 0),
       (126, '部门管理', 'STATUS', 'com.yang.tingshu.system.controller.SysDeptController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysDept/updateStatus/1/0', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 09:08:25', NULL, 0),
       (127, '部门管理', 'STATUS', 'com.yang.tingshu.system.controller.SysDeptController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysDept/updateStatus/1/1', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 09:08:29', NULL, 0),
       (128, '部门管理', 'STATUS', 'com.yang.tingshu.system.controller.SysDeptController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysDept/updateStatus/1/0', '154.9.225.83', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 09:08:39', NULL, 0),
       (129, '部门管理', 'STATUS', 'com.yang.tingshu.system.controller.SysDeptController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysDept/updateStatus/1/1', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 09:08:42', NULL, 0),
       (130, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysUser/updateStatus/5/1', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 09:08:52', NULL, 0),
       (131, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysUser/updateStatus/5/0', '154.9.225.83', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 09:08:54', NULL, 0),
       (132, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysUser/updateStatus/5/1', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 09:08:57', NULL, 0),
       (133, '部门管理', 'DELETE', 'com.yang.tingshu.system.controller.SysDeptController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysDept/remove/2019', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}', 1,
        '', NULL, '2023-05-27 09:39:47', NULL, 0),
       (134, '部门管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysDeptController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysDept/update', '154.9.225.93',
        '{\"leader\":\"测试22\",\"parentId\":1,\"sortValue\":1,\"createTime\":1653379993000,\"param\":{},\"phone\":\"12322\",\"name\":\"测试22\",\"id\":2018,\"treePath\":\",1,1,\",\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 09:39:57', NULL, 0),
       (135, '部门管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysDeptController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysDept/update', '154.9.225.83',
        '{\"leader\":\"测试22\",\"parentId\":1,\"sortValue\":1,\"createTime\":1653379993000,\"param\":{},\"phone\":\"12322\",\"name\":\"测试22\",\"id\":2018,\"treePath\":\",1,1,\",\"status\":0}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 09:40:03', NULL, 0),
       (136, '部门管理', 'STATUS', 'com.yang.tingshu.system.controller.SysDeptController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysDept/updateStatus/2018/1', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 09:40:11', NULL, 0),
       (137, '岗位管理', 'INSERT', 'com.yang.tingshu.system.controller.SysPostController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysPost/save', '154.9.225.93',
        '{\"param\":{},\"name\":\"测试\",\"description\":\"\",\"postCode\":\"测试\",\"id\":9,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 10:26:05', NULL, 0),
       (138, '岗位管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysPostController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysPost/update', '154.9.225.83',
        '{\"createTime\":1685154364000,\"param\":{},\"name\":\"测试1\",\"description\":\"\",\"postCode\":\"测试1\",\"id\":9,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 10:26:14', NULL, 0),
       (139, '岗位管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysPostController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysPost/update', '154.9.225.83',
        '{\"createTime\":1685154364000,\"param\":{},\"name\":\"测试1\",\"description\":\"\",\"postCode\":\"测试1\",\"id\":9,\"status\":0}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 10:26:25', NULL, 0),
       (140, '岗位管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysPostController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysPost/update', '154.9.225.93',
        '{\"createTime\":1685154364000,\"param\":{},\"name\":\"测试1\",\"description\":\"\",\"postCode\":\"测试1\",\"id\":9,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 10:26:32', NULL, 0),
       (141, '用户管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysRoleController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/doAssign', '154.9.225.83', '{\"roleIdList\":[1,2],\"userId\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 11:15:19', NULL, 0),
       (142, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '154.9.225.93',
        '{\"roleId\":1,\"menuIdList\":[2,3,6,7,8,9,18,4,10,11,12,13,19,39,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-27 11:19:34', NULL, 0),
       (143, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/40', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-31 08:44:32', NULL, 0),
       (144, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"system/user\",\"sortValue\":1,\"component\":\"system/user/user\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysUser.list\",\"id\":6,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysUser.add\",\"id\":7,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysUser.update\",\"id\":8,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysUser.remove\",\"id\":9,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653297272000,\"param\":{},\"name\":\"分配角色\",\"perms\":\"bnt.sysUser.assignRole\",\"id\":18,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"用户管理\",\"perms\":\"\",\"id\":3,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 08:49:24', NULL, 0),
       (145, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysUser.view\",\"id\":6,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 08:53:17', NULL, 0),
       (146, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"system/role\",\"sortValue\":2,\"component\":\"/system/role/role\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysRole.list\",\"id\":10,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysRole.add\",\"id\":11,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysRole.update\",\"id\":12,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysRole.remove\",\"id\":13,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":1,\"path\":\"assignAuth\",\"sortValue\":1,\"component\":\"system/sysRole/assignAuth\",\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1},{\"select\":false,\"type\":0,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"component\":\"ces1\",\"children\":[],\"createTime\":1685093616000,\"param\":{},\"name\":\"ces\",\"id\":39,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"perms\":\"\",\"id\":4,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 08:54:07', NULL, 0),
       (147, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"system/role\",\"sortValue\":2,\"component\":\"system/role/role\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysRole.list\",\"id\":10,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysRole.add\",\"id\":11,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysRole.update\",\"id\":12,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysRole.remove\",\"id\":13,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":1,\"path\":\"assignAuth\",\"sortValue\":1,\"component\":\"system/sysRole/assignAuth\",\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1},{\"select\":false,\"type\":0,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"component\":\"ces1\",\"children\":[],\"createTime\":1685093616000,\"param\":{},\"name\":\"ces\",\"id\":39,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"perms\":\"\",\"id\":4,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 08:56:15', NULL, 0),
       (148, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysRole.view\",\"id\":10,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 08:56:42', NULL, 0),
       (149, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/39', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-31 08:56:51', NULL, 0),
       (150, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":5,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysMenu.view\",\"id\":14,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 08:57:03', NULL, 0),
       (151, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Menu\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"system/permission\",\"sortValue\":3,\"component\":\"system/permission/permission\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":5,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysMenu.view\",\"id\":14,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":5,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysMenu.add\",\"id\":15,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":5,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysMenu.update\",\"id\":16,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":5,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysMenu.remove\",\"id\":17,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"菜单管理\",\"perms\":\"\",\"id\":5,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 08:57:49', NULL, 0),
       (152, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.view\",\"id\":21,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 08:58:17', NULL, 0),
       (153, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"el-icon-s-operation\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"system/department\",\"sortValue\":4,\"component\":\"system/department/department\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.view\",\"id\":21,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysDept.add\",\"id\":24,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysDept.update\",\"id\":25,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysDept.remove\",\"id\":26,\"status\":1}],\"createTime\":1653358025000,\"param\":{},\"name\":\"system/department\",\"perms\":\"\",\"id\":20,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 08:59:36', NULL, 0),
       (154, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"el-icon-s-operation\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"system/department\",\"sortValue\":4,\"component\":\"system/department/department\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.view\",\"id\":21,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysDept.add\",\"id\":24,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysDept.update\",\"id\":25,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysDept.remove\",\"id\":26,\"status\":1}],\"createTime\":1653358025000,\"param\":{},\"name\":\"部门管理\",\"perms\":\"\",\"id\":20,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 08:59:51', NULL, 0),
       (155, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Menu\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"system/post\",\"sortValue\":5,\"component\":\"system/post/post\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":22,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653359145000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysPost.list\",\"id\":23,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":22,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463964000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysPost.add\",\"id\":27,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":22,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463978000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysPost.update\",\"id\":28,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":22,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463991000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysPost.remove\",\"id\":29,\"status\":1}],\"createTime\":1653359130000,\"param\":{},\"name\":\"岗位管理\",\"perms\":\"\",\"id\":22,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 09:00:31', NULL, 0),
       (156, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":22,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653359145000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysPost.view\",\"id\":23,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 09:00:43', NULL, 0),
       (157, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Document\",\"type\":0,\"parentId\":2,\"isHide\":0,\"path\":\"system/log\",\"sortValue\":6,\"component\":\"system/log/operationLog\",\"children\":[{\"select\":false,\"icon\":\"el-icon-document-remove\",\"type\":1,\"parentId\":34,\"isHide\":0,\"path\":\"sysOperLog\",\"sortValue\":7,\"component\":\"system/sysOperLog/list\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":30,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"\",\"id\":30,\"status\":1},{\"select\":false,\"icon\":\"el-icon-s-goods\",\"type\":1,\"parentId\":34,\"isHide\":0,\"path\":\"sysLoginLog\",\"sortValue\":8,\"component\":\"system/sysLoginLog/list\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":32,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysLoginLog.list\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\"\",\"id\":32,\"status\":1}],\"createTime\":1653974587000,\"param\":{},\"name\":\"日志管理\",\"perms\":\"\",\"id\":34,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 09:03:08', NULL, 0),
       (158, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Menu\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"system/department\",\"sortValue\":4,\"component\":\"system/department/department\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.view\",\"id\":21,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysDept.add\",\"id\":24,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysDept.update\",\"id\":25,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysDept.remove\",\"id\":26,\"status\":1}],\"createTime\":1653358025000,\"param\":{},\"name\":\"部门管理\",\"perms\":\"\",\"id\":20,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 09:03:31', NULL, 0),
       (159, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":30,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.view\",\"id\":31,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 09:03:41', NULL, 0),
       (160, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":32,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysLoginLog.view\",\"id\":33,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 09:03:57', NULL, 0),
       (161, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"DocumentRemove\",\"type\":1,\"parentId\":34,\"isHide\":0,\"path\":\"system/log/operationLog\",\"sortValue\":7,\"component\":\"system/log/operationLog/operationLog\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":30,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.view\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"\",\"id\":30,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 09:04:47', NULL, 0),
       (162, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"DocumentRemove\",\"type\":1,\"parentId\":34,\"isHide\":0,\"path\":\"system/log/loginLog\",\"sortValue\":8,\"component\":\"system/log/loginLog/loginLog\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":32,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysLoginLog.view\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\"\",\"id\":32,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 09:05:10', NULL, 0),
       (163, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"/system/user\",\"sortValue\":1,\"component\":\"/system/user/user\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysUser.list\",\"id\":6,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysUser.add\",\"id\":7,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysUser.update\",\"id\":8,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysUser.remove\",\"id\":9,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653297272000,\"param\":{},\"name\":\"分配角色\",\"perms\":\"bnt.sysUser.assignRole\",\"id\":18,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"用户管理\",\"perms\":\"\",\"id\":3,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:26:43', NULL, 0),
       (164, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"/system/role\",\"sortValue\":2,\"component\":\"/system/role/role\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysRole.list\",\"id\":10,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysRole.add\",\"id\":11,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysRole.update\",\"id\":12,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysRole.remove\",\"id\":13,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":1,\"path\":\"assignAuth\",\"sortValue\":1,\"component\":\"system/sysRole/assignAuth\",\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"perms\":\"\",\"id\":4,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:26:55', NULL, 0),
       (165, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Menu\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"/system/permission\",\"sortValue\":3,\"component\":\"/system/permission/permission\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":5,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysMenu.list\",\"id\":14,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":5,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysMenu.add\",\"id\":15,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":5,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysMenu.update\",\"id\":16,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":5,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysMenu.remove\",\"id\":17,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"菜单管理\",\"perms\":\"\",\"id\":5,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:27:15', NULL, 0),
       (166, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Menu\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"/system/department\",\"sortValue\":4,\"component\":\"/system/department/department\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.list\",\"id\":21,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysDept.add\",\"id\":24,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysDept.update\",\"id\":25,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysDept.remove\",\"id\":26,\"status\":1}],\"createTime\":1653358025000,\"param\":{},\"name\":\"部门管理\",\"perms\":\"\",\"id\":20,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:27:52', NULL, 0),
       (167, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Menu\",\"type\":1,\"parentId\":2,\"isHide\":0,\"path\":\"/system/post\",\"sortValue\":5,\"component\":\"/system/post/post\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":22,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653359145000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysPost.list\",\"id\":23,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":22,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463964000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysPost.add\",\"id\":27,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":22,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463978000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysPost.update\",\"id\":28,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":22,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653463991000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysPost.remove\",\"id\":29,\"status\":1}],\"createTime\":1653359130000,\"param\":{},\"name\":\"岗位管理\",\"perms\":\"\",\"id\":22,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:28:08', NULL, 0),
       (168, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Document\",\"type\":0,\"parentId\":2,\"isHide\":0,\"path\":\"/system/log\",\"sortValue\":6,\"component\":\"/system/log/operationLog\",\"children\":[{\"select\":false,\"icon\":\"DocumentRemove\",\"type\":1,\"parentId\":34,\"isHide\":0,\"path\":\"system/log/operationLog\",\"sortValue\":7,\"component\":\"system/log/operationLog/operationLog\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":30,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"\",\"id\":30,\"status\":1},{\"select\":false,\"icon\":\"DocumentRemove\",\"type\":1,\"parentId\":34,\"isHide\":0,\"path\":\"system/log/loginLog\",\"sortValue\":8,\"component\":\"system/log/loginLog/loginLog\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":32,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysLoginLog.list\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\"\",\"id\":32,\"status\":1}],\"createTime\":1653974587000,\"param\":{},\"name\":\"日志管理\",\"perms\":\"\",\"id\":34,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:28:35', NULL, 0);
INSERT INTO `sys_oper_log`
VALUES (169, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"DocumentRemove\",\"type\":1,\"parentId\":34,\"isHide\":0,\"path\":\"/system/log/operationLog\",\"sortValue\":7,\"component\":\"/system/log/operationLog/operationLog\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":30,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"\",\"id\":30,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:28:52', NULL, 0),
       (170, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"DocumentRemove\",\"type\":1,\"parentId\":34,\"isHide\":0,\"path\":\"/system/log/loginLog\",\"sortValue\":8,\"component\":\"/system/log/loginLog/loginLog\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":32,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysLoginLog.list\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\"\",\"id\":32,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:29:03', NULL, 0),
       (171, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看列表\",\"perms\":\"bnt.sysUser.list\",\"id\":6,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:33:44', NULL, 0),
       (172, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看列表\",\"perms\":\"bnt.sysRole.list\",\"id\":10,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:34:23', NULL, 0),
       (173, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":5,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看列表\",\"perms\":\"bnt.sysMenu.list\",\"id\":14,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:34:37', NULL, 0),
       (174, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":20,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看列表\",\"perms\":\"bnt.sysDept.list\",\"id\":21,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:34:47', NULL, 0),
       (175, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":22,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653359145000,\"param\":{},\"name\":\"查看列表\",\"perms\":\"bnt.sysPost.list\",\"id\":23,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:35:00', NULL, 0),
       (176, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":30,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看列表\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:35:13', NULL, 0),
       (177, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":32,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看列表\",\"perms\":\"bnt.sysLoginLog.list\",\"id\":33,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:35:21', NULL, 0),
       (178, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":3,\"isHide\":0,\"sortValue\":1,\"param\":{},\"name\":\"分配角色\",\"perms\":\"bnt.sysUser.assignRole\",\"id\":41,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:38:14', NULL, 0),
       (179, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/41', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-31 11:38:52', NULL, 0),
       (180, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuthority\",\"id\":42,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:40:30', NULL, 0),
       (181, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/19', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-31 11:43:16', NULL, 0),
       (182, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"param\":{},\"name\":\"测试\",\"perms\":\"测试\",\"id\":43,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:44:00', NULL, 0),
       (183, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/43', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-31 11:44:42', NULL, 0),
       (184, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"param\":{},\"name\":\"分配测试\",\"perms\":\"bnt.sysRole.demo\",\"id\":44,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 11:45:01', NULL, 0),
       (185, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/44', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-31 11:45:11', NULL, 0),
       (186, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Film\",\"type\":0,\"parentId\":0,\"isHide\":0,\"path\":\"/album/albumList\",\"sortValue\":1,\"param\":{},\"name\":\"专辑管理\",\"id\":45,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 13:59:44', NULL, 0),
       (187, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"icon\":\"List\",\"type\":1,\"parentId\":45,\"isHide\":0,\"path\":\"/album/albumList\",\"sortValue\":1,\"component\":\"/album/albumList/albumList\",\"param\":{},\"name\":\"专辑列表\",\"id\":46,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:01:32', NULL, 0),
       (188, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":46,\"isHide\":0,\"path\":\"/album/showAlbumDetails\",\"sortValue\":1,\"component\":\"/album/albumList/showAlbumDetails\",\"param\":{},\"name\":\"查看详情\",\"perms\":\"bnt.sysUser.viewDetail\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:03:35', NULL, 0),
       (189, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":46,\"isHide\":0,\"path\":\"/album/showAlbumDetails\",\"sortValue\":1,\"component\":\"/album/albumList/showAlbumDetails\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"查看详情\",\"perms\":\"bnt.album.viewDetail\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:07:52', NULL, 0),
       (190, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Document\",\"type\":1,\"parentId\":46,\"isHide\":1,\"path\":\"/album/showAlbumDetails\",\"sortValue\":1,\"component\":\"/album/albumList/showAlbumDetails\",\"activeMenu\":\"/album/albumList\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"专辑详情\",\"perms\":\"\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:11:42', NULL, 0),
       (191, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":46,\"isHide\":0,\"sortValue\":1,\"param\":{},\"name\":\"查看专辑详情\",\"perms\":\"bnt.sysUser.viewDetail\",\"id\":48,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:13:22', NULL, 0),
       (192, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":46,\"isHide\":0,\"path\":\"/album/showAlbumDetails\",\"sortValue\":3,\"component\":\"/album/albumList/showAlbumDetails\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"查看详情1\",\"perms\":\"bnt.album.viewDetail1\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:16:47', NULL, 0),
       (193, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Document\",\"type\":2,\"parentId\":46,\"isHide\":0,\"path\":\"/album/showAlbumDetails\",\"sortValue\":3,\"component\":\"/album/albumList/showAlbumDetails\",\"activeMenu\":\"/album/albumList\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"查看详情1\",\"perms\":\"bnt.album.viewDetail1\",\"id\":47,\"status\":0}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:20:14', NULL, 0),
       (194, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Document\",\"type\":2,\"parentId\":46,\"isHide\":1,\"path\":\"/album/showAlbumDetails\",\"sortValue\":3,\"component\":\"/album/albumList/showAlbumDetails\",\"activeMenu\":\"/album/albumList\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"查看详情1\",\"perms\":\"bnt.album.viewDetail1\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:20:23', NULL, 0),
       (195, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Document\",\"type\":2,\"parentId\":46,\"isHide\":0,\"path\":\"/album/showAlbumDetails\",\"sortValue\":3,\"component\":\"/album/albumList/showAlbumDetails\",\"activeMenu\":\"/album/albumList\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"查看详情1\",\"perms\":\"bnt.album.viewDetail1\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:20:37', NULL, 0),
       (196, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Document\",\"type\":2,\"parentId\":46,\"isHide\":1,\"path\":\"/album/showAlbumDetails\",\"sortValue\":3,\"component\":\"/album/albumList/showAlbumDetails\",\"activeMenu\":\"/album/albumList\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"专辑详情\",\"perms\":\"bnt.album.viewDetail\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:21:54', NULL, 0),
       (197, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Document\",\"type\":2,\"parentId\":46,\"isHide\":0,\"path\":\"/album/showAlbumDetails\",\"sortValue\":3,\"component\":\"/album/albumList/showAlbumDetails\",\"activeMenu\":\"/album/albumList\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"专辑详情\",\"perms\":\"bnt.album.viewDetail\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:22:28', NULL, 0),
       (198, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Document\",\"type\":2,\"parentId\":46,\"isHide\":1,\"path\":\"/album/showAlbumDetails\",\"sortValue\":3,\"component\":\"/album/albumList/showAlbumDetails\",\"activeMenu\":\"/album/albumList\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"专辑详情\",\"perms\":\"bnt.album.viewDetail\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:23:04', NULL, 0),
       (199, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Document\",\"type\":2,\"parentId\":46,\"isHide\":1,\"path\":\"/album/showAlbumDetails\",\"sortValue\":3,\"component\":\"/album/albumList/showAlbumDetails\",\"activeMenu\":\"/album/albumList\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"专辑详情\",\"perms\":\"bnt.album.viewDetail\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:23:07', NULL, 0),
       (200, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Document\",\"type\":2,\"parentId\":46,\"isHide\":1,\"path\":\"/album/showAlbumDetails\",\"sortValue\":1,\"component\":\"/album/albumList/showAlbumDetails\",\"activeMenu\":\"/album/albumList\",\"children\":[],\"createTime\":1685513015000,\"param\":{},\"name\":\"专辑详情\",\"perms\":\"bnt.album.viewDetail\",\"id\":47,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:23:53', NULL, 0),
       (201, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/48', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-31 14:25:01', NULL, 0),
       (202, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":46,\"isHide\":0,\"sortValue\":1,\"param\":{},\"name\":\"通过/不通过\",\"perms\":\"bnt.album.passAndNotPass\",\"id\":49,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:26:10', NULL, 0),
       (203, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"type\":0,\"parentId\":0,\"isHide\":0,\"path\":\"/order/orderList\",\"sortValue\":1,\"component\":\"/order/orderList/orderList\",\"param\":{},\"name\":\"订单管理\",\"id\":50,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:27:33', NULL, 0),
       (204, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"DocumentCopy\",\"type\":0,\"parentId\":0,\"isHide\":0,\"path\":\"/order/orderList\",\"sortValue\":1,\"component\":\"/order/orderList/orderList\",\"children\":[],\"createTime\":1685514453000,\"param\":{},\"name\":\"订单管理\",\"id\":50,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:43:25', NULL, 0),
       (205, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"icon\":\"List\",\"type\":1,\"parentId\":50,\"isHide\":0,\"path\":\"/order/orderList\",\"sortValue\":1,\"component\":\"/order/orderList/orderList\",\"param\":{},\"name\":\"订单列表\",\"id\":51,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:43:50', NULL, 0),
       (206, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":51,\"isHide\":1,\"path\":\"/order/showOrderDetails\",\"sortValue\":1,\"component\":\"/order/orderList/showOrderDetails\",\"param\":{},\"name\":\"订单详情\",\"perms\":\"bnt.order.viewOrderDetail\",\"id\":52,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:45:04', NULL, 0),
       (207, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":0,\"isHide\":0,\"path\":\"/member/memberList\",\"sortValue\":1,\"component\":\"/member/memberList/memberList\",\"param\":{},\"name\":\"会员管理\",\"id\":53,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:46:13', NULL, 0),
       (208, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":0,\"isHide\":0,\"path\":\"/member/memberList\",\"sortValue\":1,\"component\":\"\",\"children\":[],\"createTime\":1685515573000,\"param\":{},\"name\":\"会员管理\",\"id\":53,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:46:37', NULL, 0),
       (209, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"DocumentCopy\",\"type\":0,\"parentId\":0,\"isHide\":0,\"path\":\"/order/orderList\",\"sortValue\":1,\"component\":\"\",\"children\":[{\"select\":false,\"icon\":\"List\",\"type\":1,\"parentId\":50,\"isHide\":0,\"path\":\"/order/orderList\",\"sortValue\":1,\"component\":\"/order/orderList/orderList\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":51,\"isHide\":1,\"path\":\"/order/showOrderDetails\",\"sortValue\":1,\"component\":\"/order/orderList/showOrderDetails\",\"children\":[],\"createTime\":1685515504000,\"param\":{},\"name\":\"订单详情\",\"perms\":\"bnt.order.viewOrderDetail\",\"id\":52,\"status\":1}],\"createTime\":1685515430000,\"param\":{},\"name\":\"订单列表\",\"id\":51,\"status\":1}],\"createTime\":1685514453000,\"param\":{},\"name\":\"订单管理\",\"id\":50,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:46:51', NULL, 0),
       (210, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":53,\"isHide\":0,\"path\":\"/member/memberList\",\"sortValue\":1,\"component\":\"/member/memberList/memberList\",\"param\":{},\"name\":\"会员列表\",\"id\":54,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:47:31', NULL, 0),
       (211, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Headset\",\"type\":1,\"parentId\":45,\"isHide\":0,\"path\":\"/album/trackList\",\"sortValue\":1,\"component\":\"/album/trackList/trackList\",\"param\":{},\"name\":\"声音管理\",\"id\":55,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:53:48', NULL, 0),
       (212, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Headset\",\"type\":1,\"parentId\":55,\"isHide\":0,\"path\":\"/album/trackList\",\"sortValue\":1,\"component\":\"/album/trackList/trackList\",\"param\":{},\"name\":\"声音列表\",\"id\":56,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:54:17', NULL, 0),
       (213, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":55,\"isHide\":1,\"path\":\"/album/showTrackDetails\",\"sortValue\":1,\"component\":\"/album/trackList/showTrackDetails\",\"activeMenu\":\"/album/trackList\",\"param\":{},\"name\":\"声音详情\",\"perms\":\"bnt.track.viewTrackDetail\",\"id\":57,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:55:53', NULL, 0),
       (214, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"Headset\",\"type\":0,\"parentId\":45,\"isHide\":0,\"path\":\"/album/trackList\",\"sortValue\":1,\"component\":\"/album/trackList/trackList\",\"children\":[{\"select\":false,\"icon\":\"Headset\",\"type\":1,\"parentId\":55,\"isHide\":0,\"path\":\"/album/trackList\",\"sortValue\":1,\"component\":\"/album/trackList/trackList\",\"children\":[],\"createTime\":1685516056000,\"param\":{},\"name\":\"声音列表\",\"id\":56,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":55,\"isHide\":1,\"path\":\"/album/showTrackDetails\",\"sortValue\":1,\"component\":\"/album/trackList/showTrackDetails\",\"activeMenu\":\"/album/trackList\",\"children\":[],\"createTime\":1685516153000,\"param\":{},\"name\":\"声音详情\",\"perms\":\"bnt.track.viewTrackDetail\",\"id\":57,\"status\":1}],\"createTime\":1685516028000,\"param\":{},\"name\":\"声音管理\",\"id\":55,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:57:43', NULL, 0),
       (215, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":0,\"parentId\":0,\"isHide\":0,\"path\":\"/member/memberList\",\"sortValue\":1,\"component\":\"\",\"children\":[{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":53,\"isHide\":0,\"path\":\"/member/memberList\",\"sortValue\":1,\"component\":\"/member/memberList/memberList\",\"children\":[],\"createTime\":1685515651000,\"param\":{},\"name\":\"会员列表\",\"id\":54,\"status\":1}],\"createTime\":1685515573000,\"param\":{},\"name\":\"会员管理\",\"id\":53,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:58:18', NULL, 0),
       (216, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"type\":1,\"parentId\":45,\"isHide\":0,\"path\":\"/album/category\",\"sortValue\":1,\"component\":\"/album/category/category\",\"param\":{},\"name\":\"分类管理\",\"id\":58,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:59:23', NULL, 0),
       (217, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Menu\",\"type\":1,\"parentId\":45,\"isHide\":0,\"path\":\"/album/category\",\"sortValue\":1,\"component\":\"/album/category/category\",\"children\":[],\"createTime\":1685516363000,\"param\":{},\"name\":\"分类管理\",\"id\":58,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 14:59:56', NULL, 0),
       (218, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"icon\":\"Grid\",\"type\":1,\"parentId\":45,\"isHide\":0,\"path\":\"/album/categoryAttribute\",\"sortValue\":1,\"component\":\"/album/categoryAttribute/categoryAttribute\",\"param\":{},\"name\":\"分类属性管理\",\"id\":59,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 15:00:27', NULL, 0),
       (219, '用户管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysRoleController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/doAssign', '154.9.225.83', '{\"roleIdList\":[],\"userId\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 16:01:33', NULL, 0),
       (220, '用户管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysRoleController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/doAssign', '154.9.225.83', '{\"roleIdList\":[1,2],\"userId\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 16:01:47', NULL, 0),
       (221, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1685504430000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":42,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 16:38:33', NULL, 0),
       (222, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":4,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1685504430000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":42,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 16:52:43', NULL, 0),
       (223, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '154.9.225.93',
        '{\"roleId\":1,\"menuIdList\":[2,3,6,7,8,9,41,4,10,11,12,13,42,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33,45,46,47,49,55,56,57,58,59,50,51,52,53,54]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 17:16:40', NULL, 0),
       (224, '用户管理', 'INSERT', 'com.yang.tingshu.system.controller.SysUserController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysUser/save', '154.9.225.93',
        '{\"deptId\":1,\"postId\":9,\"password\":\"96e79218965eb72c92a549dd5a330112\",\"param\":{},\"phone\":\"12345678910\",\"name\":\"ceshiyonghu\",\"id\":6,\"username\":\"ceshiyonghu\"}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:01:06', NULL, 0),
       (225, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysUser/updateStatus/6/0', '154.9.225.93', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:01:09', NULL, 0),
       (226, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysUser/updateStatus/6/1', '154.9.225.83', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:01:18', NULL, 0),
       (227, '用户管理', 'INSERT', 'com.yang.tingshu.system.controller.SysUserController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysUser/save', '154.9.225.83',
        '{\"deptId\":1,\"postId\":5,\"password\":\"770560b3c259df2ebc3fbfa2db47bdc7\",\"param\":{},\"phone\":\"123456+78910\",\"name\":\"ceshiyong\",\"status\":1,\"username\":\"ceshiyong\"}',
        '', 0,
        '\n### Error updating database.  Cause: com.mysql.jdbc.MysqlDataTruncation: Data truncation: Data too long for column \'phone\' at row 1\n### The error may exist in com/yang/tingshu/system/mapper/SysUserMapper.java (best guess)\n### The error may involve com.yang.tingshu.system.mapper.SysUserMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO sys_user  ( username, password, name, phone,  dept_id, post_id,  status )  VALUES  ( ?, ?, ?, ?,  ?, ?,  ? )\n### Cause: com.mysql.jdbc.MysqlDataTruncation: Data truncation: Data too long for column \'phone\' at row 1\n; Data truncation: Data too long for column \'phone\' at row 1',
        NULL, '2023-05-31 18:06:18', NULL, 0),
       (228, '用户管理', 'INSERT', 'com.yang.tingshu.system.controller.SysUserController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysUser/save', '154.9.225.83',
        '{\"deptId\":1,\"postId\":5,\"password\":\"770560b3c259df2ebc3fbfa2db47bdc7\",\"param\":{},\"phone\":\"123456+78910\",\"name\":\"ceshiyong\",\"status\":1,\"username\":\"ceshiyong\"}',
        '', 0,
        '\n### Error updating database.  Cause: com.mysql.jdbc.MysqlDataTruncation: Data truncation: Data too long for column \'phone\' at row 1\n### The error may exist in com/yang/tingshu/system/mapper/SysUserMapper.java (best guess)\n### The error may involve com.yang.tingshu.system.mapper.SysUserMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO sys_user  ( username, password, name, phone,  dept_id, post_id,  status )  VALUES  ( ?, ?, ?, ?,  ?, ?,  ? )\n### Cause: com.mysql.jdbc.MysqlDataTruncation: Data truncation: Data too long for column \'phone\' at row 1\n; Data truncation: Data too long for column \'phone\' at row 1',
        NULL, '2023-05-31 18:06:21', NULL, 0),
       (229, '用户管理', 'INSERT', 'com.yang.tingshu.system.controller.SysUserController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysUser/save', '154.9.225.93',
        '{\"deptId\":1,\"postId\":5,\"password\":\"770560b3c259df2ebc3fbfa2db47bdc7\",\"param\":{},\"phone\":\"123456+78910\",\"name\":\"ceshiyong\",\"status\":1,\"username\":\"ceshiyong\"}',
        '', 0,
        '\n### Error updating database.  Cause: com.mysql.jdbc.MysqlDataTruncation: Data truncation: Data too long for column \'phone\' at row 1\n### The error may exist in com/yang/tingshu/system/mapper/SysUserMapper.java (best guess)\n### The error may involve com.yang.tingshu.system.mapper.SysUserMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO sys_user  ( username, password, name, phone,  dept_id, post_id,  status )  VALUES  ( ?, ?, ?, ?,  ?, ?,  ? )\n### Cause: com.mysql.jdbc.MysqlDataTruncation: Data truncation: Data too long for column \'phone\' at row 1\n; Data truncation: Data too long for column \'phone\' at row 1',
        NULL, '2023-05-31 18:06:24', NULL, 0),
       (230, '用户管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysRoleController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/doAssign', '154.9.225.83', '{\"roleIdList\":[2],\"userId\":6}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:06:57', NULL, 0),
       (231, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '154.9.225.93',
        '{\"roleId\":2,\"menuIdList\":[6,7,9,41,10,11,13,42,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:07:34', NULL, 0),
       (232, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '154.9.225.93',
        '{\"roleId\":2,\"menuIdList\":[6,7,9,41,10,11,13,42,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33,45,46,47,49,55,56,57,58,59,50,51,52]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:08:12', NULL, 0),
       (233, '角色管理', 'INSERT', 'com.yang.tingshu.system.controller.SysRoleController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/save', '154.9.225.93',
        '{\"param\":{},\"roleCode\":\"ceshi\",\"roleName\":\"测试角色\",\"id\":12}', '{\"code\":200,\"message\":\"成功\"}', 1,
        '', NULL, '2023-05-31 18:09:23', NULL, 0),
       (234, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '154.9.225.83',
        '{\"roleId\":12,\"menuIdList\":[6,7,9,41,10,11,13,42,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:09:41', NULL, 0),
       (235, '用户管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysRoleController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/doAssign', '154.9.225.93', '{\"roleIdList\":[12],\"userId\":6}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:09:53', NULL, 0),
       (236, '用户管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysRoleController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/doAssign', '154.9.225.83', '{\"roleIdList\":[12,2],\"userId\":6}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:10:45', NULL, 0),
       (237, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '154.9.225.93',
        '{\"roleId\":2,\"menuIdList\":[6,7,9,41,10,11,13,42,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33,45,46,47,49,55,56,57,58,59]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:13:23', NULL, 0),
       (238, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":51,\"isHide\":0,\"sortValue\":1,\"param\":{},\"name\":\"ces\",\"perms\":\"ces\",\"id\":60,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:15:44', NULL, 0),
       (239, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '154.9.225.83',
        '{\"roleId\":2,\"menuIdList\":[6,7,9,41,10,11,13,42,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33,45,46,47,49,55,56,57,58,59,60]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:15:55', NULL, 0),
       (240, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"List\",\"type\":0,\"parentId\":50,\"isHide\":0,\"path\":\"/order/orderList\",\"sortValue\":1,\"component\":\"/order/orderList/orderList\",\"children\":[{\"select\":false,\"type\":2,\"parentId\":51,\"isHide\":1,\"path\":\"/order/showOrderDetails\",\"sortValue\":1,\"component\":\"/order/orderList/showOrderDetails\",\"children\":[],\"createTime\":1685515504000,\"param\":{},\"name\":\"订单详情\",\"perms\":\"bnt.order.viewOrderDetail\",\"id\":52,\"status\":1},{\"select\":false,\"type\":2,\"parentId\":51,\"isHide\":0,\"sortValue\":1,\"children\":[],\"createTime\":1685528144000,\"param\":{},\"name\":\"ces\",\"perms\":\"ces\",\"id\":60,\"status\":1}],\"createTime\":1685515430000,\"param\":{},\"name\":\"订单列表\",\"id\":51,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 18:18:32', NULL, 0),
       (241, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/60', '154.9.225.83', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-31 18:39:38', NULL, 0),
       (242, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":56,\"isHide\":0,\"sortValue\":1,\"component\":\"\",\"activeMenu\":\"\",\"param\":{},\"name\":\"通过不通过\",\"perms\":\"bnt.track.passAndNotPass\",\"id\":61,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 19:13:21', NULL, 0),
       (243, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"type\":2,\"parentId\":56,\"isHide\":0,\"sortValue\":1,\"component\":\"\",\"activeMenu\":\"\",\"children\":[],\"createTime\":1685531601000,\"param\":{},\"name\":\"通过/不通过\",\"perms\":\"bnt.track.passAndNotPass\",\"id\":61,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 19:13:52', NULL, 0),
       (244, '菜单管理', 'INSERT', 'com.yang.tingshu.system.controller.SysMenuController.save()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/save', '154.9.225.93',
        '{\"select\":false,\"type\":2,\"parentId\":56,\"isHide\":1,\"path\":\"/album/showTrackDetails\",\"sortValue\":1,\"component\":\"/album/trackList/showTrackDetails\",\"activeMenu\":\"/album/trackList\",\"param\":{},\"name\":\"声音详情\",\"perms\":\"bnt.track.viewTrackDetail\",\"id\":62,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 19:14:42', NULL, 0),
       (245, '菜单管理', 'DELETE', 'com.yang.tingshu.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/remove/57', '154.9.225.93', '', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-05-31 19:14:51', NULL, 0),
       (246, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '154.9.225.83',
        '{\"roleId\":12,\"menuIdList\":[6,7,9,41,10,11,13,42,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33,46,47,49,62]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 19:20:07', NULL, 0),
       (247, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '154.9.225.83', '{\"roleId\":12,\"menuIdList\":[47,45,46]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 19:32:59', NULL, 0),
       (248, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '154.9.225.83', '{\"roleId\":12,\"menuIdList\":[45,46,47]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-05-31 19:58:09', NULL, 0),
       (249, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.93',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":0,\"parentId\":0,\"isHide\":1,\"path\":\"/member/memberList\",\"sortValue\":1,\"component\":\"\",\"children\":[{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":53,\"isHide\":0,\"path\":\"/member/memberList\",\"sortValue\":1,\"component\":\"/member/memberList/memberList\",\"children\":[],\"createTime\":1685515651000,\"param\":{},\"name\":\"会员列表\",\"id\":54,\"status\":1}],\"createTime\":1685515573000,\"param\":{},\"name\":\"会员管理\",\"id\":53,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-06-03 18:14:43', NULL, 0),
       (250, '菜单管理', 'UPDATE', 'com.yang.tingshu.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/update', '154.9.225.83',
        '{\"select\":false,\"icon\":\"UserFilled\",\"type\":0,\"parentId\":0,\"isHide\":0,\"path\":\"/member/memberList\",\"sortValue\":1,\"component\":\"\",\"children\":[{\"select\":false,\"icon\":\"UserFilled\",\"type\":1,\"parentId\":53,\"isHide\":0,\"path\":\"/member/memberList\",\"sortValue\":1,\"component\":\"/member/memberList/memberList\",\"children\":[],\"createTime\":1685515651000,\"param\":{},\"name\":\"会员列表\",\"id\":54,\"status\":1}],\"createTime\":1685515573000,\"param\":{},\"name\":\"会员管理\",\"id\":53,\"status\":1}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-06-03 18:14:58', NULL, 0),
       (251, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysUser/updateStatus/6/0', '1.203.110.148', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-06-06 15:48:57', NULL, 0),
       (252, '用户管理', 'STATUS', 'com.yang.tingshu.system.controller.SysUserController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysUser/updateStatus/6/1', '1.203.110.148', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-06-06 15:48:59', NULL, 0),
       (253, '部门管理', 'STATUS', 'com.yang.tingshu.system.controller.SysDeptController.updateStatus()', 'GET',
        'MANAGE', 'admin', '', '/admin/system/sysDept/updateStatus/1/1', '1.203.110.148', '',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-06-06 15:49:40', NULL, 0),
       (254, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52',
        '{\"roleId\":2,\"menuIdList\":[2,3,6,7,8,9,41,4,10,11,12,13,42,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33,45,46,47,49,55,56,58,59]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-07-17 14:13:06', NULL, 0),
       (255, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52',
        '{\"roleId\":12,\"menuIdList\":[2,3,6,7,8,9,41,4,10,11,12,13,42,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33,45,46,47,49,55,56,61,62,58,59]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-07-17 14:13:15', NULL, 0),
       (256, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52', '{\"roleId\":0,\"menuIdList\":[]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-07-18 09:01:30', NULL, 0),
       (257, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52',
        '{\"roleId\":12,\"menuIdList\":[45,46,47,49,55,56,61,62,58,59]}', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-07-18 09:30:56', NULL, 0),
       (258, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52',
        '{\"roleId\":12,\"menuIdList\":[6,45,46,47,49,55,56,61,62,58,59,2,3]}', '{\"code\":200,\"message\":\"成功\"}', 1,
        '', NULL, '2023-07-18 09:34:17', NULL, 0),
       (259, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52',
        '{\"roleId\":12,\"menuIdList\":[45,46,47,49,55,56,61,62,58,59]}', '{\"code\":200,\"message\":\"成功\"}', 1, '',
        NULL, '2023-07-18 09:35:17', NULL, 0),
       (260, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52',
        '{\"roleId\":12,\"menuIdList\":[6,45,46,47,49,55,56,61,62,58,59,2,3]}', '{\"code\":200,\"message\":\"成功\"}', 1,
        '', NULL, '2023-07-18 09:35:26', NULL, 0),
       (261, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52',
        '{\"roleId\":12,\"menuIdList\":[7,8,9,41,11,12,13,42,5,14,15,16,17,20,21,24,25,26,22,23,27,28,29,34,30,31,32,33,2,3,4]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-07-18 09:38:37', NULL, 0),
       (262, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52', '{\"roleId\":12,\"menuIdList\":[]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-07-18 09:45:00', NULL, 0),
       (263, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52', '{\"roleId\":12,\"menuIdList\":[6,2,3]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-07-18 09:45:06', NULL, 0),
       (264, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52', '{\"roleId\":12,\"menuIdList\":[6,7,2,3]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-07-18 10:45:14', NULL, 0),
       (265, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52', '{\"roleId\":12,\"menuIdList\":[]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-07-18 10:45:19', NULL, 0),
       (266, '角色管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysMenu/doAssign', '219.143.132.52', '{\"roleId\":12,\"menuIdList\":[6,2,3]}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-07-18 10:45:23', NULL, 0),
       (267, '用户管理', 'ASSGIN', 'com.yang.tingshu.system.controller.SysRoleController.doAssign()', 'POST', 'MANAGE',
        'admin', '', '/admin/system/sysRole/doAssign', '223.104.67.51', '{\"roleIdList\":[2,12,1],\"userId\":6}',
        '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2023-08-04 17:40:45', NULL, 0);

#
# Structure for table "sys_post"
#

CREATE TABLE `sys_post`
(
    `id`          bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
    `post_code`   varchar(64)  NOT NULL COMMENT '岗位编码',
    `name`        varchar(50)  NOT NULL DEFAULT '' COMMENT '岗位名称',
    `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
    `status`      tinyint(1)   NOT NULL DEFAULT '1' COMMENT '状态（1正常 0停用）',
    `create_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_time` timestamp    NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted`  tinyint(3)   NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 10
  DEFAULT CHARSET = utf8 COMMENT ='岗位信息表';

#
# Data for table "sys_post"
#

INSERT INTO `sys_post`
VALUES (5, 'dsz', '董事长', '1', 1, '2022-05-24 10:33:53', NULL, 0),
       (6, 'zjl', '总经理', '2', 1, '2022-05-24 10:34:08', NULL, 0),
       (7, 'wz', '网咨', '', 1, '2023-04-21 11:23:41', '2023-04-21 11:23:41', 0),
       (8, 'yyzj', '运营总监', '', 1, '2022-06-08 17:14:21', '2023-05-27 10:20:20', 0),
       (9, '测试1', '测试1', '', 1, '2023-05-27 10:26:04', '2023-05-27 10:26:32', 0);

#
# Structure for table "sys_role"
#

CREATE TABLE `sys_role`
(
    `id`          bigint(20)  NOT NULL AUTO_INCREMENT COMMENT '角色id',
    `role_name`   varchar(20) NOT NULL DEFAULT '' COMMENT '角色名称',
    `role_code`   varchar(20)          DEFAULT NULL COMMENT '角色编码',
    `description` varchar(255)         DEFAULT NULL COMMENT '描述',
    `create_time` timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`  tinyint(3)  NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 13
  DEFAULT CHARSET = utf8 COMMENT ='角色';

#
# Data for table "sys_role"
#

INSERT INTO `sys_role`
VALUES (1, '系统管理员', 'SYSTEM', '系统管理员', '2021-05-31 18:09:18', '2022-06-08 09:21:10', 0),
       (2, '普通管理员', 'COMMON', '普通管理员', '2021-06-01 08:38:40', '2022-02-24 10:42:46', 0),
       (3, '用户管理员', 'yhgly', NULL, '2022-06-08 17:39:04', '2023-05-26 11:24:00', 1),
       (9, '测试2', 'ces2', NULL, '2023-05-26 11:20:19', '2023-05-26 11:20:32', 1),
       (10, '测试', '1', NULL, '2023-05-26 11:24:18', '2023-05-26 11:24:25', 1),
       (11, '测试', '1', NULL, '2023-05-26 11:24:33', '2023-05-26 11:24:41', 1),
       (12, '测试角色', 'ceshi', NULL, '2023-05-31 18:09:22', '2023-05-31 18:09:22', 0);

#
# Structure for table "sys_role_menu"
#

CREATE TABLE `sys_role_menu`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT,
    `role_id`     bigint(20) NOT NULL DEFAULT '0',
    `menu_id`     bigint(11) NOT NULL DEFAULT '0',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`),
    KEY `idx_role_id` (`role_id`),
    KEY `idx_menu_id` (`menu_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 709
  DEFAULT CHARSET = utf8 COMMENT ='角色菜单';

#
# Data for table "sys_role_menu"
#

INSERT INTO `sys_role_menu`
VALUES (1, 3, 2, '2023-04-21 11:25:58', '2023-05-26 11:04:52', 1),
       (2, 3, 3, '2023-04-21 11:26:03', '2023-05-26 11:04:52', 1),
       (3, 3, 6, '2023-04-21 11:26:10', '2023-05-26 11:04:52', 1),
       (4, 3, 2, '2023-05-26 11:04:52', '2023-05-26 11:05:01', 1),
       (5, 3, 3, '2023-05-26 11:04:52', '2023-05-26 11:05:01', 1),
       (6, 3, 6, '2023-05-26 11:04:52', '2023-05-26 11:05:01', 1),
       (7, 3, 7, '2023-05-26 11:04:52', '2023-05-26 11:05:01', 1),
       (8, 3, 8, '2023-05-26 11:04:52', '2023-05-26 11:05:01', 1),
       (9, 3, 9, '2023-05-26 11:04:52', '2023-05-26 11:05:01', 1),
       (10, 3, 18, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (11, 3, 4, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (12, 3, 10, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (13, 3, 11, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (14, 3, 12, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (15, 3, 13, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (16, 3, 19, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (17, 3, 5, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (18, 3, 14, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (19, 3, 15, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (20, 3, 16, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (21, 3, 17, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (22, 3, 20, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (23, 3, 21, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (24, 3, 24, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (25, 3, 25, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (26, 3, 26, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (27, 3, 22, '2023-05-26 11:04:53', '2023-05-26 11:05:01', 1),
       (28, 3, 23, '2023-05-26 11:04:54', '2023-05-26 11:05:01', 1),
       (29, 3, 27, '2023-05-26 11:04:54', '2023-05-26 11:05:01', 1),
       (30, 3, 28, '2023-05-26 11:04:54', '2023-05-26 11:05:01', 1),
       (31, 3, 29, '2023-05-26 11:04:54', '2023-05-26 11:05:01', 1),
       (32, 3, 34, '2023-05-26 11:04:54', '2023-05-26 11:05:01', 1),
       (33, 3, 30, '2023-05-26 11:04:54', '2023-05-26 11:05:01', 1),
       (34, 3, 31, '2023-05-26 11:04:54', '2023-05-26 11:05:01', 1),
       (35, 3, 32, '2023-05-26 11:04:54', '2023-05-26 11:05:01', 1),
       (36, 3, 33, '2023-05-26 11:04:54', '2023-05-26 11:05:01', 1),
       (37, 3, 2, '2023-05-26 11:05:01', '2023-05-26 11:05:43', 1),
       (38, 3, 3, '2023-05-26 11:05:01', '2023-05-26 11:05:43', 1),
       (39, 3, 6, '2023-05-26 11:05:01', '2023-05-26 11:05:43', 1),
       (40, 3, 7, '2023-05-26 11:05:01', '2023-05-26 11:05:43', 1),
       (41, 3, 8, '2023-05-26 11:05:01', '2023-05-26 11:05:43', 1),
       (42, 3, 9, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (43, 3, 18, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (44, 3, 4, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (45, 3, 10, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (46, 3, 11, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (47, 3, 12, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (48, 3, 13, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (49, 3, 19, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (50, 3, 5, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (51, 3, 14, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (52, 3, 15, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (53, 3, 16, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (54, 3, 17, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (55, 3, 20, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (56, 3, 21, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (57, 3, 24, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (58, 3, 25, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (59, 3, 26, '2023-05-26 11:05:02', '2023-05-26 11:05:43', 1),
       (60, 3, 22, '2023-05-26 11:05:03', '2023-05-26 11:05:43', 1),
       (61, 3, 23, '2023-05-26 11:05:03', '2023-05-26 11:05:43', 1),
       (62, 3, 27, '2023-05-26 11:05:03', '2023-05-26 11:05:43', 1),
       (63, 3, 28, '2023-05-26 11:05:03', '2023-05-26 11:05:43', 1),
       (64, 3, 29, '2023-05-26 11:05:03', '2023-05-26 11:05:43', 1),
       (65, 3, 34, '2023-05-26 11:05:03', '2023-05-26 11:05:43', 1),
       (66, 3, 30, '2023-05-26 11:05:03', '2023-05-26 11:05:43', 1),
       (67, 3, 31, '2023-05-26 11:05:03', '2023-05-26 11:05:43', 1),
       (68, 3, 32, '2023-05-26 11:05:03', '2023-05-26 11:05:43', 1),
       (69, 3, 33, '2023-05-26 11:05:03', '2023-05-26 11:05:43', 1),
       (70, 3, 2, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (71, 3, 3, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (72, 3, 6, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (73, 3, 7, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (74, 3, 8, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (75, 3, 9, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (76, 3, 18, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (77, 3, 4, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (78, 3, 10, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (79, 3, 11, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (80, 3, 12, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (81, 3, 13, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (82, 3, 19, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (83, 3, 5, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (84, 3, 14, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (85, 3, 15, '2023-05-26 11:05:43', '2023-05-26 11:05:51', 1),
       (86, 3, 16, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (87, 3, 17, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (88, 3, 20, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (89, 3, 21, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (90, 3, 24, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (91, 3, 25, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (92, 3, 26, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (93, 3, 22, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (94, 3, 23, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (95, 3, 27, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (96, 3, 28, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (97, 3, 29, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (98, 3, 34, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (99, 3, 30, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (100, 3, 31, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (101, 3, 32, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (102, 3, 33, '2023-05-26 11:05:44', '2023-05-26 11:05:51', 1),
       (103, 3, 3, '2023-05-26 11:05:51', '2023-05-26 11:05:57', 1),
       (104, 3, 6, '2023-05-26 11:05:51', '2023-05-26 11:05:57', 1),
       (105, 3, 7, '2023-05-26 11:05:51', '2023-05-26 11:05:57', 1),
       (106, 3, 8, '2023-05-26 11:05:51', '2023-05-26 11:05:57', 1),
       (107, 3, 9, '2023-05-26 11:05:51', '2023-05-26 11:05:57', 1),
       (108, 3, 18, '2023-05-26 11:05:51', '2023-05-26 11:05:57', 1),
       (109, 3, 2, '2023-05-26 11:05:57', '2023-05-26 11:05:57', 0),
       (110, 3, 3, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (111, 3, 6, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (112, 3, 7, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (113, 3, 8, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (114, 3, 9, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (115, 3, 18, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (116, 3, 4, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (117, 3, 10, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (118, 3, 11, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (119, 3, 12, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (120, 3, 13, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (121, 3, 19, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (122, 3, 5, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (123, 3, 14, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (124, 3, 15, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (125, 3, 16, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (126, 3, 17, '2023-05-26 11:05:58', '2023-05-26 11:05:58', 0),
       (127, 3, 20, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (128, 3, 21, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (129, 3, 24, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (130, 3, 25, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (131, 3, 26, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (132, 3, 22, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (133, 3, 23, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (134, 3, 27, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (135, 3, 28, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (136, 3, 29, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (137, 3, 34, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (138, 3, 30, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (139, 3, 31, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (140, 3, 32, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (141, 3, 33, '2023-05-26 11:05:59', '2023-05-26 11:05:59', 0),
       (142, 2, 4, '2023-05-26 11:12:08', '2023-05-26 11:12:12', 1),
       (143, 2, 10, '2023-05-26 11:12:08', '2023-05-26 11:12:12', 1),
       (144, 2, 11, '2023-05-26 11:12:08', '2023-05-26 11:12:12', 1),
       (145, 2, 12, '2023-05-26 11:12:08', '2023-05-26 11:12:12', 1),
       (146, 2, 13, '2023-05-26 11:12:08', '2023-05-26 11:12:12', 1),
       (147, 2, 19, '2023-05-26 11:12:08', '2023-05-26 11:12:12', 1),
       (148, 2, 11, '2023-05-26 11:12:12', '2023-05-26 11:12:19', 1),
       (149, 2, 12, '2023-05-26 11:12:12', '2023-05-26 11:12:19', 1),
       (150, 2, 13, '2023-05-26 11:12:12', '2023-05-26 11:12:19', 1),
       (151, 2, 19, '2023-05-26 11:12:12', '2023-05-26 11:12:19', 1),
       (152, 2, 2, '2023-05-26 11:12:19', '2023-05-26 11:32:27', 1),
       (153, 2, 3, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (154, 2, 6, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (155, 2, 7, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (156, 2, 8, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (157, 2, 9, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (158, 2, 18, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (159, 2, 4, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (160, 2, 10, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (161, 2, 11, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (162, 2, 12, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (163, 2, 13, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (164, 2, 19, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (165, 2, 5, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (166, 2, 14, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (167, 2, 15, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (168, 2, 16, '2023-05-26 11:12:20', '2023-05-26 11:32:27', 1),
       (169, 2, 17, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (170, 2, 20, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (171, 2, 21, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (172, 2, 24, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (173, 2, 25, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (174, 2, 26, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (175, 2, 22, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (176, 2, 23, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (177, 2, 27, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (178, 2, 28, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (179, 2, 29, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (180, 2, 34, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (181, 2, 30, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (182, 2, 31, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (183, 2, 32, '2023-05-26 11:12:21', '2023-05-26 11:32:27', 1),
       (184, 2, 33, '2023-05-26 11:12:22', '2023-05-26 11:32:27', 1),
       (185, 2, 7, '2023-05-26 11:32:27', '2023-05-26 11:32:34', 1),
       (186, 2, 8, '2023-05-26 11:32:27', '2023-05-26 11:32:34', 1),
       (187, 2, 9, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (188, 2, 18, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (189, 2, 4, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (190, 2, 10, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (191, 2, 11, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (192, 2, 12, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (193, 2, 13, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (194, 2, 19, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (195, 2, 5, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (196, 2, 14, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (197, 2, 15, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (198, 2, 16, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (199, 2, 17, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (200, 2, 20, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (201, 2, 21, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (202, 2, 24, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (203, 2, 25, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (204, 2, 26, '2023-05-26 11:32:28', '2023-05-26 11:32:34', 1),
       (205, 2, 22, '2023-05-26 11:32:29', '2023-05-26 11:32:34', 1),
       (206, 2, 23, '2023-05-26 11:32:29', '2023-05-26 11:32:34', 1),
       (207, 2, 27, '2023-05-26 11:32:29', '2023-05-26 11:32:34', 1),
       (208, 2, 28, '2023-05-26 11:32:29', '2023-05-26 11:32:34', 1),
       (209, 2, 29, '2023-05-26 11:32:29', '2023-05-26 11:32:34', 1),
       (210, 2, 34, '2023-05-26 11:32:29', '2023-05-26 11:32:34', 1),
       (211, 2, 30, '2023-05-26 11:32:29', '2023-05-26 11:32:34', 1),
       (212, 2, 31, '2023-05-26 11:32:29', '2023-05-26 11:32:34', 1),
       (213, 2, 32, '2023-05-26 11:32:29', '2023-05-26 11:32:34', 1),
       (214, 2, 33, '2023-05-26 11:32:29', '2023-05-26 11:32:34', 1),
       (215, 2, 2, '2023-05-26 11:32:34', '2023-05-31 18:07:32', 1),
       (216, 2, 3, '2023-05-26 11:32:34', '2023-05-31 18:07:32', 1),
       (217, 2, 6, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (218, 2, 7, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (219, 2, 8, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (220, 2, 9, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (221, 2, 18, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (222, 2, 4, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (223, 2, 10, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (224, 2, 11, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (225, 2, 12, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (226, 2, 13, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (227, 2, 19, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (228, 2, 5, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (229, 2, 14, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (230, 2, 15, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (231, 2, 16, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (232, 2, 17, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (233, 2, 20, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (234, 2, 21, '2023-05-26 11:32:35', '2023-05-31 18:07:32', 1),
       (235, 2, 24, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (236, 2, 25, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (237, 2, 26, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (238, 2, 22, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (239, 2, 23, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (240, 2, 27, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (241, 2, 28, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (242, 2, 29, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (243, 2, 34, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (244, 2, 30, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (245, 2, 31, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (246, 2, 32, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (247, 2, 33, '2023-05-26 11:32:36', '2023-05-31 18:07:32', 1),
       (248, 1, 2, '2023-05-27 11:19:32', '2023-05-31 17:16:37', 1),
       (249, 1, 3, '2023-05-27 11:19:32', '2023-05-31 17:16:37', 1),
       (250, 1, 6, '2023-05-27 11:19:32', '2023-05-31 17:16:37', 1),
       (251, 1, 7, '2023-05-27 11:19:32', '2023-05-31 17:16:37', 1),
       (252, 1, 8, '2023-05-27 11:19:32', '2023-05-31 17:16:37', 1),
       (253, 1, 9, '2023-05-27 11:19:32', '2023-05-31 17:16:37', 1),
       (254, 1, 18, '2023-05-27 11:19:32', '2023-05-31 17:16:37', 1),
       (255, 1, 4, '2023-05-27 11:19:32', '2023-05-31 17:16:37', 1),
       (256, 1, 10, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (257, 1, 11, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (258, 1, 12, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (259, 1, 13, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (260, 1, 19, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (261, 1, 39, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (262, 1, 5, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (263, 1, 14, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (264, 1, 15, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (265, 1, 16, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (266, 1, 17, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (267, 1, 20, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (268, 1, 21, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (269, 1, 24, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (270, 1, 25, '2023-05-27 11:19:33', '2023-05-31 17:16:37', 1),
       (271, 1, 26, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (272, 1, 22, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (273, 1, 23, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (274, 1, 27, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (275, 1, 28, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (276, 1, 29, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (277, 1, 34, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (278, 1, 30, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (279, 1, 31, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (280, 1, 32, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (281, 1, 33, '2023-05-27 11:19:34', '2023-05-31 17:16:37', 1),
       (282, 1, 2, '2023-05-31 17:16:37', '2023-05-31 17:16:37', 0),
       (283, 1, 3, '2023-05-31 17:16:37', '2023-05-31 17:16:37', 0),
       (284, 1, 6, '2023-05-31 17:16:37', '2023-05-31 17:16:37', 0),
       (285, 1, 7, '2023-05-31 17:16:37', '2023-05-31 17:16:37', 0),
       (286, 1, 8, '2023-05-31 17:16:37', '2023-05-31 17:16:37', 0),
       (287, 1, 9, '2023-05-31 17:16:37', '2023-05-31 17:16:37', 0),
       (288, 1, 41, '2023-05-31 17:16:37', '2023-05-31 17:16:37', 0),
       (289, 1, 4, '2023-05-31 17:16:37', '2023-05-31 17:16:37', 0),
       (290, 1, 10, '2023-05-31 17:16:37', '2023-05-31 17:16:37', 0),
       (291, 1, 11, '2023-05-31 17:16:37', '2023-05-31 17:16:37', 0),
       (292, 1, 12, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (293, 1, 13, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (294, 1, 42, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (295, 1, 5, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (296, 1, 14, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (297, 1, 15, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (298, 1, 16, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (299, 1, 17, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (300, 1, 20, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (301, 1, 21, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (302, 1, 24, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (303, 1, 25, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (304, 1, 26, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (305, 1, 22, '2023-05-31 17:16:38', '2023-05-31 17:16:38', 0),
       (306, 1, 23, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (307, 1, 27, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (308, 1, 28, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (309, 1, 29, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (310, 1, 34, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (311, 1, 30, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (312, 1, 31, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (313, 1, 32, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (314, 1, 33, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (315, 1, 45, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (316, 1, 46, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (317, 1, 47, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (318, 1, 49, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (319, 1, 55, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (320, 1, 56, '2023-05-31 17:16:39', '2023-05-31 17:16:39', 0),
       (321, 1, 57, '2023-05-31 17:16:40', '2023-05-31 17:16:40', 0),
       (322, 1, 58, '2023-05-31 17:16:40', '2023-05-31 17:16:40', 0),
       (323, 1, 59, '2023-05-31 17:16:40', '2023-05-31 17:16:40', 0),
       (324, 1, 50, '2023-05-31 17:16:40', '2023-05-31 17:16:40', 0),
       (325, 1, 51, '2023-05-31 17:16:40', '2023-05-31 17:16:40', 0),
       (326, 1, 52, '2023-05-31 17:16:40', '2023-05-31 17:16:40', 0),
       (327, 1, 53, '2023-05-31 17:16:40', '2023-05-31 17:16:40', 0),
       (328, 1, 54, '2023-05-31 17:16:40', '2023-05-31 17:16:40', 0),
       (329, 2, 6, '2023-05-31 18:07:32', '2023-05-31 18:08:09', 1),
       (330, 2, 7, '2023-05-31 18:07:32', '2023-05-31 18:08:09', 1),
       (331, 2, 9, '2023-05-31 18:07:32', '2023-05-31 18:08:09', 1),
       (332, 2, 41, '2023-05-31 18:07:32', '2023-05-31 18:08:09', 1),
       (333, 2, 10, '2023-05-31 18:07:32', '2023-05-31 18:08:09', 1),
       (334, 2, 11, '2023-05-31 18:07:32', '2023-05-31 18:08:09', 1),
       (335, 2, 13, '2023-05-31 18:07:32', '2023-05-31 18:08:09', 1),
       (336, 2, 42, '2023-05-31 18:07:32', '2023-05-31 18:08:09', 1),
       (337, 2, 5, '2023-05-31 18:07:32', '2023-05-31 18:08:09', 1),
       (338, 2, 14, '2023-05-31 18:07:32', '2023-05-31 18:08:09', 1),
       (339, 2, 15, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (340, 2, 16, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (341, 2, 17, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (342, 2, 20, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (343, 2, 21, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (344, 2, 24, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (345, 2, 25, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (346, 2, 26, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (347, 2, 22, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (348, 2, 23, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (349, 2, 27, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (350, 2, 28, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (351, 2, 29, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (352, 2, 34, '2023-05-31 18:07:33', '2023-05-31 18:08:09', 1),
       (353, 2, 30, '2023-05-31 18:07:34', '2023-05-31 18:08:09', 1),
       (354, 2, 31, '2023-05-31 18:07:34', '2023-05-31 18:08:09', 1),
       (355, 2, 32, '2023-05-31 18:07:34', '2023-05-31 18:08:09', 1),
       (356, 2, 33, '2023-05-31 18:07:34', '2023-05-31 18:08:09', 1),
       (357, 2, 6, '2023-05-31 18:08:09', '2023-05-31 18:13:21', 1),
       (358, 2, 7, '2023-05-31 18:08:09', '2023-05-31 18:13:21', 1),
       (359, 2, 9, '2023-05-31 18:08:09', '2023-05-31 18:13:21', 1),
       (360, 2, 41, '2023-05-31 18:08:09', '2023-05-31 18:13:21', 1),
       (361, 2, 10, '2023-05-31 18:08:09', '2023-05-31 18:13:21', 1),
       (362, 2, 11, '2023-05-31 18:08:09', '2023-05-31 18:13:21', 1),
       (363, 2, 13, '2023-05-31 18:08:09', '2023-05-31 18:13:21', 1),
       (364, 2, 42, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (365, 2, 5, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (366, 2, 14, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (367, 2, 15, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (368, 2, 16, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (369, 2, 17, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (370, 2, 20, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (371, 2, 21, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (372, 2, 24, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (373, 2, 25, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (374, 2, 26, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (375, 2, 22, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (376, 2, 23, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (377, 2, 27, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (378, 2, 28, '2023-05-31 18:08:10', '2023-05-31 18:13:21', 1),
       (379, 2, 29, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (380, 2, 34, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (381, 2, 30, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (382, 2, 31, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (383, 2, 32, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (384, 2, 33, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (385, 2, 45, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (386, 2, 46, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (387, 2, 47, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (388, 2, 49, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (389, 2, 55, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (390, 2, 56, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (391, 2, 57, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (392, 2, 58, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (393, 2, 59, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (394, 2, 50, '2023-05-31 18:08:11', '2023-05-31 18:13:21', 1),
       (395, 2, 51, '2023-05-31 18:08:12', '2023-05-31 18:13:21', 1),
       (396, 2, 52, '2023-05-31 18:08:12', '2023-05-31 18:13:21', 1),
       (397, 12, 6, '2023-05-31 18:09:39', '2023-05-31 19:20:05', 1),
       (398, 12, 7, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (399, 12, 9, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (400, 12, 41, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (401, 12, 10, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (402, 12, 11, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (403, 12, 13, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (404, 12, 42, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (405, 12, 5, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (406, 12, 14, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (407, 12, 15, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (408, 12, 16, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (409, 12, 17, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (410, 12, 20, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (411, 12, 21, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (412, 12, 24, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (413, 12, 25, '2023-05-31 18:09:40', '2023-05-31 19:20:05', 1),
       (414, 12, 26, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (415, 12, 22, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (416, 12, 23, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (417, 12, 27, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (418, 12, 28, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (419, 12, 29, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (420, 12, 34, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (421, 12, 30, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (422, 12, 31, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (423, 12, 32, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (424, 12, 33, '2023-05-31 18:09:41', '2023-05-31 19:20:05', 1),
       (425, 2, 6, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (426, 2, 7, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (427, 2, 9, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (428, 2, 41, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (429, 2, 10, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (430, 2, 11, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (431, 2, 13, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (432, 2, 42, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (433, 2, 5, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (434, 2, 14, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (435, 2, 15, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (436, 2, 16, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (437, 2, 17, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (438, 2, 20, '2023-05-31 18:13:21', '2023-05-31 18:15:52', 1),
       (439, 2, 21, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (440, 2, 24, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (441, 2, 25, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (442, 2, 26, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (443, 2, 22, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (444, 2, 23, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (445, 2, 27, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (446, 2, 28, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (447, 2, 29, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (448, 2, 34, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (449, 2, 30, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (450, 2, 31, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (451, 2, 32, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (452, 2, 33, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (453, 2, 45, '2023-05-31 18:13:22', '2023-05-31 18:15:52', 1),
       (454, 2, 46, '2023-05-31 18:13:23', '2023-05-31 18:15:52', 1),
       (455, 2, 47, '2023-05-31 18:13:23', '2023-05-31 18:15:52', 1),
       (456, 2, 49, '2023-05-31 18:13:23', '2023-05-31 18:15:52', 1),
       (457, 2, 55, '2023-05-31 18:13:23', '2023-05-31 18:15:52', 1),
       (458, 2, 56, '2023-05-31 18:13:23', '2023-05-31 18:15:52', 1),
       (459, 2, 57, '2023-05-31 18:13:23', '2023-05-31 18:15:52', 1),
       (460, 2, 58, '2023-05-31 18:13:23', '2023-05-31 18:15:52', 1),
       (461, 2, 59, '2023-05-31 18:13:23', '2023-05-31 18:15:52', 1),
       (462, 2, 6, '2023-05-31 18:15:52', '2023-07-17 14:13:04', 1),
       (463, 2, 7, '2023-05-31 18:15:52', '2023-07-17 14:13:04', 1),
       (464, 2, 9, '2023-05-31 18:15:52', '2023-07-17 14:13:04', 1),
       (465, 2, 41, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (466, 2, 10, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (467, 2, 11, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (468, 2, 13, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (469, 2, 42, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (470, 2, 5, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (471, 2, 14, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (472, 2, 15, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (473, 2, 16, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (474, 2, 17, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (475, 2, 20, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (476, 2, 21, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (477, 2, 24, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (478, 2, 25, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (479, 2, 26, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (480, 2, 22, '2023-05-31 18:15:53', '2023-07-17 14:13:04', 1),
       (481, 2, 23, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (482, 2, 27, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (483, 2, 28, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (484, 2, 29, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (485, 2, 34, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (486, 2, 30, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (487, 2, 31, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (488, 2, 32, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (489, 2, 33, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (490, 2, 45, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (491, 2, 46, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (492, 2, 47, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (493, 2, 49, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (494, 2, 55, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (495, 2, 56, '2023-05-31 18:15:54', '2023-07-17 14:13:04', 1),
       (496, 2, 57, '2023-05-31 18:15:55', '2023-07-17 14:13:04', 1),
       (497, 2, 58, '2023-05-31 18:15:55', '2023-07-17 14:13:04', 1),
       (498, 2, 59, '2023-05-31 18:15:55', '2023-07-17 14:13:04', 1),
       (499, 2, 60, '2023-05-31 18:15:55', '2023-07-17 14:13:04', 1),
       (500, 12, 6, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (501, 12, 7, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (502, 12, 9, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (503, 12, 41, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (504, 12, 10, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (505, 12, 11, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (506, 12, 13, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (507, 12, 42, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (508, 12, 5, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (509, 12, 14, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (510, 12, 15, '2023-05-31 19:20:05', '2023-05-31 19:32:58', 1),
       (511, 12, 16, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (512, 12, 17, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (513, 12, 20, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (514, 12, 21, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (515, 12, 24, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (516, 12, 25, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (517, 12, 26, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (518, 12, 22, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (519, 12, 23, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (520, 12, 27, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (521, 12, 28, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (522, 12, 29, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (523, 12, 34, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (524, 12, 30, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (525, 12, 31, '2023-05-31 19:20:06', '2023-05-31 19:32:58', 1),
       (526, 12, 32, '2023-05-31 19:20:07', '2023-05-31 19:32:58', 1),
       (527, 12, 33, '2023-05-31 19:20:07', '2023-05-31 19:32:58', 1),
       (528, 12, 46, '2023-05-31 19:20:07', '2023-05-31 19:32:58', 1),
       (529, 12, 47, '2023-05-31 19:20:07', '2023-05-31 19:32:58', 1),
       (530, 12, 49, '2023-05-31 19:20:07', '2023-05-31 19:32:58', 1),
       (531, 12, 62, '2023-05-31 19:20:07', '2023-05-31 19:32:58', 1),
       (532, 12, 47, '2023-05-31 19:32:58', '2023-05-31 19:58:09', 1),
       (533, 12, 45, '2023-05-31 19:32:58', '2023-05-31 19:58:09', 1),
       (534, 12, 46, '2023-05-31 19:32:58', '2023-05-31 19:58:09', 1),
       (535, 12, 45, '2023-05-31 19:58:09', '2023-07-17 14:13:12', 1),
       (536, 12, 46, '2023-05-31 19:58:09', '2023-07-17 14:13:12', 1),
       (537, 12, 47, '2023-05-31 19:58:09', '2023-07-17 14:13:12', 1),
       (538, 2, 2, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (539, 2, 3, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (540, 2, 6, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (541, 2, 7, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (542, 2, 8, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (543, 2, 9, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (544, 2, 41, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (545, 2, 4, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (546, 2, 10, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (547, 2, 11, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (548, 2, 12, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (549, 2, 13, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (550, 2, 42, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (551, 2, 5, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (552, 2, 14, '2023-07-17 14:13:04', '2023-07-17 14:13:04', 0),
       (553, 2, 15, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (554, 2, 16, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (555, 2, 17, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (556, 2, 20, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (557, 2, 21, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (558, 2, 24, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (559, 2, 25, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (560, 2, 26, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (561, 2, 22, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (562, 2, 23, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (563, 2, 27, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (564, 2, 28, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (565, 2, 29, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (566, 2, 34, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (567, 2, 30, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (568, 2, 31, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (569, 2, 32, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (570, 2, 33, '2023-07-17 14:13:05', '2023-07-17 14:13:05', 0),
       (571, 2, 45, '2023-07-17 14:13:06', '2023-07-17 14:13:06', 0),
       (572, 2, 46, '2023-07-17 14:13:06', '2023-07-17 14:13:06', 0),
       (573, 2, 47, '2023-07-17 14:13:06', '2023-07-17 14:13:06', 0),
       (574, 2, 49, '2023-07-17 14:13:06', '2023-07-17 14:13:06', 0),
       (575, 2, 55, '2023-07-17 14:13:06', '2023-07-17 14:13:06', 0),
       (576, 2, 56, '2023-07-17 14:13:06', '2023-07-17 14:13:06', 0),
       (577, 2, 58, '2023-07-17 14:13:06', '2023-07-17 14:13:06', 0),
       (578, 2, 59, '2023-07-17 14:13:06', '2023-07-17 14:13:06', 0),
       (579, 12, 2, '2023-07-17 14:13:12', '2023-07-18 09:30:55', 1),
       (580, 12, 3, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (581, 12, 6, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (582, 12, 7, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (583, 12, 8, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (584, 12, 9, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (585, 12, 41, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (586, 12, 4, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (587, 12, 10, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (588, 12, 11, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (589, 12, 12, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (590, 12, 13, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (591, 12, 42, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (592, 12, 5, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (593, 12, 14, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (594, 12, 15, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (595, 12, 16, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (596, 12, 17, '2023-07-17 14:13:13', '2023-07-18 09:30:55', 1),
       (597, 12, 20, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (598, 12, 21, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (599, 12, 24, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (600, 12, 25, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (601, 12, 26, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (602, 12, 22, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (603, 12, 23, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (604, 12, 27, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (605, 12, 28, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (606, 12, 29, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (607, 12, 34, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (608, 12, 30, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (609, 12, 31, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (610, 12, 32, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (611, 12, 33, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (612, 12, 45, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (613, 12, 46, '2023-07-17 14:13:14', '2023-07-18 09:30:55', 1),
       (614, 12, 47, '2023-07-17 14:13:15', '2023-07-18 09:30:55', 1),
       (615, 12, 49, '2023-07-17 14:13:15', '2023-07-18 09:30:55', 1),
       (616, 12, 55, '2023-07-17 14:13:15', '2023-07-18 09:30:55', 1),
       (617, 12, 56, '2023-07-17 14:13:15', '2023-07-18 09:30:55', 1),
       (618, 12, 61, '2023-07-17 14:13:15', '2023-07-18 09:30:55', 1),
       (619, 12, 62, '2023-07-17 14:13:15', '2023-07-18 09:30:55', 1),
       (620, 12, 58, '2023-07-17 14:13:15', '2023-07-18 09:30:55', 1),
       (621, 12, 59, '2023-07-17 14:13:15', '2023-07-18 09:30:55', 1),
       (622, 12, 45, '2023-07-18 09:30:56', '2023-07-18 09:34:17', 1),
       (623, 12, 46, '2023-07-18 09:30:56', '2023-07-18 09:34:17', 1),
       (624, 12, 47, '2023-07-18 09:30:56', '2023-07-18 09:34:17', 1),
       (625, 12, 49, '2023-07-18 09:30:56', '2023-07-18 09:34:17', 1),
       (626, 12, 55, '2023-07-18 09:30:56', '2023-07-18 09:34:17', 1),
       (627, 12, 56, '2023-07-18 09:30:56', '2023-07-18 09:34:17', 1),
       (628, 12, 61, '2023-07-18 09:30:56', '2023-07-18 09:34:17', 1),
       (629, 12, 62, '2023-07-18 09:30:56', '2023-07-18 09:34:17', 1),
       (630, 12, 58, '2023-07-18 09:30:56', '2023-07-18 09:34:17', 1),
       (631, 12, 59, '2023-07-18 09:30:56', '2023-07-18 09:34:17', 1),
       (632, 12, 6, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (633, 12, 45, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (634, 12, 46, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (635, 12, 47, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (636, 12, 49, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (637, 12, 55, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (638, 12, 56, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (639, 12, 61, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (640, 12, 62, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (641, 12, 58, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (642, 12, 59, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (643, 12, 2, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (644, 12, 3, '2023-07-18 09:34:17', '2023-07-18 09:35:16', 1),
       (645, 12, 45, '2023-07-18 09:35:16', '2023-07-18 09:35:25', 1),
       (646, 12, 46, '2023-07-18 09:35:16', '2023-07-18 09:35:25', 1),
       (647, 12, 47, '2023-07-18 09:35:16', '2023-07-18 09:35:25', 1),
       (648, 12, 49, '2023-07-18 09:35:16', '2023-07-18 09:35:25', 1),
       (649, 12, 55, '2023-07-18 09:35:16', '2023-07-18 09:35:25', 1),
       (650, 12, 56, '2023-07-18 09:35:16', '2023-07-18 09:35:25', 1),
       (651, 12, 61, '2023-07-18 09:35:17', '2023-07-18 09:35:25', 1),
       (652, 12, 62, '2023-07-18 09:35:17', '2023-07-18 09:35:25', 1),
       (653, 12, 58, '2023-07-18 09:35:17', '2023-07-18 09:35:25', 1),
       (654, 12, 59, '2023-07-18 09:35:17', '2023-07-18 09:35:25', 1),
       (655, 12, 6, '2023-07-18 09:35:25', '2023-07-18 09:38:35', 1),
       (656, 12, 45, '2023-07-18 09:35:25', '2023-07-18 09:38:35', 1),
       (657, 12, 46, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (658, 12, 47, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (659, 12, 49, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (660, 12, 55, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (661, 12, 56, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (662, 12, 61, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (663, 12, 62, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (664, 12, 58, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (665, 12, 59, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (666, 12, 2, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (667, 12, 3, '2023-07-18 09:35:26', '2023-07-18 09:38:35', 1),
       (668, 12, 7, '2023-07-18 09:38:35', '2023-07-18 09:45:00', 1),
       (669, 12, 8, '2023-07-18 09:38:35', '2023-07-18 09:45:00', 1),
       (670, 12, 9, '2023-07-18 09:38:35', '2023-07-18 09:45:00', 1),
       (671, 12, 41, '2023-07-18 09:38:35', '2023-07-18 09:45:00', 1),
       (672, 12, 11, '2023-07-18 09:38:35', '2023-07-18 09:45:00', 1),
       (673, 12, 12, '2023-07-18 09:38:35', '2023-07-18 09:45:00', 1),
       (674, 12, 13, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (675, 12, 42, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (676, 12, 5, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (677, 12, 14, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (678, 12, 15, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (679, 12, 16, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (680, 12, 17, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (681, 12, 20, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (682, 12, 21, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (683, 12, 24, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (684, 12, 25, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (685, 12, 26, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (686, 12, 22, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (687, 12, 23, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (688, 12, 27, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (689, 12, 28, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (690, 12, 29, '2023-07-18 09:38:36', '2023-07-18 09:45:00', 1),
       (691, 12, 34, '2023-07-18 09:38:37', '2023-07-18 09:45:00', 1),
       (692, 12, 30, '2023-07-18 09:38:37', '2023-07-18 09:45:00', 1),
       (693, 12, 31, '2023-07-18 09:38:37', '2023-07-18 09:45:00', 1),
       (694, 12, 32, '2023-07-18 09:38:37', '2023-07-18 09:45:00', 1),
       (695, 12, 33, '2023-07-18 09:38:37', '2023-07-18 09:45:00', 1),
       (696, 12, 2, '2023-07-18 09:38:37', '2023-07-18 09:45:00', 1),
       (697, 12, 3, '2023-07-18 09:38:37', '2023-07-18 09:45:00', 1),
       (698, 12, 4, '2023-07-18 09:38:37', '2023-07-18 09:45:00', 1),
       (699, 12, 6, '2023-07-18 09:45:06', '2023-07-18 10:45:14', 1),
       (700, 12, 2, '2023-07-18 09:45:06', '2023-07-18 10:45:14', 1),
       (701, 12, 3, '2023-07-18 09:45:06', '2023-07-18 10:45:14', 1),
       (702, 12, 6, '2023-07-18 10:45:14', '2023-07-18 10:45:19', 1),
       (703, 12, 7, '2023-07-18 10:45:14', '2023-07-18 10:45:19', 1),
       (704, 12, 2, '2023-07-18 10:45:14', '2023-07-18 10:45:19', 1),
       (705, 12, 3, '2023-07-18 10:45:14', '2023-07-18 10:45:19', 1),
       (706, 12, 6, '2023-07-18 10:45:23', '2023-07-18 10:45:23', 0),
       (707, 12, 2, '2023-07-18 10:45:23', '2023-07-18 10:45:23', 0),
       (708, 12, 3, '2023-07-18 10:45:23', '2023-07-18 10:45:23', 0);

#
# Structure for table "sys_user"
#

CREATE TABLE `sys_user`
(
    `id`          bigint(20)  NOT NULL AUTO_INCREMENT COMMENT '会员id',
    `username`    varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
    `password`    varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
    `name`        varchar(50)          DEFAULT NULL COMMENT '姓名',
    `phone`       varchar(11)          DEFAULT NULL COMMENT '手机',
    `head_url`    varchar(200)         DEFAULT NULL COMMENT '头像地址',
    `dept_id`     bigint(20)           DEFAULT NULL COMMENT '部门id',
    `post_id`     bigint(20)           DEFAULT NULL COMMENT '岗位id',
    `description` varchar(255)         DEFAULT NULL COMMENT '描述',
    `status`      tinyint(3)           DEFAULT NULL COMMENT '状态（1：正常 0：停用）',
    `create_time` timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`  tinyint(3)  NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_username` (`username`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8mb4 COMMENT ='用户表';

#
# Data for table "sys_user"
#

INSERT INTO `sys_user`
VALUES (1, 'admin', '96e79218965eb72c92a549dd5a330112', 'admin', '15099909888',
        'http://r61cnlsfq.hn-bkt.clouddn.com/7daa4595-dfde-45da-8513-c5c2b81d20cc', 1021, 5, NULL, 1,
        '2021-05-31 18:08:43', '2022-05-25 11:34:25', 0),
       (2, 'wangqq', '96e79218965eb72c92a549dd5a330112', '王倩倩', '15010546381',
        'http://r61cnlsfq.hn-bkt.clouddn.com/b09b3467-3d99-437a-bd2e-dd8c9be92bb8', 1022, 6, NULL, 1,
        '2022-02-08 10:35:38', '2023-05-24 16:51:22', 0),
       (3, 'wanggang', '96e79218965eb72c92a549dd5a330112', '王刚', '18909098909', NULL, 1024, 5, NULL, 1,
        '2022-05-24 11:05:40', '2023-04-21 11:29:34', 0),
       (4, 'ceshi', 'e10adc3949ba59abbe56e057f20f883e', 'ceshi', '17796639675', NULL, 1022, 6, NULL, 1,
        '2023-05-24 18:20:43', '2023-05-24 18:20:43', 0),
       (5, 'ceshi2', 'e10adc3949ba59abbe56e057f20f883e', 'ceshi2', '17796639677', NULL, 1024, 6, NULL, 1,
        '2023-05-24 18:26:08', '2023-05-24 18:26:08', 0),
       (6, 'ceshiyonghu', '96e79218965eb72c92a549dd5a330112', 'ceshiyonghu', '12345678910', NULL, 1, 9, NULL, 1,
        '2023-05-31 18:01:06', '2023-05-31 18:01:06', 0);

#
# Structure for table "sys_user_role"
#

CREATE TABLE `sys_user_role`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
    `role_id`     bigint(20) NOT NULL DEFAULT '0' COMMENT '角色id',
    `user_id`     bigint(20) NOT NULL DEFAULT '0' COMMENT '用户id',
    `create_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`  tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除标记（0:不可用 1:可用）',
    PRIMARY KEY (`id`),
    KEY `idx_role_id` (`role_id`),
    KEY `idx_admin_id` (`user_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 20
  DEFAULT CHARSET = utf8 COMMENT ='用户角色';

#
# Data for table "sys_user_role"
#

INSERT INTO `sys_user_role`
VALUES (1, 3, 3, '2023-04-21 11:25:15', '2023-04-21 11:25:15', 0),
       (2, 3, 5, '2023-05-26 09:03:08', '2023-05-26 09:04:14', 1),
       (3, 1, 5, '2023-05-26 09:04:14', '2023-05-26 09:04:23', 1),
       (4, 2, 5, '2023-05-26 09:04:15', '2023-05-26 09:04:23', 1),
       (5, 3, 5, '2023-05-26 09:04:15', '2023-05-26 09:04:23', 1),
       (6, 3, 5, '2023-05-26 09:04:24', '2023-05-26 09:04:24', 0),
       (7, 1, 5, '2023-05-26 09:04:24', '2023-05-26 09:04:24', 0),
       (8, 2, 5, '2023-05-26 09:04:24', '2023-05-26 09:04:24', 0),
       (9, 1, 1, '2023-05-27 11:15:18', '2023-05-31 16:01:33', 1),
       (10, 2, 1, '2023-05-27 11:15:18', '2023-05-31 16:01:33', 1),
       (11, 1, 1, '2023-05-31 16:01:47', '2023-05-31 16:01:47', 0),
       (12, 2, 1, '2023-05-31 16:01:47', '2023-05-31 16:01:47', 0),
       (13, 2, 6, '2023-05-31 18:06:57', '2023-05-31 18:09:53', 1),
       (14, 12, 6, '2023-05-31 18:09:53', '2023-05-31 18:10:45', 1),
       (15, 12, 6, '2023-05-31 18:10:45', '2023-08-04 17:40:44', 1),
       (16, 2, 6, '2023-05-31 18:10:45', '2023-08-04 17:40:44', 1),
       (17, 2, 6, '2023-08-04 17:40:44', '2023-08-04 17:40:44', 0),
       (18, 12, 6, '2023-08-04 17:40:45', '2023-08-04 17:40:45', 0),
       (19, 1, 6, '2023-08-04 17:40:45', '2023-08-04 17:40:45', 0);

#
# Structure for table "undo_log"
#

CREATE TABLE `undo_log`
(
    `id`            bigint(20)   NOT NULL AUTO_INCREMENT,
    `branch_id`     bigint(20)   NOT NULL,
    `xid`           varchar(100) NOT NULL,
    `context`       varchar(128) NOT NULL,
    `rollback_info` longblob     NOT NULL,
    `log_status`    int(11)      NOT NULL,
    `log_created`   datetime     NOT NULL,
    `log_modified`  datetime     NOT NULL,
    `ext`           varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

#
# Data for table "undo_log"
#

