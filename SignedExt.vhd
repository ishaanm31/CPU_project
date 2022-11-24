library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- write the Flipflops packege declaration
entity SignedExt is
port (Raw: in std_logic_vector(5 downto 0 );
    Output:out std_logic_vector(15 downto 0):="0000000000000000");
end entity SignedExt;

architecture struct of SignedExt is
begin
SE_process : process(Raw) 
  begin
    Output(5 downto 0) <= Raw(5 downto 0);
    Output(15 downto 6) <= "0000000000";
end process;
end struct;