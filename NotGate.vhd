library ieee;
use ieee.std_logic_1164.all;

entity NotGate is
	port( x : in std_logic;
			z : out std_logic);
end entity;

architecture Arch of NotGate is
begin
	z <= not x;
end Arch;