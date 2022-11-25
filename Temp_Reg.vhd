library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- write the Flipflops packege declaration
entity Temp_Reg is
port (DataIn:in std_logic_vector(15 downto 0);
clock,Write_Enable:in std_logic;
DataOut:out std_logic_vector(15 downto 0));
end entity Temp_Reg;

architecture struct of Temp_Reg is
    shared variable Data : std_logic_vector(15 downto 0):="0000000000000000";
begin
-----------------------------------------ARRAY of Registers--------------------------------------
write_process : process(DataIn,clock) 

  begin
    if(Write_Enable='1') then  
      Data(15 downto 0):= DataIn(15 downto 0);
  end if;
end process;
------------------------------------- Read A1 D1---------------------------
read_process : process(clock)
begin

  DataOut(15 downto 0) <= Data(15 downto 0);
  ----------------------------------------------------------------------
end process;
end struct;