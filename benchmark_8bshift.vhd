library ieee;
use ieee.std_logic_1164.all;

entity shift_reg_tb is
end shift_reg_tb;
architecture behav of shift_reg_tb is
--  Declaration of the component that will be instantiated.
component shift_reg
    port (      I:    in std_logic_vector (3 downto 0);
        I_SHIFT_IN: in std_logic;
        sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
        clock:            in std_logic; 
        enable:           in std_logic;
        O:    out std_logic_vector(3 downto 0)
    );
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal i, o : std_logic_vector(3 downto 0);
signal i_shift_in, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);

begin
--  Component instantiation.
shift_reg_0: shift_reg port map (I => i, I_SHIFT_IN => i_shift_in, sel => sel, clock => clk, enable => enable, O => o);
--  This process does the real job.
process
    type pattern_type is record
--  The inputs of the shift_reg.
        i: std_logic_vector (3 downto 0);
        i_shift_in, clock, enable: std_logic;
        sel: std_logic_vector(1 downto 0);
--  The expected outputs of the shift_reg.
        o: std_logic_vector (3 downto 0);
    end record;
--  The patterns to apply.

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
--Input,i_shift_in(shiftleft or right),sel,clk,enable,O
--10 shiftleft, 01 shiftright, 11 load, 00 hold
    (("00010000",'0',"11",'0','1',"00000000"),--load 16 into register
    ("00010000",'0',"01",'0','1',"00000000"),--shift left (32)
    ("00010000",'0',"10",'0','1',"00000000"),--shift right (16)
    ("00010000",'0',"00",'0','1',"00000000"),--hold
    ("01100000",'0',"11",'0','1',"00000000"),--load 96 into register
    ("01100000",'0',"01",'0','1',"00000000"),--shift left (192)
    ("01100000",'0',"10",'0','1',"00000000"),--shift right (96)
    ("01100000",'0',"00",'0','1',"00000000"),--hold
    ("00100000",'1',"11",'0','1',"00000000"),--load 32 into register
    ("00100000",'1',"01",'0','1',"00000000"),--shift left (64)
    ("00100000",'1',"10",'0','1',"00000000"),--shift right (32)
    ("00100000",'1',"00",'0','1',"00000000"),--hold
    ("01110000",'1',"11",'0','1',"00000000"),--load 112 into register
    ("01110000",'1',"01",'0','1',"00000000"),--shift left (224)
    ("01110000",'1',"10",'0','1',"00000000"),--shift right (112)
    ("01110000",'1',"00",'0','1',"00000000"),--hold
    ("00010000",'0',"11",'1','1',"00010000"),--load 16 into register
    ("00010000",'0',"01",'1','1',"00100000"),--shift left (32)
    ("00010000",'0',"10",'1','1',"00010000"),--shift right (16)
    ("00010000",'0',"00",'1','1',"00010000"),--hold
    ("01010000",'0',"11",'1','1',"01010000"),--load 82 into register
    ("01010000",'0',"01",'1','1',"10100000"),--shift left (164)
    ("01010000",'0',"10",'1','1',"01010000"),--shift right (82)
    ("01010000",'0',"00",'1','1',"01010000"),--hold
    ("00010000",'1',"11",'1','1',"00010000"),--load 16 into register
    ("00010000",'1',"01",'1','1',"00100001"),--shift left (32)
    ("00010000",'1',"10",'1','1',"00010000"),--shift right (16)
    ("00010000",'1',"00",'1','1',"00010000"),--hold
    ("10000000",'1',"11",'1','1',"10000000"),--load 128 into register
    ("10000000",'1',"10",'1','1',"11000000"),--shift right (192)
    ("10000000",'1',"01",'1','1',"10000000"),--shift left (128)
    ("10000000",'1',"00",'1','1',"10000000"),--hold
    --ENABLE = 0 for this block
    ("00010000",'0',"11",'0','0',"00000000"),--load 16 into register enable is 0 so does nothing
    ("00010000",'0',"01",'0','0',"00000000"),--shift left (32) enable is 0 so does nothing
    ("00010000",'0',"10",'0','0',"00000000"),--shift right (16) enable is 0 so does nothing
    ("00010000",'0',"00",'0','0',"00000000"),--hold enable is 0 so does nothing
    ("01100000",'0',"11",'0','0',"00000000"),--load 96 into register enable is 0 so does nothing
    ("01100000",'0',"01",'0','0',"00000000"),--shift left (192) enable is 0 so does nothing
    ("01100000",'0',"10",'0','0',"00000000"),--shift right (96) enable is 0 so does nothing
    ("01100000",'0',"00",'0','0',"00000000"),--hold enable is 0 so does nothing
    ("00100000",'1',"11",'0','0',"00000000"),--load 32 into register enable is 0 so does nothing
    ("00100000",'1',"01",'0','0',"00000000"),--shift left (64) enable is 0 so does nothing
    ("00100000",'1',"10",'0','0',"00000000"),--shift right (32) enable is 0 so does nothing
    ("00100000",'1',"00",'0','0',"00000000"),--hold enable is 0 so does nothing
    ("01110000",'1',"11",'0','0',"00000000"),--load 112 into register enable is 0 so does nothing
    ("01110000",'1',"01",'0','0',"00000000"),--shift left (224) enable is 0 so does nothing
    ("01110000",'1',"10",'0','0',"00000000"),--shift right (112) enable is 0 so does nothing
    ("01110000",'1',"00",'0','0',"00000000"),--hold enable is 0 so does nothing
    ("00010000",'0',"11",'1','0',"00000000"),--load 16 into register enable is 0 so does nothing
    ("00010000",'0',"01",'1','0',"00000000"),--shift left (32) enable is 0 so does nothing
    ("00010000",'0',"10",'1','0',"00000000"),--shift right (16) enable is 0 so does nothing
    ("00010000",'0',"00",'1','0',"00000000"),--hold enable is 0 so does nothing
    ("01010000",'0',"11",'1','0',"00000000"),--load 82 into register enable is 0 so does nothing
    ("01010000",'0',"01",'1','0',"00000000"),--shift left (164) enable is 0 so does nothing
    ("01010000",'0',"10",'1','0',"00000000"),--shift right (82) enable is 0 so does nothing
    ("01010000",'0',"00",'1','0',"00000000"),--hold enable is 0 so does nothing
    ("00010000",'1',"11",'1','0',"00000000"),--load 16 into register enable is 0 so does nothing
    ("00010000",'1',"01",'1','0',"00000000"),--shift left (32) enable is 0 so does nothing
    ("00010000",'1',"10",'1','0',"00000000"),--shift right (16) enable is 0 so does nothing
    ("00010000",'1',"00",'1','0',"00000000"),--hold enable is 0 so does nothing
    ("10000000",'1',"11",'1','0',"00000000"),--load 128 into register enable is 0 so does nothing
    ("10000000",'1',"10",'1','0',"00000000"),--shift right (192) enable is 0 so does nothing
    ("10000000",'1',"01",'1','0',"00000000"),--shift left (128) enable is 0 so does nothing
    ("10000000",'1',"00",'1','0',"00000000"));--hold enable is 0 so does nothing
                                 
begin
--  Check each pattern.
    for n in patterns'range loop
--  Set the inputs.
        i <= patterns(n).i;
        i_shift_in <= patterns(n).i_shift_in;
        sel <= patterns(n).sel;
        clk <= patterns(n).clock;
        enable <= patterns(n).enable;
--  Wait for the results.
        wait for 1 ns;
--  Check the outputs.
        assert o = patterns(n).o
        report "bad output value" severity error;
        end loop;
        assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
