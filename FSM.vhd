library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM is
	port(clock, reset, Z_flag, C_flag :in std_logic;
        T2_out :in std_logic_vector(15 downto 0);
        loop_count:in std_logic_vector(2 downto 0);
        alu_sel:out std_logic_vector(1 downto 0);    
        A1_sel : out std_logic_vector(1 downto 0);
        A3_sel : out std_logic_vector(2 downto 0);
        D3_sel : out std_logic_vector(2 downto 0);
        Reg_file_EN, mem_WR: out std_logic;
        C_ctrl, Z_ctrl: out std_logic;
        T1_WR,T2_WR,T3_WR,T4_WR,loop_count_WR: out std_logic;
        sel_m1: out std_logic_vector(2 downto 0);
        sel_m2: out std_logic_vector(1 downto 0);
        sel_m3, sel_m4, sel_m5: out std_logic
		);
end FSM;


architecture behave of FSM is
    -------ADD-SUM-------------------------------------------------------------
    type FSM_States   is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10);
    signal State : FSM_States;
    shared variable i:integer range 0 to 7;
begin
    
process(clock)
    variable next_state: FSM_States;
    variable v_alu_sel: std_logic_vector(1 downto 0);    
    variable v_loop_count_WR: std_logic;
    variable v_A1_sel : std_logic_vector(1 downto 0);
    variable v_A3_sel : std_logic_vector(2 downto 0);
    variable v_D3_sel : std_logic_vector(2 downto 0);
    variable v_Reg_file_EN, v_mem_WR: std_logic;
    variable v_C_ctrl, v_Z_ctrl: std_logic;
    variable v_T1_WR,v_T2_WR,v_T3_WR,v_T4_WR: std_logic;
    variable v_sel_m1: std_logic_vector(2 downto 0);
    variable v_sel_m2: std_logic_vector(1 downto 0);
    variable v_sel_m3, v_sel_m4, v_sel_m5: std_logic;
    variable OP_code :std_logic_vector(3 downto 0);
    variable v_LMSM_Imm :std_logic_vector(7 downto 0);
    variable Flag: std_logic;
    begin    
        v_loop_count_WR := '0';
        v_alu_sel:="00";
        v_A1_sel:="00"; v_A3_sel:="000"; v_D3_sel:="000";
        v_sel_m3:='0';
        v_Reg_file_EN:='0';
        v_mem_WR:='0';
        v_C_ctrl:='0'; 
        v_Z_ctrl:='0';
        v_T1_WR:='0';v_T2_WR:='0';v_T3_WR:='0';v_T4_WR:='0';
        v_sel_m1:="000";v_sel_m2:="00";
        v_sel_m3:='0';
        v_sel_m4:='0';
        v_sel_m5:='0';
        OP_code:= T2_out(15 downto 12);
        v_LMSM_Imm:=T2_out(7 downto 0);
        Flag:= (((not (T2_out(1))) and (not(T2_out(0)))) or (T2_out(1)and C_flag) or (T2_out(0)and Z_flag));

case State is --  making cases for states 
 
            --------------------------		    
    when S0 =>
        v_A1_sel:="01";
        v_T1_WR:='1';
        v_sel_m4:='0';
        v_T2_WR:='1';

        if(OP_code="0011") then
            next_state:=S8;
        else next_state:= S1;
        end if;
    
-----------------------------------				    
    when S1 =>
        v_A1_sel:="10";
        v_sel_m3:='0';
        v_T3_WR:='1';
        v_T4_WR:='1';

        if(OP_code="0000") then
            if(Flag = '1') then
                next_state := S2;
            else next_state := S3;
            end if;
        elsif (OP_code="0001") then
            next_state := S2;

        elsif(OP_code="0010") then
            if(Flag = '1') then
                next_state := S2;
            else next_state := S3;
            end if;
            
        elsif(OP_code="0100") then
            next_state := S2;

        elsif(OP_code="0101") then
             next_state := S2;
        elsif(OP_code="0110") then
            next_state := S6;

        elsif(OP_code="0111") then
            next_state := S7;

        elsif(OP_code="1100") then
            next_state := S2;
            
        elsif(OP_code="1000") then
            v_D3_sel := "000";
            v_A3_sel := "010";
            v_Reg_file_EN := '1';
            next_state := S3;

        elsif(OP_code="1001") then
            v_D3_sel := "000";
            v_A3_sel := "010";
            v_Reg_file_EN := '1';
            next_state := S8;
    
        else 
            next_state:=S0;
        end if;
-----------------------------------		 
    when S2 =>
        v_sel_m3:='1';
        v_T3_WR:='1';
        if(OP_code="0000") then
            v_sel_m1:="010";
            v_sel_m2:="00";
            v_alu_sel:="00";
            v_Z_ctrl:='1';
            v_C_ctrl:='1';
            next_state := S8;

        elsif (OP_code="0001") then
            v_sel_m1:="011";
            v_sel_m2:="00";
            v_alu_sel:="00";
            v_Z_ctrl:='1';
            v_C_ctrl:='1';
            next_state:= S8;

        elsif(OP_code="0010") then
            v_sel_m1:="010";
            v_sel_m2:="00";
            v_alu_sel:="01";
            v_Z_ctrl:='1';
            next_state := S8 ; 

        elsif(OP_code="0100") then
            v_sel_m1:="011";
            v_sel_m2:="11";
            v_alu_sel:="00";
            next_state:= S4;

        elsif(OP_code="0101") then
            v_sel_m1:="011";
            v_sel_m2:="11";
            v_alu_sel:="00";
            next_state:= S5;
        elsif(OP_code="1100") then
            v_sel_m1:="001";
            v_sel_m2:="11";
            v_alu_sel:="10";
            v_Z_ctrl:='1';
            next_state := S3;

        else 
            next_state:=S0;

        end if;
-----------------------------------		
    when S3 =>
        v_sel_m1:="000";
        v_D3_sel:="101";
        v_A3_sel:="011";
        v_Reg_file_EN:='1';   
        if(OP_code="0000") then
            v_sel_m2:= "10";
            next_state:=S0; 

        elsif (OP_code="0001") then
            v_sel_m2:= "10";
            next_state:=S0; 
            
        elsif(OP_code="0010") then
            v_sel_m2:= "10";
            next_state:=S0;
             
        elsif(OP_code="0011") then
            v_sel_m2:= "10";
            next_state:=S0;
             
        elsif(OP_code="0100") then
            v_sel_m2:= "10";
            next_state:=S0; 

        elsif(OP_code="0101") then
            v_sel_m2:= "10";
            next_state:=S0; 
            
        elsif(OP_code="0110") then
            v_sel_m2:= "10";
            next_state:=S0; 

        elsif(OP_code="0111") then
            v_sel_m2:= "10";
            next_state:=S0;             

        elsif(OP_code="1100") then
            if(Z_flag='1') then
                v_sel_m2:= "11";
            else 
					v_sel_m2:= "10";
				end if;
			next_state:= S0;
        elsif(OP_code="1000") then
            v_sel_m2:= "01";
            next_state:= S0;
        else 
            next_state:=S0;
        end if;
-----------------------------------

    when S4 => 
        v_sel_m4 := '1';
        v_D3_sel := "010";
        v_Reg_file_EN := '1';
        v_A3_sel := "010";
        next_state:=S3;

-----------------------------------
    when S5 =>
        v_sel_m4 := '1';
        v_sel_m5 := '0';
        v_mem_WR := '1';
        next_state:=S3;

        
    -- when S6 =>
    --     if(i<7) then
    --         v_Reg_file_EN := '1';
    --         v_sel_m4:='1';
    --         v_D3_sel:="010";
    --         v_loop_count:=std_logic_vector(to_unsigned(i,3));
    --         v_A3_sel:="011";
    --         v_sel_m1:="001";
    --         v_sel_m2:="10";
    --         v_T3_WR:='1';
    --         i:=i+1;
    --         next_state:=S6;
    --     else 
    --         v_Reg_file_EN := '1';
    --         v_sel_m4:='1';
    --         v_D3_sel:="010";
    --         v_loop_count:=std_logic_vector(to_unsigned(i,3));
    --         v_A3_sel:="011";
    --         v_sel_m1:="001";
    --         v_sel_m2:="10";
    --         v_T3_WR:='1';
    --         i:=0;
    --         next_state:=S3; 
    --     end if;

    -- when S7 =>
    
    -- if(i<7) then
    --     v_A1_sel:="00";
    --     v_sel_m5:='1';
    --     v_sel_m4:='1';
    --     v_loop_count:=std_logic_vector(to_unsigned(i,3));
    --     v_sel_m1:="001";
    --     v_sel_m2:="10";
    --     v_T3_WR:='1';
    --     v_sel_m3:='1';
    --     i:=i+1;
    --     next_state:=S7;
    -- else 
    --     v_A1_sel:="00";
    --     v_sel_m5:='1';
    --     v_sel_m4:='1';
    --     v_loop_count:=std_logic_vector(to_unsigned(i,3));
    --     v_sel_m1:="001";
    --     v_sel_m2:="10";
    --     v_T3_WR:='1';
    --     v_sel_m3:='1';
    --     i:=0;
    --     next_state:=S3; 
    -- end if;
-------------------------------------
    when S8 =>
        v_Reg_file_EN := '1';   
            if(OP_code="0000") then
                v_D3_sel:="011";
                v_A3_sel:="000";
                next_state:=S3;
            elsif (OP_code="0001") then
                v_D3_sel:="011";
                v_A3_sel:="001";
                next_state:=S3;
            elsif(OP_code="0010") then
                v_D3_sel:="011";
                v_A3_sel:="000";
                next_state:=S3;
            elsif(OP_code="0011") then
                v_D3_sel:="110";
                v_A3_sel:="010";
                next_state:=S3;
                        
            elsif(OP_code="1001") then
                v_D3_sel:="001";
                v_A3_sel:="101";
                next_state:=S0;
            else 
                next_state:=S0;
            end if;

    when S6 =>
        v_sel_m4:='1';
        v_D3_sel:="010";
        v_A3_sel:="011";
        v_Reg_file_EN := v_LMSM_Imm(to_integer(unsigned(loop_count)));
        v_sel_m1:="100";
        v_sel_m2:="10";
        v_alu_sel:="00";
        v_loop_count_WR:='1';
        if(to_integer(unsigned(loop_count))<7) then
            next_state:=S7;
        else 
            next_state:=S3; 
        end if;

    when S7 =>
        v_sel_m1:="001";
        v_sel_m2:="10";
        v_T3_WR:='1';
        v_sel_m3:='1';
        v_alu_sel:="00";
        next_state:=S6;

        when S9 =>
        v_sel_m4:='1';
        v_sel_m5:='1';
        v_A1_se6l:="00";
        v_mem_WR := v_LMSM_Imm(to_integer(unsigned(loop_count)));
        v_sel_m1:="100";
        v_sel_m2:="10";
        v_alu_sel:="00";
        v_loop_count_WR:='1';
        if(to_integer(unsigned(loop_count))<7) then
            next_state:=S7;
        else 
            next_state:=S3; 
        end if;
    
-----------------------------------
    when others =>  
        next_state:=S0;
end case;
    
    --clock_transistion.
    if(clock='1' and clock' event) then
        if(reset = '1') then  
		    state <= S0; 
		else
			state <= next_state; 
		end if;
	end if;
    --mapping to actual signal
    alu_sel<=v_alu_sel;
    loop_count_WR<=v_loop_count_WR;
    v_A1_sel:=v_A1_sel; A3_sel<=v_A3_sel; D3_sel<=v_D3_sel;
    sel_m3<=v_sel_m3;
    Reg_file_EN<=v_Reg_file_EN;
    mem_WR<=v_mem_WR;
    C_ctrl<=v_C_ctrl; 
    Z_ctrl<=v_Z_ctrl;
    T1_WR<=v_T1_WR; T2_WR<=v_T2_WR; T3_WR<=v_T3_WR ; T4_WR<=v_T4_WR;
    sel_m1<=v_sel_m1;sel_m2<=v_sel_m2;
    sel_m3<=v_sel_m3;
    sel_m4<=v_sel_m4;
    sel_m5<=v_sel_m5;

    end process;
end behave;
    