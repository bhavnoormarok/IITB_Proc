library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;	 
--use ieee.std_logic_unsigned.all;

entity T1 is
	port ( data_in : in std_logic_vector (15 downto 0);
				clk, t1_w : in std_logic);
end entity;

architecture Form of T1 is 
	signal reg : std_logic_vector (15 downto 0) := x"0000";
	
begin 
	process (clk,t1_w)
	begin 
		if (rising_edge(clk) and t1_w = '1')
		then
			reg <= data_in;
		end if;
	end process;
end Form;
		