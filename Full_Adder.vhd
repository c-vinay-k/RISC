library ieee;
		use ieee.std_logic_1164.all;

library work;
		use work.basic_components.all;


entity Full_Adder  is
		port (a, b, cin: in std_logic; s, cout: out std_logic);
end entity Full_Adder;


architecture Full_Adder_arc of Full_Adder is
begin
		s <= a xor (b xor cin);
		cout <= (a and b) or ((a xor b) and cin);
end Full_Adder_arc;