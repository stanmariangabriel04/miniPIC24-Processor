library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Control_Unit is
    Port ( 
        Instr    : in  STD_LOGIC_VECTOR (23 downto 0);
        N        : in  STD_LOGIC;
        OV       : in  STD_LOGIC;
        Z        : in  STD_LOGIC;
        C        : in  STD_LOGIC;
        
        -- Semnale de comanda pentru Datapath
        RegDst   : out STD_LOGIC;
        RegWr    : out STD_LOGIC;
        ALUSrc   : out STD_LOGIC_VECTOR (2 downto 0);
        ALUOp    : out STD_LOGIC_VECTOR (3 downto 0);
        MemWr    : out STD_LOGIC;
        MemToReg : out STD_LOGIC;
        PCSrc    : out STD_LOGIC;
		  RdReg1Sel : out STD_LOGIC_VECTOR (1 downto 0);
        
        -- Clock enable pentru flaguri
        CE_N     : out STD_LOGIC;
        CE_OV    : out STD_LOGIC;
        CE_Z     : out STD_LOGIC;
        CE_C     : out STD_LOGIC
    );
end Control_Unit;
 
architecture Behavioral of Control_Unit is
 
    -- primii 5 biti = opcode real pentru instructiunile ADD/SUB/AND/IOR
    -- (bitii 18 downto 16 fac parte din Wb, nu din opcode)
    alias Op5 : std_logic_vector(4 downto 0) is Instr(23 downto 19);
 
    -- byte-ul complet, pentru instructiunile fara biti de registru in el
    alias Opcode : std_logic_vector(7 downto 0) is Instr(23 downto 16);
 
    -- distinge SUB Wb,Ws,Wd de SUB Wb,#lit5,Wd
    alias SubLit : std_logic_vector(1 downto 0) is Instr(6 downto 5);
 
begin
    process(Instr, Op5, Opcode, SubLit, N, OV, Z, C)
        variable v_branch : std_logic := '0';
    begin
        -- Valori implicite
		  RdReg1Sel <= "00";
        RegDst   <= '0';
        RegWr    <= '0';
        ALUSrc   <= "000";
        ALUOp    <= "0111";
        MemWr    <= '0';
        MemToReg <= '0';
        PCSrc    <= '0';
        CE_N     <= '0';
        CE_OV    <= '0';
        CE_Z     <= '0';
        CE_C     <= '0';
        v_branch := '0';
 
        if Opcode = x"37" then
            -- BRA expr
            v_branch := '1';
 
        elsif Opcode = x"32" then
            -- BRA Z, expr
            v_branch := Z;
 
        elsif Opcode = x"31" then
            -- BRA C, expr
            v_branch := C;
 
        elsif Opcode = x"33" then
            -- BRA N, expr
            v_branch := N;
 
        elsif Opcode = x"30" then
            -- BRA OV, expr
            v_branch := OV;
 
        elsif Opcode = x"DE" then
			  -- ASR Wb, #lit4, Wnd
			  RegWr <= '1'; ALUSrc <= "001"; ALUOp <= "0100";
			  CE_N  <= '1'; CE_Z <= '1';
			  RdReg1Sel <= "01";                       -- <-- nou
		
		  elsif Opcode = x"EA" then
			  -- COM Ws, Wd
			  RegWr <= '1'; ALUSrc <= "000"; ALUOp <= "0101";
			  CE_N  <= '1'; CE_Z <= '1';
			  RdReg1Sel <= "10";                       -- <-- nou                       
			  
		  elsif Opcode = x"2F" or Opcode = x"20" then
			  -- MOV #literal, Wn
			  RegDst	  <= '1';
			  RegWr    <= '1';
			  ALUSrc   <= "100";  -- Trimite valoarea literala direct din instructiune pe intrarea B
			  ALUOp    <= "0111"; -- Pass-through B (ALU lasa constanta sa treaca spre Y)
			  MemToReg <= '0';    -- Selecteaza iesirea ALU pentru scrierea in registru
 
        elsif Opcode = x"B2" then
            -- AND #lit10, Wn
            RegDst <= '1'; RegWr <= '1'; ALUSrc <= "011"; ALUOp <= "0010";
            CE_N   <= '1'; CE_Z <= '1'; RdReg1Sel <= "11"; 
 
        elsif Op5 = "01000" then
            -- ADD Wb, Ws, Wd
            RegWr <= '1'; ALUSrc <= "000"; ALUOp <= "0000";
            CE_N <= '1'; CE_OV <= '1'; CE_Z <= '1'; CE_C <= '1';
 
        elsif Op5 = "01010" and SubLit = "11" then
            -- SUB Wb, #lit5, Wd
            RegWr <= '1'; ALUSrc <= "010"; ALUOp <= "0001";
            CE_N <= '1'; CE_OV <= '1'; CE_Z <= '1'; CE_C <= '1';
 
        elsif Op5 = "01010" then
            -- SUB Wb, Ws, Wd
            RegWr <= '1'; ALUSrc <= "000"; ALUOp <= "0001";
            CE_N <= '1'; CE_OV <= '1'; CE_Z <= '1'; CE_C <= '1';
 
        elsif Op5 = "01100" then
            -- AND Wb, Ws, Wd
            RegWr <= '1'; ALUSrc <= "000"; ALUOp <= "0010";
            CE_N <= '1'; CE_Z <= '1';
 
        elsif Op5 = "01110" then
            -- IOR Wb, Ws, Wd
            RegWr <= '1'; ALUSrc <= "000"; ALUOp <= "0011";
            CE_N <= '1'; CE_Z <= '1';
 
        elsif Op5 = "10000" then
				-- MOV f, Wnd (load)
				RegDst <= '1'; RegWr <= '1'; MemToReg <= '1'; ALUOp <= "0111"; ALUSrc <= "100";

		  elsif Op5 = "10001" then
				-- MOV Wns, f (store)
				MemWr <= '1'; ALUOp <= "0111"; ALUSrc <= "100";
 
        end if;
 
        PCSrc <= v_branch;
    end process;
end Behavioral;