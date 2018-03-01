-- view vw_mutatie
create or replace view vw_mutatie 
as 
select id           
,      guid         
,      ora_geometry 
,      ora_geometry_aanvullend
,      type         
,      naam         
,      motivatie    
,      datum  
,      status  
,      key_velden
,      value_velden
from   mutatie;

-- voor geoserver een primary key aanmaken
alter view vw_mutatie add constraint vw_mutatie_pk primary key (id) disable;


-- instead of insert trigger op vw_mutatie  
set define off

create or replace trigger vw_mutatie_insert
instead of insert on vw_mutatie
for each row
declare
  l_new_id mutatie.id%type;
  t_keys   string_type :=  utility_pck.split_string (:new.key_velden);
  t_values string_type :=  utility_pck.split_string (:new.value_velden);
begin
   /* 
   || insert de key en values achteraf
   */
   
   insert into mutatie
    (guid         
    ,ora_geometry 
    ,ora_geometry_aanvullend
    ,type         
    ,naam         
    ,motivatie    
    ,datum 
    ,status    
    ,key_velden
    ,value_velden
    )
   values 
    (:new.guid         
    ,:new.ora_geometry 
    ,:new.ora_geometry_aanvullend
    ,:new.type         
    ,:new.naam         
    ,:new.motivatie    
    ,:new.datum    
    ,:new.status 
    ,:new.key_velden
    ,:new.value_velden
	)
  returning id into l_new_id;
  
  /*
    key_velden en value_velden als paar wegschrijven in de onderliggende tabel key_value
	Dit is voor nu een tijdelijke oplossing....later wordt deze data mogelijk via een xml kolom  
	vastgehouden.
  */
  
  for i in t_keys.first..t_keys.last
  loop
    insert into key_value
      (mut_id
      ,key_veld
      ,value_veld
      )
    values 
      (l_new_id
      ,t_keys(i)
      ,t_values(i)
      );
  end loop;
  
end;
/