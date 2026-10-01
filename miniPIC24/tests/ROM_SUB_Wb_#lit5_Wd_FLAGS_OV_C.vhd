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
    --inw1 <= x"8000";
    0 => X"808111", -- mov 0x1022, w1     ; W1=0x8000
    1 => X"508161", -- sub w1,#0x1,w2     ; W2=7FFF, OV=1, C=1
    2 => X"888122", -- mov w2, 0x1024
    3 => X"37FFFC", -- bra LOOP
    others => X"000000"
);


begin

    Data <= ROM(conv_integer(Addr));
    
end ROM32x24_arch;