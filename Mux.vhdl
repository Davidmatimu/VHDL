library ieee;
use ieee.std_logic_1164.all;
entity mux4 is
   port(
      A,B,C,D: in std_logic_vector(7 downto 0);
      S: in std_logic_vector(1 downto 0);
      X: out std_logic_vector(7 downto 0)
   );
end mux4;

architecture if_arch of mux4 is
begin
  with S select
      X <= A when "00",
           B when "01",
           C when "10",
           D when others;

end if_arch;



