library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port (
        A      : in  STD_LOGIC_VECTOR (15 downto 0);
        B      : in  STD_LOGIC_VECTOR (15 downto 0);
        ALUOP  : in  STD_LOGIC_VECTOR (3 downto 0);

        Clk    : in  STD_LOGIC;

        CE_N   : in  STD_LOGIC;
        CE_OV  : in  STD_LOGIC;
        CE_Z   : in  STD_LOGIC;
        CE_C   : in  STD_LOGIC;

        Y      : out STD_LOGIC_VECTOR (15 downto 0);
        N      : out STD_LOGIC;
        OV     : out STD_LOGIC;
        Z      : out STD_LOGIC;
        C      : out STD_LOGIC
    );
end ALU;


architecture Behavioral of ALU is

    signal sY : STD_LOGIC_VECTOR (15 downto 0); -- Y va fi o copie a lui sY

    signal sN  : STD_LOGIC := '0';
    signal sOV : STD_LOGIC := '0';
    signal sZ  : STD_LOGIC := '0';
    signal sC  : STD_LOGIC := '0';

    signal add_result : STD_LOGIC_VECTOR (16 downto 0);

begin

        -- ALU
    -- 0000 = ADD
    -- 0001 = SUB
    -- 0010 = AND
    -- 0011 = IOR
    -- 0100 = ASR
    -- 0101 = COM
        process(A, B, ALUOP)
        variable res : STD_LOGIC_VECTOR (15 downto 0);
        variable tmp : STD_LOGIC_VECTOR (16 downto 0);
        variable sh  : integer;
    begin

        res := (others => '0');
        tmp := (others => '0');

        case ALUOP is

            -- ADD
            when "0000" =>
                tmp := ('0' & A) + ('0' & B);
                res := tmp(15 downto 0);

            -- SUB
            when "0001" =>
                tmp := ('0' & A) + ('0' & not B) + "00000000000000001";
                res := tmp(15 downto 0);

            -- AND
            when "0010" =>
                res := A and B;

            -- IOR
            when "0011" =>
                res := A or B;

            -- ASR Wb,#lit4,Wnd
            when "0100" =>
                sh := conv_integer(B(3 downto 0));

                if sh = 0 then
                    res := A;
                else
                    res := A;

                    for i in 1 to 15 loop
                        if i <= sh then
                            res(15-i+1) := A(15);
                            res(15-i downto 0) :=
                                A(15 downto i);
                        end if;
                    end loop;
                end if;

            -- COM Ws, Wd
            when "0101" =>
                res := not A;
					 
				-- Pass-Through B
				when "0111" =>
					 res := B;
				
            when others =>
                res := (others => '0');

        end case;

        sY <= res;

    end process;


        -- Carry calculation
        process(A, B, ALUOP, sY)
        variable tmp : STD_LOGIC_VECTOR (16 downto 0);
    begin

        tmp := (others => '0');

        case ALUOP is

            when "0000" =>

                tmp := ('0' & A) + ('0' & B);
                add_result <= tmp;

            when "0001" =>

                tmp := ('0' & A) +
                       ('0' & not B) +
                       "00000000000000001";

                add_result <= tmp;

            when others =>

                add_result <= (others => '0');

        end case;

    end process;


        -- Outputs din ALU
        Y <= sY;


        -- FLAG REGISTERS
        process(Clk)
    begin

        if rising_edge(Clk) then

            -- N
            if CE_N = '1' then
                sN <= sY(15);
            end if;

            -- Z
            if CE_Z = '1' then
                if sY = x"0000" then
                    sZ <= '1';
                else
                    sZ <= '0';
                end if;
            end if;

            -- C
            if CE_C = '1' then
                if (ALUOP = "0000") or (ALUOP = "0001") then
                    sC <= add_result(16);
                end if;
            end if;

            -- OV
            if CE_OV = '1' then

                if ALUOP = "0000" then

                    sOV <=
                        (not (A(15) xor B(15))) and
                        (A(15) xor sY(15));

                elsif ALUOP = "0001" then

                    sOV <=
                        (A(15) xor B(15)) and
                        (A(15) xor sY(15));

                end if;

            end if;

        end if;

    end process;


    N  <= sN;
    OV <= sOV;
    Z  <= sZ;
    C  <= sC;

end Behavioral;

