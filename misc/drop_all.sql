select (''
|| 'drop table '
|| table_name
|| ' cascade constraints purge;'
) "script" from user_tables;
