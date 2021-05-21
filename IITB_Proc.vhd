library std;
use std.standard.all;
library ieee;

library work;
use work.Types.all;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IITB_Proc is 
	port (clk, reset : in std_logic;
			currState : out integer range 0 to 40;
			currPC,currMemAddr,currT1,currT2,currT3,currIR : out std_logic_vector(15 downto 0);
			currMemAll : out memRegArray;
			currRegAll : out regArray;
			currC : out std_logic;
			currZ : out std_logic);
end entity;

architecture Form of IITB_proc is 
	component DFlipFlop is
		port( clk,rst : in std_logic;
		state_In :in integer range 0 to 40;
		state_Out : out integer range 0 to 40);
	end component;

	component StateFunc is
		port(
			state_In :in integer range 0 to 40;
			IR_out,T1_out,T2_out: in std_logic_vector(15 downto 0);
			C_out, Z_out: in std_logic;
			state_Out :out integer range 0 to 40);
	end component;

	component OutputFunc is
		port( state_In :  integer range 0 to 40;
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
          IR_out, T1_out, T2_out, T3_out : out std_logic_vector(15 downto 0);
          C_out, Z_out : out std_logic;
			 PC_out,mem_addr : out std_logic_vector(15 downto 0);
			 mem_allOut : out memRegArray;
			 reg_allOut : out regArray);
	end component;
	
	signal state_In,state_Out : integer range 0 to 40;
	signal mux_PC,w_PC,w_memory,w_IR: std_logic;
	signal mux_T1,w_T1,w_T2,w_T3: std_logic;
	signal Control_bit_ALU,w_RF,w_C,w_Z: std_logic;
	signal mux_memory, mux_A1, mux_ALU_A, mux_ALU_B, mux_A3, mux_RD3: std_logic_vector(1 downto 0);
	signal Counter: std_logic_vector(2 downto 0);
	signal IR_out,T1_out,T2_out: std_logic_vector(15 downto 0);
	signal C_out,Z_out: std_logic;

begin
		state : StateFunc
			port map(state_In, IR_out, T1_out, T2_out, C_out, Z_out, state_Out);
		output : OutputFunc
			port map(state_In,mux_PC,w_PC,w_memory,w_IR,mux_T1,w_T1,w_T2,w_T3,
			Control_bit_ALU,w_RF,w_C,w_Z,mux_memory, mux_A1, mux_ALU_A, mux_ALU_B, mux_A3, mux_RD3,Counter);
		dff : DFlipFlop
			port map(clk => clk,rst => reset, state_In => state_Out, state_Out => state_In);
		DP : Data_Path
			port map(clk,w_PC, w_memory, w_IR, w_T1, w_T2, w_T3, w_RF, w_C, w_Z,Control_bit_ALU,
          mux_PC, mux_T1, mux_memory, mux_A1, mux_ALU_A, mux_ALU_B, mux_A3, mux_RD3,
		    Counter,IR_out, T1_out, T2_out, currT3, C_out, Z_out,currPC,currMemAddr,currMemAll,currRegAll);
		currState <= state_In;
		currIR <= IR_out;
		currT1 <= T1_out;
		currT2 <= T2_out;
		currC  <= C_out;
		currZ  <= Z_out;
end Form;
