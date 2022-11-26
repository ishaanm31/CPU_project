--16 bits
--8x1 Multiplexer
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Mux16_8x1 is
    port(A0: in std_logic_vector(15 downto 0);
         A1: in std_logic_vector(15 downto 0);
         A2: in std_logic_vector(15 downto 0);
         A3: in std_logic_vector(15 downto 0);
         A4: in std_logic_vector(15 downto 0);
         A5: in std_logic_vector(15 downto 0);
         A6: in std_logic_vector(15 downto 0);
         A7: in std_logic_vector(15 downto 0);        
         sel:in std_logic_vector(2 downto 0);
         F: out std_logic_vector(15 downto 0));
end Mux16_8x1;
architecture Dataflow of Mux16_8x1 is
begin
   case sel is
      when "000" => 
         F <= A0;
      when "001" => 
         F <= A1;
      when "010" => 
         F <= A2;
      when "011" => 
         F <= A3;
      when "100" => 
         F <= A4;
      when "101" => 
         F <= A5;
      when "110" => 
         F <= A6;
      when "111" => 
         F <= A7; 
      when others =>
         F <= "0000000000000000";
   end case;
end Dataflow;

--4x1 multiplexer
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Mux16_4x1 is
    port(A0: in std_logic_vector(15 downto 0);
         A1: in std_logic_vector(15 downto 0);
         A2: in std_logic_vector(15 downto 0);
         A3: in std_logic_vector(15 downto 0);
         sel: in std_logic_vector(1 downto 0);
         F: out std_logic_vector(15 downto 0));
end Mux16_4x1;
architecture Dataflow of Mux16_4x1 is
    begin
      case sel is
         when "00" => 
            F <= A0;
         when "01" => 
            F <= A1;
         when "10" => 
            F <= A2;
         when "11" => 
            F <= A3; 
         when others =>
            F <= "0000000000000000";
      end case;   
    end Dataflow;

--2x1 Multiplexer
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Mux16_2x1 is
    port(A0: in std_logic_vector(15 downto 0);
         A1: in std_logic_vector(15 downto 0);
         sel:in std_logic_vector;
         F: out std_logic);
end Mux16_2x1;
architecture Dataflow of Mux16_2x1 is
begin
   case sel is   
      when '0' =>
         F <= A0;
      when '1' =>
         F <= A1;
      when others =>
         F <= "0000000000000000";
end Dataflow;


--D flipflop
library ieee;
use ieee.std_logic_1164.all;
entity dff_en is
   port(
      clk: in std_logic;
      reset: in std_logic;
      en: in std_logic;
      d: in std_logic;
      q: out std_logic
   );
end dff_en;

architecture behave of dff_en is
   signal q_reg: std_logic;
   signal q_next: std_logic;
begin
   -- D FF
   process(clk,reset)
   begin
      if (reset='1') then
         q_reg <= '0';
      elsif (clk'event and clk='1') then
         q_reg <= q_next;
      end if;
   end process;
   -- next-state logic
   q_next <= d when en ='1' else
             q_reg;
   -- output logic
   q <= q_reg;
end behave;

--3 bits
--8x1 Multiplexer
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Mux3_8x1 is
    port(A0: in std_logic_vector(2 downto 0);
         A1: in std_logic_vector(2 downto 0);
         A2: in std_logic_vector(2 downto 0);
         A3: in std_logic_vector(2 downto 0);
         A4: in std_logic_vector(2 downto 0);
         A5: in std_logic_vector(2 downto 0);
         A6: in std_logic_vector(2 downto 0);
         A7: in std_logic_vector(2 downto 0);        
         sel:in std_logic_vector(2 downto 0);
         F: out std_logic_vector(2 downto 0));
end Mux3_8x1;
architecture Dataflow of Mux3_8x1 is
begin
   case sel is
      when "000" => 
         F <= A0;
      when "001" => 
         F <= A1;
      when "010" => 
         F <= A2;
      when "011" => 
         F <= A3;
      when "100" => 
         F <= A4;
      when "101" => 
         F <= A5;
      when "110" => 
         F <= A6;
      when "111" => 
         F <= A7; 
      when others =>
         F <= "000";
   end case;
end Dataflow;

--4x1 multiplexer
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Mux3_4x1 is
    port(A0: in std_logic_vector(2 downto 0);
         A1: in std_logic_vector(2 downto 0);
         A2: in std_logic_vector(2 downto 0);
         A3: in std_logic_vector(2 downto 0);
         sel: in std_logic_vector(1 downto 0);
         F: out std_logic(2 downto 0));
end Mux3_4x1;
architecture Dataflow of Mux16_4x1 is
    begin
      case sel is
         when "00" => 
            F <= A0;
         when "01" => 
            F <= A1;
         when "10" => 
            F <= A2;
         when "11" => 
            F <= A3; 
         when others =>
            F <= "000";
      end case;   
    end Dataflow;