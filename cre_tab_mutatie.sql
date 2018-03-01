-- table mutatie
-- key_velden en value_velden zijn een paar....mogelijk later 1 kolom met xml type
create table mutatie
(id	                     number                    primary key 
,guid	                   varchar2(1000)            not null 
,type	                   varchar2(200)             not null 
,naam	                   varchar2(1000)            not null 
,motivatie	             varchar2(2000)            not null 
,ora_geometry            mdsys.sdo_geometry        not null  
,ora_geometry_aanvullend mdsys.sdo_geometry
,datum	                 date default sysdate      not null                       
,status                  number                    not null 
,aliassen                varchar2(2000)
,key_velden              varchar2(4000)         
,value_velden            varchar2(4000)         
);

-- id met opeenvolgende waarde vullen
create sequence mut_seq;

set define off

create or replace trigger mut_bri
before insert
on mutatie referencing old as old new as new
for each row
when (new.id is null)
begin
  select mut_seq.nextval into :new.id from dual;
end;
/

-- geo indexen toevoegen
insert into user_sdo_geom_metadata
values ('MUTATIE','ORA_GEOMETRY',
        mdsys.sdo_dim_array(
             mdsys.sdo_dim_element('X', 0, 300000, 0.05),
             mdsys.sdo_dim_element('Y', 280000, 625000, 0.05)
        ), 28992); 

create index mut_geo_idx on mutatie (ora_geometry) 
   indextype is mdsys.spatial_index;	 
   
insert into user_sdo_geom_metadata
values ('MUTATIE','ORA_GEOMETRY_AANVULLEND',
        mdsys.sdo_dim_array(
             mdsys.sdo_dim_element('X', 0, 300000, 0.05),
             mdsys.sdo_dim_element('Y', 280000, 625000, 0.05)
        ), 28992); 

create index mut_geoa_idx on mutatie (ora_geometry_aanvullend) 
   indextype is mdsys.spatial_index;	   
   
-- bitmap index op status
create bitmap index mut_status_bit_idx on mutatie(status);