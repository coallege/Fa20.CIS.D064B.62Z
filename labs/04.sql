-- This submission will be slightly different in that I will record my thoughts.
-- I think that these queries are harder than the ones before so I would like to
-- share my thinking process.

set linesize 140;
set pagesize 40;

-- This is not an assignment, it is just to help me solve problem #1.
-- I found it pretty difficult. I used this query to check if I was right by hand.
select
   mgr, sal
from
   emp
where
   mgr is not null
order by
   mgr desc,
   sal desc;

/*
       MGR        SAL
---------- ----------
      7902        800
      7839       2975
      7839       2850
      7839       2450
      7788       1100
      7782       1300
      7698       1600
      7698       1500
      7698       1250
      7698       1250
      7698        950
      7566       3000
      7566       3000
*******************************************************************************/

/*
#1.
Display the manager number and the salary of the lowest paid employee for that
manager. Exclude anyone whose manager is not known. Exclude any groups where the
minimum salary is less than $1000. Sort the output in descending order of
salary.
*/

select
   mgr as "Manager",
   min(sal) as "Minimum Salary"
from
   emp
where
   mgr is not null
group by -- group by is very important otherwise the min(sal) just does the entire table
   mgr
having -- Exclude any groups where the min(sal) is less than 1000 so
   not min(sal) < 1000 -- min(sal) >= 1000
order by
   min(sal) desc; -- from highest to lowest

/*
   Manager Minimum Salary
---------- --------------
      7566           3000
      7839           2450
      7782           1300
      7788           1100
*******************************************************************************/

/*
#2. Write a query to display the department name, location name, number of
employees, and the average salary for all employees in that department. Label
the columns dname, loc, Number of People, and Salary, respectively.
*/

-- First, let's just get all employees and their departments
select
   e.ename as "Employee Name",
   d.dname as "Department Name",
   d.loc as "Location Name"
from emp e
inner join dept d
on e.deptno = d.deptno;

-- Now that I have the table of employees and their departments,
-- I can group by d.deptno and count the number of rows.

select
   dname,
   loc,
   count(*) as "Number of People",
   avg(sal) as "Salary"
from emp
-- I wanted to try out natural join and it joins the deptno for me
natural join dept
-- at first, I grouped by only deptno but then there's no way to select dname
-- and loc so I had to also group by dname and loc.
group by deptno, dname, loc;

/*
DNAME          LOC           Number of People     Salary
-------------- ------------- ---------------- ----------
ACCOUNTING     NEW YORK                     3 2916.66667
SALES          CHICAGO                      6 1566.66667
RESEARCH       DALLAS                       5       2175
*******************************************************************************/

/*
#3. Write a query to display department names with salary grade, minimum salary
and average commission. For departments with null commission, you should display
0. (salgrade table can be used for getting salary grade).
*/

-- At first, I thought I should use DECODE
-- but then I realized that we must use a non equi join with salgrade
-- First, I'll get all employees and their salary grade.

select
   e.ename,
   e.sal,
   s.grade
from
   emp e,
   salgrade s
where e.sal between s.losal and s.hisal;

/*
ENAME             SAL      GRADE
---------- ---------- ----------
SMITH             800          1
JAMES             950          1
ADAMS            1100          1
WARD             1250          2
MARTIN           1250          2
MILLER           1300          2
TURNER           1500          3
ALLEN            1600          3
CLARK            2450          4
BLAKE            2850          4
JONES            2975          4
FORD             3000          4
SCOTT            3000          4
KING             5000          5
*/

-- Now that I have the employees, I can join that with the department.

select
   e.empno,
   e.ename,
   e.sal,
   d.deptno,
   d.dname,
   s.grade
from
   emp e,
   dept d,
   salgrade s
where (1=1
   and e.deptno = d.deptno
   and e.sal between s.losal and s.hisal
);

-- To finally answer the question #3, I will restate the problem here:
-- Display:
-- - department name
-- - salary grade
-- - minimum salary
-- - average comm

select
   d.dname as "Department Name",
   s.grade as "Salary Grade",
   min(sal) as "Minimum Salary",
   avg(nvl(comm, 0)) as "Average Commission" -- average comm where null is zero
from
   emp e,
   dept d,
   salgrade s
where (1=1
   and e.deptno = d.deptno
   and e.sal between s.losal and s.hisal
)
group by
   d.deptno,
   d.dname,
   s.grade
order by d.dname, s.grade;

/*
Department Nam Salary Grade Minimum Salary Average Commission
-------------- ------------ -------------- ------------------
ACCOUNTING                2           1300                  0
ACCOUNTING                4           2450                  0
ACCOUNTING                5           5000                  0
RESEARCH                  1            800                  0
RESEARCH                  4           2975                  0
SALES                     1            950                  0
SALES                     2           1250                950
SALES                     3           1500                150
SALES                     4           2850                  0
*/

-- As you can see, one department may have many different salary grades. But I
-- Think that this does answer question #3 in the way that it was intended.
-- If you want to see the minimum salary grade, I have also written a query for
-- that below using ANSI join syntax.

select
   d.dname as "Department Name",
   min(s.grade) as "Minimum Salary Grade",
   min(sal) as "Minimum Salary",
   avg(nvl(comm, 0)) as "Average Commission"
from emp e
inner join dept d
on e.deptno = d.deptno
inner join salgrade s
on sal between s.losal and s.hisal
group by
   d.deptno,
   d.dname
order by d.dname;

-- This question has been one of the hardest programming assignments that I've
-- done all quarter!

/*
Department Nam Minimum Salary Grade Minimum Salary Average Commission
-------------- -------------------- -------------- ------------------
ACCOUNTING                        2           1300                  0
RESEARCH                          1            800                  0
SALES                             1            950         366.666667
*******************************************************************************/

/*
#4. What is difference between
COUNT(*),
COUNT(col_name),
COUNT(DISTINCT(col_name)),
COUNT(ALL(col_name))?
Explain with examples.
*/

-- As listed in the slides, count(*) just counts the rows.
-- I just tested this out with a small table and it even counts rows that are
-- only filled with NULL.
select count(*) from table_name;

-- count(col_name) will count all rows where col_name is not null.
select count(col_name) from table_name;
-- these are actually equivalent
select count(*) from table_name where col_name is not null;

-- only counts rows where there is a unique value for col_name;
select count(distinct(col_name)) from table_name;
-- you can think of it like this:
select count(*) from (select distinct(col_name) from table_name);
-- for me, it's easier to think of it in subqueries because I already know what
-- distinct(col_name) does.

-- from my testing, I can't really tell a difference between
select count(all(col_name)) from table_name;
-- and
select count(col_name) from table_name;
-- I don't think that there really is one. Even with the all, it still does not
-- count null values in col_name. They are probably just identical.

/*
#5. Display the employee number, name, salary, and salary increase by 15%
expressed as a whole number. Label the column New Salary.
*/

select
   empno as "Employee Number",
   ename as "Name",
   sal as "Salary",
   round(sal * 1.15, 0) as "Salary Increase" -- round(?, 0) because whole number
from emp;

/*
Employee Number Name           Salary Salary Increase
--------------- ---------- ---------- ---------------
           7839 KING             5000            5750
           7698 BLAKE            2850            3278
           7782 CLARK            2450            2818
           7566 JONES            2975            3421
           7654 MARTIN           1250            1438
           7499 ALLEN            1600            1840
           7844 TURNER           1500            1725
           7900 JAMES             950            1093
           7521 WARD             1250            1438
           7902 FORD             3000            3450
           7369 SMITH             800             920
           7788 SCOTT            3000            3450
           7876 ADAMS            1100            1265
           7934 MILLER           1300            1495
*******************************************************************************/
