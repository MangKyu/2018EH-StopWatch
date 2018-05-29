----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:16:13 05/10/2018 
-- Design Name: 
-- Module Name:    clkdevider - Behavioral 
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

entity cnt_clock_divider is
	port ( clk, reset : in STD_LOGIC;
			 dclk : out STD_LOGIC
	);

end cnt_clock_divider;

architecture Behavioral of cnt_clock_divider is

signal cnt_data:STD_LOGIC_VECTOR(23 downto 0);
signal d_clk : std_logic;

begin
	process(clk, reset)
	begin
		if reset='1' then
			cnt_data<=(others=>'0');
			d_clk<='0';
		elsif clk'event and clk='1' then
			if cnt_data=x"FFFFFF" then
				cnt_data<=(others=>'0');
				d_clk<=not d_clk;
			else
				d_clk<=d_clk;
				cnt_data<=cnt_data+'1';
			end if;
		end if;
	end process;
	
	dclk<=d_clk;

end Behavioral;
