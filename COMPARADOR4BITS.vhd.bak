library ieee;  
use ieee.std_logic_1164.all;  
  
entity COMPARADOR4BITS is  
port (A, B: in std_logic_vector(3 downto 0);  
        Amayor, Aigual, Amenor: out std_logic);  
end COMPARADOR4BITS;  
  
architecture ARQcomp of COMPARADOR4BITS is  
begin  
process(A, B)  
begin  
    if A>B then Amayor<='1'; Aigual<='0'; Amenor<='0';  
    elsif A=B then Amayor<='0'; Aigual<='1'; Amenor<='0';  
    else Amayor<='0'; Aigual<='0'; Amenor<='1';  
    end if;  
end process;  
end ARQcomp;  
