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
           Data : out STD_LOGIC_VECTOR (23 downto 0)); -- Redus la 24 biti
end ROM32x24;

architecture ROM32x24_arch of ROM32x24 is
    type tROM is array (0 to 31) of std_logic_vector(23 downto 0); -- Redus la 24 biti
    
constant ROM: tROM := (
    0  => X"808101", -- mov 0x1020, w1
    1  => X"808112", -- mov 0x1022, w2
    2  => X"408182", -- add w1,w2,w3   ; 0000, Z=1
    3  => X"410382", -- add w2,w2,w7   ; 0002, Z=0
    4  => X"510202", -- sub w2,w2,w4   ; 0000, Z=1
    5  => X"520202", -- sub w4,w2,w4   ; ffff, Z=0
    6  => X"608283", -- and w1,w3,w5   ; 0000, Z=1
    7  => X"608281", -- and w1,w1,w5   ; ffff, Z=0
    8  => X"718303", -- ior w3,w3,w6   ; 0000, Z=1
    9  => X"708302", -- ior w1,w2,w6   ; ffff, Z=0
    10 => X"888121", -- mov w1,0x1024
    11 => X"888122", -- mov w2,0x1024
    12 => X"888123", -- mov w3,0x1024
    13 => X"888124", -- mov w4,0x1024
    14 => X"888125", -- mov w5,0x1024
    15 => X"888126", -- mov w6,0x1024
    16 => X"37FFEF", -- bra LOOP
    others => X"000000"
);

begin

    Data <= ROM(conv_integer(Addr));
    
end ROM32x24_arch;