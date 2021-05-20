library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity StateFunc_alt is
	port( state_In :in integer range 0 to 40;
			IR_out,T1_out,T2_out: in std_logic_vector(15 downto 0);
			C_out, Z_out: in std_logic;
			state_Out :out integer range 0 to 40);
end entity;

architecture reader of StateFunc_alt is
	
begin
	process (state_In, IR_out, T1_out, T2_out)
	begin
		if (state_In=0) then 
			if (IR_out(15 downto 12)="0000" or IR_out(15 downto 12)="0010") then 
				state_Out <= 2;
			end if;
		elsif (state_In=2) then
			if (IR_out(15 downto 12)="0000") then 
				state_Out <= 3;
			elsif (IR_out(15 downto 12)="0010") then
				state_Out <= 4;
			end if;
		elsif (state_In=3 or state_In=4) then
			if (IR_out(15 downto 12)="0000" or IR_out(15 downto 12)="0010") then 
				state_Out <= 5;
			end if;
		elsif (state_In=5) then
			if (IR_out(15 downto 12)="0000" or IR_out(15 downto 12)="0010") then 
				state_Out <= 1;
			end if;
		end if;
	end process;

end architecture;