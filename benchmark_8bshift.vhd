library ieee;
use ieee.std_logic_1164.all;

entity benchmark_8bshift is
end benchmark_8bshift;
architecture behav of benchmark_8bshift is
--  Declaration of the component that will be instantiated.
component bitreg_8shift
    port (      I8:    in std_logic_vector (7 downto 0);
        I8_SHIFT_IN: in std_logic;
        sel8:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
        clock8:            in std_logic; 
        enable8:           in std_logic;
        O8:    out std_logic_vector(7 downto 0)
    );
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal i, o : std_logic_vector(7 downto 0);
signal i_shift_in, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);

begin
--  Component instantiation.
shift_reg_0: bitreg_8shift port map (I8 => i, I8_SHIFT_IN => i_shift_in, sel8 => sel, clock8 => clk, enable8 => enable, O8 => o);
--  This process does the real job.
process
    type pattern_type is record
--  The inputs of the shift_reg.
        i: std_logic_vector (7 downto 0);
        i_shift_in, clock, enable: std_logic;
        sel: std_logic_vector(1 downto 0);
--  The expected outputs of the shift_reg.
        o: std_logic_vector (7 downto 0);
    end record;
--  The patterns to apply.

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
--Input,i_shift_in(shiftleft or right),sel,clk,enable,O
--10 shiftleft, 01 shiftright, 11 load, 00 hold
    (("00010000",'0','0','1',"11","00000000"),--load 16 into register       
    ("00010000",'0','1','1',"11","00010000"),--load 16 into register        
    ("00010001",'0','1','1',"11","00010000"),--load 17 into register not rising edge triggered        
    ("00010000",'0','0','1',"01","00010000"),--shift left (32)              
    ("00010000",'0','1','1',"01","00100000"),--shift left (32)              
    ("00010000",'0','1','1',"01","00100000"),--shift left (32) not rising edge triggered              
    ("00010000",'0','0','1',"10","00100000"),--shift right (16)             
    ("00010000",'0','1','1',"10","00010000"),--shift right (16)             
    ("00010000",'0','1','1',"10","00010000"),--shift right (16) not rising edge triggered             
    ("00010000",'0','0','1',"00","00010000"),--hold                         
    ("00010000",'0','1','1',"00","00010000"),--hold                         
    ("00010000",'0','1','1',"00","00010000"),--hold not rising edge triggered                         
    ("01110000",'1','0','1',"11","00010000"),--load 112 into register       
    ("10000000",'1','1','1',"11","10000000"),--load 128 into register       
    ("10000100",'1','1','1',"11","10000000"),--load 132 into register not rising edge triggered       
    ("01110000",'1','0','1',"10","10000000"),--shift right (112)            
    ("10000000",'1','1','1',"10","11000000"),--shift right (192)            
    ("10000000",'1','1','1',"10","11000000"),--shift right (192) not rising edge triggered            
    ("01110000",'1','0','1',"01","11000000"),--shift left (224)             
    ("10000000",'1','1','1',"01","10000001"),--shift left (129)             
    ("10000000",'1','1','1',"01","10000001"),--shift left (129) not rising edge triggered             
    ("01110000",'1','0','1',"00","10000001"),--hold                         
    ("10000000",'1','1','1',"00","10000001"),--hold                         
    ("10000000",'1','1','1',"00","10000001"),--hold not rising edge triggered                         
    --ENABLE = 0 for this block so output signal will not change for waveform
    ("00010000",'0','0','0',"11","00000000"),--load 16 into register       
    ("00010000",'0','1','0',"11","00000000"),--load 16 into register        
    ("00010000",'0','0','0',"01","00000000"),--shift left (32)              
    ("00010000",'0','1','0',"01","00000000"),--shift left (32)              
    ("00010000",'0','0','0',"10","00000000"),--shift right (16)             
    ("00010000",'0','1','0',"10","00000000"),--shift right (16)             
    ("00010000",'0','0','0',"00","00000000"),--hold                         
    ("00010000",'0','1','0',"00","00000000"),--hold                         
    ("01110000",'1','0','0',"11","00000000"),--load 112 into register       
    ("10000000",'1','1','0',"11","00000000"),--load 128 into register       
    ("01110000",'1','0','0',"10","00000000"),--shift right (112)            
    ("10000000",'1','1','0',"10","00000000"),--shift right (192)            
    ("01110000",'1','0','0',"01","00000000"),--shift left (224)             
    ("10000000",'1','1','0',"01","00000000"),--shift left (128)             
    ("01110000",'1','0','0',"00","00000000"),--hold                         
    ("10000000",'1','1','0',"00","00000000"));--hold                        
                                 
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
