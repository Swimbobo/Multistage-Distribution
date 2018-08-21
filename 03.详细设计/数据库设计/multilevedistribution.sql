/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018/8/21 17:54:52                           */
/*==============================================================*/


drop table if exists dealer;

drop table if exists exchange_orders;

drop table if exists goods;

drop table if exists goods_area_price;

drop table if exists manager;

drop table if exists manifest;

drop table if exists manifest_item;

drop table if exists orders;

drop table if exists orders_item;

drop table if exists prizes;

drop table if exists user;

/*==============================================================*/
/* Table: dealer                                                */
/*==============================================================*/
create table dealer
(
   dealer_id            bigint not null auto_increment comment '经销商ID，主键，不为空，自增，用于删查改',
   dealer_name          varchar(50) comment '经销商姓名，确认身份',
   dealer_phone         varchar(50) comment '经销商电话，取得联系',
   parent_id            bigint not null comment '上级ID，该经销商的上级，有可能是总部管理员有可能是上级经销商',
   authorization_code   varchar(50) not null,
   open_id              varchar(100),
   create_time          datetime not null,
   primary key (dealer_id)
);

alter table dealer comment '获得总部或者上级生成的授权码，然后提交给总部管理员进行授权
经销商在微信登陆，通过绑定的授权码，得知该经销商';

/*==============================================================*/
/* Table: exchange_orders                                       */
/*==============================================================*/
create table exchange_orders
(
   exchange_orders_id   bigint not null auto_increment,
   user_id              bigint,
   prizes_id            bigint,
   create_time          datetime,
   status               varchar(30),
   primary key (exchange_orders_id)
);

alter table exchange_orders comment '用户用积分兑换物品的订单，不可批量兑换';

/*==============================================================*/
/* Table: goods                                                 */
/*==============================================================*/
create table goods
(
   goods_id             bigint not null auto_increment,
   goods_name           varchar(50),
   goods_score          int,
   goods_pic            varchar(255),
   status               int not null,
   primary key (goods_id)
);

/*==============================================================*/
/* Table: goods_area_price                                      */
/*==============================================================*/
create table goods_area_price
(
   goods_area_price_id  bigint not null auto_increment,
   goods_id             bigint,
   bei_shang_guang_price decimal,
   hangzhou_price       decimal,
   shenzhen_price       decimal,
   zhuhai_price         decimal,
   dongguan_price       decimal,
   primary key (goods_area_price_id)
);

alter table goods_area_price comment '同一个商品因为各地区经济水平不用价格不同';

/*==============================================================*/
/* Table: manager                                               */
/*==============================================================*/
create table manager
(
   manager_id           bigint not null auto_increment comment '管理员ID，自增，不为空，唯一标识，可用于删查改',
   userName             varchar(50) not null comment '管理员账号，用于登录系统',
   password             varchar(50) not null comment '管理员密码，用于登录系统',
   manager_name         varchar(50) comment '管理员姓名，用于清楚管理员的真实身份',
   manager_phone        varchar(50) comment '管理员电话，用于联系管理员',
   create_time          datetime not null comment '管理员账号的创建时间，用于为后期其他检索业务做准备',
   status               int not null comment '管理员状态，是否被冻结的状态，用于管理员因为其他状况而进行冻结',
   primary key (manager_id)
);

alter table manager comment '经销商管理（增删查改），授权码绑定微信号（即增加一个经销商），解除绑定（即删除一个经销商），查询经销商信息，修改经销商信';

/*==============================================================*/
/* Table: manifest                                              */
/*==============================================================*/
create table manifest
(
   manifest_id          bigint not null auto_increment,
   dealers              varchar(200),
   create_time          datetime not null,
   status               varchar(30),
   orders_id            bigint not null,
   primary key (manifest_id)
);

/*==============================================================*/
/* Table: manifest_item                                         */
/*==============================================================*/
create table manifest_item
(
   manifest_item_id     bigint not null auto_increment,
   goods_id             bigint,
   manifest_id          bigint,
   goods_num            int,
   primary key (manifest_item_id)
);

alter table manifest_item comment '货单详情，货单内的商品详情';

/*==============================================================*/
/* Table: orders                                                */
/*==============================================================*/
create table orders
(
   orders_id            bigint not null auto_increment,
   dealers              varchar(200),
   create_time          datetime not null,
   status               varchar(30),
   user_id              bigint not null,
   primary key (orders_id)
);

/*==============================================================*/
/* Table: orders_item                                           */
/*==============================================================*/
create table orders_item
(
   orders_item_id       bigint not null auto_increment,
   goods_id             bigint,
   orders_id            bigint not null,
   goods_num            int,
   total_price          decimal,
   primary key (orders_item_id)
);

alter table orders_item comment '订单详情，购买商品的详情';

/*==============================================================*/
/* Table: prizes                                                */
/*==============================================================*/
create table prizes
(
   prizes_id            bigint not null auto_increment,
   prizes_name          varchar(50),
   prizes_score         int,
   prizes_pic           varchar(255),
   status               int not null,
   primary key (prizes_id)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              bigint not null auto_increment,
   open_id              varchar(100) not null,
   score                int,
   primary key (user_id)
);

alter table user comment '用户积分存储';

alter table exchange_orders add constraint FK_Reference_10 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table exchange_orders add constraint FK_Reference_9 foreign key (prizes_id)
      references prizes (prizes_id) on delete restrict on update restrict;

alter table goods_area_price add constraint FK_Reference_7 foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table manifest add constraint FK_Reference_4 foreign key (orders_id)
      references orders (orders_id) on delete restrict on update restrict;

alter table manifest_item add constraint FK_Reference_5 foreign key (manifest_id)
      references manifest (manifest_id) on delete restrict on update restrict;

alter table manifest_item add constraint FK_Reference_6 foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table orders add constraint FK_Reference_8 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table orders_item add constraint FK_Reference_2 foreign key (orders_id)
      references orders (orders_id) on delete restrict on update restrict;

alter table orders_item add constraint FK_Reference_3 foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

