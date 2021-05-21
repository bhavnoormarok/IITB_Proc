library work;
use work.all;
use work.Types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_main is
end entity;

architecture test_archi of testbench_main is

signal clk: std_logic := '0';
signal rst : std_logic := '1';
signal finished : std_logic := '0';
signal currState: integer range 0 to 40;
signal currPC,currMemAddr,currT1,currT2,currT3,currIR : std_logic_vector(15 downto 0);
signal currMemAll : memRegArray;
signal currRegAll : regArray;

component IITB_Proc is 
	port (clk, reset : in std_logic;
			currState : out integer range 0 to 40;
			currPC,currMemAddr,currT1,currT2,currT3,currIR : out std_logic_vector(15 downto 0);
			currMemAll : out memRegArray;
			currRegAll : out regArray);
end component;

begin
	enc_instance: IITB_Proc 
		port map(clk,rst,currState,currPC,currMemAddr,currT1,currT2,currT3,currIR,currMemAll,currRegAll);
	clk <= not clk after 10 ns when finished = '0' else '0';
	rst <= '1',
			 '0' after 20 ns;
	finished <= '0',
			 '1' after 400 ns;
end architecture;
