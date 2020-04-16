
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bitreg_shift is
    Port ( I : in STD_LOGIC_VECTOR (3 downto 0);
           I_Shift_In : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (3 downto 0);-- 00:hold; 01: shift left; 10: shift right; 11: load
           clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (3 downto 0));
end bitreg_shift;

architecture Behavioral of bitreg_shift is
begin
shift:process(I, I_SHIFT_IN, sel, clock, enable)
begin

end process shift;
end Behavioral;
