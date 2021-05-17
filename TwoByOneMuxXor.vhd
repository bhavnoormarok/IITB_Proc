library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity TwoByOneMuxXor is -- defining entity
	port( in1, in0 : in std_logic;
			out0 : out std_logic);
end entity;

architecture Arch of TwoByOneMuxXor is --declaring architecture
	
	signal notin0: std_logic;
	component TwoByOneMux
		port( i : in std_logic_vector(1 downto 0);
			sel : in std_logic;
			z : out std_logic);
	end component;
	
begin
	Mux0 : TwoByOneMux
		port map (i(1) => '0', i(0) => '1', sel => in0, z => notin0);
	Mux1 : TwoByOneMux
		port map (i(1) => notin0, i(0) => in0 , sel => in1, z => out0);
end architecture;