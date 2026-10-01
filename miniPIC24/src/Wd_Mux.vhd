library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Wd_Mux is
    Port ( 
        RegDst     : in  STD_LOGIC;
        Instr_10_7 : in  STD_LOGIC_VECTOR (3 downto 0);
        Instr_3_0  : in  STD_LOGIC_VECTOR (3 downto 0);
        Wd         : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Wd_Mux;

architecture Behavioral of Wd_Mux is
begin
    Wd <= Instr_10_7 when RegDst = '0' else Instr_3_0;
end Behavioral;