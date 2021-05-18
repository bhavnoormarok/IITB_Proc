library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY reg_1 IS
	 PORT ( clk, wr : in std_logic;
		 dataIn : in std_logic;
		 dataOut : out std_logic );
END reg_1; 

ARCHITECTURE behaviour OF reg_1 IS
signal reg : std_logic := '0';
BEGIN
     dataOut <= reg    
	 PROCESS (clock)
	 BEGIN
		IF (rising_edge(clock) and wr = '1') THEN
			reg <= dataIn;
		END IF;
	END PROCESS;
END behaviour;
	
--	currently at reset=1, 0 is assigned.
