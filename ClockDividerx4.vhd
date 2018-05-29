----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:03:37 04/06/2017 
-- Design Name: 
-- Module Name:    clkdivider - Behavioral 
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

entity ClockDividerx4 is
	port (clk, reset : in STD_LOGIC;
			dclk : out STD_LOGIC
			);
end ClockDividerx4;

architecture Behavioral of ClockDividerx4 is
	signal cnt_data : STD_LOGIC_VECTOR(3 downto 0);
	signal d_clk: STD_LOGIC;
begin
	process (clk, reset)
	begin
		if reset='1' then
			cnt_data<=(others=>'0');
			d_clk<='0';
		elsif clk'event and clk='1' then
			if cnt_data=x"F" then
				cnt_data<=(others=>'0');
				d_clk<= NOT d_clk;
			else
				d_clk <= d_clk;
				cnt_data<=cnt_data+'1';
			end if;
		end if;
	end process;
	dclk<=d_clk;
end Behavioral;