library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity StateFunc is
	port( operation_In : in integer range 0 to 20;
			state_In :in integer range 0 to 20;
			instruction,T1,T2: in std_logic_vector(15 downto 0);
			C_flag, Z_flag: in std_logic;
			operation_Out : out integer range 0 to 20;
			state_Out :out integer range 0 to 20);
end entity;

architecture reader of StateFunc is
	
begin
	process (operation_In,state_In, instruction, T1, T2)
	begin
		if (operation_In=0) and (state_In=0) then 
			if (instruction(15 downto 12)="0000" or instruction(15 downto 12)="0010") then 
				operation_Out <= 1;
				state_Out <= 1;
			
			
			
			
			end if;
		elsif (operation_In=1) and (state_In=1) then
			if (instruction(15 downto 12)="0000") then 
				operation_Out <= 1;
				state_Out <= 2;
			elsif (instruction(15 downto 12)="0010") then
				operation_Out <= 2;
				state_Out <= 2;
			end if;
		elsif (operation_In=1 or operation_In=2) and (state_In=2) then
			operation_Out <= 1;
			state_Out <= 3;
		elsif (operation_In=1) and (state_In=3) then
			operation_Out <= 0;
			state_Out <= 1;
		elsif (operation_In=1) and (state_In=3) then
			operation_Out <= 0;
			state_Out <= 1;
		elsif (operation_In=0) and (state_In=1) and (1=1) then  -- 1=1 will be replace by another condition
			operation_Out <= 0;
			state_Out <= 0;
		end if;
	end process;

end architecture;