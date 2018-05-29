----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:15:51 05/29/2018 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	port(
			clk, reset, en: in std_logic;
			creg0, creg1, creg2, creg3, creg4, creg5 : out STD_LOGIC_VECTOR(3 downto 0)
		);
end counter;

architecture Behavioral of counter is

COMPONENT Reg
	port(
		input : IN STD_LOGIC_VECTOR (3 downto 0);
		clk, reset, en : IN STD_LOGIC;
		output : OUT STD_LOGIC_VECTOR (3 downto 0)
		);

END COMPONENT;

--Input
signal input_reg0, input_reg1, input_reg2, input_reg3, input_reg4, input_reg5 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others=>'0');
--Output
signal output_reg0, output_reg1, output_reg2, output_reg3, output_reg4, output_reg5 : STD_LOGIC_VECTOR(3 DOWNTO 0);

begin
	REG0: Reg port map(input=>input_reg0, clk=>clk, reset=>reset, en=>'1', output=>output_reg0);
	REG1: Reg port map(input=>input_reg1, clk=>clk, reset=>reset, en=>'1', output=>output_reg1);
	REG2: Reg port map(input=>input_reg2, clk=>clk, reset=>reset, en=>'1', output=>output_reg2);
	REG3: Reg port map(input=>input_reg3, clk=>clk, reset=>reset, en=>'1', output=>output_reg3);
	REG4: Reg port map(input=>input_reg4, clk=>clk, reset=>reset, en=>'1', output=>output_reg4);
	REG5: Reg port map(input=>input_reg5, clk=>clk, reset=>reset, en=>'1', output=>output_reg5);

	process(reset, clk, en)
	begin
		if reset = '1' then
			input_reg0 <= (others=>'0');
			input_reg1 <= (others=>'0');
			input_reg2 <= (others=>'0');
			input_reg3 <= (others=>'0');
			input_reg4 <= (others=>'0');
			input_reg5 <= (others=>'0');
		elsif en = '1' then
			if rising_edge(clk) then
		--	if en = '1' and rising_edge(clk) then
				input_reg0 <= input_reg0 + '1';
					if input_reg0 = x"9" and input_reg1 = x"9" and input_reg2 = x"9" and input_reg3 = x"9" and input_reg4 = x"9" and input_reg5 = x"9" then
						input_reg0 <= x"0";
						input_reg1 <= x"0";
						input_reg2 <= x"0";
						input_reg3 <= x"0";
						input_reg4 <= x"0";
						input_reg5 <= x"0";
					elsif input_reg0 = x"9" and input_reg1 = x"9" and input_reg2 = x"9" and input_reg3 = x"9" and input_reg4 = x"9" then
						input_reg0 <= x"0";
						input_reg1 <= x"0";
						input_reg2 <= x"0";
						input_reg3 <= x"0";
						input_reg4 <= x"0";
						input_reg5 <= input_reg5 + '1';
					elsif input_reg0 = x"9" and input_reg1 = x"9" and input_reg2 = x"9" and input_reg3 = x"9" then
						input_reg0 <= x"0";
						input_reg1 <= x"0";
						input_reg2 <= x"0";
						input_reg3 <= x"0";
						input_reg4 <= input_reg4 + '1';
					elsif input_reg0 = x"9" and input_reg1 = x"9" and input_reg2 = x"9" then
						input_reg0 <= x"0";
						input_reg1 <= x"0";
						input_reg2 <= x"0";
						input_reg3 <= input_reg3 + '1';
					elsif input_reg0 = x"9" and input_reg1 = x"9" then
						input_reg0 <= x"0";
						input_reg1 <= x"0";
						input_reg2 <= input_reg2 + '1';
					elsif input_reg0 = x"9" then
						input_reg0 <= x"0";
						input_reg1 <= input_reg1 + '1';
					end if;
			end if;
		else
			input_reg0 <= output_reg0;
			input_reg1 <= output_reg1;
			input_reg2 <= output_reg2;
			input_reg3 <= output_reg3;
			input_reg4 <= output_reg4;
			input_reg5 <= output_reg5;
		end if;
	end process;

	creg0 <=  output_reg0;
	creg1 <=  output_reg1;
	creg2 <=  output_reg2;
	creg3 <=  output_reg3;
	creg4 <=  output_reg4;
	creg5 <=  output_reg5;
	
	
	
end Behavioral;

