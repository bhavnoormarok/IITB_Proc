library work;
use work.all;

library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OutputFunc is
	port( operation_In : integer range 0 to 20;
				state_In :  integer range 0 to 20;
				mux_PC_s,w_PC,w_memory,w_IR: out std_logic;
				mux_T1_s,w_T1,w_T2,w_T3: out std_logic;
				Control_bit_ALU,w_RF: out std_logic;
				mux_memory_s, mux_A1_s, mux_ALU_A_s, mux_ALU_B_s, mux_A3_s, mux_RD3_s: out std_logic_vector(1 downto 0);
				Counter: out std_logic_vector(2 downto 0));
end entity;

architecture reader of OutputFunc is

begin
	process (operation_In, state_In)
	begin
		mux_PC_s<='0';
		w_PC<='0';
		w_memory<='0';
		w_IR<='0';
		mux_T1_s<='0';
		w_T1<='0';
		w_T2<='0';
		w_T3<='0';
		Control_bit_ALU<='0';
		w_RF<='0';
		mux_memory_s<="00";
		mux_A1_s<="00";
		mux_ALU_A_s<="00";
		mux_ALU_B_s<="00";
		mux_A3_s<="00";
		mux_RD3_s<="00";
		Counter<="000";
		if (operation_In = 0) and (state_In=0) then   -- The initial common state_In for all operation_Ins
			mux_memory_s<="01";
			w_IR<='1';
		elsif (operation_In = 1) and (state_In=1) then  -- ADD_s1/NAND_s1
			w_T1<='1';
			w_T2<='1';
		elsif (operation_In = 1) and (state_In=2) then  -- ADD_s2
			mux_ALU_A_s<="01";
			mux_ALU_B_s<="01";
			w_T3<='1';
			Control_bit_ALU<='1';
		elsif (operation_In = 2) and (state_In=2) then  -- NAND_s2
			mux_ALU_A_s<="01";
			mux_ALU_B_s<="01";
			w_T3<='1';
		elsif (operation_In = 1) and (state_In=3) then  -- ADD_s3/NAND_s3
			mux_A3_s<="11";
			mux_RD3_s<="01";
			w_RF<='1';
		elsif (operation_In = 0) and (state_In=1) then  		--common state PC+2 
			w_PC<='1';
			mux_ALU_A_s<="10";
			Control_bit_ALU<='1';
			
			
			
			
		-- Add your outputs here
			
			
			
			
		end if;		
	end process;

end architecture;