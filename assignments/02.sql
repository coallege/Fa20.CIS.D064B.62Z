/******************************************************************************/
/*
   Write a simple query to display the name, job, hire date and employee
   number of each employee from the emp table.
*/

select ename, job, hiredate, empno from emp;

/*
ENAME      JOB       HIREDATE       EMPNO
---------- --------- --------- ----------
KING       PRESIDENT 17-NOV-81       7839
BLAKE      MANAGER   01-MAY-81       7698
CLARK      MANAGER   09-JUN-81       7782
JONES      MANAGER   02-APR-81       7566
MARTIN     SALESMAN  28-SEP-81       7654
ALLEN      SALESMAN  20-FEB-81       7499
TURNER     SALESMAN  08-SEP-81       7844
JAMES      CLERK     03-DEC-81       7900
WARD       SALESMAN  22-FEB-81       7521
FORD       ANALYST   03-DEC-81       7902
SMITH      CLERK     17-DEC-80       7369

ENAME      JOB       HIREDATE       EMPNO
---------- --------- --------- ----------
SCOTT      ANALYST   09-DEC-82       7788
ADAMS      CLERK     12-JAN-83       7876
MILLER     CLERK     23-JAN-82       7934
*/

/******************************************************************************/

/* Now, display all employees in the emp table including all columns. */
set linesize 90;
set pagesize 20;
select * from emp;

/*
     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING       PRESIDENT            17-NOV-81       5000                    10
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
      7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20
      7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
      7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
      7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
      7900 JAMES      CLERK           7698 03-DEC-81        950                    30
      7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
      7902 FORD       ANALYST         7566 03-DEC-81       3000                    20
      7369 SMITH      CLERK           7902 17-DEC-80        800                    20
      7788 SCOTT      ANALYST         7566 09-DEC-82       3000                    20
      7876 ADAMS      CLERK           7788 12-JAN-83       1100                    20
      7934 MILLER     CLERK           7782 23-JAN-82       1300                    10
*/

/******************************************************************************/
/*
   Now rewrite the query to display names of all employees, making sure that
   two employees with same name don't appear twice in the result set.
*/
select distinct ename from emp;

/*
ENAME
----------
CLARK
TURNER
WARD
ADAMS
KING
FORD
BLAKE
SMITH
SCOTT
JONES
ALLEN
JAMES
MILLER
MARTIN
*/


/******************************************************************************/
/*
   Write a query to add a record to the emp table:
   EMPNO: 1456  ENAME: John Smith  JOB: Analyst  SAL: 2000  HIREDATE: 1/1/02  COMM:  DEPTNO: 20  MGR: 7566
*/

insert into emp (empno, ename, job, sal, hiredate, comm, deptno, mgr) values
(1456, 'John Smith', 'Analyst', 2000, '01-JAN-2002', NULL, 20, 7566);

/*
1 row created.
*/

/******************************************************************************/
/* Show how will you modify the above record to reflect SAL = 3000 */

update emp
set sal = 3000
where empno = 1456;

/*
1 row updated.
*/

/******************************************************************************/
/*
   Write a SQL statement to show the employee number, employee name, hiredate
   of employees where name has 2 L's.
*/

select empno, ename, hiredate from emp where ename like '%L%L%';

/*
     EMPNO ENAME      HIREDATE
---------- ---------- ---------
      7499 ALLEN      20-FEB-81
      7934 MILLER     23-JAN-82
*/

/******************************************************************************/
/*
   Now from the above result set, display the same fields, for employees
   whose names end with "N".
*/

select empno, ename, hiredate from emp
where (ename like '%L%L%') and (trim(ename) like '%N');

/*
     EMPNO ENAME      HIREDATE
---------- ---------- ---------
      7499 ALLEN      20-FEB-81
*/

/******************************************************************************/
/* Display all the fields of dept table, where location is BOSTON. */
select * from dept where trim(loc) = 'BOSTON';

/*
    DEPTNO DNAME          LOC
---------- -------------- -------------
        40 OPERATIONS     BOSTON
*/

/******************************************************************************/
/*
   Display employee number, employee name, department number, job for an
   employee who is not a manager and is not a clerk in department number 10.
*/
select empno, ename, deptno, job from emp where not (
   (trim(job) = 'MANAGER')
   or ((trim(job) = 'CLERK') and (deptno = 10))
);

/*
     EMPNO ENAME          DEPTNO JOB
---------- ---------- ---------- ---------
      7839 KING               10 PRESIDENT
      7654 MARTIN             30 SALESMAN
      7499 ALLEN              30 SALESMAN
      7844 TURNER             30 SALESMAN
      7900 JAMES              30 CLERK
      7521 WARD               30 SALESMAN
      7902 FORD               20 ANALYST
      7369 SMITH              20 CLERK
      7788 SCOTT              20 ANALYST
      7876 ADAMS              20 CLERK
      1456 John Smith         20 Analyst
*/

/******************************************************************************/
/*
   Display all employees whose commission is greater than zero and salary is
   between 1000 and 3000.
*/

select * from emp where (
   comm > 0 and sal between 1000 and 3000
);

/*
     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
      7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
      7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
*/

/******************************************************************************/
/* Write a SQL statement to show employees, who don't have any managers. */

select * from emp where mgr is null;

/*
     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING       PRESIDENT            17-NOV-81       5000                    10
*/

/******************************************************************************/
/*
   Write a SQL statement to display employee number, employee name, salary,
   manager for all employees, whose managers have employee numbers 7566, 7788
*/

select empno, ename, sal, mgr from emp where mgr in (7566, 7788);

/*
     EMPNO ENAME             SAL        MGR
---------- ---------- ---------- ----------
      7902 FORD             3000       7566
      7788 SCOTT            3000       7566
      7876 ADAMS            1100       7788
      1456 John Smith       3000       7566
*/
