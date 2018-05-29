----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:29:55 04/19/2018 
-- Design Name: 
-- Module Name:    bcd_counter - Behavioral 
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

entity bcd_counter is
	port (
			clk, reset: in std_logic;
			cnt : out std_logic_vector(2 downto 0)
	);
end bcd_counter;

architecture Behavioral of bcd_counter is
	
	signal cnt_data : std_logic_vector(2 downto 0);
	
begin

	process(clk, reset)
	begin
		if reset = '1' then
			cnt_data <= (others => '0');
		elsif clk'event and clk = '1' then
				if cnt_data = "101" then
					cnt_data <= (others => '0');
				else
					cnt_data <= cnt_data + 1;
				end if;
		end if;
	end process;
	
	cnt <= cnt_data;
end Behavioral;

