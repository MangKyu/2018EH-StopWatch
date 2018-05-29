----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:28:55 05/25/2018 
-- Design Name: 
-- Module Name:    ShiftReg - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ShiftReg is
port(
		input : in STD_LOGIC_VECTOR(3 downto 0);
		clk, reset: in std_logic;
		shreg0, shreg1, shreg2, shreg3, shreg4, shreg5 : out STD_LOGIC_VECTOR(3 downto 0)
);
end ShiftReg;

architecture Behavioral of ShiftReg is

COMPONENT Reg
	port(
		input : IN STD_LOGIC_VECTOR (3 downto 0);
		clk, reset, en : IN STD_LOGIC;
		output : OUT STD_LOGIC_VECTOR (3 downto 0)
		);

END COMPONENT;


signal shift_reg0, shift_reg1, shift_reg2, shift_reg3, shift_reg4, shift_reg5 : STD_LOGIC_VECTOR(3 DOWNTO 0);

begin
	REG0: Reg port map(input=>input, clk=>clk, reset=>reset, en=>'1', output=>shift_reg0);
	REG1: Reg port map(input=>shift_reg0, clk=>clk, reset=>reset, en=>'1', output=>shift_reg1);
	REG2: Reg port map(input=>shift_reg1, clk=>clk, reset=>reset, en=>'1', output=>shift_reg2);
	REG3: Reg port map(input=>shift_reg2, clk=>clk, reset=>reset, en=>'1', output=>shift_reg3);
	REG4: Reg port map(input=>shift_reg3, clk=>clk, reset=>reset, en=>'1', output=>shift_reg4);
	REG5: Reg port map(input=>shift_reg4, clk=>clk, reset=>reset, en=>'1', output=>shift_reg5);


	shreg0 <=  shift_reg0;
	shreg1 <=  shift_reg1;
	shreg2 <=  shift_reg2;
	shreg3 <=  shift_reg3;
	shreg4 <=  shift_reg4;
	shreg5 <=  shift_reg5;
end Behavioral;

