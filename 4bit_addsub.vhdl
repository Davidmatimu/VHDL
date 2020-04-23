library ieee;
use ieee.std_logic_1164.all;

--Half Adder----------------------

entity half_adder is
port(	A,B:	in std_logic;
		O, carry: out std_logic);
end half_adder;

architecture behav of half_adder is
	begin
		
		O <= A xor B;
		carry <= A and B;

end behav;

--------------------------------

--Full Adder--------------------
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
port( A,B, Cin: in std_logic;
	
	O, carry: out std_logic
	);
	
end full_adder;

architecture behav1 of full_adder is
	component half_adder is
		port(	
			A,B:	in std_logic;
			O,carry: out std_logic);
	end component half_adder;
	
	signal s0, s1, s2 : std_logic;
	begin
		h1: half_adder port map(A,B,s0,s1);
		h2 : half_adder port map(s0,Cin,O,s2);
		carry <= s1 or s2;
		
	end behav1;
----------------------------------

--4-bit Adder--------------------
library ieee;
use ieee.std_logic_1164.all;

entity full_adder_4b is
port( 
		A,B: in std_logic_vector(3 downto 0);
		Cin: in std_logic;
		O: out std_logic_vector(3 downto 0);
		overflow, underflow: out std_logic
	);
end full_adder_4b;

architecture behav2 of full_adder_4b is
	component full_adder is
		port(
			A,B,Cin: in std_logic;
			O,carry: out std_logic);
			
	end component full_adder;
	
	signal c0, c1, c2,S,S1: std_logic;
	
	begin
		f0: full_adder port map(A(0),B(0),Cin,O(0),c0); -- Cin on an first adder is '0'
		f1: full_adder port map(A(1),B(1),c0,O(1),c1);
		f2: full_adder port map(A(2),B(2),c1,O(2),c2);
		f3: full_adder port map(A(3),B(3),c2, S,S1);
		overflow <= (s1 xor c2) and (not A(3) and not B(3)); --this specifies when both numbers are positive(0 = msb) and output is negative
		underflow <= (s1 xor c2) and (A(3) and B(3)); --specifies when both numbers are negative(1=msb) and output is positive
		O(3) <= S;
end behav2;

-------------------------------------

--4-bit Adder/Subber
library ieee;
use ieee.std_logic_1164.all;


entity add_sub_4b is
	port(	
		A,B: in std_logic_vector(3 downto 0);
		sel: in std_logic;
		O: out std_logic_vector(3 downto 0);
		overflow, underflow: out std_logic
	);
	
end add_sub_4b;

architecture behav3 of add_sub_4b is
	component full_adder_4b is
		port(
			A,B: in std_logic_vector(3 downto 0);
			Cin: in std_logic;
			O: out std_logic_vector(3 downto 0);
			overflow, underflow: out std_logic
		);
	end component full_adder_4b;
	
	signal input2: std_logic_vector(3 downto 0);
	begin
	add1: full_adder_4b port map(A,input2,sel,O,overflow,underflow);
	

	
	input2(0) <= B(0) xor sel;	--exclusive or on each bit of input of sel = 1 will give subtraction and result in two's complement
	input2(1) <= B(1) xor sel;
	input2(2) <= B(2) xor sel;
	input2(3) <= B(3) xor sel;
	
	--overflow <=  (B(3) and (not(B(2))) and (not(B(1))) and (not(B(0))) and sel);
	
end behav3;
	
	


	
	



