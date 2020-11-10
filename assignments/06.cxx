class Date{};

class User {
   char *first_name;
   char *last_name;
   char *address;
   char *email;
   char *tel;
};

class Location {
   char *location_name;
};

class Payment {
   char *payment_name; // visa / mastercard / cash
};

class Resident {
   User *user_id;
   char *status; // resident / non-resident
};

class College {
   char *college_name;
   char *address;
   char *tel;
};

class Department {
   char *department_name;
   Location *location_id;
   College *college_id;
};

class Course {
   char *course_name;
   unsigned num;
   Course *prereq_id;
   Department *dept_id;
};

class Section {
   unsigned section_number;
   Course *course_id;
   Location *location_id;
   User *instructor_id;
   short start_time[4];
   short end_time[4];
   Date start_date;
   Date end_date;
};

