library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity Register_File is
	port ( A1, A2, A3 : in std_logic_vector(2 down to 0);
			D3 : in std_logic_vector (15 downto 0);
			clk, reg_w : in std_logic;
			D1, D2 : out std_logic_vector (15 downto 0));
end entity;

architecture Form of Register_file is 
	type regArray is array(7 downto 0) of std_logic_vector(15 downto 0);
	signal reg : regArray := (others => x"0000");
begin
	D1 <= reg(to_integer(unsigned(A1)));
	D2 <= reg(to_integer(unsigned(A2)));
	
	process (clk,reg_w)
	begin
		if (rising_edge(clk) and reg_w = '1')
		then
			reg(to_integer(unsigned(A3))) <= D3;
		end if;
	end process;
end Form;