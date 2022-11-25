library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Datapath is
	port( clock:in std_logic
		);
end Datapath;


architecture behave of Datapath is
    -------ADD-SUM-------------------------------------------------------------
       function add_sum( a,b : in std_logic_vector(15 downto 0);
                 M : in std_logic
                        )
            return std_logic_vector is
                variable sum :  std_logic_vector(15 downto 0); 
                variable carry: std_logic_vector(15 downto 0);
            begin
                loop1 : for i in 0 to 15 loop
                        if i=0 then
                                    sum(i) := a(i) xor (b(i) xor M) xor M;
                                 carry(i) := (a(i) and (b(i) xor M)) or (M and ( a(i) or (b(i) xor M)));
                        else 
                            sum(i) := a(i) xor (b(i) xor M) xor carry(i-1);
                            carry(i) := (a(i) and (b(i) xor M)) or (carry(i-1) and ( a(i) or (b(i) xor M)));
                        end if;
                end loop loop1;
            return sum;
        end add_sum;
    ---------ADD-CARRY-----------------------------------------------------------
        function add_carry( a,b : in std_logic_vector(15 downto 0);
                    M : in std_logic
                        )
            return std_logic is
                variable sum :  std_logic_vector(15 downto 0); 
                variable carry: std_logic_vector(15 downto 0);
            begin
                loop2 : for i in 0 to 15 loop
                    if i=0 then
                        sum(i) := a(i) xor (b(i) xor M) xor M;
                        carry(i) := (a(i) and (b(i) xor M)) or (M and ( a(i) or (b(i) xor M)));
                    else 
                        sum(i) := a(i) xor (b(i) xor M) xor carry(i-1);
                        carry(i) := (a(i) and (b(i) xor M)) or (carry(i-1) and ( a(i) or (b(i) xor M)));
                    end if;
                end loop loop2;
            return carry(15);
        end add_carry;	
    -------BIT-WISE-NAND-----------------------------------------------------	
        function bit_nand(a: in std_logic_vector(15 downto 0);
                  b: in std_logic_vector(15 downto 0))
            return std_logic_vector is
                variable S : std_logic_vector(15 downto 0);
            begin
                loop3 : for i in 0 to 15 loop
                           S(i) :=(a(i) nand b(i));
                end loop loop3;
            return S;
        end bit_nand ;
    -------BIT WISE XOR------------------------------------------------
        function bit_xor(a: in std_logic_vector(15 downto 0);
                     b: in std_logic_vector(15 downto 0))
        return std_logic_vector is
            variable S : std_logic_vector(15 downto 0);
        begin
            loop4 : for i in 0 to 15 loop
                 S(i) :=(a(i) xor b(i));
            end loop loop4;
        return S;
        end bit_xor ;
    
        begin
        alu : process(ALU_A, ALU_B,sel)
            
        end process;
    end behave;
    