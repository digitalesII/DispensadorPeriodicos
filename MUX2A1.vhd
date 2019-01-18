
LIBRARY ieee ;  
use ieee.std_logic_1164.all;  
  
ENTITY MUX2A1 IS  
    PORT ( w0, w1: STD_LOGIC;  
    s : IN STD_LOGIC ;  
    f : OUT STD_LOGIC) ;  
END MUX2A1 ;  
  
ARCHITECTURE comp OF MUX2A1 IS  
BEGIN  
    WITH s SELECT  
    f <= w0 WHEN '0',  
    w1 WHEN OTHERS ;  
END comp ;  
