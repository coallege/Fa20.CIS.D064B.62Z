select (''
|| 'drop table '
|| table_name
|| ' cascade constraints;'
) "script" from user_tables;
