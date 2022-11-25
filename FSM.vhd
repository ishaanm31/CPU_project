library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM is
	port( clock:in std_logic;

		);
end FSM;


architecture behave of FSM is
    -------ADD-SUM-------------------------------------------------------------
    type FSM_States   is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10);
    signal State : FSM_States;

    begin
        alu : process(ALU_A, ALU_B,sel)
            
        end process;
    end behave;
    