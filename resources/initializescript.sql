-- echo Building demo tables. Please wait.
DROP TABLE EMP CASCADE CONSTRAINTS;
DROP TABLE DEPT;
DROP TABLE SALGRADE;
DROP TABLE Prod CASCADE CONSTRAINTS;
DROP TABLE Vend;

CREATE TABLE DEPT (
   DEPTNO NUMBER(2) NOT NULL,
   DNAME CHAR(14),
   LOC CHAR(13),
   CONSTRAINT DEPT_PRIMARY_KEY PRIMARY KEY (DEPTNO)
);

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

CREATE TABLE EMP (
   EMPNO NUMBER(4) NOT NULL,
   ENAME CHAR(10),
   JOB CHAR(9),
   MGR NUMBER(4) CONSTRAINT EMP_SELF_KEY REFERENCES EMP (EMPNO),
   HIREDATE DATE,
   SAL NUMBER(7,2),
   COMM NUMBER(7,2),
   DEPTNO NUMBER(2) NOT NULL,
   CONSTRAINT EMP_FOREIGN_KEY FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO),
   CONSTRAINT EMP_PRIM_KEY PRIMARY KEY (EMPNO)
);

INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'17-NOV-1981',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'1-MAY-1981',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'9-JUN-1981',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'2-APR-1981',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'28-SEP-1981',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'20-FEB-1981',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'8-SEP-1981',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'3-DEC-1981',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'22-FEB-1981',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'3-DEC-1981',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'17-DEC-1980',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'09-DEC-1982',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'12-JAN-1983',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'23-JAN-1982',1300,NULL,10);

CREATE TABLE SALGRADE (
   GRADE NUMBER,
   LOSAL NUMBER,
   HISAL NUMBER
);

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

CREATE TABLE Prod (
   ProdNo NUMBER(4) NOT NULL,
   PName CHAR(10),
   Type CHAR(4),
   Family NUMBER(4),
   Price NUMBER(7,2),
   Disc NUMBER(3,1),
   IntroDate DATE,
   VendNo NUMBER(4),
   Inv NUMBER(3),
   PRIMARY KEY (ProdNo)
);

INSERT INTO Prod VALUES (
4186, 'Lotus 123', 'SPSH', 2215, 399.95, 25, '08-MAY-1990' ,26, 35);
INSERT INTO Prod VALUES (
2215, 'Windows', 'OS', 7224, 129, 40, '15-JUN-1990' ,12, 123);
INSERT INTO Prod VALUES (
6240, 'AmiPro', 'WP', 2215, 295.5, 33.3, '01-JUN-1990' ,26, 17);
INSERT INTO Prod VALUES (
7224, 'MS-DOS', 'OS', NULL, 99.95, 30, '03-MAR-1991' ,12, 88);
INSERT INTO Prod VALUES (
3055, 'Lotus 123', 'SPSH', 3088, 399.95, 0, '18-OCT-1990' ,26, 12);
INSERT INTO Prod VALUES (
3088, 'Macintosh', 'OS', NULL, 149.95, NULL, '12-DEC-1989' ,41, 142);
INSERT INTO Prod VALUES (
1108, 'Finance', 'BUS', 4186, 99.95, NULL, '22-APR-1991' ,82, 16);
INSERT INTO Prod VALUES (
9167, 'Lotus 123', 'SPSH', 7224, 399.95, 35, '26-FEB-1989' ,26, 71);
INSERT INTO Prod VALUES (
4925, 'Paradox', 'DBMS', 7224, 345, 25, '21-SEP-1989' ,55, 64);
INSERT INTO Prod VALUES (
1067, 'Finance', 'BUS', 9167, 99.95, NULL, '07-MAR-1989' ,82, 0);
INSERT INTO Prod VALUES (
6482, 'BusPlan', 'BUS', 4186, 54.5, 10, '05-JAN-1991' ,82, 41);
INSERT INTO Prod VALUES (
7190, 'BusPlan', 'BUS', 9167, 54.5, 10, '14-FEB-1989' ,82, NULL);
INSERT INTO Prod VALUES (
6888, 'BusPlan', 'BUS', 3055, 54.5, 0, '14-FEB-1989' ,82, 26);
INSERT INTO Prod VALUES (
3981, 'SQL*Report', 'DBMS', 5476, 149.5, 0, '22-SEP-1990' ,58, 12);
INSERT INTO Prod VALUES (
9482, 'Quattro', 'SPSH', 7224, 199.95, 30, '24-AUG-1990' ,55, 53);
INSERT INTO Prod VALUES (
5476, 'Oracle', 'DBMS', 7224, 895, 5, '12-SEP-1990' ,58, 38);
INSERT INTO Prod VALUES (
3007, 'Finance', 'BUS', 9482, 99.95, NULL, '06-NOV-1990' ,82, 17);
INSERT INTO Prod VALUES (
8120, 'Inventory', 'BUS', 9482, 199.5, 10, '06-NOV-1990' ,82, 0);
INSERT INTO Prod VALUES (
1830, 'SQL*Plus', 'DBMS', 5476, 199.5, 5, '06-OCT-1990' ,58, 19);

CREATE TABLE Vend
( VName CHAR(10),
VState CHAR(2),
VendNo NUMBER(2) NOT NULL,
Acct CHAR(5),
PRIMARY KEY (VendNo));

INSERT INTO Vend VALUES (
'Apple', 'CA', 41, 'COD');
INSERT INTO Vend VALUES (
'Oracle', 'CA', 58, '30');
INSERT INTO Vend VALUES (
'Lotus', 'UT', 26, '30');
INSERT INTO Vend VALUES (
'Microsoft', 'WA', 12, '10');
INSERT INTO Vend VALUES (
'Acme', 'UT', 82, 'COD');
INSERT INTO Vend VALUES (
'Borland', 'CA', 55, '30');
INSERT INTO Vend VALUES (
'Ace', 'OR', 67, '30');

COMMIT;
