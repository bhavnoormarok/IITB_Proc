library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_1 is
	 PORT ( clk, wr : in std_logic;
		 dataIn : in std_logic;
		 dataOut : out std_logic );
end entity; -- 1-bit register component

architecture behaviour of reg_1 is
signal reg : std_logic := '0';
begin
    dataOut <= reg;  -- read output of the register
	 process(clk)
	 begin
		if (rising_edge(clk) and wr = '1') then
			reg <= dataIn; -- write into the register when write signal is '1'
		end if;
	end process;
end architecture;
	
--	currently at reset=1, 0 is assigned.
