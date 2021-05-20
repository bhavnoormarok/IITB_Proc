library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_16 is
	 PORT ( clk, wr : in std_logic;
		 dataIn : in std_logic_vector(15 downto 0);
		 dataOut : out std_logic_vector(15 downto 0) );
end entity; 

architecture behaviour of reg_16 is

signal reg : std_logic_vector(15 downto 0) := x"0000";

begin
     
    dataOut <= reg;    
	process (clk)
	begin
	    if (rising_edge(clk) and wr = '1') then
			reg <= dataIn;
		end if;
	end process;

end architecture;
