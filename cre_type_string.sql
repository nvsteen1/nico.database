-- Oracle kent ook wel bv dbms_utility.name_array maar is beperkt qua max lengte
create type string_type as table of varchar2(2000)
/