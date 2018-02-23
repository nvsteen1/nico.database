drop type string_type;


-- type en function om string in table type te ontleden
create type string_type as table of varchar2(100)
/