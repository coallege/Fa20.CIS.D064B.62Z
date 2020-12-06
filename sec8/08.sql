-- This assignment is based off of assignment 7.
-- make sure that the tables needed have been created

-- to start off with, we're going to add some fake users

insert into da_user (id, first_name, last_name)
select 0, 'Cole', 'Gannon' from dual
union all select 1, 'Mozambique', 'Hope' from dual
union all select 2, 'Saha', 'Ranafriqa' from dual
union all select 3, 'Cafra', 'Satz' from dual
union all select 4, 'Mr. Sun', 'Microsystems' from dual
union all select 5, 'BEN', 'STEED' from dual
union all select 6, 'Linux', 'Sebastian' from dual
union all select 7, 'Cassandra', 'Deebee' from dual
union all select 8, 'Panser', 'Bjarne' from dual;

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
   id,
   course_id, -- CIS 35B - Advanced Java Programming
   location_id, -- AT312
   instructor_id, -- Mr. Sun Microsystems
   start_time, end_time, -- Starts at 8:00pm and goes to 9:50pm
   start_date, end_date -- Goes from 2020-01-06 to 2020-03-27
)
values (0, 0, 1, 4, 2000, 2150, date'2020-01-06', date'2020-03-27');

insert into da_section (
   id,
   course_id, -- CIS 35B - Advanced Java Programming
   location_id, -- ONLINE
   instructor_id, -- Cafra Satz
   start_time, end_time, -- No start times because online
   start_date, end_date -- Goes from 2020-01-06 to 2020-03-27
)
values (1, 0, 0, 3, null, null, date'2020-01-06', date'2020-03-27');

/*
- Produce a report showing the department, its course and sections
   (with complete section information).
- Now register a student to a section and process student payment.
- Produce a report showing student registration information, including paymen
   information.
*/



/*
How can you improve your DB Schema further? Make four recommendations.
*/
