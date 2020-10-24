/*
#1.
Display the manager number and the salary of the lowest paid employee for that
manager. Exclude anyone whose manager is not known. Exclude any groups where the
minimum salary is less than $1000. Sort the output in descending order of
salary.
*/

select mgr, min(sal)
from emp
where mgr is not null;

/*
#2. Write a query to display the department name, location name, number of
employees, and the average salary for all employees in that department. Label
the columns dname, loc, Number of People, and Salary, respectively.
*/

/*
#3. Write a query to display department names with salary grade, minimum salary
and average commission. For departments with null commission, you should display
0. (salgrade table can be used for getting salary grade).
*/

/*
#4. What is difference between
COUNT(*),
COUNT(col_name),
COUNT(DISTINCT(col_name)),
COUNT(ALL(col_name))?
Explain with examples.
*/

/*
#5. Display the employee number, name, salary, and salary increase by 15%
expressed as a whole number. Label the column New Salary.
*/
