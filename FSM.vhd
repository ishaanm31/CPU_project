library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM is
	port(clock, reset, Z_flag, C_flag :in std_logic;
        T2_out :in std_logic_vector(15 downto 0);
        
        alu_sel:out std_logic_vector(1 downto 0);    
        loop_count:out std_logic_vector(2 downto 0);
        A1_sel : out std_logic_vector(1 downto 0);
        A3_sel : out std_logic_vector(2 downto 0);
        D3_sel : out std_logic_vector(2 downto 0);
        Reg_file_EN, mem_WR: out std_logic;
        C_ctrl, Z_ctrl: out std_logic;
        T1_WR,T2_WR,T3_WR,T4_WR: out std_logic;
        sel_m1, sel_m2: out std_logic_vector(1 downto 0);
        sel_m3, sel_m4, sel_m5: out std_logic;
		);
end FSM;


architecture behave of FSM is
    -------ADD-SUM-------------------------------------------------------------
    type FSM_States   is (S0,S1,S2,S3,S4,S5,S6,S7,S8);
    signal State : FSM_States;
begin
    
    process(clock, ALU_B,sel)
    variable next_state: FSM_States;
    variable v_alu_sel: std_logic_vector(1 downto 0);    
    variable v_loop_count: std_logic_vector(2 downto 0);
    variable v_A1_sel : std_logic_vector(1 downto 0);
    variable v_A3_sel : std_logic_vector(2 downto 0);
    variable v_D3_sel : std_logic_vector(2 downto 0);
    variable v_Reg_file_EN, v_mem_WR: std_logic;
    variable v_C_ctrl, v_Z_ctrl: std_logic;
    variable v_T1_WR,v_T2_WR,v_T3_WR,v_T4_WR: std_logic;
    variable v_sel_m1, v_sel_m2: std_logic_vector(1 downto 0);
    variable v_sel_m3, v_sel_m4, v_sel_m5: std_logic;
    variable OP_code :std_logic_vector(3 downto 0);
    begin    
        
        v_alu_sel:="00";
        v_loop_count:="000";
        v_A1_sel:="00"; A3_sel:="000"; D3_sel:="000";
        v_m3_sel:='0';
        v_Reg_file_EN:='0';
        v_mem_WR:='0';
        v_C_ctrl:='0'; 
        v_Z_ctrl:='0';
        v_T1_WR:='0';T2_WR:='0';T3_WR:='0';T4_WR:='0'
        v_sel_m1:="00";sel_m2:="00";
        v_sel_m3:='0';
        v_sel_m4:='0';
        v_sel_m5:='0';
        OP_code:= T2_out(15 downto 12);


case State is --  making cases for states 
 
            --------------------------		    
    when S0 =>
        v_A1_sel:="01";
        v_T1_WR:='1';
        v_sel_m4:='0';
        v_T2_WR:='1';

        next_state:=S1;
    
-----------------------------------				    
    when S1 =>
        v_A1_sel:="10";
        v_m3_sel:="0";
        v_T3_WR:='1';
        v_T4_WR:='1';
        v_A3_sel:="10";

            if(vop="0000" or vop="0010" or vop="0001") then
                next_state := S5;
            elsif (vop="0011") then
                
            end if;
-----------------------------------		 
    when S2 =>
        v_m3_sel:='1';
        v_T3_WR:='1';
        v_Z_ctrl:='1';
        v_C_ctrl:='1';
            
-----------------------------------		
    when S3 =>
        v_sel_m1:="00";
        v_D3_sel:="101";
        v_A3_sel:="011";
        v_Reg_file_EN:='1';
        
            if(vop="0100") then
                vc_m4 := "01";
                vc_m5 := "01";
                vc_m1 := '1';
                vc_T2 := '1';
                vc_m11 := "10";
                next_state := S6;
            end if;
-----------------------------------

    when S4 => 
        v_m4 := '1';
        v_D3_sel := "010";
        v_Reg_file_EN := '1';
        v_A3_sel := "010";
-----------------------------------
    when S5 =>
        v_m4_sel := '1';
        v_m5_sel := '0';
        v_mem_WR := '1';
        
    when S6 =>
        v_Reg_file_EN := '1';
        v_m4_sel:='1';
        v_D3_sel:="010";
    loop1: for i in 0 to 7 loop
        v_loop_count:=std_logic_vector(to_unsigned(i,3));
        v_A3_sel:="011";
        v_sel_m1:="01";
        v_sel_m2:="10";
        v_T3_WR:='1';
    end loop;
-------------------------------------
    when S8 =>
            vc_rf := '1';
            vc_m4 := "00";
            vc_m5 := "00";
            vc_m1 := '1';
            vc_m7 := "11";
            vc_m9 := "10";
            next_state := S4;
-----------------------------------
    when others =>  null;
end case;
    
    --clock_transistion.
    if(clock='1' and clock' event) then
        if(reset = '1') then  
		    state <= S0; 
		else
			state <= next_state; 
		end if;
	end if;

    end process;
end behave;
    