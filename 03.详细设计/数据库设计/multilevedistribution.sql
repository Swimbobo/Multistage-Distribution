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
   dealer_id            bigint not null auto_increment comment '������ID����������Ϊ�գ�����������ɾ���',
   dealer_name          varchar(50) comment '������������ȷ�����',
   dealer_phone         varchar(50) comment '�����̵绰��ȡ����ϵ',
   parent_id            bigint not null comment '�ϼ�ID���þ����̵��ϼ����п������ܲ�����Ա�п������ϼ�������',
   authorization_code   varchar(50) not null,
   open_id              varchar(100),
   create_time          datetime not null,
   primary key (dealer_id)
);

alter table dealer comment '����ܲ������ϼ����ɵ���Ȩ�룬Ȼ���ύ���ܲ�����Ա������Ȩ
��������΢�ŵ�½��ͨ���󶨵���Ȩ�룬��֪�þ�����';

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

alter table exchange_orders comment '�û��û��ֶһ���Ʒ�Ķ��������������һ�';

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

alter table goods_area_price comment 'ͬһ����Ʒ��Ϊ����������ˮƽ���ü۸�ͬ';

/*==============================================================*/
/* Table: manager                                               */
/*==============================================================*/
create table manager
(
   manager_id           bigint not null auto_increment comment '����ԱID����������Ϊ�գ�Ψһ��ʶ��������ɾ���',
   userName             varchar(50) not null comment '����Ա�˺ţ����ڵ�¼ϵͳ',
   password             varchar(50) not null comment '����Ա���룬���ڵ�¼ϵͳ',
   manager_name         varchar(50) comment '����Ա�����������������Ա����ʵ���',
   manager_phone        varchar(50) comment '����Ա�绰��������ϵ����Ա',
   create_time          datetime not null comment '����Ա�˺ŵĴ���ʱ�䣬����Ϊ������������ҵ����׼��',
   status               int not null comment '����Ա״̬���Ƿ񱻶����״̬�����ڹ���Ա��Ϊ����״�������ж���',
   primary key (manager_id)
);

alter table manager comment '�����̹�����ɾ��ģ�����Ȩ���΢�źţ�������һ�������̣�������󶨣���ɾ��һ�������̣�����ѯ��������Ϣ���޸ľ�������';

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

alter table manifest_item comment '�������飬�����ڵ���Ʒ����';

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

alter table orders_item comment '�������飬������Ʒ������';

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

alter table user comment '�û����ִ洢';

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

