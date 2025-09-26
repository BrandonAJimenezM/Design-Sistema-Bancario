/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     13/9/2025 6:08:57                            */
/*==============================================================*/


alter table BANK_ACCOUNTS
   drop constraint FK_ACCOUNT_USER;

alter table TRANSACTIONS
   drop constraint FK_TRANS_FROM;

alter table TRANSACTIONS
   drop constraint FK_TRANS_TO;

alter table USER_ROLES
   drop constraint FK_USERROLES_ROLE;

alter table USER_ROLES
   drop constraint FK_USERROLES_USER;

drop table BANK_ACCOUNTS cascade constraints;

drop table ROLES cascade constraints;

drop table TRANSACTIONS cascade constraints;

drop table USERS cascade constraints;

drop table USER_ROLES cascade constraints;

/*==============================================================*/
/* Table: BANK_ACCOUNTS                                         */
/*==============================================================*/
create table BANK_ACCOUNTS 
(
   ID                   NUMBER               default SYSTEM not null,
   ACCOUNT_NUMBER       VARCHAR2(20)         not null,
   USER_ID              NUMBER               not null,
   BALANCE              NUMBER(15,2)         default 0 not null,
   CURRENCY             VARCHAR2(10)         default 'USD',
   STATUS               VARCHAR2(20)         default 'ACTIVE',
   constraint PK_BANK_ACCOUNTS primary key (ID),
   constraint AK_KEY_2_BANK_ACC unique (ACCOUNT_NUMBER)
);

/*==============================================================*/
/* Table: ROLES                                                 */
/*==============================================================*/
create table ROLES 
(
   ID                   NUMBER               not null,
   NAME                 VARCHAR2(50)         not null,
   constraint PK_ROLES primary key (ID),
   constraint AK_KEY_2_ROLES unique (NAME)
);

/*==============================================================*/
/* Table: TRANSACTIONS                                          */
/*==============================================================*/
create table TRANSACTIONS 
(
   ID                   NUMBER               default SYSTEM not null,
   FROM_ACCOUNT         NUMBER,
   TO_ACCOUNT           NUMBER,
   AMOUNT               NUMBER(15,2)         not null,
   TYPE                 VARCHAR2(20)         not null,
   DESCRIPTION          VARCHAR2(255),
   CREATED_AT           TIMESTAMP(6)         default SYSTIMESTAMP,
   constraint PK_TRANSACTIONS primary key (ID)
);

/*==============================================================*/
/* Table: USERS                                                 */
/*==============================================================*/
create table USERS 
(
   ID                   NUMBER               not null,
   USERNAME             VARCHAR2(50)         not null,
   EMAIL                VARCHAR2(100)        not null,
   PASSWORD             VARCHAR2(200)        not null,
   constraint PK_USERS primary key (ID),
   constraint AK_KEY_2_USERS unique (USERNAME),
   constraint AK_KEY_3_USERS unique (EMAIL)
);

/*==============================================================*/
/* Table: USER_ROLES                                            */
/*==============================================================*/
create table USER_ROLES 
(
   USER_ID              NUMBER               not null,
   ROLE_ID              NUMBER               not null,
   constraint PK_USER_ROLES primary key (USER_ID, ROLE_ID)
);

alter table BANK_ACCOUNTS
   add constraint FK_ACCOUNT_USER foreign key (USER_ID)
      references USERS (ID);

alter table TRANSACTIONS
   add constraint FK_TRANS_FROM foreign key (FROM_ACCOUNT)
      references BANK_ACCOUNTS (ID);

alter table TRANSACTIONS
   add constraint FK_TRANS_TO foreign key (TO_ACCOUNT)
      references BANK_ACCOUNTS (ID);

alter table USER_ROLES
   add constraint FK_USERROLES_ROLE foreign key (ROLE_ID)
      references ROLES (ID);

alter table USER_ROLES
   add constraint FK_USERROLES_USER foreign key (USER_ID)
      references USERS (ID);

