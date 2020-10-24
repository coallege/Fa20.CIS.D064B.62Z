type dept = [
   /** @key primary */
   deptno: number,
   dname: string | null,
   loc: string | null,
];

const dept: dept[] = [];

dept.push(
   [10, 'ACCOUNTING', 'NEW YORK'],
   [20, 'RESEARCH', 'DALLAS'],
   [30, 'SALES', 'CHICAGO'],
   [40, 'OPERATIONS', 'BOSTON'],
);

type emp = [
   /** @key primary */
   empno: number,
   ename: string | null,
   job: string | null,
   /** @key foreign {emp.empno} */
   mgr: number,
   hiredate: Date | null,
   sal: number | null,
   comm: number | null,
   /** @key foreign {dept.deptno} */
   deptno: number,
];


