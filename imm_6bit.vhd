library ieee;
		use ieee.std_logic_1164.all;

library work;
		use work.basic_components.all;


entity imm_6bit is
	port ( x: in std_logic_vector(5 downto 0);
	       y: out std_logic_vector(15 downto 0));
end entity imm_6bit;

architecture imm_6bit_arc of imm_6bit is
begin
      y(5 downto 0) <= x(5 downto 0);
		y(15) <= x(5);
		y(14) <= x(5); 
		y(13) <= x(5);
		y(12) <= x(5);
		y(11) <= x(5);
		y(10) <= x(5);
		y(9) <= x(5);
		y(8) <= x(5);
		y(7) <= x(5);
		y(6) <= x(5);
end imm_6bit_arc;