library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_8by1 is
 Port ( s : in  STD_LOGIC_VECTOR (2 downto 0);
           I : in  STD_LOGIC_VECTOR (7 downto 0);
           Y : out STD_LOGIC);

end mux_8by1;

 Architecture struct of mux_8by1 is
     Signal a0,a1,a2,a3,a4,a5,a6,a7: STD_LOGIC;
    begin
    a0 <= I(0)  and (not s(0))  and  (not s(1))  and  (not s(2));
    a1 <= I(1)  and (not s(0))  and  (not s(1))  and          s(2);             
    a2 <= I(2)  and (not s(0))  and      s(1)    and  (not s(2));
    a3 <= I(3)  and (not s(0))  and         s(1)    and          s(2);
    a4 <= I(4)  and      s(0)      and  (not s(1))  and  (not s(2));
    a5 <= I(5)  and      s(0)      and  (not s(1))  and          s(2);
    a6 <= I(6)  and      s(0)      and          s(1)   and  (not s(2));
    a7 <= I(7)  and      s(0)      and          s(1)   and          s(2);
     
    Y <= a0 or a1 or a2 or a3 or a4 or a5 or a6 or a7;
    end struct;