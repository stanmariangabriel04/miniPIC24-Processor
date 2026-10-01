----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:50:09 03/19/2025 
-- Design Name: 
-- Module Name:    ProgCnt - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM32x24 is
    Port ( Addr : in  STD_LOGIC_VECTOR (4 downto 0);
           Data : out STD_LOGIC_VECTOR (23 downto 0));
end ROM32x24;

architecture ROM32x24_arch of ROM32x24 is
    type tROM is array (0 to 31) of std_logic_vector(23 downto 0); 
    
constant ROM: tROM := (
    0  => X"808101", -- mov 0x1020, w1        ; INW0=0xFFFF
    1  => X"B23FF1", -- and #0x3FF, w1        ; w1=0x03FF, caz nominal
    2  => X"888121", -- mov w1, 0x1024
    3  => X"808101", -- mov 0x1020, w1        ; reincarca INW0=0xFFFF
    4  => X"B23FF1", -- and #0x3FF, w1        ; w1=0x03FF, Z=0
    5  => X"320007", -- bra Z, STOP           ; nu trebuie sa sara
    6  => X"B20001", -- and #0x0, w1          ; w1=0x0000, Z=1
    7  => X"320001", -- bra Z, NEXT           ; trebuie sa sara
    8  => X"370004", -- bra STOP              ; nu ar trebui ajuns aici
    9  => X"808101", -- mov 0x1020, w1        ; INW0=0xFFFF   (NEXT)
    10 => X"B23FF1", -- and #0x3FF, w1        ; w1=0x03FF, N mereu 0
    11 => X"330001", -- bra N, STOP           ; nu trebuie sa sara niciodata
    12 => X"370001", -- bra END
    13 => X"37FFFF", -- STOP: bra STOP (bucla infinita)
    14 => X"37FFF1", -- END: bra LOOP
    others => X"000000"
);



begin

    Data <= ROM(conv_integer(Addr));
    
end ROM32x24_arch;