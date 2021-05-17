library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity Node is -- defining entity
	port( Gin1, Gin0, Pin1, Pin0 : in std_logic;
			Gout, Pout : out std_logic);
end entity;

architecture Arch of Node is --declaring architecture
	
	signal temp: std_logic;
	component TwoByOneMux
		port( i : in std_logic_vector(1 downto 0);
			sel : in std_logic;
			z : out std_logic);
	end component;
	
begin
	MuxP : TwoByOneMux
		port map (i(1) => Pin0, i(0) => '0' , sel => Pin1, z => Pout);
	MuxG1 : TwoByOneMux
		port map (i(1) => Pin1, i(0) => '0' , sel => Gin0, z => temp);
	MuxG2 : TwoByOneMux
		port map (i(1) => '1', i(0) => temp , sel => Gin1, z => Gout);

end architecture;