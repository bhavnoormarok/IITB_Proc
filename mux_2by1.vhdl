library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_2by1 is
    Port ( S : in  STD_LOGIC;
           I : in  STD_LOGIC_VECTOR (1 downto 0);
           Y : out STD_LOGIC);

end mux_2by1;

architecture struct of mux_2by1 is
begin
	y <= (I(0) and (not S) )
			or (I(1) and S);
end struct;