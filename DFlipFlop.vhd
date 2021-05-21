library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DFlipFlop is
	port( clk,rst : in std_logic;
			state_In :in integer range 0 to 40;
			state_Out : out integer range 0 to 40);
end entity; -- component which stores and updates the controller FSM states

architecture behave of DFlipFlop is
begin
	process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1' ) then
				state_Out <= 0; -- reset the state to 0 when reset signal is 1
			else
				state_Out <= state_In; -- update state at clock edge
			end if;
		end if;
	end process;
end architecture;
