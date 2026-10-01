library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_B_Mux is
    Port ( 
        ALUSrc : in  STD_LOGIC_VECTOR (2 downto 0);
        RD2    : in  STD_LOGIC_VECTOR (15 downto 0);
        Instr  : in  STD_LOGIC_VECTOR (23 downto 0);
        B_Out  : out STD_LOGIC_VECTOR (15 downto 0)
    );
end ALU_B_Mux;

architecture Behavioral of ALU_B_Mux is
begin
    process(ALUSrc, RD2, Instr)
begin
    case ALUSrc is
        when "000" => 
            -- Operatii Registru-Registru
            B_Out <= RD2; 
        when "001" => 
            -- ASR Wb, #lit4, Wnd
            B_Out <= "000000000000" & Instr(3 downto 0); 
        when "010" => 
            -- SUB Wb, #lit5, Wd
            B_Out <= "00000000000" & Instr(4 downto 0); 
        when "011" => 
            -- AND #lit10, Wn
            B_Out <= "000000" & Instr(13 downto 4); 
        when "100" => 
            -- MOV f, Wnd / MOV Wns, f => extragem adresa 'f' pe 15 biti
            B_Out <= Instr(18 downto 4) & '0';
        when others => 
            B_Out <= RD2;
    end case;
end process;
end Behavioral;

