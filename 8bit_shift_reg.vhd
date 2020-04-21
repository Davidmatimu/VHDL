
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bitreg_8shift is
    Port ( I : in STD_LOGIC_VECTOR (7 downto 0);
           I_Shift_In : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (1 downto 0);-- 00:hold; 01: shift left; 10: shift right; 11: load
           clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (7 downto 0));
end bitreg_8shift;

architecture Structural of bitreg_8shift is
component bitreg_4shift is
    Port( I : in STD_LOGIC_VECTOR (3 downto 0);
          I_Shift_In : in STD_LOGIC;
          sel : in STF_LOGIC_VECTOR (3 downto 0);
          clock : in STD_LOGIC;
          enable : in STD_LOGIC;
          O : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal 4bitCarry1: STD_LOGIC;
signal 4bitCarry2: STD_LOGIC;
signal sig : STD_LOGIC_VECTOR (7 downto 0) := "0000"; --start signal at 0

begin
bitreg_shift1: bitreg_4shift port map(I(3 downto 0), 4bitCarry1, sel, clock, enable, sig(3 downto 0));
bitreg_shift2: bitreg_4shift port map(I(7 downto 4), 4bitCarry2, sel, clock, enable, sig(7 downto 4));

--process statements are in the component since this is structural architecture
--First 4bit shift reg uses sig 3 downto 0
--    sig(3) = carry of second reg when shift right
--    sig(0) = I_Shift_In when shift left, also carrys it's sig(3) as in for second reg
--Second 4bit Shift reg uses sig 7 downto 4
--    sig(7) = I_Shift_In when shift right, also carrys it's sig(4) as in for first reg
--    sig(4) = carry of first reg when shift left

with sel select 4bitCarry1 <= I_Shift_In when "01", sig(4) when "10", '0' when others;
with sel select 4bitCarry2 <= sig(3) when "01", I_Shift_In when "10", '0' when others;

O <= sig;
end Structural;
