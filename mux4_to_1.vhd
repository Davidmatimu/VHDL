--Tutorials:
--https://www.ics.uci.edu/~jmoorkan/vhdlref/ifs.html
--https://www.seas.upenn.edu/~ese171/vhdl/vhdl_primer.html

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4_to_1 is
    Port ( I0 : in STD_LOGIC; --I0,I1,I2,I3 are the four inputs to the MUX, Sel is the Selector for picking inputs to Mux and O is the Output of the Mux
           I1 : in STD_LOGIC;
           I2 : in STD_LOGIC;
           I3 : in STD_LOGIC;
           Sel : in STD_LOGIC_VECTOR (1 downto 0);
           O : out STD_LOGIC);
end mux4_to_1;

architecture Behavioral of mux4_to_1 is
begin
        pick: process(I0,I1,I2,I3,Sel) --This function takes in the inputs and Sel to perform the output of the Mux
        begin
            if(SEL = "00")then -- if Sel is 00 then pick input 0 AKA I0
     		   O <= I0;
    		elsif (SEL = "01") then 
				O <= I1;
			elsif (SEL = "10") then 
      			O <= I2;
    		else 
      			O <= I3;
    		end if;
             end process pick;
 end Behavioral;
