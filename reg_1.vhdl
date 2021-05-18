
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY reg_1 IS
	 PORT ( clock, reset : in std_logic;
		 D : in std_logic;
		 Q : out std_logic );
END reg_1; 

ARCHITECTURE behaviour OF reg_1 IS
	 BEGIN
		 PROCESS (clock, reset)
		 BEGIN
			IF (reset = '1') THEN
				Q <= '0';
			ELSIF (rising_edge(clock)) THEN
				Q <= D;
			END IF;
		END PROCESS;
	END behaviour;
	
--	currently at reset=1, 0 is assigned.