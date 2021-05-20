library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Memory is --declaring entity
	port( dataIn, addr : in std_logic_vector(15 downto 0);
			clk, wr : in std_logic;
			dataOut : out std_logic_vector(15 downto 0));
end entity;

architecture Arch of Memory is --declaring architecture
	
	type regArray is array(128 downto 0) of std_logic_vector(15 downto 0); --defining type to implement memory
	signal memArray : regArray := (
		0 => x"104b",
		1 => x"6000",
		2 => x"c042",
		3 => x"0210",
		4 => x"c4c3",
		7 => x"13be",
		8 => x"2128",
		9 => x"0a32",
		10 => x"c982",
		11 => x"212a",
		12 => x"3caa",
		13 => x"5044",
		14 => x"8202",
		16 => x"91c0",
		18 => x"7000",
		19 => x"f000",
		20 => x"0014",
		21 => x"0002",
		23 => x"0016",
		24 => x"ffff",
		26 => x"ffff",
		27 => x"0012",
		others => x"0000"); -- initialise with instructions

begin
	
	process(clk)
	begin
		if(rising_edge(clk) and wr = '1')
		then
			memArray(to_integer(signed(addr))) <= dataIn;
		end if;
	end process;
	
	dataOut <= memArray(to_integer(signed(addr)));

end architecture;
