library std;
		use std.standard.all;

library ieee;
		use ieee.std_logic_1164.all; 

library ieee;
		use ieee.numeric_std.all;

entity memory is 
		port (writer,reader,clk: in std_logic; 
			adrress_in, data_in: in std_logic_vector(15 downto 0);
			data_out: out std_logic_vector(15 downto 0)); 
end entity; 

architecture memory_arc of memory is 
	type reg_file is array(65535 downto 0) of std_logic_vector(15 downto 0);
	signal arr: reg_file:=(0 => x"7054", 1 => x"7456", 2 => x"1418", 3 => x"5657",
									4 => x"72c0", 5 => x"70b8", 6 => x"2202", 7 => X"5178",
	                          others => x"ffff");
	begin
		process(writer,reader,adrress_in,data_in,arr,clk)
			begin
				if (reader = '1') then
					data_out <= arr(to_integer(unsigned(adrress_in)));
				elsif (reader = '0') then
					data_out <= "1111111111111111";
				end if;
		
				if (writer = '1') then
					if(falling_edge(clk)) then
						arr(to_integer(unsigned(adrress_in))) <= data_in;
					end if;
				end if;
		end process;	
end memory_arc;