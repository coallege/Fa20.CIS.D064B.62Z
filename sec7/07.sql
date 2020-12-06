/*
Q1.
Create tables and tablespaces.
Based on the schema in Assignment 6, create tables with constraints.
Consider using the following constraints as appropriate:
- Primary Key
- Foreign key
- Unique
- Null or Check.
*/

create tablespace da_reg datafile 'da_reg.f' size 1M autoextend on next 1M;
-- ORA-01031: insufficient privileges
-- As expected and said in the lecture
-- Ideally, you'd also use a create schema da_reg but we can't do that either.

select * from dual;
drop table da_user cascade constraints purge;
-- purge partitions
-- see one time I forgot to purge and the partition was still there
-- if that happens, I have to run purge recyclebin;
drop table da_location cascade constraints;
drop table da_payment cascade constraints;
drop table da_resident cascade constraints;
drop table da_college cascade constraints;
drop table da_department cascade constraints;
drop table da_course cascade constraints;
drop table da_section cascade constraints;
drop table da_student_registration cascade constraints purge;
drop view da_catalogue cascade constraints;

create table da_user (
   id number(8) primary key, -- as long as a CWID
   first_name varchar2(32) not null, -- legal name limits
   last_name varchar2(32) not null,
   address varchar2(256),
   email varchar2(64),
   tel varchar2(32)
) partition by range (id)
interval(1000) -- every thousand people
(partition da_user_dummy values less than (0));

create table da_payment (
   id number(1) primary key, -- there aren't gonna be that many payment types
   type varchar2(32) not null
);

create table da_resident (
   user_id number(8) not null references da_user(id),
   status varchar2(12) not null -- either resident or non-resident
);

-- I really don't get why a single college would have... multiple colleges?
-- but that's just the schema so we're working with it
-- maybe there's like a college of liberal arts or a college of business
create table da_college (
   id number(2) primary key, -- 99 colleges max
   name varchar2(128) not null,
   address varchar2(256),
   tel varchar2(32) -- telephone numbers can sometimes include more than numbers
);

create table da_location (
   id number(4) primary key,
   name varchar2(64) not null,
   -- 4. College has locations (Room Sem 5 etc.)
   college_id number(2) references da_college(id)
);

/* 1. College has several departments */
create table da_department (
   id number(2) primary key, -- 99 departments
   name varchar(64) not null,
   college_id number(2) references da_college(id)
);

create table da_course (
   -- this id also doubles as the course number
   -- there shouldn't be two courses of the same number
   id number(4) primary key,
   name varchar(64) not null,
   prereq_id number(5) references da_course(id),
   dept_id number(2) references da_department(id),
   constraint da_course_not_require_self check (id <> prereq_id)
);

create table da_section (
   -- this is also the section number
   -- we can assume that the section number does not change
   -- this is the crn but we're calling it id
   id number(5) primary key,
   course_id number(5) references da_course(id),
   location_id number(4) references da_location(id),
   instructor_id number(8) references da_user(id),
   -- military time like 1832 or 0830
   start_time number(4),
   end_time number(4),
   start_date date,
   end_date date
);

comment on column da_section.id is 'The CRN or Course Request Number';

create table da_student_registration (
   id number(16) primary key,
   reg_date date not null,
   student_id number(8) references da_user(id),
   section_id number(5) references da_section(id),
   payment_id number(1) references da_payment(id)
   -- fee status???
) partition by range (reg_date)
interval(numtoyminterval(4, 'month'))
(partition da_student_reg_dummy values less than (date '1967-01-01'));

create view da_catalogue as select
   sctn.id as "SCTN#",
   crse.name as "Course Name",
   dept.name as "Department",
   'Prof. ' || prof.last_name as "Instructor",
   loc.name as "Location"
from da_section sctn
left join da_course crse
on sctn.course_id = crse.id
left join da_department dept
on crse.dept_id = dept.id
left join da_user prof
on sctn.instructor_id = prof.id
left join da_location loc
on sctn.location_id = loc.id;

-- set wra off;
-- column "SCTN#" format 99999;
-- column "Course Name" format A32;
-- column "Department" format A16;
-- column "Location" format A23;

/*
Q2.
Project which tables will increase quickly and implement partitioning types in
at least 2 tables in your schema.
Explain why these partitioning types would be useful in the context of your
implementation.
*/

-- Firstly, the da_users table will increase a lot because there are going to be
-- a lot of students and instructors so partitioning it out would be good.
-- It's likely that a lot of the older users will leave the college so keeping
-- it in a separate partition that is less accessed will speed up the db, maybe?
-- I have partitioned it by thousand users.
-- The partition names are autogenerated.

-- Secondly, the da_student_registration table will get absolutely GIANT.
-- Thats because for every one student, they are going to take at least like 2
-- classes per quarter. To make it easily partitionable, I have added an extra
-- column called "reg_date". That way when it gets too big, the partition can
-- be moved somewhere else and archived by date.
