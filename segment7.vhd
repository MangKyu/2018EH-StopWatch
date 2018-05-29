----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:10:43 05/10/2018 
-- Design Name: 
-- Module Name:    segment7 - Behavioral 
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

entity segment7 is 
	port( SEG_INPUT1,SEG_INPUT2,SEG_INPUT3,SEG_INPUT4,SEG_INPUT5,SEG_INPUT6 : in STD_LOGIC_VECTOR(3 downto 0);
			 segment:out STD_LOGIC_VECTOR(7 downto 0);
			 dig : out STD_LOGIC_VECTOR(5 downto 0);
			 clk,  reset, start : in STD_LOGIC
			);
end segment7;

architecture Behavioral of segment7 is
COMPONENT count0to5 is
	port ( clk, reset : in STD_LOGIC;
			 cnt : out STD_LOGIC_VECTOR(2 downto 0)
	);
END COMPONENT;
signal seg_int : STD_LOGIC_VECTOR(7 downto 0);
signal display_data : STD_LOGIC_VECTOR(3 downto 0);
signal clk_count : STD_LOGIC_VECTOR(2 downto 0);
signal digit : STD_LOGIC_VECTOR(5 downto 0);

begin
	C0to5 : count0to5 port map(clk=>clk, reset=>reset, cnt=>clk_count);
	
	process(clk, reset, start)
	begin
		if reset='1' then
			digit<="000001";
		else
			if rising_edge(clk) then
				case clk_count is
					when "000" => digit <= "000001";
					when "001" => digit <= "000010";
					when "010" => digit <= "000100";
					when "011" => digit <= "001000";
					when "100" => digit <= "010000";
					when "101" => digit <= "100000";
					when others => digit <= "000000";
				end case;
			end if;
		end if;
	end process;

	process(digit,reset,SEG_INPUT1,SEG_INPUT2,SEG_INPUT3,SEG_INPUT4,SEG_INPUT5,SEG_INPUT6)
	begin
		case digit is 
			when "000001" => display_data <= SEG_INPUT1;
			when "000010" => display_data <= SEG_INPUT2;
			when "000100" => display_data <= SEG_INPUT3;
			when "001000" => display_data <= SEG_INPUT4;
			when "010000" => display_data <= SEG_INPUT5;
			when "100000" => display_data <= SEG_INPUT6;
			when others => display_data <= "0000";
		end case;
	end process;
	
	
	-- 1~F를 출력해주는 코드
	process(display_data)
	begin
		case display_data is
			when X"0" => seg_int <= "11111101";
			when X"1" => seg_int <= "01100001";
			when X"2" => seg_int <= "11011011";
			when X"3" => seg_int <= "11110011";
			when X"4" => seg_int <= "01100111";
			when X"5" => seg_int <= "10110111";
			when X"6" => seg_int <= "10111111";
			when X"7" => seg_int <= "11100101";
			when X"8" => seg_int <= "11111111";
			when X"9" => seg_int <= "11110111";
			when X"a" => seg_int <= "11111011";
			when X"b" => seg_int <= "00111111";
			when X"c" => seg_int <= "10011101";
			when X"d" => seg_int <= "01111011";
			when X"e" => seg_int <= "10011111";
			when X"f" => seg_int <= "10001111";
			when others => seg_int <= (others => '0');
		end case;
	end process;


	dig <= digit;
	segment<=seg_int;
	
end Behavioral;

