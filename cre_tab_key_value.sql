
drop sequence kve_seq;
drop table key_value;

-- key_value tabel
create table key_value
(id         number        primary key
,mut_id     number        not null
,key_veld   varchar2(100) not null
,value_veld varchar2(100) not null
);

-- id met opeenvolgende waarde vullen
create sequence kve_seq;

set define off

create or replace trigger kve_bri
before insert
on key_value referencing old as old new as new
for each row
when (new.id is null)
begin
  select kve_seq.nextval into :new.id from dual;
end;
/

alter table key_value
add constraint fk_mut1 foreign key (mut_id)
    references mutatie(id);
    
create index kve_mut_id_idx on key_value(mut_id); 