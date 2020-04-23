library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity add_sub_tb_4b is
end add_sub_tb_4b;

architecture behav of add_sub_tb_4b is
--  Declaration of the component that will be instantiated.
component add_sub_4b
port (	A,B:	in std_logic_vector (3 downto 0);
		sel: in std_logic;
		overflow,underflow: out std_logic;
		O:	out std_logic_vector(3 downto 0)
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal a,b,o : std_logic_vector(3 downto 0);
signal s,ovr,undr : std_logic;
begin
--  Component instantiation.
add_sub_0: add_sub_4b port map (A => a, B => b, sel => s, overflow => ovr, underflow => undr, O => o);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the add_sub.
a,b: std_logic_vector (3 downto 0);
s: std_logic;
o: std_logic_vector (3 downto 0);
ovr,undr: std_logic;
--  The expected outputs of the add_sub.

end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
-- A, B, sel, overflow, underflow, O

(("0000", "0000", '0', "0000", '0', '0'), -- 0+0 = 0

    ("0000", "0001", '0', "0001", '0', '0'), -- 0+1 = 1

    ("0101", "0010", '0', "0111", '0', '0'), -- 5+2 = 7

    ("0110", "0011", '0', "1001", '1', '0'), -- 6+3 = 9, overflow

    ("0010", "1111", '0', "0001", '0', '0'), -- 2+(-1) = 1

    ("0100", "1011", '0', "1111", '0', '0'), -- 4+(-5) = -1

    ("1111", "1001", '0', "1000", '0', '0'), -- -1+(-7) = -8

    ("1110", "0011", '0', "0001", '0', '0'), -- -2+3 = 1

    ("1010", "0010", '0', "1100", '0', '0'), -- -6+2 = -4

    ("1011", "1100", '0', "0111", '0', '1'), -- -5+(-4) = -9, underflow

    ("1001", "0100", '1', "0101", '0', '1'), -- -7-4 = -11, underflow

    ("0000", "0000", '1', "0000", '0', '0'), -- 0-0 = 0

    ("0010", "0001", '1', "0001", '0', '0'), -- 2-1 = 0

    ("0101", "0011", '1', "0010", '0', '0'), -- 5-3 = 2

    ("0110", "0111", '1', "1111", '0', '0'), -- 6-7 = -1

    ("0101", "1110", '1', "0111", '0', '0'), -- 5-(-2) = 7

    ("1010", "0010", '1', "1000", '0', '0'), -- -6-2 = -8

    ("1001", "1011", '1', "1110", '0', '0'), -- -7-(-5) = -2

    ("0000", "1111", '1', "0001", '0', '0'), -- 0-(-1) = -1

    ("0000", "1000", '1', "1000", '1', '0'), -- 0-(-8) = 8, overflow.

    ("0010", "1000", '1', "1010", '1', '0'), -- 2-(-8) = 10, overflow (2 + -8 = -6 != 10)


    ("1101", "1011", '1', "0010", '0', '0'), -- -3-(-5) = 2

    ("0101", "1101", '1', "1000", '1', '0') -- 5-(-3) = 8, overflow

    );

begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
a <= patterns(n).a;
b <= patterns(n).b;
s <= patterns(n).s;
--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
assert o = patterns(n).o
report "bad output value" severity error;
assert ovr = patterns(n).ovr;
report "bad overflow value" severity error;
assert undr = patterns(n).undr;
report "bad underflow value" severity error;
end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
