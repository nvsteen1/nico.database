drop package utility_pck;


create package utility_pck
is 

  function split_string (p_list       in varchar2
                        ,p_delimiter  in varchar2 := '#'
                        )
    return string_type;
                
 
end utility_pck;   
/



create or replace package body utility_pck
is

  function split_string (p_list       in varchar2
                        ,p_delimiter  in varchar2 := '#'
                        )
    return string_type
  as
    l_string         varchar2(4000) := p_list || p_delimiter;
    l_delimit_index  pls_integer;
    l_index          pls_integer := 1;
    l_tab            string_type := string_type();
  begin
    loop
      l_delimit_index := instr(l_string, p_delimiter, l_index);
      exit when l_delimit_index = 0;
      l_tab.extend;
      l_tab(l_tab.count) := substr(l_string, l_index, l_delimit_index - l_index);
      l_index := l_delimit_index + 1;
    end loop;
    return l_tab;
  end split_string;

end utility_pck;   
/