library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MemToReg_Mux is
    Port ( 
        MemToReg : in  STD_LOGIC; -- Selecteaza sursa (0 = ALU, 1 = RAM)
        ALU_Out  : in  STD_LOGIC_VECTOR (15 downto 0);
        MemData  : in  STD_LOGIC_VECTOR (15 downto 0);
        WD       : out STD_LOGIC_VECTOR (15 downto 0)    
    );
end MemToReg_Mux;

architecture Behavioral of MemToReg_Mux is
begin
    --WD <= ALU_Out when MemToReg = '0' else MemData;
	 WD <= MemData when MemToReg = '1' else ALU_Out;
end Behavioral;