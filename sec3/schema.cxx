#define primary
using number = short;
using date = char *;

struct dept_r {
   primary number deptno[2];
   char dname[14];
   char loc[14];
};

struct emp_r {
   primary number empno[4];
   char ename[10];
   char job [9];
   decltype(emp_r::empno) mgr;
   date hiredate;
   number sal[7];
   number comm[7]; // commission
   decltype(dept_r::deptno) deptno;
};
