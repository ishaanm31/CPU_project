library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Datapath is
	port(
        --Inputs
        clock:in std_logic;
        alu_sel:in std_logic_vector(1 downto 0);    
        loop_count:in std_logic_vector(2 downto 0);
        A1_sel : in std_logic_vector(0 downto 0);
        A3_sel : in std_logic_vector(1 downto 0);
        D3_sel : in std_logic_vector(1 downto 0);
        Reg_file_EN: in std_logic;
        C_ctrl, Z_ctrl: in std_logic;
        T1_WR,T2_WR,T3_WR: in std_logic;
        sel_m1,sel_m2,sel_m3: in std_logic;
        
        --Outputs
        Mem_Data_In: out std_logic_vector(15 downto 0);
        Z_flag, C_flag: out std_logic;
		);
end Datapath;

architecture Struct of Datapath is
    --1. ALU
    component ALU is
        port( sel: in std_logic_vector(1 downto 0); 
			ALU_A: in std_logic_vector(15 downto 0);
			ALU_B: in std_logic_vector(15 downto 0);
			ALU_c: out std_logic_vector(15 downto 0);
			C_F: out std_logic;
			Z_F: out std_logic
		);
    end component;

    --2. 16 bit 2x1 Mux
    component Mux16_2x1 is
        port(A0: in std_logic_vector(15 downto 0);
             A1: in std_logic_vector(15 downto 0);
             sel:in std_logic;
             F: out std_logic_vector(15 downto 0));

    end component;

    --3. 16 bit 4x1 Mux
    component Mux16_4x1 is
        port(A0: in std_logic_vector(15 downto 0);
            A1: in std_logic_vector(15 downto 0);
            A2: in std_logic_vector(15 downto 0);
            A3: in std_logic_vector(15 downto 0);
            sel: in std_logic_vector(1 downto 0);
            F: out std_logic);
    end component;
    
    --4. Temporary Register
    component Temp_Reg is
        port (DataIn:in std_logic_vector(15 downto 0);
        clock,Write_Enable:in std_logic;
        DataOut:out std_logic_vector(15 downto 0));
        end component;
    
    --5. Register_File
    component Register_file is
        port (A1, A2, A3: in std_logic_vector(2 downto 0 );
              D3: in std_logic_vector(15 downto 0);
              clock,Write_Enable:in std_logic;
              D1, D2: out std_logic_vector(15 downto 0));
        end component;
    
    --6. Signed extension 7
    component SE7 is
        port (Raw: in std_logic_vector(8 downto 0 );
            Outp:out std_logic_vector(15 downto 0):="0000000000000000");
    end component;    
    
    --7. D-flipflop with enable
    component dff_en is
        port(
           clk: in std_logic;
           reset: in std_logic;
           en: in std_logic;
           d: in std_logic;
           q: out std_logic
        );
     end component;
    
    --Signals required for ALU:
    signal alu_a, alu_b, alu_c: std_logic_vector(15 downto 0);
    signal carry_dff_inp, zero_dff_inp: std_logic_vector();
    signal alu_sel: std_logic_vector(1 downto 0);    
    
    --Signals for Register File:
    signal D1,D2 D3: std_logic_vector(15 downto 0);
    signal A1,A2 A3: std_logic_vector(2 downto 0);

    --Sig_Extended Signals
    signal ImmT1_in: std_logic_vector();
    --Signals in general:
    signal SE1_out: std_logic_vector(15 downto 0);
begin
--Component Initiate for Register File

    Reg_File: Register_file port map (A1, A2, A3, D3, clock,Reg_file_EN, D1,D2);
    --Muxes for input
    A1_Mux: Mux16_2x1 port map(loop_count, "111", A1_sel, A1);
    A3_Mux: Mux16_4x1 port map ();
    --Signed Extender
    
--Components for ALU
    ALU : ALU port map (ALU_A => alu_a, ALU_B => alu_b, ALU_C => alu_c, C_F => carry_dff_inp, Z_F => zero_dff_inp, sel => alu_sel);
    m1 : Mux16_2x1 port map(A0 => T1_out, A1 => "0000000000000001", sel => sel_m1, F => alu_a);
    SE1 : SE7 port map(Raw => T2_out(8 downto 0), outp => SE1_out);
    m2 : Mux16_2x1 port map(A0 => T3_out, A1 => SE1_out, sel => sel_m2, F => alu_b); 
    carry_dff: dff_en port map(clk => clock, reset => reset, en => C_ctrl, q => C_flag);
    zero_dff: dff_en port map(clk => clock, reset => reset, en => Z_ctrl, q => Z_flag);
    
    T1: Temp_Reg port map(DataIn => T1_in, clock => clock, Write_Enable => T1_WR, DataOut => T1_out);
    T2: Temp_Reg port map(DataIn => T2_in, clock => clock, Write_Enable => T2_WR, DataOut => T2_out);
    T3: Temp_Reg port map(DataIn => T3_in, clock => clock, Write_Enable => T3_WR, DataOut => T3_out);

    m3: MUX16_2x1 port map(A0=> ,A1=> ,sel =>sel_m3, F=>T3_out);                --
--
end Struct;
    