
delete from user_sdo_geom_metadata
where table_name = 'MUTATIE';

commit;

drop sequence mut_seq;
drop sequence kve_seq;
drop table key_value;
drop table mutatie;
drop type string_type;
drop package utility_pck; 



select * from user_constraints where table_name = 'MUTATIE'

