library ieee;
use ieee.std_logic_1164.all;

entity benchmark_4bshift is
end benchmark_4bshift;
architecture behav of benchmark_4bshift is
--  Declaration of the component that will be instantiated.
component bitreg_4shift
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
shift_reg_0: bitreg_4shift port map (I => i, I_SHIFT_IN => i_shift_in, sel => sel, clock => clk, enable => enable, O => o);
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
    (("0001",'0','0','1',"11","0000"),--load 1 into register
    ("0001",'0','1','1',"11","0001"),--load 1 into register
    ("0001",'0','0','1',"01","0001"),--shift left (2)
    ("0001",'0','1','1',"01","0010"),--shift left (2)
    ("0001",'0','0','1',"10","0010"),--shift right (1)
    ("0001",'0','1','1',"10","0001"),--shift right (1)
    ("0001",'0','0','1',"00","0001"),--hold
    ("0001",'0','1','1',"00","0001"),--hold
    ("0110",'0','0','1',"11","0001"),--load 6 into register
    ("0101",'0','1','1',"11","0101"),--load 5 into register
    ("0110",'0','0','1',"01","0101"),--shift left (12)
    ("0101",'0','1','1',"01","1010"),--shift left (10)
    ("0110",'0','0','1',"10","1010"),--shift right (6)
    ("0101",'0','1','1',"10","0101"),--shift right (5)
    ("0110",'0','0','1',"00","0101"),--hold
    ("0101",'0','1','1',"00","0101"),--hold
    ("0010",'1','0','1',"11","0101"),--load 2 into register
    ("0001",'1','1','1',"11","0001"),--load 1 into register
    ("0010",'1','0','1',"01","0001"),--shift left (4)
    ("0001",'1','1','1',"01","0011"),--shift left (3)
    ("0010",'1','0','1',"10","0001"),--shift right (2)
    ("0001",'1','1','1',"10","0001"),--shift right (1)
    ("0010",'1','0','1',"00","0001"),--hold
    ("0001",'1','1','1',"00","0001"),--hold
    ("0111",'1','0','1',"11","0001"),--load 7 into register
    ("1000",'1','1','1',"11","1000"),--load 8 into register
    ("0111",'1','0','1',"10","1000"),--shift right (7)
    ("1000",'1','1','1',"10","1100"),--shift right (12)
    ("0111",'1','0','1',"01","1000"),--shift left (14)
    ("1000",'1','1','1',"01","1000"),--shift left (8)
    ("0111",'1','0','1',"00","1000"),--hold
    ("1000",'1','1','1',"00","1000"),--hold
    --ENABLE = 0 for this block
    ("0001",'0','0','0',"11","0000"),--load 1 into register enable is 0 so does nothing
    ("0001",'0','0','0',"01","0000"),--shift left (2) enable is 0 so does nothing
    ("0001",'0','0','0',"10","0000"),--shift right (1) enable is 0 so does nothing
    ("0001",'0','0','0',"00","0000"),--hold enable is 0 so does nothing
    ("0110",'0','0','0',"11","0000"),--load 6 into register enable is 0 so does nothing
    ("0110",'0','0','0',"01","0000"),--shift left (12) enable is 0 so does nothing
    ("0110",'0','0','0',"10","0000"),--shift right (6) enable is 0 so does nothing
    ("0110",'0','0','0',"00","0000"),--hold enable is 0 so does nothing
    ("0010",'1','0','0',"11","0000"),--load 2 into register enable is 0 so does nothing
    ("0010",'1','0','0',"01","0000"),--shift left (4) enable is 0 so does nothing
    ("0010",'1','0','0',"10","0000"),--shift right (2) enable is 0 so does nothing
    ("0010",'1','0','0',"00","0000"),--hold enable is 0 so does nothing
    ("0111",'1','0','0',"11","0000"),--load 7 into register enable is 0 so does nothing
    ("0111",'1','0','0',"01","0000"),--shift left (14) enable is 0 so does nothing
    ("0111",'1','0','0',"10","0000"),--shift right (7) enable is 0 so does nothing
    ("0111",'1','0','0',"00","0000"),--hold enable is 0 so does nothing
    ("0001",'0','1','0',"11","0000"),--load 1 into register enable is 0 so does nothing
    ("0001",'0','1','0',"01","0000"),--shift left (2) enable is 0 so does nothing
    ("0001",'0','1','0',"10","0000"),--shift right (1) enable is 0 so does nothing
    ("0001",'0','1','0',"00","0000"),--hold enable is 0 so does nothing
    ("0101",'0','1','0',"11","0000"),--load 5 into register enable is 0 so does nothing
    ("0101",'0','1','0',"01","0000"),--shift left (10) enable is 0 so does nothing
    ("0101",'0','1','0',"10","0000"),--shift right (5) enable is 0 so does nothing
    ("0101",'0','1','0',"00","0000"),--hold enable is 0 so does nothing
    ("0001",'1','1','0',"11","0000"),--load 1 into register enable is 0 so does nothing
    ("0001",'1','1','0',"01","0000"),--shift left (3) enable is 0 so does nothing
    ("0001",'1','1','0',"10","0000"),--shift right (1) enable is 0 so does nothing
    ("0001",'1','1','0',"00","0000"),--hold enable is 0 so does nothing
    ("1000",'1','1','0',"11","0000"),--load 8 into register enable is 0 so does nothing
    ("1000",'1','1','0',"10","0000"),--shift right (12) enable is 0 so does nothing
    ("1000",'1','1','0',"01","0000"),--shift left (8) enable is 0 so does nothing
    ("1000",'1','1','0',"00","0000"));--hold enable is 0 so does nothing
                                 
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
