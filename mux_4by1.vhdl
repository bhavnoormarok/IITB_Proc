library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_4by1 is
    Port ( S : in  STD_LOGIC_VECTOR (1 downto 0);
           I : in  STD_LOGIC_VECTOR (3 downto 0);
           Y : out STD_LOGIC);

end mux_4by1;

architecture struct of mux_4by1  is
begin
	y <= (I(0) and (not S(1)) and (not S(0)))
			or (I(1) and (not S(1)) and (S(0)))
			or (I(2) and (S(1)) and (not S(0)))
			or (I(3) and (S(1)) and (S(0)));
end struct;