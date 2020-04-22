library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4TB is 
end mux4TB;

architecture behavior of mux4TB is


component mux4 is
   port(
      A,B,C,D: in std_logic_vector(7 downto 0);
      S: in std_logic_vector(1 downto 0);
      X: out std_logic_vector(7 downto 0)
   );
end component;

--Inputs

signal A: std_logic_vector(7 downto 0) := "00000000";
signal B : std_logic_vector(7 downto 0) := "00000000";
signal C : std_logic_vector(7 downto 0):= "00000000";
signal D : std_logic_vector(7 downto 0) := "00000000";
signal S : std_logic_vector(1 downto 0) := "00";

--Outputs

signal X : std_logic_vector(7 downto 0);

begin

  uut: mux4 port map(
        A => A,
        B => B,
        C => C,
        D => D,
        S => S,
        X => X
  );

 process
	begin 

    wait for 1 ns;

  A <= "00000000";
  B <= "00000001";
  C <= "00000010";
  D <= "00000011";
  S <= "00";

  wait for 1 ns;

  S <= "01";

  wait for 1 ns;

  S <= "10";

  wait for 1 ns;

  S <= "11";
  
  wait;


  end process;
 

end behavior;  
