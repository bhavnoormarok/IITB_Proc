library ieee;
use ieee.std_logic_1164.all;

entity OrGate is
	port( x : in std_logic;
			y : in std_logic;
			z : out std_logic);
end entity;

architecture Arch of OrGate is
begin
	z <= x or y;
end Arch;
