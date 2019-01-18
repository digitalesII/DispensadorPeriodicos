
LIBRARY ieee ;  
use ieee.std_logic_1164.all;  
  
ENTITY MUX2A1DE12BITS IS  
    PORT ( w0, w1: STD_LOGIC_VECTOR(11 downto 0);  
    s : IN STD_LOGIC ;  
    f : OUT STD_LOGIC_VECTOR(11 downto 0) ) ;  
END MUX2A1DE12BITS ;  
  
ARCHITECTURE comp OF MUX2A1DE12BITS IS  
BEGIN  
    WITH s SELECT  
    f <= w0 WHEN '0',  
    w1 WHEN OTHERS ;  
END comp ;  
