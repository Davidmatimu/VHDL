
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bitreg_4shift is
    Port ( I : in STD_LOGIC_VECTOR (3 downto 0);
           I_Shift_In : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (1 downto 0);-- 00:hold; 01: shift left; 10: shift right; 11: load
           clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (3 downto 0));
end bitreg_4shift;

architecture Behavioral of bitreg_4shift is
signal sig : STD_LOGIC_VECTOR (3 downto 0) := "0000"; --start signal at 0
begin
shift:process(clock)
begin

if enable = '0' then
    sig <= "0000"; --sig is signal so has "memory"
elsif (clock'event and clock = '1' and enable = '1') then
    if sel = "00" then --hold, ie do nothing
    elsif sel = "01" then --shift left
        sig(3 downto 1) <= sig(2 downto 0); 
        sig(0) <= I_Shift_In;
    elsif sel = "10" then --shift right
        sig(2 downto 0) <= sig(3 downto 1);
        sig(3) <= I_Shift_In;
    elsif sel = "11" then --load
        sig <= I;--load whatever is being input into register
    end if;
end if;
end process shift;

O <= sig;
end Behavioral;
