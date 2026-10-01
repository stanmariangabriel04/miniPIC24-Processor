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
    0  => X"808101", -- mov 0x1020, w1
    1  => X"808112", -- mov 0x1022, w2
    2  => X"408182", -- add w1,w2,w3   ; 0000, C=1
    3  => X"608282", -- and w1,w2,w5   ; C nemodificat
    4  => X"418182", -- add w3,w2,w3   ; 0001, C=0
    5  => X"518202", -- sub w3,w2,w4   ; 0000, C=1
    6  => X"708302", -- ior w1,w2,w6   ; C nemodificat
    7  => X"520202", -- sub w4,w2,w4   ; ffff, C=0
    8  => X"888121", -- mov w1,0x1024
    9  => X"888122", -- mov w2,0x1024
    10 => X"888123", -- mov w3,0x1024
    11 => X"888124", -- mov w4,0x1024
    12 => X"888125", -- mov w5,0x1024
    13 => X"888126", -- mov w6,0x1024
    14 => X"37FFF1", -- bra LOOP
    others => X"000000"
);


begin

    Data <= ROM(conv_integer(Addr));
    
end ROM32x24_arch;