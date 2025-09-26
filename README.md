📌 Modelo de Base de Datos - Sistema Bancario



Este repositorio contiene el diseño de un modelo de base de datos desarrollado en \*\*Power Designer\*\*, abarcando sus tres niveles: \*\*Conceptual, Lógico y Físico\*\*.  

El objetivo principal es gestionar la información de \*\*usuarios, roles, cuentas bancarias y transacciones\*\* dentro de un sistema bancario.



---



🗂️ Contenido

\- 📖 \*\*Modelo Conceptual\*\*  

&nbsp; - Representación abstracta de las entidades principales y sus relaciones.  

&nbsp; - Se definieron las entidades clave: `Usuarios`, `Roles`, `Cuentas Bancarias` y `Transacciones`.  



\- 📐 \*\*Modelo Lógico\*\*  

&nbsp; - Traducción del modelo conceptual a un esquema lógico compatible con un SGBD relacional.  

&nbsp; - Incluye atributos, tipos de datos y relaciones normalizadas.  



\- 🏗️ \*\*Modelo Físico (Oracle 11g)\*\*  

&nbsp; - Definición final de las tablas, columnas, llaves primarias, foráneas y restricciones.  



Psdt: Cada Modelo cuenta con su propio reporte generado.

---



📊 Tablas y Descripción



\ 1. \*\*USERS\*\*

Contiene la información básica de los usuarios.  

```sql

ID         NUMBER              PK, NOT NULL

USERNAME   VARCHAR2(50)        NOT NULL, UNIQUE

EMAIL      VARCHAR2(100)       NOT NULL, UNIQUE

PASSWORD   VARCHAR2(200)       NOT NULL

````



🔹 Restricciones:



\* `PK\_USERS` → Llave primaria en `ID`

\* `AK\_KEY\_2\_USERS` → `USERNAME` único

\* `AK\_KEY\_3\_USERS` → `EMAIL` único



---



\ 2. \*\*ROLES\*\*



Define los distintos roles de usuario dentro del sistema.



```sql

ID     NUMBER           PK, NOT NULL

NAME   VARCHAR2(50)     NOT NULL, UNIQUE

```



🔹 Restricciones:



\* `PK\_ROLES` → Llave primaria en `ID`

\* `AK\_KEY\_2\_ROLES` → `NAME` único



---



\ 3. \*\*USER\_ROLES\*\*



Tabla intermedia para la relación \*\*N:M\*\* entre `USERS` y `ROLES`.



```sql

USER\_ID   NUMBER   PK, FK → USERS(ID)

ROLE\_ID   NUMBER   PK, FK → ROLES(ID)

```



🔹 Restricciones:



\* `PK\_USER\_ROLES` → Llave primaria compuesta `(USER\_ID, ROLE\_ID)`

\* `FK\_USERROLES\_USER` → FK a `USERS(ID)`

\* `FK\_USERROLES\_ROLE` → FK a `ROLES(ID)`



---



\ 4. \*\*BANK\_ACCOUNTS\*\*



Gestiona las cuentas bancarias asociadas a cada usuario.



```sql

ID              NUMBER          PK, NOT NULL, DEFAULT SYSTEM

ACCOUNT\_NUMBER  VARCHAR2(20)    NOT NULL, UNIQUE

USER\_ID         NUMBER          NOT NULL, FK → USERS(ID)

BALANCE         NUMBER(15,2)    NOT NULL, DEFAULT 0

CURRENCY        VARCHAR2(10)    DEFAULT 'USD'

STATUS          VARCHAR2(20)    DEFAULT 'ACTIVE'

```



🔹 Restricciones:



\* `PK\_BANK\_ACCOUNTS` → Llave primaria en `ID`

\* `AK\_KEY\_2\_BANK\_ACC` → `ACCOUNT\_NUMBER` único

\* `FK\_ACCOUNT\_USER` → FK a `USERS(ID)`



---



\ 5. \*\*TRANSACTIONS\*\*



Almacena el historial de transacciones entre cuentas.



```sql

ID            NUMBER          PK, NOT NULL, DEFAULT SYSTEM

FROM\_ACCOUNT  NUMBER          FK → BANK\_ACCOUNTS(ID)

TO\_ACCOUNT    NUMBER          FK → BANK\_ACCOUNTS(ID)

AMOUNT        NUMBER(15,2)    NOT NULL

TYPE          VARCHAR2(20)    NOT NULL

DESCRIPTION   VARCHAR2(255)

CREATED\_AT    TIMESTAMP(6)    DEFAULT SYSTIMESTAMP

```



🔹 Restricciones:



\* `PK\_TRANSACTIONS` → Llave primaria en `ID`

\* `FK\_TRANS\_FROM` → FK a `BANK\_ACCOUNTS(ID)`

\* `FK\_TRANS\_TO` → FK a `BANK\_ACCOUNTS(ID)`



---



\ 🔗 Relaciones principales



\* Un \*\*usuario\*\* puede tener \*\*múltiples roles\*\* (relación N:M con `ROLES`).

\* Un \*\*usuario\*\* puede tener \*\*múltiples cuentas bancarias\*\* (1:N).

\* Una \*\*cuenta bancaria\*\* puede participar en \*\*múltiples transacciones\*\* (1:N como origen/destino).



---



🚀 Posibles mejoras



\* Implementación de auditoría de accesos.

\* Manejo de historial de roles.

\* Inclusión de más entidades (ej: sucursales, tarjetas de crédito).



---



👨‍💻 Autor



Brandon Jiménez



Este modelo fue diseñado en \*\*Power Designer\*\* como práctica de modelado de bases de datos, siguiendo el ciclo completo: \*\*Conceptual → Lógico → Físico\*\*, y posteriormente implementado en \*\*Oracle 11g\*\*.



```



