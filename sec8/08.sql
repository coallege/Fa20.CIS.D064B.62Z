set linesize 140;
set pagesize 40;
-- This assignment is based off of assignment 7.
-- make sure that the tables needed have been created

-- to start off with, we're going to add some fake users

insert into da_user (id, first_name, last_name)
select 0, 'Cole', 'Gannon' from dual
union all select 1, 'Hope', 'Mozambique' from dual
union all select 2, 'Saha', 'Ranafriqa' from dual
union all select 3, 'Cafra', 'Satz' from dual
union all select 4, 'Mr. Sun', 'Microsystems' from dual
union all select 5, 'BEN', 'STEED' from dual
union all select 6, 'Linux', 'Sebastian' from dual
union all select 7, 'Cassandra', 'Deebee' from dual
union all select 8, 'Panser', 'Bjarne' from dual;

-- and add the resident entries

insert into da_resident (user_id, status)
select 0, 'resident' from dual
union all select 1, 'nonresident' from dual
union all select 2, 'exempt' from dual
union all select 3, 'exempt' from dual
union all select 4, 'residents' from dual
union all select 5, 'ben steed' from dual
union all select 6, 'nonresident' from dual
union all select 7, 'resident' from dual
union all select 8, 'C++ microbe' from dual;

-- and some different types of payment

insert into da_payment (id, type)
select 0, 'cash' from dual
union all select 1, 'debit card' from dual
union all select 2, 'credit card' from dual
union all select 3, 'check' from dual
union all select 4, 'bank wire' from dual
union all select 5, 'ACH' from dual;

/*
Write DML Statements to simulate the following Business Processes:
- Setup a department, course within a department with 2 sections.
- Section must have a location assigned.
*/

insert into da_college (id, name)
values (0, 'De Anza College');

insert into da_location (college_id, id, name)
values (0, 0, 'ONLINE');

insert into da_location (college_id, id, name)
values (0, 1, 'AT312');

insert into da_department (college_id, id, name)
values (0, 0, 'Department of Computer Information Systems');

-- we're going to let that prereq foreign key be null
insert into da_course (id, name, dept_id)
values (0, 'CIS 35B - Advanced Java Programming', 0);

insert into da_section (
   id, -- 00453
   course_id, -- CIS 35B - Advanced Java Programming
   location_id, -- AT312
   instructor_id, -- Mr. Sun Microsystems
   start_time, end_time, -- Starts at 8:00pm and goes to 9:50pm
   start_date, end_date -- Goes from 2020-01-06 to 2020-03-27
)
values (00453, 0, 1, 4, 2000, 2150, date'2020-01-06', date'2020-03-27');

insert into da_section (
   id,
   course_id, -- CIS 35B - Advanced Java Programming
   location_id, -- ONLINE
   instructor_id, -- Cafra Satz
   start_time, end_time, -- No start times because online
   start_date, end_date -- Goes from 2020-01-06 to 2020-03-27
)
values (30996, 0, 0, 3, null, null, date'2020-01-06', date'2020-03-27');

/*
Produce a report showing the department, its course and sections
(with complete section information).

Forgot section information
-1 point
*/

-- this works best if it's run as a script file

set verify off;
col id for 99;
tti off
btitle off
col "Department Name" for A64;

select
   d.id,
   d.name
   || ' at '
   || (
      select name
      from da_college c
      where id = d.college_id
   ) as "Department Name"
from da_department d;

accept user_dept_id prompt 'Enter the department id: ';

tti 'Department#&user_dept_id Courses';

select
   c.id as "Course ID",
   c.name as "Course Name"
from da_course c
where c.dept_id = '&user_dept_id';

tti off

/* Now register a student to a section and process student payment.*/

insert into da_student_registration (
   id,
   reg_date, -- today
   student_id, -- Cole Gannon (me)
   section_id, -- 00453
   payment_id -- credit card
)
values (0, current_date, 0, 00453, 2);

/*
Produce a report showing student registration information,
including payment information.
*/

-- see https://www.deanza.edu/cashier/fees.html
create or replace
function get_quarter_cost(status varchar2) return number deterministic
is
   quarter_cost number := 0;
begin
   select
      decode(status,
         'resident'   ,  31,
         'nonresident', 193,
         0 -- some lucky microbes are exempt
      ) * 5 -- most classes are five units
   into quarter_cost
   from dual;
   return quarter_cost;
end;
/

-- as before, since this is a report, it works better if it's in a script file
-- otherwise, you have to paste all of these in manually

tti off
btitle off
accept user_id prompt 'Enter the user id: ';

tti 'User#&user_id.s Registration';

col "Student Name" for A26
select
   (''
      || first_name
      || ' '
      || last_name
   ) as "Student Name"
from da_user u
where u.id = '&user_id';

prompt 'Student resident status:'

select status
from da_resident
join da_user
using (id);

prompt 'Student registration count:'

select
count(*) as "# of Registrations"
from da_student_registration
where student_id = '&user_id';

tti 'User#&user_is.s Registrations';

col "Course Name" for A40;
col "CRN" for 99999;
col "Time" for A9;
col "Payment Method" for A11;
col "Room" for A8;
col "Cost" for A5;
select
   reg.reg_date as "Reg Date",
   reg.section_id as "CRN",
   crs.name as "Course Name",
   sec.start_time || '-' || sec.end_time as "Time",
   pymt.type as "Payment Method",
   loc.name as "Room",
   '$' || get_quarter_cost(rsdnt.status) as "Cost"
from da_student_registration reg
join da_section sec
on sec.id = reg.section_id
join da_course crs
on crs.id = sec.course_id
join da_location loc
on loc.id = sec.location_id
join da_payment pymt
on pymt.id = reg.payment_id
join da_resident rsdnt
on rsdnt.user_id = reg.student_id
where reg.id = '&user_id';

tti off;
/*
Reg Date     CRN Course Name                              Time      Payment Met Room     Cost
--------- ------ ---------------------------------------- --------- ----------- -------- -----
05-DEC-20    453 CIS 35B - Advanced Java Programming      2000-2150 credit card AT312    $155
*******************************************************************************/

/*
How can you improve your DB Schema further? Make four recommendations.
*/

-- yes, there's room for improvement

-- The prerequisite setup only allows one prerequisite, at this time.
-- It would be good allow classes to have multiple prerequisites.
-- I don't know how to deal with circular prereqs, though.

-- In my opinon, the da_resident table should not exist and should rather be
-- part of the da_users table. I think that would make the entire schema easier
-- to reason about.

-- Also, the da_payment table should be joined to the da_user table instead of
-- the da_student_registration table, but that was just what the specification
-- required me to do. I think it makes more sense if one user has multiple
-- payments like credit card numbers instead of a "registration" having
-- payment methods.

-- Indexing was confusing to me but I think that perhaps it would be a good idea
-- to create a manual partitioned local index for for da_student_registration.

-- I'm not sure if I specified the extent size but that might also be something
-- that should be done at some point.
