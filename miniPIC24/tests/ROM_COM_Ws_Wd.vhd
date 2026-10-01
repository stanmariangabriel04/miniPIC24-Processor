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
    -- inw0 <= x"FFFF"; inw1 <= x"0000";
    0 => X"808101", -- mov 0x1020, w1      ; INW0=0xFFFF
    1 => X"EA8101", -- com w1, w2          ; w2=0000, Z=1, N=0
    2 => X"888122", -- mov w2, 0x1024
    3 => X"808113", -- mov 0x1022, w3      ; INW1=0x0000
    4 => X"EA8203", -- com w3, w4          ; w4=FFFF, N=1, Z=0
    5 => X"888124", -- mov w4, 0x1024
    6 => X"37FFF9", -- bra LOOP
    others => X"000000"
);


begin

    Data <= ROM(conv_integer(Addr));
    
end ROM32x24_arch;