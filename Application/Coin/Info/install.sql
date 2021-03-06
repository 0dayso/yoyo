-- -----------------------------
-- 表结构 `ocenter_user_coin`
-- -----------------------------
CREATE TABLE IF NOT EXISTS `ocenter_user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `btc` decimal(10,8) NOT NULL COMMENT 'btc数量',
  `eth` decimal(10,8) NOT NULL COMMENT 'eth数量',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户币种';

-- -----------------------------
-- 表结构 `ocenter_coin_addr`
-- -----------------------------
CREATE TABLE IF NOT EXISTS `ocenter_coin_addr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `addr_type` tinyint(2) NOT NULL COMMENT '类型：1充值,2提款',
  `coin_type` tinyint(2) NOT NULL COMMENT '类型：1BTC,2ETH',
  `addr` varchar(50) NOT NULL COMMENT '钱包地址',
  `status` tinyint(2) NOT NULL COMMENT '状态：1正常，2冻结',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='钱包地址表';

-- -----------------------------
-- 表结构 `ocenter_tradead`
-- -----------------------------

CREATE TABLE IF NOT EXISTS `ocenter_tradead` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `type` tinyint(2) NOT NULL COMMENT '广告类型：1在线sell，2在线buy，3本地sell，4本地buy',
  `coin_type` tinyint(2) NOT NULL COMMENT '币种',
  `country` smallint(4) NOT NULL COMMENT '国家地区',
  `currency` varchar(5) NOT NULL COMMENT '货币类型',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `pre_price` tinyint(2) NOT NULL COMMENT '溢价',
  `low_price` decimal(10,2) NOT NULL COMMENT '最低价',
  `max_price` int(11) NULL COMMENT 'max',
  `min_price` int(11) NULL COMMENT 'min',
  `pay_type` smallint(4) NOT NULL COMMENT '付款方式',
  `pay_time` int(11) NULL,
  `pay_addr` varchar(50) NULL COMMENT '见面地点',
  `pay_text` varchar(50) NULL COMMENT '交易条款',
  `auto_message` varchar(100) NULL COMMENT '自动回复消息',
  `is_safe` tinyint(2) NOT NULL DEFAULT '0' COMMENT '安全验证',
  `is_trust` tinyint(2) NOT NULL DEFAULT '0'  COMMENT '信任验证',
  `open_time` varchar(200) NULL,
  `status` tinyint(2) NOT NULL COMMENT '状态：1开放，0关闭',
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4003 DEFAULT CHARSET=utf8 COMMENT='交易广告表';

-- -----------------------------
-- 表结构 `ocenter_trade_order`
-- -----------------------------
CREATE TABLE IF NOT EXISTS `ocenter_trade_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) NOT NULL,
  `order_id` varchar(20) NOT NULL,
  `ad_uid` int(11) NOT NULL,
  `get_uid` int(11) NOT NULL,
  `type` tinyint(2) NOT NULL COMMENT '广告类型：1在线sell，2在线buy，3本地sell，4本地buy',
  `coin_type` tinyint(2) NOT NULL COMMENT '币种',
  `coin_num` decimal(10,8) NOT NULL COMMENT '交易数量',
  `price` decimal(10,4) NOT NULL COMMENT '交易价格',
  `fee` decimal(10,8) NOT NULL COMMENT '手续费',
  `currency` varchar(5) NOT NULL COMMENT '货币类型',
  `pay_text` varchar(50) NULL COMMENT '交易条款',
  `status` tinyint(2) NOT NULL COMMENT '状态：1等待付款，2付款完毕，3确认完成，4，申诉，0取消',
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='交易表';

-- -----------------------------
-- 表结构 `ocenter_ticket`
-- -----------------------------
CREATE TABLE IF NOT EXISTS `ocenter_ticket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `type` varchar(10) NULL COMMENT '类型',
  `child_type` varchar(20) NULL COMMENT '子类型',
  `order_id` int(11) NOT NULL,
  `content` varchar(200) NULL COMMENT '内容',
  `images` varchar(200) NOT NULL COMMENT '图片',
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='支持工单';

-- ----------------------------
-- Table structure for `ocenter_country`
-- ----------------------------
CREATE TABLE IF NOT EXISTS `ocenter_country` (
  `id` smallint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `en_name` varchar(50) NOT NULL,
  `code` varchar(5) NOT NULL DEFAULT '',
  `code2` varchar(5) NOT NULL DEFAULT '',
  `code3` varchar(5) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `ocenter_pay`
-- ----------------------------
CREATE TABLE IF NOT EXISTS `ocenter_pay` (
  `id` smallint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `en_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `ocenter_country`
-- ----------------------------
CREATE TABLE IF NOT EXISTS `ocenter_currency` (
  `id` smallint(4) NOT NULL AUTO_INCREMENT,
  `code` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8;