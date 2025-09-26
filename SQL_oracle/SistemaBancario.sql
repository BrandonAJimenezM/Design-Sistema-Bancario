create table ROLES
(
    ID   NUMBER generated as identity
        primary key,
    NAME VARCHAR2(50) not null
        unique
)
/

create table USERS
(
    ID       NUMBER generated as identity
        primary key,
    USERNAME VARCHAR2(50)  not null
        unique,
    EMAIL    VARCHAR2(100) not null
        unique,
    PASSWORD VARCHAR2(200) not null
)
/

create table USER_ROLES
(
    USER_ID NUMBER not null
        constraint FK_USERROLES_USER
            references USERS,
    ROLE_ID NUMBER not null
        constraint FK_USERROLES_ROLE
            references ROLES,
    constraint PK_USER_ROLES
        primary key (USER_ID, ROLE_ID)
)
/

create table BANK_ACCOUNTS
(
    ID             NUMBER        default "SYSTEM"."ISEQ$$_83661".nextval generated as identity
		primary key,
    ACCOUNT_NUMBER VARCHAR2(20)            not null
        unique,
    USER_ID        NUMBER                  not null
        constraint FK_ACCOUNT_USER
            references USERS,
    BALANCE        NUMBER(15, 2) default 0 not null,
    CURRENCY       VARCHAR2(10)  default 'USD',
    STATUS         VARCHAR2(20)  default 'ACTIVE'
)
/

create table TRANSACTIONS
(
    ID           NUMBER       default "SYSTEM"."ISEQ$$_83665".nextval generated as identity
		primary key,
    FROM_ACCOUNT NUMBER
        constraint FK_TRANS_FROM
            references BANK_ACCOUNTS,
    TO_ACCOUNT   NUMBER
        constraint FK_TRANS_TO
            references BANK_ACCOUNTS,
    AMOUNT       NUMBER(15, 2) not null,
    TYPE         VARCHAR2(20)  not null,
    DESCRIPTION  VARCHAR2(255),
    CREATED_AT   TIMESTAMP(6) default SYSTIMESTAMP
)
/


