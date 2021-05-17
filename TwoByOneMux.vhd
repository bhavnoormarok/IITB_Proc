library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity TwoByOneMux is -- defining entity
	port( i : in std_logic_vector(1 downto 0);
			sel : in std_logic;
			z : out std_logic);
end entity;

architecture Arch of TwoByOneMux is --declaring architecture
	
	signal p,q,r : std_logic;
	component OrGate
		port ( x,y : in std_logic; z: out std_logic);
	end component;
	
	component NotGate
		port ( x : in std_logic; z: out std_logic);
	end component;
	component AndGate
		port ( x,y : in std_logic; z: out std_logic); -- using and. or and not gate as components
	end component;
	
begin
	and1 : AndGate
		port map (x => i(1), y => sel , z => p); --using formula (i1 and sel) or (i0 and sel') 
	not1 : NotGate
		port map (x => sel, z => q);
	and2 : AndGate
		port map (x => i(0), y=> q, z => r);
	or1 : OrGate 
		port map (x => p, y => r, z => z);
end architecture;