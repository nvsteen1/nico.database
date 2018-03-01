-- controle 

insert into vw_mutatie
(guid         
,type         
,naam         
,motivatie  
,ora_geometry  
,datum
,status    
,key_velden
,value_velden
)
values
('wgb-53d7840b-e90a-4c9b-931a-6d3ea604ac5c'
,'weegbrug'
,'Mooie weegbrug'
,'Nieuwe weegbrug, nog niet in BAG'
,MDSYS.SDO_GEOMETRY(2001,28992,MDSYS.SDO_POINT_TYPE(203668.023,502815.419,null),NULL,NULL)
,sysdate
,0
,'status#nummer#max_ton'
,'In Gebruik#46-AK#18'
);


select *
from   key_value;

rollback;

