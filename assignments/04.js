const zip = require("../js/zip");
const { dept, emp } = require("../js/initial");

/*
#1.
Display the manager number and the salary of the lowest paid employee for that
manager. Exclude anyone whose manager is not known. Exclude any groups where the
minimum salary is less than $1000. Sort the output in descending order of
salary.
*/

/*
End result is a table of { mgr: number, salary: number }
*/


emp.reduce((a, m) => (a.push(...emp.map(e => [m, e])), a), [])
   // exclude anyone whose manager is not known
   .filter(([mgr, emp]) => mgr !== null)
   .map(([mgr, emp]) => {
      
   });
