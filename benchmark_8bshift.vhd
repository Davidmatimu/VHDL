library ieee;
use ieee.std_logic_1164.all;

entity benchmark_8bshift is
end benchmark_8bshift;
architecture behav of benchmark_8bshift is
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
shift_reg_0: bitreg_8shift port map (I => i, I_SHIFT_IN => i_shift_in, sel => sel, clock => clk, enable => enable, O => o);
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
    (("00010000",'0','0','1',"11","00000000"),--load 16 into register       1ns
    ("00010000",'0','1','1',"11","00010000"),--load 16 into register        2ns
    ("00010000",'0','0','1',"01","00010000"),--shift left (32)              3
    ("00010000",'0','1','1',"01","00100000"),--shift left (32)              4
    ("00010000",'0','0','1',"10","00100000"),--shift right (16)             5
    ("00010000",'0','1','1',"10","00010000"),--shift right (16)             6
    ("00010000",'0','0','1',"00","00010000"),--hold                         7
    ("00010000",'0','1','1',"00","00010000"),--hold                         8
    ("01100000",'0','0','1',"11","00010000"),--load 96 into register        9
    ("01010000",'0','1','1',"11","01010000"),--load 82 into register        10
    ("01100000",'0','0','1',"01","01010000"),--shift left (192)             11
    ("01010000",'0','1','1',"01","10100000"),--shift left (164)             12
    ("01100000",'0','0','1',"10","10100000"),--shift right (96)             13
    ("01010000",'0','1','1',"10","01010000"),--shift right (82)             14
    ("01100000",'0','0','1',"00","01010000"),--hold                         15
    ("01010000",'0','1','1',"00","01010000"),--hold                         16
    ("00100000",'1','0','1',"11","01010000"),--load 32 into register        17
    ("00010000",'1','1','1',"11","00010000"),--load 16 into register        18
    ("00100000",'1','0','1',"01","00010000"),--shift left (64)              19
    ("00010000",'1','1','1',"01","00100001"),--shift left (32)              20
    ("00100000",'1','0','1',"10","00100001"),--shift right (32)             21
    ("00010000",'1','1','1',"10","10010000"),--shift right (16)             22
    ("00100000",'1','0','1',"00","10010000"),--hold                         23
    ("00010000",'1','1','1',"00","10010000"),--hold                         24
    ("01110000",'1','0','1',"11","10010000"),--load 112 into register       25
    ("10000000",'1','1','1',"11","10000000"),--load 128 into register       26
    ("01110000",'1','0','1',"10","10000000"),--shift right (112)            27
    ("10000000",'1','1','1',"10","11000000"),--shift right (192)            28
    ("01110000",'1','0','1',"01","10000001"),--shift left (224)             29
    ("10000000",'1','1','1',"01","10000001"),--shift left (128)             30
    ("01110000",'1','0','1',"00","10000001"),--hold                         31
    ("10000000",'1','1','1',"00","10000001"),--hold                         32
    --ENABLE = 0 for this block so output signal will not change for waveform
    ("00010000",'0','0','0',"11","00000000"),--load 16 into register       33
    ("00010000",'0','1','0',"11","00000000"),--load 16 into register        34
    ("00010000",'0','0','0',"01","00000000"),--shift left (32)              35
    ("00010000",'0','1','0',"01","00000000"),--shift left (32)              36
    ("00010000",'0','0','0',"10","00000000"),--shift right (16)             37
    ("00010000",'0','1','0',"10","00000000"),--shift right (16)             38
    ("00010000",'0','0','0',"00","00000000"),--hold                         39
    ("00010000",'0','1','0',"00","00000000"),--hold                         40
    ("01100000",'0','0','0',"11","00000000"),--load 96 into register        41
    ("01010000",'0','1','0',"11","00000000"),--load 82 into register        42
    ("01100000",'0','0','0',"01","00000000"),--shift left (192)             43
    ("01010000",'0','1','0',"01","00000000"),--shift left (164)             44
    ("01100000",'0','0','0',"10","00000000"),--shift right (96)             45
    ("01010000",'0','1','0',"10","00000000"),--shift right (82)             46
    ("01100000",'0','0','0',"00","00000000"),--hold                         47
    ("01010000",'0','1','0',"00","00000000"),--hold                         48
    ("00100000",'1','0','0',"11","00000000"),--load 32 into register        49
    ("00010000",'1','1','0',"11","00000000"),--load 16 into register        50
    ("00100000",'1','0','0',"01","00000000"),--shift left (64)              51
    ("00010000",'1','1','0',"01","00000000"),--shift left (32)              52
    ("00100000",'1','0','0',"10","00000000"),--shift right (32)             53
    ("00010000",'1','1','0',"10","00000000"),--shift right (16)             54
    ("00100000",'1','0','0',"00","00000000"),--hold                         55
    ("00010000",'1','1','0',"00","00000000"),--hold                         56
    ("01110000",'1','0','0',"11","00000000"),--load 112 into register       57
    ("10000000",'1','1','0',"11","00000000"),--load 128 into register       58
    ("01110000",'1','0','0',"10","00000000"),--shift right (112)            59
    ("10000000",'1','1','0',"10","00000000"),--shift right (192)            60
    ("01110000",'1','0','0',"01","00000000"),--shift left (224)             61
    ("10000000",'1','1','0',"01","00000000"),--shift left (128)             62
    ("01110000",'1','0','0',"00","00000000"),--hold                         63
    ("10000000",'1','1','0',"00","00000000"));--hold                         64
                                 
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
