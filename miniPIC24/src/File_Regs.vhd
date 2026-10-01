library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity File_Regs is
    Port ( Clk     : in  STD_LOGIC;
           WrEn    : in  STD_LOGIC;
           RdReg1  : in  STD_LOGIC_VECTOR (3 downto 0);
           RdReg2  : in  STD_LOGIC_VECTOR (3 downto 0);
           WrReg   : in  STD_LOGIC_VECTOR (3 downto 0);
           WrData  : in  STD_LOGIC_VECTOR (15 downto 0);
           RdData1 : out STD_LOGIC_VECTOR (15 downto 0);
           RdData2 : out STD_LOGIC_VECTOR (15 downto 0));
end File_Regs;

architecture Behavioral of File_Regs is
    type tRegs is array (0 to 15) of std_logic_vector(15 downto 0);
    signal s32Regs32: tRegs := (others => (others => '0'));
begin

    -- Proces pentru scrierea sincrona in registre
    process(Clk)
    begin
        if rising_edge(Clk) then
            if WrEn = '1' then
                s32Regs32(conv_integer(WrReg)) <= WrData;
            end if;
        end if;
    end process;

    -- Citire asincrona directa pe porturile de iesire
    RdData1 <= s32Regs32(conv_integer(RdReg1));
    RdData2 <= s32Regs32(conv_integer(RdReg2));

end Behavioral;

