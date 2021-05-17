library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity NodeRed is -- defining entity
	port( A, B : in std_logic;
			g, p : out std_logic);
end entity;

architecture Arch of NodeRed is --declaring architecture

	component TwoByOneMux
		port( i : in std_logic_vector(1 downto 0);
			sel : in std_logic;
			z : out std_logic);
	end component;
	component TwoByOneMuxXor
		port( in1, in0 : in std_logic;
			out0 : out std_logic);
	end component;
	
begin
	Muxp : TwoByOneMuxXor
		port map (in1 => A, in0 => B, out0 => p);
	Muxg : TwoByOneMux
		port map (i(1) => B, i(0) => '0' , sel => A, z => g);

end architecture;