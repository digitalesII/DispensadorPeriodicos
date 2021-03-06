
LIBRARY IEEE;  
USE  IEEE.STD_LOGIC_1164.all;  	
USE  IEEE.STD_LOGIC_UNSIGNED.all;  
	  
ENTITY mssDispensador IS  
    PORT(clock,reset,start,dinero_or,periodico_or,ok_periodico,seg_3,ok_dinero,validar_compra: IN STD_LOGIC;
	 error,vuelto_led,num_monedas_led,wr_RAM_periodico,en_periodico_sel,rst_periodico_sel,en_i_periodico,rst_i_periodico,en_reg_cant_periodicos,
	  rst_reg_cant_periodicos,en_seg,rst_seg,en_disp_cant,rst_disp_cant,en_dinero_sel,rst_dinero_sel,en_disp_dinero,rst_disp_dinero,en_reg_dinero_ingresado
	 ,rst_reg_dinero_ingresado,en_precio, rst_precio,sel_dinero_or_vuelto,sel_periodicos_or_monedas: OUT STD_LOGIC;
	 estados:	out std_logic_vector(5 downto 0));  
END mssDispensador;  
  
 
ARCHITECTURE ARQDispensador OF mssDispensador IS  
Type estado is (A1,A2,A3,B0,B1,B2,B3,B4,B5,B6,C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16);  
SIGNAL y:estado;  
BEGIN  
PROCESS(clock,reset)  
      BEGIN  
          if reset='0' then y<=A1;  
          elsif (clock'event and clock='1') then  
              case y is  
                  when A1=>    if start='1' then y<=A2; else y<=A1; end if;  
                  when A2=>    if start='0' then y<=A3; else y<=A2; end if;  
                  when A3=>    if periodico_or='1'and dinero_or='0' then y<=B0;elsif periodico_or='0'and dinero_or='1' then y<=C1; else y<=A3;end if;      --estado de activación  
						when B0=>	 y<=B1;		
                  when B1=>    if periodico_or='0' then y<=B2;else y<=B1;end if; 	 
                  when B2=>    if ok_periodico='1' then y<=B4; else y<=B3;end if; 
						when B3=>    y<=B2; 	
                  when B4=>    y<=B5;   
   				   when B5=> 	 if seg_3='1' then y<=B6; else y<=B5;end if; 
                  when B6=>    y<=A3;
						when C1=>    y<=C2;
						when C2=>    if dinero_or='0' then y<=C3; else y<=C2;end if;
						when C3=>    if ok_dinero='1' then y<=C4; else y<=C5;end if; 
						when C4=>	 y<=C5;
						when C5=>	 if periodico_or='1'and dinero_or='0' then y<=C8;elsif periodico_or='0'and dinero_or='1' then y<=C6; else y<=C5;end if;
						when C6=>    y<=C7;
						when C7=>	 if dinero_or='0' then y<=C3; else y<=C7; end if;  
						when C8=>	 y<=C9;
						when C9=>	 if periodico_or='0' then y<=C10; else y<=C9; end if;
						when C10=>   if ok_periodico='1' then y<=C12; else y<=C11; end if;
						when C11=>   y<=C10;
						when C12=>   y<=C0; 
						when C0=>	 if validar_compra='1' then  y<=C13; else y<=C15; end if;
						when C13=>   if seg_3='1' then y<=C14; else y<=C13;end if; 
						when C14=>   y<=A3;
						when C15=>   if seg_3='1' then y<=C16; else y<=C15;end if;
						when C16=>	 y<=A3;	
             end case;  
         end if;  
END PROCESS;  
      
PROCESS(y)  
    BEGIN  
        error<='0';vuelto_led<='0';num_monedas_led<='0';en_periodico_sel<='0'; rst_periodico_sel<='0'; en_i_periodico<='0'; rst_i_periodico<='0'; 
		  en_reg_cant_periodicos<='0'; rst_reg_cant_periodicos<='0'; en_seg<='0'; rst_seg<='0';wr_RAM_periodico<='0';
		  en_disp_cant<='0';rst_disp_cant<='0';en_dinero_sel<='0';rst_dinero_sel<='0';en_disp_dinero<='0';rst_disp_dinero<='0';en_reg_dinero_ingresado<='0';
		  rst_reg_dinero_ingresado<='0';en_precio<='0';rst_precio<='0';sel_dinero_or_vuelto<='0';sel_periodicos_or_monedas<='0';estados<="000000";
        case y is  
                when A1=>   rst_disp_cant<='1';rst_periodico_sel<='1'; rst_i_periodico<='1'; rst_reg_cant_periodicos<='1';rst_seg<='1';rst_dinero_sel<='1';
									 rst_disp_dinero<='1';rst_reg_dinero_ingresado<='1';rst_precio<='1';estados<="111111";   
					 when A2=>   estados<="000001";  
                when A3=>   rst_disp_cant<='1';rst_seg<='1';rst_i_periodico<='1';rst_periodico_sel<='1';rst_reg_cant_periodicos<='1';rst_dinero_sel<='1';
									 rst_disp_dinero<='1';rst_reg_dinero_ingresado<='1';rst_precio<='1';estados<="000010";   
                when B0=>   en_periodico_sel<='1'; estados<="000011"; --BX: mostrar cantidad de periodicos restantes
					 when B1=>   estados<="000100"; 	
                when B2=>   estados<="000101";   
                when B3=>   en_i_periodico<='1';estados<="000110";   
                when B4=>   en_reg_cant_periodicos<='1';estados<="000111";    
                when B5=>   en_disp_cant<='1';en_seg<='1'; estados<="001000";    
                when B6=>   estados<="001001";
					 when C1=>   en_dinero_sel<='1';en_disp_dinero<='1';estados<="001010"; --CX: comprar periodico 10
					 when C2=>   en_disp_dinero<='1';estados<="001011";  --11
					 when C3=>   en_disp_dinero<='1';estados<="001100"; --12
					 when C4=>   en_reg_dinero_ingresado<='1';en_disp_dinero<='1';estados<="001101"; --13
					 when C5=>   en_disp_dinero<='1';estados<="001110"; --14
					 when C6=>   en_dinero_sel<='1';en_disp_dinero<='1';estados<="001111"; --15
					 when C7=>   en_disp_dinero<='1';estados<="010000"; --16
					 when C8=>   en_periodico_sel<='1';en_disp_dinero<='1';estados<="010001"; --17
					 when C9=>   en_disp_dinero<='1';estados<="010010"; --18
					 when C10=>  en_disp_dinero<='1';estados<="010011"; --19
					 when C11=>  en_i_periodico<='1';en_disp_dinero<='1';estados<="010100"; --20
					 when C12=>  en_reg_cant_periodicos<='1';en_precio<='1';en_disp_dinero<='1';estados<="010101"; --21
					 when C0 =>  en_disp_dinero<='1';estados<="000000"; --00
					 when C13=>  en_seg<='1';sel_dinero_or_vuelto<='1';vuelto_led<='1';num_monedas_led<='1';sel_periodicos_or_monedas<='1';en_disp_cant<='1';
									 en_disp_dinero<='1';estados<="010110"; --22
					 when C14=>  wr_RAM_periodico<='1';en_disp_dinero<='1';estados<="010111"; --23
					 when C15=>  en_seg<='1';error<='1';vuelto_led<='1';num_monedas_led<='1';sel_periodicos_or_monedas<='1';en_disp_cant<='1';
									 en_disp_dinero<='1';
									 estados<="011000"; --24
					 when C16=>  en_disp_dinero<='1';estados<="011001"; --25
        end case;  
END PROCESS;  
END ARQDispensador; 