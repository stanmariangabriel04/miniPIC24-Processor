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
    -- inw0 <= x"0001"; inw1 <= x"0002";
    0 => X"808101", -- mov 0x1020, w1
    1 => X"808112", -- mov 0x1022, w2
    2 => X"408182", -- add w1,w2,w3      ; 0003, N=0
    3 => X"330002", -- bra N, STOP       ; nu sare
    4 => X"508182", -- sub w1,w2,w3      ; FFFF, N=1
    5 => X"330001", -- bra N, END        ; sare
    6 => X"37FFFF", -- STOP: bra STOP
    7 => X"37FFF8", -- END: bra LOOP
    others => X"000000"
);



begin

    Data <= ROM(conv_integer(Addr));
    
end ROM32x24_arch;