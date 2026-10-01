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
	 -- inw0 <= x"AAAB"; inw1 <= x"5555";
    0  => X"808101", -- mov 0x1020, w1
    1  => X"808112", -- mov 0x1022, w2
    2  => X"408182", -- add w1,w2,w3
    3  => X"508202", -- sub w1,w2,w4
    4  => X"608282", -- and w1,w2,w5
    5  => X"708302", -- ior w1,w2,w6
    6  => X"888121", -- mov w1,0x1024
    7  => X"888122", -- mov w2,0x1024
    8  => X"888123", -- mov w3,0x1024
    9  => X"888124", -- mov w4,0x1024
    10 => X"888125", -- mov w5,0x1024
    11 => X"888126", -- mov w6,0x1024
    12 => X"37FFF3", -- bra LOOP
    others => X"000000"
);


begin

    Data <= ROM(conv_integer(Addr));
    
end ROM32x24_arch;