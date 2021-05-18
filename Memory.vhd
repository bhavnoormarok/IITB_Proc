library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;


entity Memory is --declaring entity
	port( dataIn,addr : in std_logic_vector(15 downto 0);
			clk,memW : in std_logic;
			dataOut : out std_logic_vector(15 downto 0));
end entity;

architecture Arch of Memory is --declaring architecture
	
	type regArray is array(128 downto 0) of std_logic_vector(15 downto 0); --defining type to implement memory
	signal memArray : regArray := (others => x"0000"); -- initialise with instructions

begin
	
	process(clk)
	begin
		if(rising_edge(clk) and memW = '1')
		then
			memArray(to_integer(unsigned(addr))) <= dataIn;
		end if;
	end process;
	
	dataOut <= memArray(to_integer(unsigned(addr)));

end architecture;