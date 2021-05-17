library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity Adder is
port ( a, b : in std_logic_vector (15 downto 0);
		cin: in std_logic;
		sum: out std_logic_vector (15 downto 0);
		cout: out std_logic);
end entity;

architecture Arch of Adder is --declaring architecture
	signal G_0,P_0: std_logic_vector(15 downto 0);
	signal G_1, P_1 : std_logic_vector(15 downto 0);
	signal G_2, P_2 : std_logic_vector(15 downto 0);
	signal G_3, P_3 : std_logic_vector(15 downto 0);
	signal G_4, P_4 : std_logic_vector(15 downto 0);
	--signal pre_G,pre_P : std_logic_vector(7 downto 0);
	signal carry : std_logic_vector(15 downto 1);
	component Node -- defining component
		port( Gin1, Gin0, Pin1, Pin0 : in std_logic;
			Gout, Pout : out std_logic);
	end component;
	
	component NodeRed -- defining component
		port( A, B : in std_logic;
				g, p : out std_logic);
	end component;
	
	component TwoByOneMuxXor
		port( in1, in0 : in std_logic;
			out0 : out std_logic);
	end component;
	
begin
	-- Level 0
	Level_0 : for n in 15 downto 0 generate
		pre_proc_node : NodeRed
			port map(A => a(n), B => b(n), g => G_0(n), p => P_0(n)); 
	end generate Level_0;
	
	-- Level 1
	Level_1 : for n in 15 downto 1 generate
		prefix_node : Node
			port map(Gin1 => G_0(n), Gin0 => G_0(n-1), Pin1 => P_0(n), Pin0 => P_0(n-1), Gout => G_1(n), Pout => P_1(n)); 
	end generate Level_1;
	
	G_1(0) <= G_0(0);
	P_1(0) <= P_0(0);
	
	-- Level 2
	Level_2 : for n in 15 downto 2 generate
		prefix_node : Node
			port map(Gin1 => G_1(n), Gin0 => G_1(n-2), Pin1 => P_1(n), Pin0 => P_1(n-2), Gout => G_2(n), Pout => P_2(n)); 
	end generate Level_2;
	
	G_2(1 downto 0) <= G_1(1 downto 0);
	P_2(1 downto 0) <= P_1(1 downto 0);
	
	-- Level 3
	Level_3 : for n in 15 downto 4 generate
		prefix_node : Node
			port map(Gin1 => G_2(n), Gin0 => G_2(n-4), Pin1 => P_2(n), Pin0 => P_2(n-4), Gout => G_3(n), Pout => P_3(n)); 
	end generate Level_3;
	
	G_3(3 downto 0) <= G_2(3 downto 0);
	P_3(3 downto 0) <= P_2(3 downto 0);
	
	
	-- Level 4
	Level_4 : for n in 15 downto 8 generate
		prefix_node : Node
			port map(Gin1 => G_3(n), Gin0 => G_3(n-8), Pin1 => P_3(n), Pin0 => P_3(n-8), Gout => G_4(n), Pout => P_4(n)); 
	end generate Level_4;
	
	G_4(7 downto 0) <= G_3(7 downto 0);
	P_4(7 downto 0) <= P_3(7 downto 0);
	
	
	
	-- finalise
	Finalise : for n in 14 downto 0 generate
		carry_node : Node
			port map(Gin1 => G_4(n), Gin0 => cin, Pin1 => P_4(n), Pin0 => '1', Gout => carry(n+1), Pout => open);
	end generate Finalise;
	
	carry_node_15 : Node
			port map(Gin1 => G_4(15), Gin0 => cin, Pin1 => P_4(15), Pin0 => '1', Gout => cout, Pout => open);
	
	Sum_For : for n in 15 downto 1 generate
		sum_gate : TwoByOneMuxXor
			port map(in1 => P_0(n), in0 => carry(n), out0 => sum(n));
	end generate Sum_For;
	
	sum_gate_0 : TwoByOneMuxXor
			port map(in1 => P_0(0), in0 => cin, out0 => sum(0));
	
end architecture;