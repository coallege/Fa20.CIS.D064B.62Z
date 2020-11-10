select
   e.ename as Name,
   d.dname as Department
from emp e
join dept d
using (deptno);
