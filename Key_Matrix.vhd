----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:34:00 04/25/2017 
-- Design Name: 
-- Module Name:    key_matrix - Behavioral 
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

entity key_matrix is
	port (
			reset : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			key_in : IN STD_LOGIC_VECTOR (3 downto 0);
			key_scan : OUT STD_LOGIC_VECTOR (3 downto 0);
			key_data : OUT STD_LOGIC_VECTOR (3 downto 0);
			key_event : OUT STD_LOGIC
			);
end key_matrix;

architecture Behavioral of key_matrix is

COMPONENT ClockDividerx4 is
	port (clk, reset : IN STD_LOGIC;
			dclk : OUT STD_LOGIC
			);
END COMPONENT;

signal scan_cnt : STD_LOGIC_VECTOR (3 downto 0);
signal key_data_int : STD_LOGIC_VECTOR (3 downto 0);
signal key_in_int : STD_LOGIC_VECTOR (3 downto 0);
signal seg_clk : STD_LOGIC;
signal key_temp : STD_LOGIC_VECTOR(15 downto 0);

begin

	DVD0 : ClockDividerx4 port map (clk=>clk, reset=>reset, dclk=>seg_clk);

	process(reset, seg_clk)
	begin
		if reset = '1' then
			scan_cnt <= "1110";
		elsif rising_edge(seg_clk) then
			scan_cnt <= scan_cnt(2 downto 0) & scan_cnt(3);
		end if;
	end process;
	
	process(reset, clk)
	begin
		if reset = '1' then
			key_in_int <= (others => '1');
		elsif rising_edge (clk) then
			key_in_int <= key_in;
		end if;
	end process;
	
	process(scan_cnt,key_in_int,seg_clk)
	begin
		if rising_edge (seg_clk) then
		case scan_cnt is
			when "1110" => if		key_in_int = "1110" then
										key_data_int <= x"1";
								elsif	key_in_int = "1101" then
										key_data_int <= x"4";
								elsif	key_in_int = "1011" then
										key_data_int <= x"7";
								elsif	key_in_int = "0111" then
										key_data_int <= x"0";
								end if;
			when "1101" => if		key_in_int = "1110" then
										key_data_int <= x"2";
								elsif	key_in_int = "1101" then
										key_data_int <= x"5";
								elsif	key_in_int = "1011" then
										key_data_int <= x"8";
								elsif	key_in_int = "0111" then
										key_data_int <= x"A";
								end if;
			when "1011" => if		key_in_int = "1110" then
										key_data_int <= x"3";
								elsif	key_in_int = "1101" then
										key_data_int <= x"6";
								elsif	key_in_int = "1011" then
										key_data_int <= x"9";
								elsif	key_in_int = "0111" then
										key_data_int <= x"B";
								end if;
			when "0111" => if		key_in_int = "1110" then
										key_data_int <= x"F";
								elsif	key_in_int = "1101" then
										key_data_int <= x"E";
								elsif	key_in_int = "1011" then
										key_data_int <= x"D";
								elsif	key_in_int = "0111" then
										key_data_int <= x"C";
								end if;
			when others => key_data_int <= key_data_int;
		end case;
		end if;
	end process;

	process(reset, key_in_int, scan_cnt, seg_clk)
	begin
		if reset = '1' then
			key_temp <= (others=>'1');
		elsif rising_edge (seg_clk) then
			case scan_cnt is
				when "1110" => key_temp(15 DOWNTO 12) <= key_in_int;
				when "1101" => key_temp(11 DOWNTO 8) <= "1" & key_in_int(2 downto 0);
				when "1011" => key_temp(7 DOWNTO 4) <= "1" & key_in_int(2 downto 0);
				when "0111" => key_temp(3 DOWNTO 0) <= "1111";--key_in_int;
				when others => key_temp <= key_temp;
			end case;
		end if;
	end process;
	
	process(key_temp)
	begin
		if key_temp = x"FFFF" then
			key_event<='0';
		else
			key_event<='1';
		end if;
	end process;

	key_data <= key_data_int;
	key_scan <= scan_cnt;
end Behavioral;

