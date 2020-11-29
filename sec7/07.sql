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

drop table da_user cascade constraints;
drop table da_location cascade constraints;
drop table da_payment_type cascade constraints;
drop table da_resident cascade constraints;
drop table da_college cascade constraints;
drop table da_department cascade constraints;
drop table da_course cascade constraints;
drop table da_course_prereq_join cascade constraints;
drop table da_section cascade constraints;
drop table da_course_user_join cascade constraints;
drop table da_student_registration cascade constraints;
drop view da_catalogue cascade constraints;

create tablespace da_reg datafile 'da_reg.f' size 1M autoextend on next 1M;

/*
ORA-01031: insufficient privileges
*/

-- As expected
-- Ideally, you'd also use a create schema da_reg but we can't do that either.

create table da_user (
   id number(8) primary key, -- as long as a CWID
   first_name varchar2(32) not null, -- legal name limits
   last_name varchar2(32) not null,
   address varchar2(256),
   email varchar2(64),
   tel varchar2(32)
);

create table da_payment (
   id number(1) primary key, -- there aren't gonna be that many payment types
   type varchar2(32) not null
);

create table da_resident (
   user_id number(8) references da_user(id),
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
   -- 2. Departments offer several courses
   dept_id number(2) references da_department(id)
);


-- a course can have multiple prereqs
create table da_course_prereq_join (
   course_id number(5) references da_course(id),
   prereq_id number(5) references da_course(id),
   -- enforce the uniqueness
   constraint course_prereq_join_pk primary key (course_id, prereq_id),
   -- a course should not include itself as a prereq
   constraint course_prereq_not_self check (course_id <> prereq_id)
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
   student_id number(8) references da_user(id),
   section_crn number(5) references da_section(id),
   payment_id number(1) references da_payment(id)
   -- fee status???
);

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
