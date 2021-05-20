library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DFlipFlop_alt is
	port( clk,rst : in std_logic;
			state_In :in integer range 0 to 40;
			state_Out : out integer range 0 to 40);
end entity;

architecture behave of DFlipFlop_alt is
begin
	process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1' ) then
				state_Out <= 0;
			else
				state_Out <= state_In;
			end if;
		end if;
	end process;
end architecture;