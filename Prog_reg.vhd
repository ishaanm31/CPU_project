library ieee;
use ieee.std_logic_1164.all;

package components is

component dff is port(D,clock:in std_logic;Q:out std_logic);
end component dff;

component Mux is port( A,B,S: in std_logic; F: out std_logic);
end component Mux;

component encoder8to3 is
    port(
    din : in STD_LOGIC_VECTOR(7 downto 0);
    dout : out STD_LOGIC_VECTOR(2 downto 0)
    );
    end component encoder8to3;

component decoder is
        Port ( s : in STD_LOGIC_VECTOR (2 downto 0);
        y : out STD_LOGIC_VECTOR (7 downto 0));
        end component decoder;
end package components;

library ieee;
use ieee.std_logic_1164.all;
entity Mux is
    port( A,B,S: in std_logic;
    F: out std_logic);
    end Mux;
    architecture Dataflow of Mux is
    begin
    F <= ((not S) and A) or (S and B);
    end Dataflow;
--D flip flop with reset
library ieee;
use ieee.std_logic_1164.all;
entity dff is port(D,clock:in std_logic;Q:out std_logic);
end entity dff;
architecture behav of dff is
begin
dff_reset_proc: process (clock)
begin
Q <= D ;
end process dff_reset_proc;
end behav;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity encoder8to3 is
port(
din : in STD_LOGIC_VECTOR(7 downto 0);
dout : out STD_LOGIC_VECTOR(2 downto 0)
);
end encoder8to3;

architecture encoder8to3_arc of encoder8to3 is
begin

dout <= "000" when (din="10000000") else
"001" when (din="01000000") else
"010" when (din="00100000") else
"011" when (din="00010000") else
"100" when (din="00001000") else
"101" when (din="00000100") else
"110" when (din="00000010") else
"111";

end encoder8to3_arc;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder is
Port ( s : in STD_LOGIC_VECTOR (2 downto 0);
y : out STD_LOGIC_VECTOR (7 downto 0));
end decoder;

architecture Behavioral of decoder is
begin
with sel select
y<="00000001" when "000",
"00000010" when "001",
"00000100" when "010",
"00001000" when "011",
"00010000" when "100",
"00100000" when "101",
"01000000" when "110",
"10000000" when "111",
"00000000" when others;
end Behavioral;

library ieee;
use ieee.std_logic_1164.all;
-- write the Flipflops packege declaration
entity Register is
port (Din:in std_logic_vector(15 downto 0); clock,WE:in std_logic;
      Dout: buffer std_logic_vector(15 downto 0));
end entity Register;

architecture struct of Register_File is

    component dff is port(D,clock:in std_logic;Q:out std_logic);
    end component dff;

    component Mux is port( A,B,S: in std_logic; F: out std_logic);
    end component Mux;
    signal M:std_logic_vector(15 downto 0);
begin

-----------MUXES--------------
Mux0: Mux port map(Dout(0),Din(0),WE,M(0));
Mux1: Mux port map(Dout(1),Din(1),WE,M(1));
Mux2: Mux port map(Dout(2),Din(2),WE,M(2));
Mux3: Mux port map(Dout(3),Din(3),WE,M(3));
Mux4: Mux port map(Dout(4),Din(4),WE,M(4));
Mux5: Mux port map(Dout(5),Din(5),WE,M(5));
Mux6: Mux port map(Dout(6),Din(6),WE,M(6));
Mux7: Mux port map(Dout(7),Din(7),WE,M(7));
Mux8: Mux port map(Dout(8),Din(8),WE,M(8));
Mux9: Mux port map(Dout(9),Din(9),WE,M(9));
Mux10: Mux port map(Dout(10),Din(10),WE,M(10));
Mux11: Mux port map(Dout(11),Din(11),WE,M(11));
Mux12: Mux port map(Dout(12),Din(12),WE,M(12));
Mux13: Mux port map(Dout(13),Din(13),WE,M(13));
Mux14: Mux port map(Dout(14),Din(14),WE,M(14));
Mux15: Mux port map(Dout(15),Din(15),WE,M(15));

-----------------------------------------D FF--------------------------------------
ff0:dff port map(M(0),clock,Dout(0));
ff1:dff port map(M(1),clock,Dout(1));
ff2:dff port map(M(2),clock,Dout(2));
ff3:dff port map(M(3),clock,Dout(3));
ff4:dff port map(M(4),clock,Dout(4));
ff5:dff port map(M(5),clock,Dout(5));
ff6:dff port map(M(6),clock,Dout(6));
ff7:dff port map(M(7),clock,Dout(7));
ff8:dff port map(M(8),clock,Dout(8));
ff9:dff port map(M(9),clock,Dout(9));
ff10:dff port map(M(10),clock,Dout(10));
ff11:dff port map(M(11),clock,Dout(11));
ff12:dff port map(M(12),clock,Dout(12));
ff13:dff port map(M(13),clock,Dout(13));
ff14:dff port map(M(14),clock,Dout(14));
ff15:dff port map(M(15),clock,Dout(15));
end struct;



library ieee;
use ieee.std_logic_1164.all;
-- write the Flipflops packege declaration
entity Register_file is
port (A1, A2, A3: in std_logic_vector(2 downto 0 );
D3:in std_logic_vector(15 downto 0);
clock:in std_logic;
D1, D2:out std_logic_vector(15 downto 0));
end entity Register_file;

architecture struct of Register_File is

    component encoder8to3 is
        port(
        din : in STD_LOGIC_VECTOR(7 downto 0);
        dout : out STD_LOGIC_VECTOR(2 downto 0)
        );
        end component encoder8to3;

    component decoder is
            Port ( s : in STD_LOGIC_VECTOR (2 downto 0);
            y : out STD_LOGIC_VECTOR (7 downto 0));
    end component decoder;

    component Register is
        port (Din:in std_logic_vector(15 downto 0); clock,WE:in std_logic;
              Dout: buffer std_logic_vector(15 downto 0));
        end component Register;
    signal WritEn : std_logic_vector(7 downto 0);
    type mem_word   is array (0 to 7) of std_logic_vector(15 downto 0);
    signal Data : mem_word;
begin
---------Write Enable Pin------------------
WE_Selector : decoder port map(A3,WritEn);
-----------------------------------------ARRAY of Registers--------------------------------------
R0: Register port map(D3,clock,WritEn(0),Data(0));
R1: Register port map(D3,clock,WritEn(1),Data(1));
R2: Register port map(D3,clock,WritEn(2),Data(2));
R3: Register port map(D3,clock,WritEn(3),Data(3));
R4: Register port map(D3,clock,WritEn(4),Data(4));
R5: Register port map(D3,clock,WritEn(5),Data(5));
R6: Register port map(D3,clock,WritEn(6),Data(6));
R7: Register port map(D3,clock,WritEn(7),Data(7));
------------------------------------- Read A1 D1---------------------------
case(A1) is 
    when "000" =>  D1<= Data(0);
    when "001" =>  D1<= Data(1);
    when "010" =>  D1<= Data(2);
    when "011" =>  D1<= Data(3);
    when "100" =>  D1<= Data(4);
    when "101" =>  D1<= Data(5);
    when "110" =>  D1<= Data(6);
    when "111" =>  D1<= Data(7);
      when others => D1 <= Data(0);

  end case;

------------------------------------- Read A2 D2---------------------------
case(A2) is 
    when "000" =>  D2<= Data(0);
    when "001" =>  D2<= Data(1);
    when "010" =>  D2<= Data(2);
    when "011" =>  D2<= Data(3);
    when "100" =>  D2<= Data(4);
    when "101" =>  D2<= Data(5);
    when "110" =>  D2<= Data(6);
    when "111" =>  D2<= Data(7);
      when others => D2 <= Data(0);

  end case;
  ----------------------------------------------------------------------

end struct;