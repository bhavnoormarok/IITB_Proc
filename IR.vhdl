
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY IR IS
	 PORT ( clock, reset : in std_logic;
		 D : in std_logic_vector (15 downto 0);
		 Q : out std_logic_vector (15 downto 0) );
END IR; 

ARCHITECTURE behaviour OF IR IS
	 BEGIN
		 PROCESS (clock, reset)
		 BEGIN
			IF (reset = '1') THEN
				Q <= "0000000000000000";
			ELSIF (rising_edge(clock)) THEN
				Q <= D;
			END IF;
		END PROCESS;
	END behaviour;
	
--	currently at reset=1, 0 is assigned.