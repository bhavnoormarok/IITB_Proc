library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Types is -- package to declare the type fo array used for register file and memory
    type memRegArray is array (127 downto 0) of std_logic_vector(15 downto 0);
	 type regArray is array (7 downto 0) of std_logic_vector(15 downto 0);
end package Types;