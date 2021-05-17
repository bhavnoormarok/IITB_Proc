library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity Nand_16 is
	port( x : in std_logic_vector(15 downto 0);
			y : in std_logic_vector(15 downto 0);
			z : out std_logic_vector(15 downto 0));
end entity;

architecture Arch of Nand_16 is
begin
	z(0) <= x(0) nand y(0);
	z(1) <= x(1) nand y(1);
	z(2) <= x(2) nand y(2);
	z(3) <= x(3) nand y(3);
	z(4) <= x(4) nand y(4);
	z(5) <= x(5) nand y(5);
	z(6) <= x(6) nand y(6);
	z(7) <= x(7) nand y(7);
	z(8) <= x(8) nand y(8);
	z(9) <= x(9) nand y(9);
	z(10) <= x(10) nand y(10);
	z(11) <= x(10) nand y(10);
	z(12) <= x(10) nand y(10);
	z(13) <= x(10) nand y(10);
	z(14) <= x(10) nand y(10);
	z(15) <= x(10) nand y(10);
	
end Arch;