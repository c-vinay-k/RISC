library ieee;
	use ieee.std_logic_1164.all;

library work;
	use work.basic_components.all;

entity adder_16bit is
	port ( a , b : in std_logic_vector( 15 downto 0 ) ; cin: in std_logic; cout: out std_logic; sum: out std_logic_vector ( 15 downto 0));
end entity adder_16bit; 

architecture adder_16bit_arc of adder_16bit is

	signal temp: std_logic_vector( 14 downto 0);
  
	component Full_Adder  is
		port ( a , b , cin: in std_logic; s , cout: out std_logic);
	end component Full_Adder;

begin
       fully0: Full_Adder
       port map ( a=>a(0), b=>b(0) , cin => cin, s=>sum(0), cout=>temp(0) ) ;     
		 
       fully1: Full_Adder
       port map (a=>a(1), b=>b(1) , cin=>temp(0), s=>sum(1), cout=>temp(1) ) ;   
		 
       fully2: Full_Adder
       port map ( a=>a(2) , b=>b(2) ,cin=>temp(1) ,s=>sum(2),cout=>temp(2) );   
		 
		 fully3 : Full_Adder
       port map ( a=>a(3) ,b=>b(3),cin=>temp(2), s=>sum(3),  cout=>temp(3)  ) ;    
		 
		 fully4: Full_Adder
       port map ( a=>a(4) , b=>b(4),cin =>temp(3) , s=>sum(4),cout=>temp(4) );    
		 
		 fully5: Full_Adder
       port map ( a=>a(5),b=>b(5),cin =>temp(4) ,s=>sum(5) ,cout=>temp(5)  )  ;   
		 
		 fully6: Full_Adder
       port map ( a=>a(6) ,b=>b(6),cin =>temp(5) ,s=>sum(6) ,cout=>temp(6)  )  ;           
		 
		 full7: Full_Adder
       port map (a=>a(7) ,b=>b(7),cin =>temp(6) ,s=>sum(7) ,cout=>temp(7)   ) ;                          
 		 
		 fully8: Full_Adder
       port map ( a=>a(8) ,b=>b(8),cin =>temp(7) ,s=>sum(8) ,cout=>temp(8)   )     ;
		 
		 fully9: Full_Adder
       port map ( a=>a(9) ,b=>b(9),  cin =>temp(8)  , s=>sum(9) ,cout  =>temp(9)  )  ;
		 
		 fully10: Full_Adder
       port map ( a=>a(10) ,b  =>  b(10) , cin =>temp(9) ,s=>sum(10) ,cout  =>  temp(10 )  )   ;           
		 
		 fully11: Full_Adder
       port map ( a=>a(11) ,  b  =>  b(11)  ,  cin =>  temp(10) ,s=>sum(11) ,cout  =>temp( 11)   ) ;
     		 
		 fully12: Full_Adder
       port map ( a=>a(12 ) ,b  =>b(12)  ,  cin =>temp(11) ,s  =>sum(12) ,cout  =>temp(12)   )  ;   
		 
		 fully13: Full_Adder
       port map ( a =>a(13) ,b=>b(13)  , cin =>temp(12) ,s=>sum(13) ,cout  =>temp(13)   )     ;            
		 
		 fully14: Full_Adder
       port map ( a=>a(14) ,b  =>  b(14)  ,cin =>  temp(13) ,  s  =>  sum(14) ,  cout  =>  temp(14)   )   ;        
 		 
		 fully15: Full_Adder
       port map ( a=>a(15) ,b  =>  b(15)  ,  cin =>temp(14) ,s  =>  sum(15) ,   cout => cout );
  
end adder_16bit_arc;