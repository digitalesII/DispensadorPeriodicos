LIBRARY IEEE;  
USE  IEEE.STD_LOGIC_1164.all;  
USE  IEEE.STD_LOGIC_UNSIGNED.all;  
  
ENTITY REGISTRO4BITS IS  
    PORT(clock,reset,enable: IN STD_LOGIC;  
         Ent : IN STD_LOGIC_VECTOR(3 downto 0);  
         Q : OUT STD_LOGIC_VECTOR (3 downto 0));  
END REGISTRO4BITS;  
	  
ARCHITECTURE ARQreg OF REGISTRO4BITS IS  
	  
BEGIN  
    PROCESS(clock,reset)  
    BEGIN  
        if reset='1' then Q<="0000";  
        elsif (clock'event and clock='1') then  
            if(enable='1') then Q<=Ent;  
            end if;  
        end if;  
    end process;  
END ARQreg;  
