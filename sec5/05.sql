set linesize 140;
set pagesize 40;

/*
1a.
Create a query that displays the employees names and indicates the amounts of
their salaries through asterisks. Each asterisk signifies hundred dollars. Sort
the data in descending order of salary. Label the column
EMPLOYEE_AND_THEIR_SALARIES.
*/

select
   concat(ename, rpad(' ', (sal / 100) + 1, '*'))
   as EMPLOYEE_AND_THEIR_SALARIES
from emp
order by sal desc;

/*
EMPLOYEE_AND_THEIR_SALARIES
--------------------------------------------------------------------------------
KING       **************************************************
SCOTT      ******************************
FORD       ******************************
JONES      *****************************
BLAKE      ****************************
CLARK      ************************
ALLEN      ****************
TURNER     ***************
MILLER     *************
WARD       ************
MARTIN     ************
ADAMS      ***********
JAMES      *********
SMITH      ********
*******************************************************************************/

/*
1b.
Display the employees name, username, hire date, salary and salary review date,
which is the first Monday after six months of service. Label the column REVIEW.
Format the dates to appear in the format mm/dd/yy. Salary should be rounded.
Username is first two letters of the name in the lower case.
*/

select
   ename as "Name",
   lower(substr(ename, 1, 2)) as "Username",
   to_char(hiredate, 'mm/dd/yy') as "Hire Date",
   to_char(sal, '$99,999.00') as "Salary",
   to_char(next_day(add_months(hiredate, 6), 'mon'), 'mm/dd/yy') as "REVIEW"
from emp
order by hiredate asc;

/*
1c.
Use subquery to display all employees, in department location 'BOSTON' with a
salary of greater than $1000.
*/

-- A different way to do this would be to equi-join

select *
from emp
where (1=1
   and (
      deptno = (
         select deptno
         from dept
         where trim(loc) = 'BOSTON'
      )
   )
   and (sal > 1000)
);

/*
no rows selected
*******************************************************************************/

-- Otherwise it's insane
alter session set NLS_DATE_FORMAT='yyyy.mm.dd';

/*
2a.
Write a query to display the employee name, job, and hire date for all employees
who started between 01/01/81 to 12/31/81. Concatenate the name and job together,
separated by a space and comma, and label the column Employees.
*/
select
   concat(trim(ename), concat(', ', trim(job))) as "Employees",
   hiredate as "Hire Date"
from emp
where
   hiredate between date '1981-01-01' and date '1981-12-31'
order by hiredate asc;

/*
Employees             Hire Date
--------------------- ----------
ALLEN, SALESMAN       1981.02.20
WARD, SALESMAN        1981.02.22
JONES, MANAGER        1981.04.02
BLAKE, MANAGER        1981.05.01
CLARK, MANAGER        1981.06.09
TURNER, SALESMAN      1981.09.08
MARTIN, SALESMAN      1981.09.28
KING, PRESIDENT       1981.11.17
JAMES, CLERK          1981.12.03
FORD, ANALYST         1981.12.03
*******************************************************************************/

/*
2b.
Explain the usage of correlated subqueries, inline views with an example.
*/

/*
Both correlated subqueries and inline views are types of subqueries.

A correlated subquery is where you have a subquery that actually uses parts of
the main or outer query. It has to be in the where clause because you can't use
parts of the outer query in the from clause. It's called correlated because,
well, the query is correlated with each row.

Let's say we wanted to select people who were paid higher than the average per
manager. We can also list their manager too.
*/

select
   outer.ename as "Name",
   outer.sal as "Salary",
   outer.mgr as "Manager Number",
   mgr.ename as "Manager Name"
from emp outer
inner join emp mgr
on outer.mgr = mgr.empno
where outer.sal > (
   select avg(inner.sal)
   from emp inner
   where inner.mgr = outer.mgr
);

/*
Name           Salary Manager Number Manager Na
---------- ---------- -------------- ----------
BLAKE            2850           7839 KING
JONES            2975           7839 KING
ALLEN            1600           7698 BLAKE
TURNER           1500           7698 BLAKE
*/

-- Just to see that I'm right, I can list off the managers and what the average
-- salary is working under them
select
   left.ename as "Manager Name",
   left.empno as "Manager Number",
   right.avgsal as "Average Salary Under Manager"
from emp left
inner join (
   select
      mgr,
      avg(sal) avgsal
   from emp
   group by mgr
) right
on left.empno = right.mgr;

/*
Manager Na Manager Number Average Salary Under Manager
---------- -------------- ----------------------------
JONES                7566                         3000
BLAKE                7698                         1310
CLARK                7782                         1300
SCOTT                7788                         1100
KING                 7839                   2758.33333
FORD                 7902                          800
*/

/*
As we can see, the results from the first query look to be correct and the
employees returned do have higher salaries than average per manager.
*/

/*
It looks like last week, I used an "inline view" without even knowing it when I
was explaining the types of count.

The concept of an inline view is simple, it's just a subquery that is inside the
from clause. Last week, I used it like this:
*/

select count(*) from (select distinct(col_name) from table_name);

/*
I can't really understand why it's called an inline view but I suspect that
there might also be a non-inline view.
*/
