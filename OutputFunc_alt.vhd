library work;
use work.all;

library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OutputFunc_alt is
	port( state_In :  integer range 0 to 40;
				mux_PC,w_PC,w_memory,w_IR: out std_logic;
				mux_T1,w_T1,w_T2,w_T3: out std_logic;
				Control_bit_ALU,w_RF,w_C,w_Z: out std_logic;
				mux_memory, mux_A1, mux_ALU_A, mux_ALU_B, mux_A3, mux_RD3: out std_logic_vector(1 downto 0);
				Counter: out std_logic_vector(2 downto 0));
end entity;

architecture reader of OutputFunc_alt is

begin
	process (state_In)
	begin
		mux_PC<='0';
		w_PC<='0';
		w_memory<='0';
		w_IR<='0';
		mux_T1<='0';
		w_T1<='0';
		w_T2<='0';
		w_T3<='0';
		Control_bit_ALU<='0';
		w_RF<='0';
		w_C<='0';
		w_Z<='0';
		mux_memory<="00";
		mux_A1<="00";
		mux_ALU_A<="00";
		mux_ALU_B<="00";
		mux_A3<="00";
		mux_RD3<="00";
		Counter<="000";
		if (state_In=0) then   -- The initial common state_In for all operation_Ins
			mux_memory<="01";
			w_IR<='1';
		elsif (state_In=1) then  		--common state PC+2 
			w_PC<='1';
			mux_ALU_A<="10";
			Control_bit_ALU<='1';
		elsif (state_In=2) then  -- ADD_s1/NAND_s1
			w_T1<='1';
			w_T2<='1';
		elsif (state_In=3) then  -- ADD_s2
			mux_ALU_A<="01";
			mux_ALU_B<="01";
			w_T3<='1';
			w_Z<='1';
			w_C<='1';
			Control_bit_ALU<='1';
		elsif (state_In=4) then  -- NAND_s2
			mux_ALU_A<="01";
			mux_ALU_B<="01";
			w_T3<='1';
		elsif (state_In=5) then  -- ADD_s3/NAND_s3
			mux_A3<="11";
			mux_RD3<="01";
			w_RF<='1';
	
			
			
		-- Add your outputs here
			
			
			
			
		end if;		
	end process;

end architecture;