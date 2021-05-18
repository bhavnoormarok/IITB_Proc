library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY reg_16 IS
	 PORT ( clk, wr : in std_logic;
		 dataIn : in std_logic_vector(15 downto 0);
		 dataOut : out std_logic_vector(15 downto 0) );
END reg_16; 

ARCHITECTURE behaviour OF reg_1 IS

signal reg : std_logic_vector := x"0000";

BEGIN
     
    dataOut <= reg;    
	PROCESS (clock)
	BEGIN
	    IF (rising_edge(clock) and wr = '1') THEN
			reg <= dataIn;
		END IF;
	END PROCESS;

END behaviour;
