library std;
	use std.standard.all;
	
library ieee;
	use ieee.std_logic_1164.all;

entity alu_16bit is 

	port( x , y :in std_logic_vector( 15 downto 0 ) ;          
		typ:in std_logic  ;              
		cout ,eq :  out std_logic ;             
		z :out std_logic_vector ( 15  downto 0) ) ;             
		
end entity;

architecture alu_16bit_arc of alu_16bit is

	signal temp1: std_logic_vector( 15 downto  0 )  ;
	signal temp2: std_logic_vector( 15 downto  0 )  ;
	signal c1 : std_logic;
	signal c2 : std_logic;

	component adder_16bit is
	
      port ( a , b : in std_logic_vector( 15 downto 0 ) ;    
		cin: in std_logic;
		cout: out std_logic;
		sum: out std_logic_vector( 15  downto  0 ) ) ;
		
   end component adder_16bit;

begin

	addr1: adder_16bit
	port map ( a=>x , b=>y , cin=>'0' , sum=>temp1 , cout=>c1);
			
	temp2 <= x nand y;

	
	
	process (typ , temp2 , temp1 , c2 , c1)	
	begin
		if (typ = '0') then
			eq <= not (temp1(0) or temp1(1) or temp1(2) or temp1(3) or temp1(4) 
			or temp1(5) or temp1(6) or temp1(7) or temp1(8) or temp1(9) or temp1( 10 )   
			or temp1(11) or temp1(12) or temp1(13) or temp1(14) or temp1( 15 ) ) ; 
			
			cout <= c1;
			z <= temp1; 
			
		elsif (typ = '1') then
			eq <= not (temp2(0) or  temp2(1) or  temp2(2) or  temp2(3) or  temp2(4) 
			or temp2(5) or  temp2(6)  or temp2(7) or  temp2(8) or  temp2(9) or  temp2(10)
			or temp2(11 ) or  temp2( 12 )  or temp2(13 )  or temp2(14 )  or temp2(15 ) )  ;        
			cout <= c2;
			z <= temp2; 
			
	   end if;
	end process;

end alu_16bit_arc;