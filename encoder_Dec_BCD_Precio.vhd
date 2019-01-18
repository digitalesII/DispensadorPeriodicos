library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
	  
entity encoder_Dec_BCD_Precio is  
    Port ( Ent: in STD_LOGIC_VECTOR(3 downto 0);  
			Salida : OUT STD_LOGIC_VECTOR(7 downto 0)  
			);  
end encoder_Dec_BCD_Precio;  
	  
Architecture ARQenc of encoder_Dec_BCD_Precio is  
Begin  
    With Ent Select  
        Salida <=    "00000101" when "0001",  --5  centavos
                     "00001010" when "0010",  --10 centavos	
                     "00011001" when "0100",  --25 centavos 	
                     "00110010" when "1000",  --50 centavos
                     "00000000" when others;  
end ARQenc;
