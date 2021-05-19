library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity ALU is 
port (A,B :in std_logic_vector(15 downto 0) ;
		op : in std_logic;
		ALU_out : out std_logic_vector(15 downto 0);
		Z,Cout: out std_logic);
end entity;

architecture Struct of ALU is

	signal adder_out,nand_out,f: std_logic_vector(15 downto 0);
	Signal c_out : std_logic;
	component Adder
		port ( a, b : in std_logic_vector (15 downto 0);
		cin: in std_logic;
		sum: out std_logic_vector (15 downto 0);
		cout: out std_logic);
	end component;
	
	component two_one_mux_16bit is
	port( A_1 : in std_logic_vector(15 downto 0);
			A_0 : in std_logic_vector(15 downto 0);
			op: in std_logic;
			z : out std_logic_vector(15 downto 0));
	end component;

begin
	adder_16bit : Adder
			port map(a => A, b => B, cin => '0', sum => adder_out, cout => c_out); 
	nand_out <= (A nand B);
	mux :	two_one_mux_16bit
			port map(A_1 => adder_out, A_0 => nand_out, op => op, z => f);
	Z <= not (f(0) or f(1) or f(2) or f(3) or f(4) or f(5) or f(6) or f(7) or f(8) or f(9) or f(10) or f(11) or f(12) or f(13) or f(14) or f(15));
	ALU_out <=f;
	Cout <= c_out;
end architecture;	
