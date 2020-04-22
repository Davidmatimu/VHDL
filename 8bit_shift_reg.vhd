library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bitreg_8shift is
    Port ( I : in STD_LOGIC_VECTOR (7 downto 0);
           I_Shift_In : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (1 downto 0);-- 00:hold; 01: shift left; 10: shift right; 11: load
           clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (7 downto 0));
           --SHIFT_OUT : out STD_LOGIC;
end bitreg_8shift;

architecture Structural of bitreg_8shift is
component bitreg_4shift is
    Port( I : in STD_LOGIC_VECTOR (3 downto 0);
          I_Shift_In : in STD_LOGIC;
          sel : in STD_LOGIC_VECTOR (1 downto 0);
          clock : in STD_LOGIC;
          enable : in STD_LOGIC;
          O : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal bitCarry1: STD_LOGIC;
signal bitCarry2: STD_LOGIC;

begin
Carrying:process(clock)
begin
    if sel = "00" then
        bit1Carry1 <= '0';
        bit1Carry2 <= '0';
    elsif sel = "01" then
        bit1Carry1 <= I_Shift_In;
        bit1Carry2 <= I(3);
    elsif sel = "10" then
        bit1Carry1 <= I(4);
        bit1Carry2 <= I_Shift_In;
    elsif sel = "11" then
        bit1Carry1 <= '0';
        bit1Carry2 <= '0';
end if;
--bitCarry1 <=
--    I_Shift_In when sel = "01" else
--    sig(4) when sel = "10" else
--    '0' when sel = "00" else
--    '0' when sel = "11";
--bitCarry2 <=
--    sig(3) when sel = "01" else
--    I_Shift_In when sel = "10" else
--    '0' when sel = "00" else
--    '0' when sel = "11";
end process Carrying;
bitreg_shift1: bitreg_4shift port map(I(3 downto 0), bitCarry1, enable, sel, clock, O(3 downto 0));
bitreg_shift2: bitreg_4shift port map(I(7 downto 4), bitCarry2, enable, sel, clock, O(7 downto 4));

        
--process statements are in the component since this is structural architecture
--First 4bit shift reg uses sig 3 downto 0
--    sig(3) = carry of second reg when shift right
--    sig(0) = I_Shift_In when shift left, also carrys it's sig(3) as in for second reg
--Second 4bit Shift reg uses sig 7 downto 4
--    sig(7) = I_Shift_In when shift right, also carrys it's sig(4) as in for first reg
--    sig(4) = carry of first reg when shift left

O <= sig;
end Structural;
