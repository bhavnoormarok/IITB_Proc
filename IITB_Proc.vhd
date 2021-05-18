library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity IITB_Proc is 
	port (clk, reset : in std_logic;
			O:  out std_logic_vector(15 downto 0);
			Done: out std_logic);
end entity;

architecture Form of iitb_proc is 
begin
end Form;