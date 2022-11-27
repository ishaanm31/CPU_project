library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- write the Flipflops packege declaration
entity Register_16bit is
port (DataIn:in std_logic_vector(15 downto 0);
clock,Write_Enable:in std_logic;
DataOut:out std_logic_vector(15 downto 0));
end entity Register_16bit;

architecture struct of Register_16bit is
    shared variable Data : std_logic_vector(15 downto 0):="0000000000000000";
begin
-----------------------------------------ARRAY of Registers--------------------------------------
write_process : process(clock) 

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

-- write the Flipflops packege declaration
entity Register_3bit is
  port (DataIn:in std_logic_vector(2 downto 0);
  clock,Write_Enable:in std_logic;
  DataOut:out std_logic_vector(2 downto 0));
  end entity Register_3bit;
  
  architecture struct of Register_3bit is
      shared variable Data : std_logic_vector(2 downto 0):="000";
  begin
  -----------------------------------------ARRAY of Registers--------------------------------------
  write_process : process(clock) 
  
    begin
      if(Write_Enable='1') then  
        Data(2 downto 0):= DataIn(2 downto 0);
    end if;
  end process;
  ------------------------------------- Read A1 D1---------------------------
  read_process : process(clock)
  begin
  
    DataOut(2 downto 0) <= Data(2 downto 0);
    ----------------------------------------------------------------------
  end process;
  end struct;