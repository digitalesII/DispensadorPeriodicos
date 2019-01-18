library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

ENTITY DIVISOR8BITS IS
     PORT (a : IN std_logic_vector(7 DOWNTO 0); 
           b : IN std_logic_vector(7 DOWNTO 0); 
           salida : OUT std_logic_vector(7 DOWNTO 0));
END DIVISOR8BITS;

ARCHITECTURE synth OF DIVISOR8BITS IS
BEGIN
PROCESS (a, b) IS
   BEGIN
      salida <= std_logic_vector(UNSIGNED(a) / UNSIGNED(b));
      END PROCESS;
END synth;