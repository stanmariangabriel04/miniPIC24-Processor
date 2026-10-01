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
	 -- inw0 <= x"7FFF"; inw1 <= x"0001";
    0  => X"808101", -- mov 0x1020, w1
    1  => X"808112", -- mov 0x1022, w2
    2  => X"408182", -- add w1,w2,w3   ; w3=8000, OV=1
    3  => X"410402", -- add w2,w2,w8   ; w8=0002, OV=0
    4  => X"418203", -- add w3,w3,w4   ; w4=0000, OV=1
    5  => X"418402", -- add w3,w2,w8   ; OV=0
    6  => X"510283", -- sub w2,w3,w5   ; w5=8001, OV=1
    7  => X"508402", -- sub w1,w2,w8   ; OV=0
    8  => X"528381", -- sub w5,w1,w7   ; w7=0002, OV=1
    9  => X"608282", -- and w1,w2,w5   ; OV nemodificat
    10 => X"708302", -- ior w1,w2,w6   ; OV nemodificat
    11 => X"888121", -- mov w1,0x1024
    12 => X"888122", -- mov w2,0x1024
    13 => X"888123", -- mov w3,0x1024
    14 => X"888124", -- mov w4,0x1024
    15 => X"888125", -- mov w5,0x1024
    16 => X"37FFEF", -- bra LOOP
    others => X"000000"
);



begin

    Data <= ROM(conv_integer(Addr));
    
end ROM32x24_arch;