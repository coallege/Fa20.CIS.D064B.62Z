select
   e.ename as Name,
   d.dname as Department
from emp e
join dept d
using (deptno);

-- https://docs.oracle.com/javadb/10.8.3.0/ref/rrefsqljusing.html
