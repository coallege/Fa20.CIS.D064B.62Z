set linesize 140;
set pagesize 40;

/*
Dean of Admission at DeAnza College has hired you to do the database design for
a new registration system. Keeping in the mind the following requirements,
design a Database Schema.
*/

-- the suffering begins now

drop table user_6 cascade constraints;
drop table location_6 cascade constraints;
drop table payment_type_6 cascade constraints;
drop table resident_6 cascade constraints;
drop table college_6 cascade constraints;
drop table department_6 cascade constraints;
drop table course_6 cascade constraints;
drop table course_prereq_join_6 cascade constraints;
drop table section_6 cascade constraints;
drop table course_user_join_6 cascade constraints;

create table user_6 (
   id number(8) primary key,
   first_name varchar2(32) not null,
   last_name varchar2(32) not null,
   address varchar2(256),
   email varchar2(64),
   tel varchar2(32)
);

create table payment_type_6 (
   id number(3) primary key,
   type varchar2(32) not null
);

create table resident_6 (
   user_id number(8) references user_6(id),
   status varchar2(12) not null -- either resident or non-resident
);

create table college_6 (
   id number(3) primary key, -- 999 colleges max
   name varchar2(128) not null,
   address varchar2(256),
   tel varchar2(32)
);

create table location_6 (
   id number(4) primary key,
   name varchar2(64) not null,
   -- 4. College has locations (Room Sem 5 etc.)
   college_id number(3) references college_6(id)
);

/* 1. College has several departments */
create table department_6 (
   id number(2) primary key, -- 99 departments
   name varchar(64) not null,
   college_id number(3) references college_6(id)
);

create table course_6 (
   -- like the length of a CRN
   -- this also doubles as the course number
   id number(5) primary key,
   name varchar(64) not null,
   -- 2. Departments offer several courses
   dept_id number(2) references department_6(id)
);


create table course_prereq_join_6 (
   course_id number(5) references course_6(id),
   prereq_id number(5) references course_6(id),
   -- enforce the uniqueness
   constraint course_prereq_join_pk primary key (course_id, prereq_id)
);

create table section_6 (
   -- this is also the section number
   -- we can assume that the section number does not change
   id number(5) primary key,
   -- 3. Courses have sections.
   course_id number(5) references course_6(id),
   location_id number(4) references location_6(id),
   instructor_id number(8) references user_6(id),
   start_time number(4), -- military time like 1832 or 0830
   end_time number(4),
   start_date date,
   end_date date
);

-- need a join table for this because course and users is a
-- many to many relationship; one course can have many users
-- and one user can be enrolled in many sections
-- one thing to note is that a user can't be enrolled in two
-- sections that are part of the same course. My portal
-- doesn't allow it so I'll try the same thing here
create table course_user_join_6 (
   course_id number(5) references course_6(id),
   user_id number(8) references user_6(id),
   -- this is just to keep track of which sections people are enrolled in
   section_id number(5) references section_6(id),
   constraint course_user_join_pk primary key (course_id, user_id)
);

insert into user_6
select 0, 'Cole', 'Gannon', '120 Mozambique Way', '9938@qq.com', '+1404 003 9312' from dual
union all select 1, 'William', 'Windows', null, null, null from dual
union all select 2, 'Scala', 'Johansson', null, null, null from dual
union all select 3, 'Eddie', 'Larrison', null, null, null from dual
union all select 4, 'Cafra', 'Satz', null, null, null from dual
union all select 5, 'Mr. Sun', 'Microsystems', null, null, null from dual
union all select 6, 'BEN', 'STEED', null, null, null from dual
union all select 7, 'Linux', 'Sebastian', null, null, null from dual
union all select 8, 'Cassandra', 'Deebee', null, null, null from dual
union all select 9, 'Panser', 'Bjarne', null, null, null from dual;

insert into payment_type_6 (id, type)
select 0, 'cash' from dual
union all select 1, 'debit card' from dual
union all select 2, 'credit card' from dual
union all select 3, 'check' from dual
union all select 4, 'bank wire' from dual
union all select 5, 'ACH' from dual;

insert into college_6 (id, name)
select 0, 'Deya Zuck College' from dual
union all select 1, 'Southwestern' from dual
union all select 2, 'University of American Colombia' from dual
union all select 3, 'University of CBOE' from dual
union all select 4, 'I stan ford' from dual
union all select 5, 'Handhill College' from dual
union all select 6, 'University States of America' from dual
union all select 7, 'Saint Haul University' from dual
union all select 8, 'Universidade Católica de Makoto' from dual
union all select 9, 'Unsigned Tech University' from dual;

insert into location_6 (college_id, id, name)
select 0, 0, 'Flint and Steel Center' from dual
union all select 0, 1, 'Admin' from dual
union all select 0, 2, 'Student Council Dungeons' from dual
union all select 1, 3, 'Northern Hall Room 1A' from dual
union all select 1, 4, 'Northern Hall Room 1B' from dual
union all select 1, 5, 'Northern Hall Room 1C' from dual
union all select 1, 6, 'Northern Hall Room 2A' from dual
union all select 1, 7, 'Northern Hall Room 2B' from dual
union all select 1, 8, 'Northern Hall Room 2C' from dual
union all select 1, 9, 'Eastern Hall Room 1A' from dual
union all select 1, 10, 'Eastern Hall Room 1B' from dual
union all select 1, 11, 'North Eastern Hall Corner Classroom' from dual
union all select 2, 12, 'Film Room' from dual
union all select 2, 13, 'Stage Set' from dual
union all select 2, 14, 'Animal Center 01' from dual
union all select 2, 15, 'Animal Center 02 (Closed)' from dual
union all select 2, 16, 'Animal Center 04' from dual
union all select 2, 17, 'Far Wing Classroom 3' from dual
union all select 3, 18, 'Call Room 0' from dual
union all select 3, 19, 'Condor Hallway: Room A' from dual
union all select 3, 20, 'Mock Trading Room Floor A' from dual
union all select 3, 21, 'Mock Trading Room Floor B' from dual
union all select 4, 22, 'Bing Lecture Hall' from dual
union all select 4, 23, 'Room P' from dual
union all select 4, 24, 'Room A' from dual
union all select 4, 25, 'Room I' from dual
union all select 4, 26, 'Room N' from dual
union all select 5, 27, 'Rock Climbing Wall' from dual
union all select 5, 28, '"Foot Mountain" Room H' from dual
union all select 5, 29, '"Foot Mountain" Room A' from dual
union all select 5, 30, '"Foot Mountain" Room U' from dual
union all select 5, 31, '"Foot Mountain" Room L' from dual
union all select 6, 32, 'Conspiracy Theory Club Room' from dual
union all select 6, 33, '"Rampant Capitalism" Lecture Hall' from dual
union all select 6, 34, 'Consumerism Brainwashing Arena 02' from dual
union all select 7, 36, 'ben steed worship site' from dual
union all select 7, 37, 'Big Pharmacy Chapel' from dual
union all select 7, 38, 'Mandatory Outreach Offices' from dual
union all select 7, 39, 'U-Nited Parcel Services Shared Classroom' from dual
union all select 9, 40, 'Negative Hanguar' from dual
union all select 9, 41, 'Atrium' from dual
union all select 9, 42, 'Breakout in Hives Room' from dual
union all select 9, 43, 'Fennel Containment Room (Chemestry)' from dual;

insert into department_6 (college_id, id, name)
select 0, 0, 'CIS Department' from dual
union all select 0, 1, 'Ultimate Anthropology Department' from dual
union all select 1, 2, 'East West Studies' from dual
union all select 3, 3, 'Department of Human Suffering and Labor' from dual;

insert into course_6 (dept_id, id, name)
select 0, 0, 'Visual Basic .NET Programming I' from dual
union all select 0, 1, 'Beginning Programming Methodologies in C++' from dual
union all select 0, 2, 'Java Programming' from dual
union all select 0, 3, 'Intro To SQL' from dual
union all select 3, 4, 'Flensing for fun and profit!' from dual;

insert into section_6 (id, course_id, location_id, instructor_id)
select 25934, 3, 2, 8 from dual
union all select 23382, 2, 1, 5 from dual
union all select 21718, 1, 0, 9 from dual
union all select 00666, 4, 18, 6 from dual;

-- let's enroll me into some of my courses

insert into course_user_join_6 (user_id, course_id, section_id)
select 0, 1, 21718 from dual
union all select 0, 2, 23382 from dual
union all select 0, 3, 25934 from dual;

/*
5.
Students register for a section from a catalog (which is composed of
Departments, Courses, Sections, Location.)
*/

set wra off;
column "SCTN#" format 99999;
column "Course Name" format A32;
column "Department" format A16;
column "Location" format A23;

select
   sctn.id as "SCTN#",
   crse.name as "Course Name",
   dept.name as "Department",
   loc.name as "Location"
from section_6 sctn
left join location_6 loc
on sctn.location_id = loc.id
left join course_6 crse
on sctn.course_id = crse.id
left join department_6 dept
on crse.dept_id = dept.id;

/*
 SCTN# Course Name                      Department       Location
------ -------------------------------- ---------------- -----------------------
 25934 Intro To SQL                     CIS Department   Student Council Dungeon
 23382 Java Programming                 CIS Department   Admin
 21718 Beginning Programming Methodolog CIS Department   Flint and Steel Center
   666 Flensing for fun and profit!     Department of Hu Call Room 0
*******************************************************************************/

-- just for fun, since I'm actually kinda rockin' this db stuff
-- let's select a list of each section and who teaches it

column "Instuctor" format A16;

select
   sctn.id as "SCTN#",
   crse.name as "Course Name",
   'Prof. ' || usr.last_name as "Instructor"
from section_6 sctn
join course_6 crse
on sctn.course_id = crse.id
join user_6 usr
on sctn.instructor_id = usr.id;

/*
 SCTN# Course Name                      Instructor
------ -------------------------------- --------------------------------------
 23382 Java Programming                 Prof. Microsystems
   666 Flensing for fun and profit!     Prof. STEED
 25934 Intro To SQL                     Prof. Sebastian
 21718 Beginning Programming Methodolog Prof. Bjarne
*******************************************************************************/
/*
6.
Students have to pay for the course they take. You may want to think about
resident, non resident.
*/

-- and it was about around here that I realized that we didn't actually have to
-- make this for lab6 and I didn't read the instructions correctly.
-- 

/*
7.
Their status is updated based on their registration. A document to help you
remind the symbols for DB Schema is posted in the notes area for Session 1 -
called Introduction to RDBMS.doc.
*/
