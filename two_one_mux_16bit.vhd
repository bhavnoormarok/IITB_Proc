library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity two_one_mux_16bit is
	port( add_out : in std_logic_vector(15 downto 0);
			nand_out : in std_logic_vector(15 downto 0);
			op: in std_logic;
			z : out std_logic_vector(15 downto 0));
end entity;

architecture Arch of two_one_mux_16bit is
begin
z(0) <= (add_out(0) and op) or (nand_out(0) and (not op));
z(1) <= (add_out(1) and op) or (nand_out(1) and (not op));
z(2) <= (add_out(2) and op) or (nand_out(2) and (not op));
z(3) <= (add_out(3) and op) or (nand_out(3) and (not op));
z(4) <= (add_out(4) and op) or (nand_out(4) and (not op));
z(5) <= (add_out(5) and op) or (nand_out(5) and (not op));
z(6) <= (add_out(6) and op) or (nand_out(6) and (not op));
z(7) <= (add_out(7) and op) or (nand_out(7) and (not op));
z(8) <= (add_out(8) and op) or (nand_out(8) and (not op));
z(9) <= (add_out(9) and op) or (nand_out(9) and (not op));
z(10) <= (add_out(10) and op) or (nand_out(10) and (not op));
z(11) <= (add_out(11) and op) or (nand_out(11) and (not op));
z(12) <= (add_out(12) and op) or (nand_out(12) and (not op));
z(13) <= (add_out(13) and op) or (nand_out(13) and (not op));
z(14) <= (add_out(14) and op) or (nand_out(14) and (not op));
z(15) <= (add_out(15) and op) or (nand_out(15) and (not op));
end architecture;