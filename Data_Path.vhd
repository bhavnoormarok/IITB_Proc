library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity Data_Path is
	port (clk, reset : in std_logic;
			mux_PC_s,w_PC,w_memory,w_IR: in std_logic;
			mux_T1_s,w_T1,w_T2,w_T3:in std_logic;
			Control_bit_ALU,w_RF: in std_logic;
			
			mux_memory_s, mux_A1_s, mux_ALU_A_s, mux_ALU_B_s, mux_A3_s, mux_RD3_s: in std_logic_vector(1 downto 0);
			
			Counter: in std_logic_vector(2 downto 0));
			--O:  out std_logic_vector(15 downto 0);
			--Done: out std_logic);
end entity;

architecture Form of Data_Path is 
	type bus_4x16 is array (0 to 3) of std_logic_vector(15 downto 0);
	type bus_2x16 is array (0 to 1) of std_logic_vector(15 downto 0);
	type bus_4x3 is array (0 to 3) of std_logic_vector(2 downto 0);
	type bus_2x3 is array (0 to 1) of std_logic_vector(2 downto 0);
	
	Signal mux_PC_i, memory_i, mux_T1_i: bus_2x16;
	Signal mux_memory_i, mux_ALU_A_i, mux_ALU_B_i, mux_RD3_i: bus_4x16;
	Signal PC_i,IR_i, T1_i, T2_i, ALU_A_i, ALU_B_i, T3_i, RD3_i: std_logic_vector(15 downto 0);
	
	
	Signal mux_A1_i,mux_A3_i: bus_4x3;
	Signal A1_i, A3_i, A2_i: std_logic_vector(3 downto 0);
	
	Signal mux_PC_o, PC_o, mux_memory_o, memory_o, IR_o, mux_T1_o, mux_ALU_A_o:std_logic_vector(15 downto 0);
	Signal mux_ALU_B_o, ALU_C_o,T1_o, T2_o, T3_o, RD1_o, RD2_o, mux_RD3_o:std_logic_vector(15 downto 0);
	
	Signal mux_A1_o, mux_A3_o: std_logic_vector(2 downto 0);
	component ALU is 
	port (A,B :in std_logic_vector(15 downto 0) ;
			op : in std_logic;
			ALU_out : out std_logic_vector(15 downto 0);
			Z,Cout: out std_logic);
	end component;
	
	component two_one_mux_16bit is
	port( A_1 : in std_logic_vector(15 downto 0);
			A_0 : in std_logic_vector(15 downto 0);
			op: in std_logic;
			z : out std_logic_vector(15 downto 0));
	end component;
	
	component four_one_mux_16bit is
	port( A_0,A_1,A_2,A_3 : in std_logic_vector(15 downto 0);
			op: in std_logic_vector(1 downto 0);
			z : out std_logic_vector(15 downto 0));
	end component;
	
	component two_one_mux_3bit is
	port( A_1 : in std_logic_vector(15 downto 0);
			A_0 : in std_logic_vector(15 downto 0);
			op: in std_logic;
			z : out std_logic_vector(15 downto 0));
	end component;
	
	component four_one_mux_3bit is
	port( A_0,A_1,A_2,A_3 : in std_logic_vector(15 downto 0);
			op: in std_logic_vector(1 downto 0);
			z : out std_logic_vector(15 downto 0));
	end component;
	
	component reg_16 is
	 PORT ( clk, wr : in std_logic;
		 dataIn : in std_logic_vector(15 downto 0);
		 dataOut : out std_logic_vector(15 downto 0) );
	end component;
	
	component Memory is --declaring entity
	port( dataIn, addr : in std_logic_vector(15 downto 0);
			clk, wr : in std_logic;
			dataOut : out std_logic_vector(15 downto 0));
	end component;
	
	component Register_File is
	port ( A1, A2, A3 : in std_logic_vector(2 downto 0);
			D3 : in std_logic_vector (15 downto 0);
			clk, wr : in std_logic;
			D1, D2 : out std_logic_vector (15 downto 0));
	end component;
begin
	mux_PC: two_one_mux_16bit
		port map (A_0 => mux_PC_i(0), A_1 => mux_PC_i(1), op => mux_PC_s, z => mux_PC_o); 
	
	PC_i <= mux_PC_o;
	
	PC: reg_16
		port map(clk => clk, wr => w_PC, dataIn => PC_i, dataOut => PC_o);
	
	mux_memory_i(0) <= ALU_C_o;
	mux_memory_i(1) <= PC_o;
	mux_memory_i(2) <= T3_o;
	mux_memory_i(3) <= T1_o;
	
	mux_memory: four_one_mux_16bit
		port map(A_0 => mux_memory_i(0), A_1 => mux_memory_i(1), A_2 => mux_memory_i(2), A_3 => mux_memory_i(3), op => mux_memory_s, z => mux_memory_o);
	
	memory_i(0) <= RD1_o;
	memory_i(1) <= mux_memory_o;
	
	mem: Memory
		port map(dataIn => memory_i(0), addr => memory_i(1), clk => clk, wr => w_memory, dataOut => memory_o);
	
	IR_i <= memory_o;
	
	IR: reg_16
		port map(clk => clk, wr => w_IR, dataIn => IR_i, dataOut => IR_o);
	
	mux_A1_i(0) <= IR_o(11 downto 9);
	mux_A1_i(1) <= IR_o(8 downto 6);
	mux_A1_i(2) <= Counter;
	mux_A1_i(3) <= "000";
	
	mux_A1: four_one_mux_3bit
		port map(A_0 => mux_A1_i(0), A_1 => mux_A1_i(1), A_2 => mux_A1_i(2), A_3 => mux_A1_i(3), op => mux_A1_s, z => mux_A1_o);
	
	mux_A3_i(0) <= IR_o(11 downto 9);
	mux_A3_i(1) <= IR_o(8 downto 6);
	mux_A3_i(2) <= Counter;
	mux_A3_i(3) <= IR_o(5 downto 3);
	
	mux_A3: four_one_mux_3bit
		port map(A_0 => mux_A3_i(0), A_1 => mux_A3_i(1), A_2 => mux_A3_i(2), A_3 => mux_A3_i(3), op => mux_A3_s, z => mux_A3_o);
	
	A1_i <= mux_A1_o;
	A2_i <= IR_o(8 downto 6);
	A3_i <= mux_A3_o;
	RD3_i <= mux_RD3_o;
	
	RF: Register_File
		port map(A1 => A1_i, A2 => A2_i, A3 => A3_i, D3 =>RD3_i, clk =>clk, wr => w_RF, D1 =>RD1_o, D2 => RD2_o);
	
	mux_T1_i(0) <= RD1_o;
	mux_T1_i(1) <= ALU_C_o;
	
	mux_T1: two_one_mux_16bit
		port map(A_0 => mux_T1_i(0), A_1 => mux_T1_i(1), op => mux_T1_s, z => mux_T1_o);  
	
	T1_i <= mux_T1_o;
	
	T1: reg_16
		port map(clk => clk, wr => w_T1, dataIn => T1_i, dataOut => T1_o);
		
	T2_i <= RD2_o;	
		
	T2: reg_16
		port map(clk => clk, wr => w_T2, dataIn => T2_i, dataOut => T2_o);
	
	mux_ALU_A_i(0)(5 downto 0) <= IR_o(5 downto 0);
	mux_ALU_A_i(0)(15 downto 6)<= "0000000000";
	mux_ALU_A_i(1) <= T1_o;
	mux_ALU_A_i(2) <= PC_o;
	mux_ALU_A_i(3) <= x"0000";
	
	mux_ALU_A: four_one_mux_16bit
		port map(A_0 => mux_ALU_A_i(0), A_1 => mux_ALU_A_i(1), A_2 => mux_ALU_A_i(2), A_3 => mux_ALU_A_i(3), op => mux_ALU_A_s, z => mux_ALU_A_o);
	
	mux_ALU_B_i(0) <= "0000000000000010";
	mux_ALU_B_i(1) <= T2_o;
	mux_ALU_B_i(2)(8 downto 0) <= IR_o(8 downto 0);
	mux_ALU_B_i(3)(5 downto 0) <= IR_o(5 downto 0);
	mux_ALU_B_i(2)(15 downto 9) <= "0000000";
	mux_ALU_B_i(3)(15 downto 6) <= "0000000000";
	
	mux_ALU_B: four_one_mux_16bit
		port map(A_0 => mux_ALU_B_i(0), A_1 => mux_ALU_B_i(1), A_2 => mux_ALU_B_i(2), A_3 => mux_ALU_B_i(3), op => mux_ALU_B_s, z => mux_ALU_B_o);
	
	ALU_A_i <= mux_ALU_A_o;
	ALU_B_i <= mux_ALU_B_o;
	
	ALUnit: ALU
		port map(A => ALU_A_i, B => ALU_B_i, op => Control_bit_ALU, ALU_out => ALU_C_o);
		
	T3_i <= ALU_C_o;
	
	T3: reg_16
		port map(clk => clk, wr => w_T3, dataIn => T3_i, dataOut => T3_o);
	
	mux_RD3_i(0) <= PC_o;
	mux_RD3_i(1) <= T3_o;
	mux_RD3_i(2)(8 downto 0) <= IR_o(8 downto 0);
	mux_RD3_i(3) <= memory_o;
	
	mux_RD3: four_one_mux_16bit
		port map(A_0 => mux_RD3_i(0), A_1 => mux_RD3_i(1), A_2 => mux_RD3_i(2), A_3 => mux_RD3_i(3), op => mux_RD3_s, z => mux_RD3_o);
	
end Form;