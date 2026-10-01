library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC_Update is
    Port ( 
        PC     : in  STD_LOGIC_VECTOR (5 downto 0);
        Instr  : in  STD_LOGIC_VECTOR (23 downto 0); -- Primeste magistrala completa de la ROM (Data/Instr)
        PCSrc  : in  STD_LOGIC;                      -- Semnal de la Control_Unit
        New_PC : out STD_LOGIC_VECTOR (5 downto 0)   -- Spre intrarea ProgCnt
    );
end PC_Update;

architecture Behavioral of PC_Update is
begin
    process(PC, Instr, PCSrc)
        variable offset : std_logic_vector(5 downto 0);
    begin
        offset := Instr(5 downto 0);

        if PCSrc = '1' then
            New_PC <= PC + 1 + offset; -- Salt (PC + 1 + offset)
        else
            New_PC <= PC + 1;          -- Incrementare normala
        end if;
    end process;
end Behavioral;
