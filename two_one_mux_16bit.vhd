library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity two_one_mux_16bit is
	port( A_0 : in std_logic_vector(15 downto 0);
			A_1 : in std_logic_vector(15 downto 0);
			op: in std_logic;
			z : out std_logic_vector(15 downto 0));
end entity;

architecture Arch of two_one_mux_16bit is
begin
z(0) <= (A_1(0) and op) or (A_0(0) and (not op));
z(1) <= (A_1(1) and op) or (A_0(1) and (not op));
z(2) <= (A_1(2) and op) or (A_0(2) and (not op));
z(3) <= (A_1(3) and op) or (A_0(3) and (not op));
z(4) <= (A_1(4) and op) or (A_0(4) and (not op));
z(5) <= (A_1(5) and op) or (A_0(5) and (not op));
z(6) <= (A_1(6) and op) or (A_0(6) and (not op));
z(7) <= (A_1(7) and op) or (A_0(7) and (not op));
z(8) <= (A_1(8) and op) or (A_0(8) and (not op));
z(9) <= (A_1(9) and op) or (A_0(9) and (not op));
z(10) <= (A_1(10) and op) or (A_0(10) and (not op));
z(11) <= (A_1(11) and op) or (A_0(11) and (not op));
z(12) <= (A_1(12) and op) or (A_0(12) and (not op));
z(13) <= (A_1(13) and op) or (A_0(13) and (not op));
z(14) <= (A_1(14) and op) or (A_0(14) and (not op));
z(15) <= (A_1(15) and op) or (A_0(15) and (not op));
end architecture;