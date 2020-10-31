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
   lower(substr(ename, 0, 2)) as "Username",
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

/*
2a.
Write a query to display the employee name, job, and hire date for all employees
who started between 01/01/81 to 12/31/81. Concatenate the name and job together,
separated by a space and comma, and label the column Employees.
*/

/*
2b.
Explain the usage of correlated subqueries, inline views with an example.
*/
