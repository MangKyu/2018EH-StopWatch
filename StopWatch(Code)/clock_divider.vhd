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

entity clock_divider is
	port ( clk, rst : in STD_LOGIC;
			 dclk : out STD_LOGIC
	);

end clock_divider;

architecture Behavioral of clock_divider is

signal cnt_data:STD_LOGIC_VECTOR(23 downto 0);
begin
	process(clk, rst)
	begin
		if rst='1'then
			cnt_data<=(others=>'0');
			dclk<='0';
		elsif clk'event and clk='1' then
			if cnt_data=x"2710" then
				cnt_data<=(others=>'0');
				dclk<='1';
			elsif cnt_data=x"1388" then
				dclk<='0';
				cnt_data<=cnt_data+'1';
			else
				cnt_data<=cnt_data+'1';
			end if;
		end if;
	end process;


end Behavioral;
