library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity;

architecture test_archi of testbench is
	signal A: std_logic_vector(15 downto 0);
	signal B: std_logic_vector(15 downto 0);
	signal OP: std_logic;
	signal ALU_out:std_logic_vector(15 downto 0);
	signal Z,Cout:std_logic;
	component ALU is
	port (A,B :in std_logic_vector(15 downto 0) ;
		op : in std_logic;
		ALU_out : out std_logic_vector(15 downto 0);
		Z,Cout: out std_logic);
	end component;
begin
	enc_instance: ALU port map(A,B,op,ALU_out,Z,Cout);

process
begin 

for a_r in 200 to 300 loop 
    for b_r in 1000 to 1100 loop  -- 0 to 15 for p'length = 4
	 
		op <= '1';
      A  <= std_logic_vector(to_unsigned(a_r, 16));
      B  <= std_logic_vector(to_unsigned(b_r,16));

      wait for 5 ns;
		
		assert unsigned(ALU_out) = to_unsigned(a_r + b_r,16) report "Error 1" severity FAILURE;
		
    end loop;
end loop;
end process;

end architecture;
