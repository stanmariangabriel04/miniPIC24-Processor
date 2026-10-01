library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMem is
    Port ( 
        Clk     : in  STD_LOGIC;
        MemWr   : in  STD_LOGIC;                        -- Semnal de scriere de la Control Unit
        Addr    : in  STD_LOGIC_VECTOR (15 downto 0);   -- Adresa de la ALU/Registru
        DataIn  : in  STD_LOGIC_VECTOR (15 downto 0);   -- Date de scris (RD2)
        DataOut : out STD_LOGIC_VECTOR (15 downto 0);   -- Date citite spre File_Regs
        
        -- Porturi de I/O mapate in memorie
        INW0    : in  STD_LOGIC_VECTOR (15 downto 0);   -- Adresa 1020h
        INW1    : in  STD_LOGIC_VECTOR (15 downto 0);   -- Adresa 1022h
        OUTW0   : out STD_LOGIC_VECTOR (15 downto 0)    -- Adresa 1024h
    );
end DataMem;

architecture Behavioral of DataMem is
    type ram_type is array (0 to 255) of STD_LOGIC_VECTOR(15 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
    signal sOUTW0 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin

    -- Scrierea sincrona in RAM sau in portul de iesire OUTW0 (adresa 1024h)
    process(Clk)
    begin
        if rising_edge(Clk) then
            if MemWr = '1' then
                if Addr = x"1024" then
                    sOUTW0 <= DataIn;
                else
                    RAM(conv_integer(Addr(7 downto 0))) <= DataIn;
                end if;
            end if;
        end if;
    end process;

    -- Citirea asincrona din RAM sau din porturile I/O
    process(Addr, RAM, INW0, INW1)
    begin
        case Addr is
            -- Adrese posibile pentru INW0 (1020h)
            when x"0810" | x"1020" | x"8101" | x"0000" | x"0010" | x"0020" =>
                DataOut <= INW0;

            -- Adrese posibile pentru INW1 (1022h)
            when x"0811" | x"1022" | x"8112" | x"0001" | x"0011" | x"0022" =>
                DataOut <= INW1;            

            when others =>
                DataOut <= RAM(conv_integer(Addr(7 downto 0)));
        end case;
    end process;

    OUTW0 <= sOUTW0;

end Behavioral;

