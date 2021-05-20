library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity StateFunc is
	port( state_In :in integer range 0 to 40;
			IR_out,T1_out,T2_out: in std_logic_vector(15 downto 0);
			C_out, Z_out: in std_logic;
			state_Out :out integer range 0 to 40);
end entity;

architecture reader of StateFunc is
	
begin
	process (state_In, IR_out, T1_out, T2_out)
	begin
		if (state_In=0) then 
			if (IR_out(15 downto 12)="0000" or IR_out(15 downto 12)="0010" or IR_out(15 downto 12) = "1100") then 
				state_Out <= 2;
			elsif (IR_out(15 downto 12) = "0001") then
				state_Out <= 9;
			elsif (IR_out(15 downto 12)="0101" or IR_out(15 downto 12)="0100") then
				state_Out <= 12;
			elsif( IR_out(15 downto 12)="1001" or IR_out(15 downto 12)="1000") then
				state_Out <= 7;
			elsif( IR_out(15 downto 12)="0111" or IR_out(15 downto 12)="0111") then
				state_Out <= 9;
			elsif( IR_out(15 downto 12)="0011") then
				state_Out <= 6;
			--
			end if;
		elsif (state_In=1) then
			state_Out <= 0;
		elsif (state_In=2) then
			if (IR_out(15 downto 12)="0000") then 
				state_Out <= 3;
			elsif (IR_out(15 downto 12)="0010") then
				state_Out <= 4;
			elsif (IR_out(15 downto 12)="1100" and T1_out = T2_out) then
				state_Out <= 15;
			elsif (IR_out(15 downto 12)="1100" and T1_out /= T2_out) then
				state_Out <= 1;
			end if;
		elsif (state_In=3) then
			if (IR_out(15 downto 12)="0000" or IR_out(15 downto 12)="0010") then 
				state_Out <= 5;
			end if;
		elsif (state_In=4) then
			if (IR_out(15 downto 12)="0000" or IR_out(15 downto 12)="0010") then 
				state_Out <= 5;
			end if;
		elsif (state_In=5) then
			if (IR_out(15 downto 12)="0000" or IR_out(15 downto 12)="0010") then 
				state_Out <= 1;
			end if;
		elsif (state_In = 6) then
			if (IR_out(15 downto 12)="0011") then
				state_Out <= 1;
			end if;
		elsif (state_In = 7) then
			if (IR_out(15 downto 12)="1001") then 
				state_Out <= 16;
			elsif (IR_out(15 downto 12)="1000") then
				state_Out <= 8;
			end if;
		elsif (state_In = 8) then
			state_Out <= 0;
		elsif (state_In = 9) then
			if (IR_out(15 downto 12) = "0001") then
				state_Out <= 10;
			elsif( IR_out(15 downto 12)="0110") then
				state_Out <= 17;
			elsif( IR_out(15 downto 12)="0111") then
				state_Out <= 25;
			end if;
		elsif (state_In = 10) then
			if (IR_out(15 downto 12) = "0001") then
				state_Out <= 11;
			elsif (IR_out(15 downto 12) = "0100") then
				state_Out <= 13;
			elsif (IR_out(15 downto 12) = "0101") then
				state_Out <= 14;
			end if;
		elsif (state_In = 11) then
			state_Out <= 1;
		elsif (state_In = 12) then
			state_Out <= 10;
		elsif (state_In = 13) then
			state_Out <= 1;
		elsif (state_In = 14) then
			state_Out <= 1;
		elsif (state_In = 15) then
			state_Out <= 0;
		elsif (state_In>=17 and State_In< 24) then
			state_Out<= (State_In+1);
		elsif (state_In = 24) then
			state_Out <= 1;
		elsif( state_In >=25 and State_In <32) then
			state_Out<= (State_In+1);
		elsif (state_In = 32) then
			state_Out <= 1;
		end if;
	end process;

end architecture;