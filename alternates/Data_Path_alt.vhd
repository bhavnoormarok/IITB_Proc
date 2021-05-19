library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity Data_Path is
	port (clk, reset : in std_logic;
		  w_PC, w_memory, w_IR, w_T1, w_T2, w_T3, w_RF : in std_logic;
	      Control_bit_ALU : in std_logic;
          mux_PC, mux_T1 : in std_logic;
	      mux_memory, mux_A1, mux_ALU_A, mux_ALU_B, mux_A3, mux_RD3: in std_logic_vector(1 downto 0);
		  Counter: in std_logic_vector(2 downto 0);
          IR_out, T1_out, T2_out : out std_logic_vector(15 downto 0);
          C_out, Z_out : out std_logic);
end entity;

architecture Arch of Data_Path is
	
	signal memory_addr_i,memory_data_i,PC_i,IR_i, T1_i, T2_i, ALU_A_i, ALU_B_i, T3_i, RD3_i: std_logic_vector(15 downto 0);
	
	signal A1_i, A2_i, A3_i: std_logic_vector(3 downto 0);
	
	signal memory_o, IR_o, PC_o:std_logic_vector(15 downto 0);
	signal ALU_C_o,T1_o, T2_o, T3_o, RD1_o, RD2_o :std_logic_vector(15 downto 0);
	
	component ALU is 
	    port (A,B :in std_logic_vector(15 downto 0) ;
			  op : in std_logic;
			  ALU_out : out std_logic_vector(15 downto 0);
			  Z,Cout: out std_logic);
	end component;
	
	component reg_16 is
	    port ( clk, wr : in std_logic;
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
    -- assign inputs using muxes
	memory_addr_i <= ALU_C_o when (mux_memory(1 downto 0) = "00") else
                     PC_o when (mux_memory(1 downto 0) = "01") else
	                 T3_o when (mux_memory(1 downto 0) = "10") else
                     T1_o;  
    
    memory_data_i <= RD3_o;

    PC_i <= ALU_C_o when (mux_PC = '0') else
            RD1_o;
    
    IR_i <= memory_o;

    T1_i <= ALU_C_o when (mux_T1 = '1') else
            RD1_o;  
    
    T2_i <= RD2_o;
    
    T3_i <= ALU_C_o;
    
    ALU_A_i <= std_logic_vector(resize(signed(IR_o(5 downto 0), 16)) when (mux_ALU_A(1 downto 0) = "00") else
               T1_o when (mux_ALU_A(1 downto 0) = "01") else
	           PC;

    ALU_B_i <= std_logic_vector(to_signed(2, 16)) when (mux_ALU_B(1 downto 0) = "00") else
               T2_o when (mux_ALU_B(1 downto 0) = "01") else
	           std_logic_vector(resize(signed(IR_o(8 downto 0), 16)) when (mux_ALU_B(1 downto 0) = "10") else
               std_logic_vector(resize(signed(IR_o(5 downto 0), 16));
    
    RD3_i <= PC_o when (mux_RD3(1 downto 0) = "00") else
             T3_o when (mux_RD3(1 downto 0) = "01") else
	         std_logic_vector(resize(signed(IR_o(8 downto 0), 16)) when (mux_RD3(1 downto 0) = "10") else
             memory_o;
    
    A1_i <= IR_o(11 downto 9) when (mux_A1(1 downto 0) = "00") else
            IR_o(8 downto 6) when (mux_A1(1 downto 0) = "01") else
	        Counter(2 downto 0);
    
    A2_i <= IR_o(8 downto 6)

    A3_i <= IR_o(11 downto 9) when (mux_A3(1 downto 0) = "00") else
            IR_o(8 downto 6) when (mux_A3(1 downto 0) = "01") else
	        Counter(2 downto 0) when (mux_A3(1 downto 0) = "10") else
            IR_o(5 downto 3);
    
    --------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------
    -- map inputs and outputs to components
	PC: reg_16  
		port map(clk => clk, wr => w_PC, dataIn => PC_i, dataOut => PC_o);
	
	mem: Memory
		port map(dataIn => memory_data_i, addr => memory_addr_i, clk => clk, wr => w_memory, dataOut => memory_o);
	
	IR: reg_16
		port map(clk => clk, wr => w_IR, dataIn => IR_i, dataOut => IR_o);
	
	RF: Register_File
		port map(A1 => A1_i, A2 => A2_i, A3 => A3_i, D3 => RD3_i, clk => clk, wr => w_RF, D1 => RD1_o, D2 => RD2_o);

	T1: reg_16
		port map(clk => clk, wr => w_T1, dataIn => T1_i, dataOut => T1_o);
		
	T2: reg_16
		port map(clk => clk, wr => w_T2, dataIn => T2_i, dataOut => T2_o);
	
	ALUnit: ALU
		port map(A => ALU_A_i, B => ALU_B_i, op => Control_bit_ALU, ALU_out => ALU_C_o);
	
	T3: reg_16
		port map(clk => clk, wr => w_T3, dataIn => T3_i, dataOut => T3_o);
	
end Arch;
