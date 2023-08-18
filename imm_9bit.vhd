library ieee;
		use ieee.std_logic_1164.all;

library work;
		use work.basic_components.all;


entity imm_9bit is
	port ( x: in std_logic_vector(8 downto 0);
	       typ: in std_logic;
	       y: out std_logic_vector(15 downto 0));
end entity imm_9bit;

architecture imm_9bit_arc of imm_9bit is
begin

	process(x,typ)
	begin
		
		if(typ='1') then
				y <= x & "0000000";
		
		elsif(typ='0') then
				y(8 downto 0) <= x(8 downto 0); 
				y(15) <= x(8);
				y(14) <= x(8); 
				y(13) <= x(8);
				y(12) <= x(8); 
				y(11) <= x(8);
				y(10) <= x(8);
				y(9) <= x(8);
		
		end if;
	end process;
end imm_9bit_arc;