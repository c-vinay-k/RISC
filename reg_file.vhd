library std;
		use std.standard.all;

library ieee;
		use ieee.std_logic_1164.all;

library ieee;
		use ieee.numeric_std.all; 

entity reg_file is 
	port( adrress1,adrress2,adrress3 : in std_logic_vector(2 downto 0);
		  data3, data_pc: in std_logic_vector(15 downto 0);
		  
		clk,writer,pc_writer, reset: in std_logic ; 
		data1, data2: out std_logic_vector(15 downto 0));
end entity;

architecture reg_file_arc of reg_file is
		type regfile is array(0 to 7) of std_logic_vector(15 downto 0);
		signal registers: regfile;

begin
		process (clk)
		begin 
			if((clk'event and clk = '0')) then
				if (reset = '1') then
					for i in 0 to 7 loop
						registers(i) <= "0000000000000000";
					end loop;
				else
							if (writer = '1') then
							if (pc_writer = '1'and (not (adrress3 = "111"))) then
								registers(7) <= data_pc;
								registers(to_integer(unsigned(adrress3))) <= data3;
							elsif (pc_writer = '1' and adrress3 = "111") then
								registers(7) <= data_pc;
							else
								registers(to_integer(unsigned(adrress3))) <= data3;
							end if;
						end if;
				end if;
			end if;
		end process;

		process (adrress1, adrress2)
		begin
			data1 <= registers(to_integer(unsigned(adrress1)));
			data2 <= registers(to_integer(unsigned(adrress2)));
		end process;		  
end reg_file_arc;