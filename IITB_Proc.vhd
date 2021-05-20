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
	component DFlipFlop_alt is
		port( clk,rst : in std_logic;
			state_In :in integer range 0 to 40;
			state_Out :in integer range 0 to 40);
	end component;

	component StateFunc_alt is
		port(
			state_In :in integer range 0 to 40;
			IR_out,T1_out,T2_out: in std_logic_vector(15 downto 0);
			C_out, Z_out: in std_logic;
			state_Out :out integer range 0 to 40);
	end component;

	component OutputFunc_alt is
		port( state :  integer range 0 to 40;
				mux_PC,w_PC,w_memory,w_IR: out std_logic;
				mux_T1,w_T1,w_T2,w_T3: out std_logic;
				Control_bit_ALU,w_RF,w_C,w_Z: out std_logic;
				mux_memory, mux_A1, mux_ALU_A, mux_ALU_B, mux_A3, mux_RD3: out std_logic_vector(1 downto 0);
				Counter: out std_logic_vector(2 downto 0));
	end component;

	component Data_Path is
		port (clk : in std_logic;
		  w_PC, w_memory, w_IR, w_T1, w_T2, w_T3, w_RF, w_C, w_Z : in std_logic;
	      Control_bit_ALU : in std_logic;
          mux_PC, mux_T1 : in std_logic;
	      mux_memory, mux_A1, mux_ALU_A, mux_ALU_B, mux_A3, mux_RD3: in std_logic_vector(1 downto 0);
		  Counter: in std_logic_vector(2 downto 0);
          IR_out, T1_out, T2_out : out std_logic_vector(15 downto 0);
          C_out, Z_out : out std_logic);
	end component;
	
	signal operation_In,operation_Out : integer range 0 to 20;
	signal state_In,state_Out : integer range 0 to 20;
	signal mux_PC,w_PC,w_memory,w_IR: std_logic;
	signal mux_T1,w_T1,w_T2,w_T3: std_logic;
	signal Control_bit_ALU,w_RF,w_C,w_Z: std_logic;
	signal mux_memory, mux_A1, mux_ALU_A, mux_ALU_B, mux_A3, mux_RD3: std_logic_vector(1 downto 0);
	signal Counter: std_logic_vector(2 downto 0);
	signal IR_out,T1_out,T2_out: std_logic_vector(15 downto 0);
	signal C_out,Z_out: std_logic;

begin
		state : StateFunc_alt
			port map(state_In, IR_out, T1_out, T2_out, C_out, Z_out, state_Out);
		output : OutputFunc_alt
			port map(state_In,mux_PC,w_PC,w_memory,w_IR,mux_T1,w_T1,w_T2,w_T3,
			Control_bit_ALU,w_RF,w_C,w_Z,mux_memory, mux_A1, mux_ALU_A, mux_ALU_B, mux_A3, mux_RD3,Counter);
		dff : DFlipFlop_alt
			port map(clk => clk,rst => reset, state_In => state_Out, state_Out => state_In);
		DP : Data_Path
			port map(clk,w_PC, w_memory, w_IR, w_T1, w_T2, w_T3, w_RF, w_C, w_Z,Control_bit_ALU,
          mux_PC, mux_T1, mux_memory, mux_A1, mux_ALU_A, mux_ALU_B, mux_A3, mux_RD3,
		    Counter,IR_out, T1_out, T2_out, C_out, Z_out);
end Form;