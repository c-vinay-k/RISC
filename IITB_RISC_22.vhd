library std;
		use std.standard.all;

library ieee;
		use ieee.std_logic_1164.all;

library ieee;
		use ieee.numeric_std.all; 

entity IITB_RISC_22 is
	port (clk,rst : in  std_logic;
	      op : out std_logic_vector(3 downto 0));
end entity;


architecture RISC_arc of IITB_RISC_22 is

		component memory is 
			port ( writer,reader,clk : in std_logic; 
					adrress_in, data_in: in std_logic_vector(15 downto 0);
					data_out: out std_logic_vector(15 downto 0)); 
		end component memory;
		
		component imm_9bit is
			port ( x: in std_logic_vector(8 downto 0);
					typ: in std_logic;
					y: out std_logic_vector(15 downto 0));
		end component imm_9bit;
		
		component alu_16bit is 
			port( x,y : in std_logic_vector(15 downto 0);
					typ : in std_logic ;
					cout, eq: out std_logic;
					z : out std_logic_vector(15 downto 0));
		end component alu_16bit;
		
		
		
		component reg_file is 
			port( adrress1,adrress2,adrress3 : in std_logic_vector(2 downto 0);
					data3, data_pc: in std_logic_vector(15 downto 0);
					clk,writer,pc_writer, reset: in std_logic ; 
					data1, data2: out std_logic_vector(15 downto 0));
		end component reg_file;
		
		component imm_6bit is
			port ( x: in std_logic_vector(5 downto 0);
					y: out std_logic_vector(15 downto 0));
		end component imm_6bit;
		
		type FSMState is (Sres, Sup, state1, state2, state3, state4,
												state5, state6, state7, state8,
													state9, state10, state11, state12,
														state13, state14, state15, state16,
															state17, state18, state19, state20,
																state21, state22,state23);
		
		signal RA1, RA2, RA3: std_logic_vector(2 downto 0);
		signal memory_address: std_logic_vector(15 downto 0):="0000000000000000";
		signal op_code : std_logic_vector(3 downto 0);
		signal state: FSMState ;
		signal t1, t2, t3, t4 : std_logic_vector(15 downto 0):="0000000000000000";
		signal ir, sel6_out, sel9_out : std_logic_vector(15 downto 0):="0000000000000000";
		signal memory_add, memory_dout, memory_din : std_logic_vector(15 downto 0):="0000000000000000";
		signal alu_x,alu_out, alu_y : std_logic_vector(15 downto 0):="0000000000000000";
		signal rdata_PC : std_logic_vector(15 downto 0):="0000000000000000";
		signal rdata1, rdata2, rdata3 : std_logic_vector(15 downto 0):="0000000000000000";
		signal sel9_in : std_logic_vector(8 downto 0);
		signal sel6_in : std_logic_vector(5 downto 0);
		signal memory_read, sel9_type, memory_write, alu_op ,rpc_wr,zero_out :std_logic:='0';
		signal cout, z_out, rf_rst, carry, zero, rwr :std_logic:='0';

	begin
	
	alu_main : alu_16bit
		port map (alu_x, alu_y, alu_op, cout, z_out, alu_out);
	
	mem_main : memory
		port map (memory_write, memory_read,clk, memory_add, memory_din, memory_dout);
	
	sel6_reg : imm_6bit
		port map (sel6_in, sel6_out);
	
	sel9_reg : imm_9bit
		port map (sel9_in, sel9_type, sel9_out);
	
	register_file_main : reg_file
		port map (RA1, RA2, RA3, rdata3,rdata_PC, clk, rwr,rpc_wr, rf_rst, rdata1, rdata2);
	
	process(state,clk)	
		variable op_v : std_logic_vector(3 downto 0);
		variable next_state : FSMState;
		variable t1_v, t2_v, t3_v, t4_v, ir_v, next_ip: std_logic_vector(15 downto 0);
		variable z, car : std_logic;
		
	begin
			z :=zero; car :=carry;
			next_ip :=memory_address;
			next_state :=state;
			t1_v :=t1;
			t2_v :=t2;
			t3_v :=t3;
			t4_v :=t4;
			ir_v :=ir;
			op_v := op_code;
			
	case state is
			when Sres =>
				rf_rst <= '1';
				rwr <= '0';
				t1_v := "0000000000000000";
				t2_v := "0000000000000000";
				t3_v := "0000000000000000";
				ir_v := "0000000000000000";
				car :='0';
				z := '0';
				memory_read <= '0';
				memory_write <= '0';
				next_state := state1;
	
			when state1 =>
				rf_rst <='0';
				rwr <= '0';
				t1_v := "0000000000000000";
				t2_v := "0000000000000000";
				t3_v := "0000000000000000";
				ir_v := memory_dout;
				memory_read <= '1';
				memory_write <= '0';
				memory_add <= memory_address;
				op_v := ir_v(15 downto 12);
				
				case (op_v) is
					when "1101" =>
						next_state :=state9;
					when "1100" =>
						next_state :=state9;
					when "1011" =>
						next_state :=state13;
					when "1010" =>
						next_state :=state13;
					when "1001" =>
						next_state :=state13;
					when "1000" =>
						next_state :=state4;
					when "0111" =>
						next_state :=state8;
					when "0101" =>
						next_state :=state8;
					when "0011" =>
						next_state :=state2;
					when "0010" =>
						next_state :=state4;
					when "0001" =>
						next_state :=state4;
					when "0000" =>
						next_state :=state7;
					when others => null;
					end case; 
	
			when state4 =>
				rwr <= '0';
				RA1 <=ir_v(11 downto 9);
				RA2 <=ir_v(8 downto 6);
				t1_v := rdata1;
				t2_v := rdata2;
				memory_read <= '0';
				memory_write <= '0';
				next_state :=state5;
	
					
			when state5 =>
				rwr <= '0';
				alu_x <= t1_v;
				alu_y <= t2_v;
				memory_write <= '0';
				memory_read <= '0';
				if(op_v="0010") then
					alu_op <='1';
				else 
					alu_op <= '0';
				end if;
				t3_v := alu_out;
				
				case (op_v) is
					when "1000" =>
						if(t1_v=t2_v) then
							next_state :=state18;
						else
							next_state :=Sup;
						end if;
					when "0111" =>
						next_state :=state19;
					when "0101" =>
						next_state :=state20;
					when "0010" =>
						next_state :=state6;
					when "0001" =>
						next_state :=state6;
					when "0000" =>
						next_state :=state21;
					when others => null;
					end case; 
			
			
			when state7 =>          
				rwr <= '0';        
				RA1 <=ir_v(11 downto 9);       
				t1_v := rdata1;              
				sel6_in <=ir_v(5 downto 0);         
				t2_v := sel6_out;             
				memory_write <= '0';          
				memory_read <= '0';         
				next_state :=state5;
			
			
			
			when state6 =>
				memory_write <= '0';
				memory_read <= '0';
				rwr <= '1';
				if(ir_v(1 downto 0)="00") then
					rdata3<=t3_v;
					RA3<=ir_v(5 downto 3);
					if(op_v="0111" or op_v="0010" or op_v="0001" or op_v="0000") then
						z :=z_out;
					end if;
					if(op_v="0000" or op_v="0001") then
						car:=cout;
					end if;
				elsif( car='1' and  ir_v(1 downto 0)="10") then
					rdata3<=t3_v;
					RA3<=ir_v(5 downto 3);
					if(op_v="0111" or op_v="0010" or op_v="0001" or op_v="0000") then
						z :=z_out;
					end if;
					if(op_v="0000" or op_v="0001") then
					car:=cout;
					end if;
					elsif(  z='1' and  ir_v(1 downto 0)="01") then
					rdata3<=t3_v;
					RA3<=ir_v(5 downto 3);
					if(op_v="0111" or op_v="0010" or op_v="0001" or op_v="0000") then
						z :=z_out;
					end if;
					if(op_v="0001" or op_v="0000") then
						car:=cout;
					end if;
				elsif(ir_v ( 1 downto 0 ) = "11" and  z='1') then
					t1_v:=rdata1;
					t2_v:=rdata2(14 downto 0)&'0';
					alu_x  <= t1_v;
					alu_y <=  t2_v;
					alu_op <= '0';
					t3_v := alu_out;
					rdata3 <= t3_v;
					RA3 <= ir_v(5 downto 3);
					if( op_v = "0111" or op_v = "0010" or op_v = "0001" or op_v = "0000" ) then 
						z :=z_out;                                                        
					end if;            
					if(op_v="0001" or op_v="0000") then                
						car:=cout;                           
					end if;           
				end if;          
				next_state :=Sup;          
	                              
			       
	
					
			when state21 =>          
				rwr <= '1';        
				memory_write<='0';        
				memory_read<='0';      
				if( op_v = "0000" or op_v = "0001" or op_v = "0010" or op_v = "0111") then        
					z :=z_out;                                          
				end if;         
				if( op_v = "0000" or op_v = "0001" ) then            
					car:=cout;                                
				end if;                          
				RA3 <= ir_v( 8 downto 6 );   
				rdata3 <= t3_v; 
				next_state :=Sup;             
	
					
			when state2 =>
				
				rwr <= '0';
				sel9_in <= ir_v(8 downto 0);
				sel9_type<='1';
				t1_v := sel9_out;
				next_state :=state3;
				memory_write <= '0';
				memory_read <= '0';
	
			when state3 =>
				
				rwr <= '1';
				rdata3<=t1_v;
				RA3<=ir_v(11 downto 9);
				memory_write <= '0';
				memory_read <= '0';
				next_state :=Sup;
	
					
			when state8 =>
				
				rwr <= '0';
				RA1 <=ir_v(8 downto 6);
				t1_v := rdata1;
				sel6_in <=ir_v(5 downto 0);
				memory_write <= '0';
				memory_read <= '0';
				t2_v := sel6_out;
				next_state :=state5;
	
			when state19 =>
				memory_read <='1';
				if(op_v="0001" or op_v="0000" or op_v="0010" or op_v="0111") then
					z :=z_out;
				end if;
				if(op_v="0001" or op_v="0000") then
					car:=cout;
				end if;
				memory_add <= t3_v;
				t1_v := memory_dout;
				rwr <= '1';
				rdata3<=t1_v;
				RA3<=ir_v(11 downto 9);
					next_state :=Sup;
	
			when state20 =>
				memory_write <= '1';
				memory_read <= '0';
				rwr <= '0';
				RA1 <=ir_v(11 downto 9);
				t2_v := rdata1;
				memory_add <= t3_v;
				memory_din <= t2_v;
				next_state :=Sup;
				
				
				
				
			when state12 =>
				alu_x <= t1_v;
				alu_y <= "0000000000000001";
				alu_op <= '0';
				t1_v := alu_out;
				if(unsigned(t2_v)<8) then
					if(op_v="1100") then
						if (ir_v(to_integer(unsigned(t2_v))) = '1') then
							next_state :=state10;
						end if; 
					else
						next_state :=state16;
					end if;
				else
					next_state :=Sup;
				end if;
	
					
			when state9 =>
				
				rwr <= '0';
				t1_v := rdata1;
				RA1 <=ir_v(11 downto 9);
				memory_write <= '0';
				memory_read <= '0';
				if(op_v="1100") then
					next_state :=state10;
				else
					next_state :=state16;
				end if;
	
			when state10 =>
				
				rwr <= '0';
				memory_add <= t1_v;
				t3_v := memory_dout;
				memory_write <= '0';
				memory_read <= '1';
				next_state :=state11;
	
			when state11 =>
				rwr <= '1';
				alu_x <= t2_v;
				alu_y <= "0000000000000001";
				rdata3<=t3_v;
				RA3<=t2_v(2 downto 0);
				alu_op <= '0';
				t2_v := alu_out;
				next_state :=state12;
	
			
				
			when state16 =>
				
				rwr <= '0';
				RA2 <=t2_v(2 downto 0);
				memory_write <= '1';
				memory_read <= '0';
				next_state :=state15;
				if (ir_v(to_integer(unsigned(t2_v))) = '1') then
					t3_v := rdata2;		
					memory_din <= t3_v;
				end if;			
				memory_add <= t1_v;
				
	
			
	
					
			when state13 =>
				
				rwr <= '1';
				rdata3<=memory_address;
				memory_write <= '0';
				memory_read <= '0';
				RA3<=ir_v(11 downto 9);
				if(op_v="1010") then
					next_state :=state14;
				elsif(op_v="1011") then
					next_state :=state23;
				else
					next_state :=state22;
				end if;
				
			when state15 =>
				t2_v :=alu_out;
				next_state :=state12;
				alu_x <= t2_v;
				alu_y <= "0000000000000001";
				alu_op <='0';
				
					
			when state23 =>
				
				rwr <= '0';
				RA2<=ir_v(11 downto 9);
				t1_v:=rdata2;
				alu_x <= t1_v;
				alu_y <=sel9_out;
				memory_read <='0';
				sel9_in <=ir_v(8 downto 0);
				sel9_type <='0';
				alu_op <= '0';
				next_ip:=alu_out;
				next_state :=state1;
				memory_write <= '0';
				
				
				
			when state22 =>
				
				rwr <= '0';
				alu_x <=next_ip;
				sel9_in <=ir_v(8 downto 0);
				sel9_type <='0';
				memory_write <= '0';
				alu_y <=sel9_out;
				alu_op <= '0';
				next_ip:=alu_out;
				memory_read <= '0';
				next_state :=state1;
	
					
			when state14 =>
				rwr <= '0';
				RA1 <=ir_v(8 downto 6);
				next_ip := rdata1;
				next_state :=state1;
				memory_write <= '0';
				memory_read <= '0';
	
			
		   
			
			when Sup =>
				next_ip := alu_out;
				next_state :=state1;
				rwr <= '0';
				alu_x <= memory_address;
				alu_y <= "0000000000000001";
				alu_op <= '0';
				memory_write <= '0';
				memory_read <= '0';
				
				
					
			when state18 =>
				alu_x <= memory_address;
				sel6_in <= ir_v(5 downto 0);
				alu_y <= sel6_out;
				alu_op<='0';
				next_ip:=alu_out;
				next_state :=state1;
	
			
				
				
			when others => null;
	end case;		
	
	if (clk'event and clk = '0') then
				if(rst = '1') then
					state <= Sres;
				else
				   ir<=ir_v;
					op_code<=op_v;
					state <= next_state;
					t1<=t1_v;
					t2<=t2_v;
					t3<=t3_v;
					t4<=t4_v;
					memory_address<=next_ip;
					zero<=z; 
					carry<=car;

				end if;
		end if;
	end process;
end RISC_arc;