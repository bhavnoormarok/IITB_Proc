library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;


entity AndGate is
	port( x : in std_logic;
			y : in std_logic;
			z : out std_logic);
end entity;

architecture Arch of AndGate is
begin
	z <= x and y;
end Arch;