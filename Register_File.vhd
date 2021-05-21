library std;
use std.standard.all;

library work;
use work.Types.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_File is
	port ( A1, A2, A3 : in std_logic_vector(2 downto 0);
			D3 : in std_logic_vector (15 downto 0);
			clk, wr : in std_logic;
			D1, D2 : out std_logic_vector (15 downto 0);
			allOut : out regArray);
end entity; -- compnent which implements the 8 16-bit registers

architecture Arch of Register_file is 

signal reg : regArray := (0 => x"0001", 1 => x"0001", others => x"0000");

begin

	D1 <= reg(to_integer(unsigned(A1))); 
	D2 <= reg(to_integer(unsigned(A2))); -- read outputs of the register file
	allOut <= reg;
	process (clk)
	begin
		if (rising_edge(clk) and wr = '1')
		then
			reg(to_integer(unsigned(A3))) <= D3; -- write into register file when write signal is '1'
		end if;
	end process;
end Arch;
