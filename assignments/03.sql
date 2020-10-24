set linesize 140;
set pagesize 40;

/*
#1. Write a query to display employee number, employee name, hiredate, manager's
name for those employees, whose manager's name starts with K or M or S.
Label the columns Employee Number, Employee Name, Hiredate, Mgr Name.
*/

select
   e.empno as "Employee Number",
   e.ename as "Employee Name",
   e.hiredate as "Hiredate",
   m.ename as "Mgr Name"
from emp e
inner join emp m
on e.mgr = m.empno
where (0=1
   or m.ename like 'K%'
   or m.ename like 'M%'
   or m.ename like 'S%'
);

/* old syntax way */

select
   e.empno as "Employee Number",
   e.ename as "Employee Name",
   e.hiredate as "Hiredate",
   m.ename as "Mgr Name"
from emp e, emp m
where e.mgr = m.empno and (0=1
   or m.ename like 'K%'
   or m.ename like 'M%'
   or m.ename like 'S%'
);

/*
Employee Number Employee N Hiredate  Mgr Name
--------------- ---------- --------- ----------
           7698 BLAKE      01-MAY-81 KING
           7782 CLARK      09-JUN-81 KING
           7566 JONES      02-APR-81 KING
           7876 ADAMS      12-JAN-83 SCOTT
*******************************************************************************/

/*
#2. Create a query that will display the employee name, department number,
department name and all the employees that work in the same department as a
given employee. Give each column an appropriate label.
*/

select
   e.ename  "Employee",
   c.ename  "Works With",
   d.dname  "In Department",
   d.deptno "Department Number"
from
   emp  e,
   emp  c,
   dept d
where (1=1
   and e.deptno = c.deptno
   and e.deptno = d.deptno
)
order by e.ename;

/*
Employee   Works With In Department  Department Number
---------- ---------- -------------- -----------------
ADAMS      FORD       RESEARCH                      20
ADAMS      John Smith RESEARCH                      20
ADAMS      JONES      RESEARCH                      20
ADAMS      ADAMS      RESEARCH                      20
ADAMS      SMITH      RESEARCH                      20
ADAMS      SCOTT      RESEARCH                      20
ALLEN      JAMES      SALES                         30
ALLEN      WARD       SALES                         30
ALLEN      MARTIN     SALES                         30
ALLEN      ALLEN      SALES                         30
ALLEN      TURNER     SALES                         30
ALLEN      BLAKE      SALES                         30
BLAKE      TURNER     SALES                         30
BLAKE      ALLEN      SALES                         30
BLAKE      MARTIN     SALES                         30
BLAKE      BLAKE      SALES                         30
BLAKE      WARD       SALES                         30
BLAKE      JAMES      SALES                         30
CLARK      KING       ACCOUNTING                    10
CLARK      MILLER     ACCOUNTING                    10
CLARK      CLARK      ACCOUNTING                    10
FORD       JONES      RESEARCH                      20
FORD       SMITH      RESEARCH                      20
FORD       FORD       RESEARCH                      20
FORD       ADAMS      RESEARCH                      20
FORD       SCOTT      RESEARCH                      20
FORD       John Smith RESEARCH                      20
JAMES      BLAKE      SALES                         30
JAMES      WARD       SALES                         30
JAMES      ALLEN      SALES                         30
JAMES      MARTIN     SALES                         30
JAMES      JAMES      SALES                         30
JAMES      TURNER     SALES                         30
JONES      John Smith RESEARCH                      20
JONES      ADAMS      RESEARCH                      20
JONES      FORD       RESEARCH                      20
JONES      JONES      RESEARCH                      20

Employee   Works With In Department  Department Number
---------- ---------- -------------- -----------------
JONES      SMITH      RESEARCH                      20
JONES      SCOTT      RESEARCH                      20
John Smith JONES      RESEARCH                      20
John Smith FORD       RESEARCH                      20
John Smith SMITH      RESEARCH                      20
John Smith SCOTT      RESEARCH                      20
John Smith ADAMS      RESEARCH                      20
John Smith John Smith RESEARCH                      20
KING       KING       ACCOUNTING                    10
KING       CLARK      ACCOUNTING                    10
KING       MILLER     ACCOUNTING                    10
MARTIN     WARD       SALES                         30
MARTIN     TURNER     SALES                         30
MARTIN     BLAKE      SALES                         30
MARTIN     MARTIN     SALES                         30
MARTIN     JAMES      SALES                         30
MARTIN     ALLEN      SALES                         30
MILLER     KING       ACCOUNTING                    10
MILLER     MILLER     ACCOUNTING                    10
MILLER     CLARK      ACCOUNTING                    10
SCOTT      JONES      RESEARCH                      20
SCOTT      John Smith RESEARCH                      20
SCOTT      ADAMS      RESEARCH                      20
SCOTT      SCOTT      RESEARCH                      20
SCOTT      SMITH      RESEARCH                      20
SCOTT      FORD       RESEARCH                      20
SMITH      John Smith RESEARCH                      20
SMITH      SMITH      RESEARCH                      20
SMITH      JONES      RESEARCH                      20
SMITH      FORD       RESEARCH                      20
SMITH      ADAMS      RESEARCH                      20
SMITH      SCOTT      RESEARCH                      20
TURNER     BLAKE      SALES                         30
TURNER     ALLEN      SALES                         30
TURNER     MARTIN     SALES                         30
TURNER     TURNER     SALES                         30
TURNER     WARD       SALES                         30

Employee   Works With In Department  Department Number
---------- ---------- -------------- -----------------
TURNER     JAMES      SALES                         30
WARD       ALLEN      SALES                         30
WARD       MARTIN     SALES                         30
WARD       TURNER     SALES                         30
WARD       WARD       SALES                         30
WARD       JAMES      SALES                         30
WARD       BLAKE      SALES                         30
*******************************************************************************/

/*
#3. Write a query to display the department name,
location of all employees who are clerks.
*/

select
   d.dname "Department Name",
   d.loc   "Location"
from emp e
inner join dept d
on e.deptno = d.deptno
where (trim(job) = 'CLERK');

/*
Department Nam Location
-------------- -------------
SALES          CHICAGO
RESEARCH       DALLAS
RESEARCH       DALLAS
ACCOUNTING     NEW YORK
*******************************************************************************/

/*
#4.
Insert a new row into the department table:
department number = 50,
department name = training,
location = San Francisco.

Now create a query to display all the employees in department number 20 and 50.
Columns to be displayed are emp number, emp name, dept name, dept location.
*/

insert into dept (deptno, dname, loc) values
(50, 'training', 'San Francisco');

select
   e.empno "Employee Number",
   e.ename "Name",
   d.dname "Department",
   d.loc   "Location"
from emp e
inner join dept d
on e.deptno = d.deptno
where e.deptno in (20, 50);

/*
1 row created.

Employee Number Name       Department     Location
--------------- ---------- -------------- -------------
           7566 JONES      RESEARCH       DALLAS
           7902 FORD       RESEARCH       DALLAS
           7369 SMITH      RESEARCH       DALLAS
           7788 SCOTT      RESEARCH       DALLAS
           7876 ADAMS      RESEARCH       DALLAS
           1456 John Smith RESEARCH       DALLAS
*******************************************************************************/

/*
#5.
Insert a new row into the emp table - you can choose any values for the fields,
but department number should be null.
Now create a query to display all the employees and all the departments,
using joins.
*/

insert into emp (empno, ename, job, deptno) values
(1936, 'JohnMadden', 'Football', null);

/*
ERROR at line 2:
ORA-01400: cannot insert NULL into ("SQLUSER25"."EMP"."DEPTNO")

This doesn't work because of the foreign key constraint.
*/

select
   emp.ename   "Name",
   dept.dname  "Department"
from emp
inner join dept
on emp.deptno = dept.deptno;

/*
Name       Department
---------- --------------
KING       ACCOUNTING
CLARK      ACCOUNTING
MILLER     ACCOUNTING
John Smith RESEARCH
JONES      RESEARCH
SMITH      RESEARCH
SCOTT      RESEARCH
ADAMS      RESEARCH
FORD       RESEARCH
WARD       SALES
JAMES      SALES
TURNER     SALES
ALLEN      SALES
MARTIN     SALES
BLAKE      SALES

15 rows selected.
*******************************************************************************/
