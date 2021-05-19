library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity IITB_Proc is 
	port (clk, reset : in std_logic);
end entity;

architecture Form of iitb_proc is 
	component DFlipFlop is
		port( clk,rst : in std_logic;
			operation_In : in integer range 0 to 20;
			state_In :in integer range 0 to 20;
			operation_Out : in integer range 0 to 20;
			state_Out :in integer range 0 to 20);
	end component;

	component StateFunc is
		port( operation_In : in integer range 0 to 20;
			state_In :in integer range 0 to 20;
			instruction,T1,T2: in std_logic_vector(15 downto 0);
			C_flag, Z_flag: in std_logic;
			operation_Out : out integer range 0 to 20;
			state_Out :out integer range 0 to 20);
	end component;

	component OutputFunc is
		port( operation : integer range 0 to 20;
				state :  integer range 0 to 20;
				mux_PC_s,w_PC,w_memory,w_IR: out std_logic;
				mux_T1_s,w_T1,w_T2,w_T3: out std_logic;
				Control_bit_ALU,w_RF: out std_logic;
				mux_memory_s, mux_A1_s, mux_ALU_A_s, mux_ALU_B_s, mux_A3_s, mux_RD3_s: out std_logic_vector(1 downto 0);
				Counter: out std_logic_vector(2 downto 0));
	end component;

	component Data_Path is
	port (clk, reset : in std_logic;
			mux_PC_s,w_PC,w_memory,w_IR: in std_logic;
			mux_T1_s,w_T1,w_T2,w_T3:in std_logic;
			Control_bit_ALU,w_RF: in std_logic;
			mux_memory_s, mux_A1_s, mux_ALU_A_s, mux_ALU_B_s, mux_A3_s, mux_RD3_s: in std_logic_vector(1 downto 0);
			Counter: in std_logic_vector(2 downto 0);
			instruction,T1,T2: out std_logic_vector(15 downto 0);
			C_flag,Z_flag: out std_logic);
	end component;
	
	signal operation_In,operation_Out : integer range 0 to 20;
	signal state_In,state_Out : integer range 0 to 20;
	signal mux_PC_s,w_PC,w_memory,w_IR: std_logic;
	signal mux_T1_s,w_T1,w_T2,w_T3: std_logic;
	signal Control_bit_ALU,w_RF: std_logic;
	signal mux_memory_s, mux_A1_s, mux_ALU_A_s, mux_ALU_B_s, mux_A3_s, mux_RD3_s: std_logic_vector(1 downto 0);
	signal Counter: std_logic_vector(2 downto 0);
	signal instruction,T1,T2: std_logic_vector(15 downto 0);
	signal C_flag,Z_flag: std_logic;

begin
		state : StateFunc
			port map(operation_In, state_In, instruction, T1, T2, C_flag, Z_flag,operation_Out, state_Out);
		output : OutputFunc
			port map(operation_In, state_In,mux_PC_s,w_PC,w_memory,w_IR,mux_T1_s,w_T1,w_T2,w_T3,
			Control_bit_ALU,w_RF,mux_memory_s, mux_A1_s, mux_ALU_A_s, mux_ALU_B_s, mux_A3_s, mux_RD3_s,Counter);
		dff : DFlipFlop
			port map(clk => clk,rst => reset, operation_In => operation_Out, state_In => state_Out,operation_Out => operation_In, state_Out => state_In);
		DP : Data_Path
			port map(clk, reset, mux_PC_s,w_PC,w_memory,w_IR,
			mux_T1_s,w_T1,w_T2,w_T3,Control_bit_ALU,w_RF,
			mux_memory_s, mux_A1_s, mux_ALU_A_s, mux_ALU_B_s, mux_A3_s, mux_RD3_s,Counter,instruction,T1,T2,C_flag,Z_flag);
end Form;