const Table = require("./Table");

const dept = new Table();
(dept
   .insert_into("deptno", "dname", "loc")
   .values(
      [10, "ACCOUNTING", "NEW YORK"],
      [20, "RESEARCH", "DALLAS"],
      [30, "SALES", "CHICAGO"],
      [40, "OPERATIONS", "BOSTON"],
   )
);

exports.dept = dept;

const emp = new Table();
(emp
   .insert_into("empno", "ename", "job", "mgr", "hiredate", "sal", "comm", "deptno")
   .values(
      [7839, "KING", "PRESIDENT", null, "17-NOV-1981", 5000, null, 10],
      [7698, "BLAKE", "MANAGER", 7839, "1-MAY-1981", 2850, null, 30],
      [7782, "CLARK", "MANAGER", 7839, "9-JUN-1981", 2450, null, 10],
      [7566, "JONES", "MANAGER", 7839, "2-APR-1981", 2975, null, 20],
      [7654, "MARTIN", "SALESMAN", 7698, "28-SEP-1981", 1250, 1400, 30],
      [7499, "ALLEN", "SALESMAN", 7698, "20-FEB-1981", 1600, 300, 30],
      [7844, "TURNER", "SALESMAN", 7698, "8-SEP-1981", 1500, 0, 30],
      [7900, "JAMES", "CLERK", 7698, "3-DEC-1981", 950, null, 30],
      [7521, "WARD", "SALESMAN", 7698, "22-FEB-1981", 1250, 500, 30],
      [7902, "FORD", "ANALYST", 7566, "3-DEC-1981", 3000, null, 20],
      [7369, "SMITH", "CLERK", 7902, "17-DEC-1980", 800, null, 20],
      [7788, "SCOTT", "ANALYST", 7566, "09-DEC-1982", 3000, null, 20],
      [7876, "ADAMS", "CLERK", 7788, "12-JAN-1983", 1100, null, 20],
      [7934, "MILLER", "CLERK", 7782, "23-JAN-1982", 1300, null, 10],
   )
);

exports.emp = emp;
