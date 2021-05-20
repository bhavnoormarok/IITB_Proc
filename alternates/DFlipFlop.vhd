library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DFlipFlop is
	port( clk,rst : in std_logic;
			operation_In : in integer range 0 to 9;
			state_In :in integer range 0 to 20;
			operation_Out : out integer range 0 to 9;
			state_Out : out integer range 0 to 20);
end entity;

architecture behave of DFlipFlop is
begin
	process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1' ) then
				state_Out <= 0;
				operation_Out <= 0;
			else
				state_Out <= state_In;
				operation_Out <= operation_In;
			end if;
		end if;
	end process;
end architecture;