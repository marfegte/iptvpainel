/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/5/7 16:21:04                            */
/*==============================================================*/
drop database if exists iptvm;
create database iptvm default character set utf8 collate utf8_general_ci;
use iptvm;


drop procedure if exists updateServerStatus;

drop procedure if exists updateStreamStatus;

drop table if exists account;

drop table if exists account_product;

drop table if exists admin_log;

drop table if exists administrator;

drop table if exists agent_log;

drop table if exists api;

drop table if exists channel;

drop table if exists channel_directory;

drop table if exists cpu;

drop table if exists directory;

drop table if exists disk;

drop table if exists io;

drop table if exists language;

drop table if exists loads;

drop table if exists memory;

drop table if exists menu;

drop table if exists mysql;

drop table if exists mysql_info;

drop table if exists nginx;

drop table if exists nginx_info;

drop table if exists online_client;

drop table if exists product;

drop table if exists product_channel;

drop table if exists productcard;

drop table if exists realtime;

drop table if exists server;

drop table if exists stb_log;

drop table if exists stbbind;

drop table if exists stream;

drop table if exists stream_info;

drop table if exists streaming_access_log;

drop table if exists streaming_log;

drop table if exists threshold;

drop table if exists timezone;

drop table if exists traffic;

/*==============================================================*/
/* Table: account                                               */
/*==============================================================*/
create table account
(
   accountId            varchar(20) not null comment '使用账户id',
   state                int not null comment '账户状态',
   enable               bool not null comment '是否启用',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '修改时间',
   primary key (accountId)
)
charset = UTF8
engine = InnoDB;

alter table account comment '账户';

/*==============================================================*/
/* Table: product                                               */
/*==============================================================*/
create table product
(
   productId            int not null auto_increment comment '产品id',
   productName          varchar(20) not null comment '产品名称',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '修改时间',
   primary key (productId)
)
charset = UTF8
engine = InnoDB;

alter table product comment '产品包';

/*==============================================================*/
/* Table: account_product                                       */
/*==============================================================*/
create table account_product
(
   accountId            varchar(20) not null comment '使用账户id',
   productId            int not null comment '产品id',
   endDate              bigint not null comment '到期时间',
   primary key (accountId, productId),
   constraint FK_account_product foreign key (accountId)
      references account (accountId) on delete cascade on update cascade,
   constraint FK_account_product2 foreign key (productId)
      references product (productId) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table account_product comment '账户拥有的产品包';

/*==============================================================*/
/* Table: admin_log                                             */
/*==============================================================*/
create table admin_log
(
   id                   bigint not null auto_increment comment 'id',
   level                int comment '级别',
   category             varchar(255) comment '类别',
   log_time             bigint comment '日志时间',
   prefix               text comment '前缀',
   message              text comment '日志信息',
   primary key (id)
)
charset = UTF8
engine = InnoDB;

alter table admin_log comment '管理员日志';

/*==============================================================*/
/* Table: administrator                                         */
/*==============================================================*/
create table administrator
(
   id                   int not null auto_increment comment '管理员id',
   userName             varchar(20) not null comment '登录用户名',
   password             varchar(100) not null comment '密码',
   realName             varchar(20) not null comment '真实姓名',
   email                varchar(50) not null comment '邮箱',
   type                 bool not null comment '类型',
   lastLoginTime        bigint not null comment '最后登录时间',
   authKey              varchar(20) not null comment 'yii密钥',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '修改时间',
   primary key (id)
)
charset = UTF8
engine = InnoDB;

alter table administrator comment '管理员';

/*==============================================================*/
/* Table: server                                                */
/*==============================================================*/
create table server
(
   serverName           varchar(128) not null comment '服务器名称',
   serverIp             varchar(30) not null comment '服务器Ip',
   status               bool not null comment '服务器状态',
   streamingStatus      bool not null comment '串流状态',
   operatingSystem      varchar(50) not null comment '操作系统',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '更新时间',
   primary key (serverName)
)
charset = UTF8
engine = InnoDB;

alter table server comment '服务器';

/*==============================================================*/
/* Table: agent_log                                             */
/*==============================================================*/
create table agent_log
(
   id                   bigint not null auto_increment comment 'id',
   moduleName           varchar(20) not null comment '模块名',
   server               varchar(128) not null comment '所在服务器',
   status               varchar(10) not null comment '状态',
   detail               varchar(200) not null comment '详情',
   recordTime           bigint not null comment '记录时间',
   primary key (id),
   constraint FK_server_agentlog foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table agent_log comment 'Agent日志';

/*==============================================================*/
/* Table: api                                                   */
/*==============================================================*/
create table api
(
   id                   int not null auto_increment comment 'id',
   interface            varchar(128) not null comment '接口',
   accessTimes          bigint not null comment '访问次数',
   primary key (id)
)
charset = UTF8
engine = InnoDB;

alter table api comment 'API访问';

/*==============================================================*/
/* Table: language                                              */
/*==============================================================*/
create table language
(
   languageId           int not null auto_increment comment '语言id',
   languageName         varchar(20) not null comment '语言名称',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '修改时间',
   primary key (languageId)
)
charset = UTF8
engine = InnoDB;

alter table language comment '语言';

/*==============================================================*/
/* Table: channel                                               */
/*==============================================================*/
create table channel
(
   channelId            int not null auto_increment comment '节目id',
   channelName          varchar(20) not null comment '节目名称',
   channelIp            varchar(30) not null comment '节目ip',
   channelPic           varchar(50) not null comment '节目缩略图',
   channelUrl           varchar(50) not null comment '节目url',
   urlType              varchar(20) not null comment 'url类型',
   channelType          varchar(10) not null comment '节目类型',
   languageId           int not null comment '语言id',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '修改时间',
   primary key (channelId),
   constraint FK_language_channel foreign key (languageId)
      references language (languageId) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table channel comment '节目';

/*==============================================================*/
/* Table: directory                                             */
/*==============================================================*/
create table directory
(
   directoryId          int not null auto_increment comment '目录id',
   parentId             int comment '目录父id',
   directoryName        varchar(20) not null comment '目录名称',
   showOrder            int not null comment '显示顺序',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '修改时间',
   primary key (directoryId),
   constraint FK_directory_directory foreign key (parentId)
      references directory (directoryId) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table directory comment '目录';

/*==============================================================*/
/* Table: channel_directory                                     */
/*==============================================================*/
create table channel_directory
(
   directoryId          int not null comment '目录id',
   channelId            int not null comment '节目id',
   primary key (directoryId, channelId),
   constraint FK_channel_directory foreign key (directoryId)
      references directory (directoryId) on delete cascade on update cascade,
   constraint FK_channel_directory2 foreign key (channelId)
      references channel (channelId) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table channel_directory comment '节目所在目录';

/*==============================================================*/
/* Table: cpu                                                   */
/*==============================================================*/
create table cpu
(
   user                 decimal(8,2) not null comment '执行用户进程时间',
   system               decimal(8,2) not null comment '内核运行时间',
   wait                 decimal(8,2) not null comment '等待IO时间',
   hardIrq              decimal(8,2) not null comment '处理硬中断时间',
   softIrq              decimal(8,2) not null comment '处理软中断时间',
   nice                 decimal(8,2) not null comment '调整进程优先级时间',
   steal                decimal(8,2) not null comment '强制等待时间',
   guest                decimal(8,2) not null comment '虚拟处理器运行时间',
   utilize              decimal(8,2) not null comment 'CPU总使用时间百分比',
   idle                 decimal(8,2) not null comment 'CPU空闲时间百分比',
   ncpu                 int not null comment 'CPU核数',
   recordTime           bigint not null comment '记录时间',
   server               varchar(128) not null comment '所属服务器',
   primary key (recordTime, server),
   constraint FK_server_cpu foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table cpu comment 'CPU';

/*==============================================================*/
/* Table: disk                                                  */
/*==============================================================*/
create table disk
(
   free                 decimal(15,2) not null comment '磁盘可用量（G）',
   used                 decimal(15,2) not null comment '磁盘已用量（G）',
   total                decimal(15,2) not null comment '磁盘总大小（G）',
   usedPercent          decimal(15,2) not null comment '磁盘已用量百分比',
   freePercent          decimal(15,2) not null comment '磁盘可用量百分比',
   recordTime           bigint not null comment '记录时间',
   server               varchar(128) not null comment '所属服务器',
   primary key (recordTime, server),
   constraint FK_server_disk foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table disk comment '磁盘';

/*==============================================================*/
/* Table: io                                                    */
/*==============================================================*/
create table io
(
   deviceName           varchar(50) not null comment '设备名',
   mergedRead           decimal(15,2) not null comment '单位时间合并读请求数',
   mergedWrite          decimal(15,2) not null comment '单位时间合并写请求数',
   readRequest          decimal(15,2) not null comment '单位时间读请求数',
   writeRequest         decimal(15,2) not null comment '单位时间写请求数',
   sectorRead           decimal(15,2) not null comment '单位时间读扇区数',
   sectorWrite          decimal(15,2) not null comment '单位时间写扇区数',
   sectorAverage        decimal(15,2) not null comment '所有IO请求的平均扇区大小',
   await                decimal(15,2) not null comment '处理IO请求平均耗时',
   scvtm                decimal(15,2) not null comment '服务IO请求平均耗时',
   utilize              decimal(15,2) not null comment 'CPU等待IO请求时间',
   recordTime           bigint not null comment '记录时间',
   server               varchar(128) not null comment '所属服务器',
   primary key (recordTime, server, deviceName),
   constraint FK_server_io foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table io comment '输入输出';

/*==============================================================*/
/* Table: loads                                                 */
/*==============================================================*/
create table loads
(
   load1                decimal(8,2) not null comment '一分钟平均负载',
   load5                decimal(8,2) not null comment '五分钟平均负载',
   load15               decimal(8,2) not null comment '十五分钟平均负载',
   processRun           decimal(8,2) not null comment '运行的进程数',
   processTotal         decimal(8,2) not null comment '总进程数',
   recordTime           bigint not null comment '记录时间',
   server               varchar(128) not null comment '所属服务器',
   primary key (recordTime, server),
   constraint FK_server_load foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table loads comment '负载';

/*==============================================================*/
/* Table: memory                                                */
/*==============================================================*/
create table memory
(
   free                 decimal(15,2) not null comment '空闲内存（Byte）',
   used                 decimal(15,2) not null comment '使用的内存（Byte）',
   buffer               decimal(15,2) not null comment 'buffer（Byte）',
   cache                decimal(15,2) not null comment 'cache（Byte）',
   total                decimal(15,2) not null comment '总内存（Byte）',
   utilize              decimal(15,2) not null comment '内存使用率',
   recordTime           bigint not null comment '记录时间',
   server               varchar(128) not null comment '所属服务器',
   primary key (recordTime, server),
   constraint FK_server_memory foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table memory comment '内存';

/*==============================================================*/
/* Table: menu                                                  */
/*==============================================================*/
create table menu
(
   id                   int not null auto_increment comment '菜单id',
   menuName             varchar(50) not null comment '菜单名',
   parentId             int comment '父菜单id',
   route                varchar(50) not null comment '路由',
   showLevel            int not null comment '显示级别',
   showOrder            int not null comment '显示顺序',
   icon                 varchar(100) not null comment '图标',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '修改时间',
   primary key (id),
   constraint FK_menu_menu foreign key (parentId)
      references menu (id) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table menu comment '菜单';

/*==============================================================*/
/* Table: mysql                                                 */
/*==============================================================*/
create table mysql
(
   status               bool not null comment '状态',
   server               varchar(128) not null comment '所属服务器',
   primary key (server),
   constraint FK_server_mysql foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table mysql comment 'MySQL';

/*==============================================================*/
/* Table: mysql_info                                            */
/*==============================================================*/
create table mysql_info
(
   status               bool not null comment '状态',
   totalConnections     int not null comment '总连接数',
   activeConnections    int not null comment '活动连接数',
   qps                  int not null comment '每秒请求数',
   tps                  int not null comment '每秒事务数',
   receiveTraffic       int not null comment '每秒接收流量（KB）',
   sendTraffic          int not null comment '每秒发送流量（KB）',
   recordTime           bigint not null comment '记录时间',
   server               varchar(128) not null comment '所属服务器',
   primary key (server, recordTime),
   constraint FK_server_mysqlinfo foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table mysql_info comment 'MySQL信息';

/*==============================================================*/
/* Table: nginx                                                 */
/*==============================================================*/
create table nginx
(
   status               bool not null comment '状态',
   server               varchar(128) not null comment '所属服务器',
   primary key (server),
   constraint FK_server_nginx foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table nginx comment 'nginx';

/*==============================================================*/
/* Table: nginx_info                                            */
/*==============================================================*/
create table nginx_info
(
   status               bool not null comment '状态',
   accept               int not null comment '接收的新连接数',
   handle               int not null comment '总共处理的连接数',
   request              int not null comment '总共产生连接数',
   active               int not null comment '活跃的连接数',
   readRequest          int not null comment '读请求数据的连接数',
   writeRequest         int not null comment '写数据的连接数',
   wait                 int not null comment '长连接等待的连接数',
   qps                  int not null comment '每秒处理请求数',
   responseTime         float not null comment '平均响应时间',
   recordTime           bigint not null comment '记录时间',
   server               varchar(128) not null comment '所属服务器',
   primary key (recordTime, server),
   constraint FK_server_nginxinfo foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table nginx_info comment 'nginx信息';

/*==============================================================*/
/* Table: online_client                                         */
/*==============================================================*/
create table online_client
(
   accountId            varchar(20) not null comment '账户ID',
   server               varchar(128) not null comment '访问服务器',
   stream               varchar(64) not null comment '访问流',
   Ip                   varchar(30) not null comment 'Ip',
   startTime            bigint not null comment '开始时间',
   totalTime            int not null comment '观看时长',
   primary key (accountId, server, stream),
   constraint FK_server_onlineclient foreign key (server)
      references server (serverName) on delete cascade on update cascade,
   constraint FK_account_onlineclient foreign key (accountId)
      references account (accountId) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table online_client comment '在线用户';

/*==============================================================*/
/* Table: product_channel                                       */
/*==============================================================*/
create table product_channel
(
   productId            int not null comment '产品id',
   channelId            int not null comment '节目id',
   primary key (productId, channelId),
   constraint FK_product_channel foreign key (productId)
      references product (productId) on delete cascade on update cascade,
   constraint FK_product_channel2 foreign key (channelId)
      references channel (channelId) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table product_channel comment '产品包下的节目';

/*==============================================================*/
/* Table: productcard                                           */
/*==============================================================*/
create table productcard
(
   cardNumber           varchar(50) not null comment '充值卡号',
   cardValue            int not null comment '充值卡时长',
   productId            int not null comment '产品id',
   cardState            bool not null comment '充值卡状态',
   useDate              bigint comment '充值卡使用时间',
   accountId            varchar(20) comment '使用账户id',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '修改时间',
   primary key (cardNumber),
   constraint FK_product_productcard foreign key (productId)
      references product (productId) on delete cascade on update restrict,
   constraint FK_account_productcard foreign key (accountId)
      references account (accountId) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table productcard comment '产品包充值卡';

/*==============================================================*/
/* Table: realtime                                              */
/*==============================================================*/
create table realtime
(
   server               varchar(128) not null comment '服务器',
   cpuUtilize           decimal(8,2) not null comment 'CPU利用率',
   memoryUtilize        decimal(8,2) not null comment '内存利用率',
   diskUtilize          decimal(8,2) not null comment '磁盘利用率',
   load1                decimal(8,2) not null comment '1分钟负载',
   recordTime           bigint not null comment '记录时间',
   primary key (server),
   constraint FK_server_realtime foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table realtime comment '实时';

/*==============================================================*/
/* Table: stb_log                                               */
/*==============================================================*/
create table stb_log
(
   id                   bigint not null auto_increment comment 'id',
   level                int comment '级别',
   category             varchar(255) comment '类别',
   log_time             bigint comment '日志时间',
   prefix               text comment '前缀',
   message              text comment '日志信息',
   primary key (id)
)
charset = UTF8
engine = InnoDB;

alter table stb_log comment '机顶盒日志';

/*==============================================================*/
/* Table: stbbind                                               */
/*==============================================================*/
create table stbbind
(
   productId            int not null comment '产品id',
   accountId            varchar(20) not null comment '使用账户id',
   bindDay              int not null comment '绑定期限',
   isActive             int not null comment '是否激活',
   activeDate           bigint comment '激活时间',
   primary key (productId, accountId),
   constraint FK_stbbind foreign key (productId)
      references product (productId) on delete cascade on update cascade,
   constraint FK_stbbind2 foreign key (accountId)
      references account (accountId) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table stbbind comment '机顶盒预绑定产品包';

/*==============================================================*/
/* Table: stream                                                */
/*==============================================================*/
create table stream
(
   streamName           varchar(64) not null comment '串流名',
   status               bool not null comment '串流状态',
   source               varchar(256) not null comment '流源',
   sourceStatus         bool not null comment '流源状态',
   server               varchar(128) not null comment '所属服务器',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '更新时间',
   primary key (streamName, server),
   constraint FK_server_stream foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table stream comment '串流';

/*==============================================================*/
/* Table: stream_info                                           */
/*==============================================================*/
create table stream_info
(
   streamName           varchar(64) not null comment '串流名',
   status               bool not null comment '串流状态',
   sourceStatus         bool not null comment '流源状态',
   user                 decimal(8,2) not null comment '用户态cpu消耗百分比',
   system               decimal(8,2) not null comment '系统态cpu消耗百分比',
   total                decimal(8,2) not null comment '总cpu消耗百分比',
   memory               decimal(8,2) not null comment '总内存消耗百分比',
   rss                  int not null comment '物理内存消耗（KB）',
   readByte             int not null comment '进程io读字节',
   writeByte            int not null comment '进程io写字节',
   recordTime           bigint not null comment '记录时间',
   server               varchar(128) not null comment '所属服务器',
   primary key (streamName, recordTime, server),
   constraint FK_server_streaminfo foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table stream_info comment '串流信息';

/*==============================================================*/
/* Table: streaming_access_log                                  */
/*==============================================================*/
create table streaming_access_log
(
   id                   bigint not null auto_increment comment 'id',
   accountId            varchar(20) not null comment '用户ID',
   server               varchar(128) not null comment '访问服务器',
   stream               varchar(64) not null comment '访问流',
   Ip                   varchar(30) not null comment 'Ip',
   startTime            bigint not null comment '开始时间',
   endTime              bigint not null comment '结束时间',
   totalTime            int not null comment '总时长',
   primary key (id),
   constraint FK_server_streamingaccesslog foreign key (server)
      references server (serverName) on delete cascade on update cascade,
   constraint FK_account_streamingaccesslog foreign key (accountId)
      references account (accountId) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table streaming_access_log comment '串流访问日志';

/*==============================================================*/
/* Table: streaming_log                                         */
/*==============================================================*/
create table streaming_log
(
   id                   bigint not null auto_increment comment 'id',
   streamName           varchar(64) not null comment '串流名',
   server               varchar(128) not null comment '所属服务器',
   status               varchar(10) not null comment '状态',
   detail               varchar(200) not null comment '详情',
   recordTime           bigint not null comment '记录时间',
   primary key (id),
   constraint FK_server_streaminglog foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table streaming_log comment '串流日志';

/*==============================================================*/
/* Table: threshold                                             */
/*==============================================================*/
create table threshold
(
   cpu                  decimal(8,2) not null comment 'cpu（%）',
   memory               decimal(8,2) not null comment '内存（%）',
   disk                 decimal(8,2) not null comment '磁盘（%）',
   loads                decimal(8,2) not null comment '负载（%）'
)
charset = UTF8
engine = InnoDB;

alter table threshold comment '阈值';

/*==============================================================*/
/* Table: timezone                                              */
/*==============================================================*/
create table timezone
(
   timezone             varchar(50) not null comment '时区名',
   isCurrent            bool not null comment '目前时区',
   status               bool not null comment '启用状态',
   continent            varchar(50) not null comment '大洲',
   country              varchar(50) not null comment '国家',
   icon                 varchar(100) not null comment '图标',
   chinese              varchar(50) not null comment '中文名称',
   createTime           bigint not null comment '创建时间',
   updateTime           bigint not null comment '更新时间',
   primary key (timezone)
)
charset = UTF8
engine = InnoDB;

alter table timezone comment '时区';

/*==============================================================*/
/* Table: traffic                                               */
/*==============================================================*/
create table traffic
(
   port                 varchar(64) not null comment '端口',
   byteIn               decimal(15,2) not null comment '入口流量',
   byteOut              decimal(15,2) not null comment '出口流量',
   packetIn             decimal(15,2) not null comment '入口包数',
   packetOut            decimal(15,2) not null comment '出口包数',
   recordTime           bigint not null comment '记录时间',
   server               varchar(128) not null comment '所属服务器',
   primary key (recordTime, server, port),
   constraint FK_server_traffic foreign key (server)
      references server (serverName) on delete cascade on update cascade
)
charset = UTF8
engine = InnoDB;

alter table traffic comment '流量';


DELIMITER $$
CREATE PROCEDURE updateServerStatus()
BEGIN
    DECLARE Done INT DEFAULT 0;
	DECLARE pserver VARCHAR(128);
	DECLARE precordtime BIGINT;
	DECLARE pstatus TINYINT; 
	DECLARE pdiff INT;
	DECLARE pcursor CURSOR FOR SELECT `server`,recordTime FROM realtime;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET Done = 1;
	OPEN pcursor;
	FETCH NEXT FROM pcursor INTO pserver,precordtime;
	REPEAT
		IF NOT Done THEN
			#SELECT pserver,precordtime;
			SELECT UNIX_TIMESTAMP(NOW())-precordtime INTO pdiff;
			SELECT status INTO pstatus FROM `server` WHERE serverName=pserver;
			IF pdiff > 60 && pstatus = 1 THEN
				UPDATE `server` SET `status`=0 WHERE serverName=pserver;
			END IF;
			IF pdiff < 60 && pstatus = 0 THEN
				UPDATE `server` SET `status`=1 WHERE serverName=pserver;
			END IF;
			#SELECT pstatus;
		END IF;
		FETCH NEXT FROM pcursor INTO pserver,precordtime;
	UNTIL Done END REPEAT;
	CLOSE pcursor;
END
$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE updateStreamStatus()
BEGIN
	DECLARE Done INT DEFAULT 0;
	DECLARE pserver VARCHAR(128);
	DECLARE pstreamingStatus TINYINT;

	DECLARE pcursor CURSOR FOR SELECT serverName,streamingStatus FROM `server`;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET Done = 1;
	OPEN pcursor;
	FETCH NEXT FROM pcursor INTO pserver,pstreamingStatus;
	REPEAT
		IF NOT Done THEN
			IF pstreamingStatus = 0 THEN
				UPDATE stream SET `status`=0 WHERE `server`=pserver;
			END IF;
		END IF;
		FETCH NEXT FROM pcursor INTO pserver,pstreamingStatus;
	UNTIL Done END REPEAT;
	CLOSE pcursor;
END
$$
DELIMITER ;

# trigger
DROP TRIGGER IF EXISTS `insertApp`;
DELIMITER $$
CREATE TRIGGER `insertApp` 
AFTER INSERT ON `server` 
FOR EACH ROW 
BEGIN
insert into mysql values (0, new.serverName );
insert into nginx values (0, new.serverName );
END
$$
DELIMITER ;

# scheduler event
SET GLOBAL event_scheduler = 1;
DROP EVENT IF EXISTS `callUpdateServerProcedure`;
DELIMITER $$
CREATE EVENT `callUpdateServerProcedure` ON SCHEDULE EVERY 1 SECOND STARTS CURRENT_TIMESTAMP ON COMPLETION NOT PRESERVE ENABLE DO CALL updateServerStatus
$$
DELIMITER ;

DROP EVENT IF EXISTS `callUpdateStreamProcedure`;
DELIMITER $$
CREATE EVENT `callUpdateStreamProcedure` ON SCHEDULE EVERY 1 MINUTE STARTS CURRENT_TIMESTAMP ON COMPLETION NOT PRESERVE ENABLE DO CALL updateStreamStatus
$$