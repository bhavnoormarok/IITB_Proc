library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity ALU is 
    port (A,B :in std_logic_vector(15 downto 0) ;
	      op : in std_logic;
		  ALU_out : out std_logic_vector(15 downto 0);
		  Z,C: out std_logic);
end entity;

architecture Struct of ALU is

signal f: std_logic_vector(16 downto 0);

begin

	f <= ('0' & (A nand B)) when (op = '0') else
         std_logic_vector(unsigned('0' & A) + unsigned('0' & B)));
   
	Z <= not (f(0) or f(1) or f(2) or f(3) or f(4) or f(5) or f(6) or f(7) or f(8) or f(9) or f(10) or f(11) or f(12) or f(13) or f(14) or f(15));
	ALU_out <= f(15 downto 0);	
    C <= f(16);

end architecture;	
