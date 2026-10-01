library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RdReg1_Mux is
    Port ( 
        Instr  : in  STD_LOGIC_VECTOR (23 downto 0);
        Sel    : in  STD_LOGIC_VECTOR (1 downto 0);
        RdReg1 : out STD_LOGIC_VECTOR (3 downto 0)
    );
end RdReg1_Mux;

architecture Behavioral of RdReg1_Mux is
begin
    process(Instr, Sel)
    begin
        case Sel is
            when "01" =>
                -- ASR Wb,#lit4,Wnd -> Wb e la Instr(14 downto 11)
                RdReg1 <= Instr(14 downto 11);
            when "10" =>
                -- COM Ws,Wd -> operandul e Ws, la Instr(3 downto 0)
                RdReg1 <= Instr(3 downto 0);
				when "11" =>
					 -- AND #lit10, Wn -> Wn e sursa SI destinatia, la Instr(3 downto 0)
					 RdReg1 <= Instr(3 downto 0);
            when others =>
                -- ADD/SUB/AND/IOR -> Wb la Instr(18 downto 15)
                RdReg1 <= Instr(18 downto 15);
        end case;
    end process;
end Behavioral;

