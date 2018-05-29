----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:47:03 04/25/2017 
-- Design Name: 
-- Module Name:    top_module - Behavioral 
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

entity top is
	port (
			key_in : IN STD_LOGIC_VECTOR (3 downto 0);
			key_scan : OUT STD_LOGIC_VECTOR (3 downto 0);
			clk, reset, start : IN STD_LOGIC;
			segment : out STD_LOGIC_VECTOR(7 downto 0);
			dig : out STD_LOGIC_VECTOR(5 downto 0)
			);
end top;

architecture Behavioral of top is

COMPONENT clock_divider is
	port (clk, rst : in STD_LOGIC;
			dclk : out STD_LOGIC
			);
END COMPONENT;

COMPONENT key_matrix is
	port (
			reset : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			key_in : IN STD_LOGIC_VECTOR (3 downto 0);
			key_scan : OUT STD_LOGIC_VECTOR (3 downto 0);
			key_data : OUT STD_LOGIC_VECTOR (3 downto 0);
			key_event : OUT STD_LOGIC
			);
END COMPONENT;

COMPONENT segment7 is
	port( SEG_INPUT1, SEG_INPUT2, SEG_INPUT3, SEG_INPUT4, SEG_INPUT5, SEG_INPUT6 : in STD_LOGIC_VECTOR(3 downto 0);
			segment: out STD_LOGIC_VECTOR(7 downto 0);
			dig : out STD_LOGIC_VECTOR(5 downto 0);
			clk, reset, start: in STD_LOGIC
			);
END COMPONENT;

COMPONENT ShiftReg is
	port(
		input : in STD_LOGIC_VECTOR(3 downto 0);
		clk, reset: in STD_LOGIC;
		shreg0, shreg1, shreg2, shreg3, shreg4, shreg5 : out STD_LOGIC_VECTOR(3 downto 0)
);
END COMPONENT;

COMPONENT dff
	port( d,clk,reset,en : in STD_LOGIC;
	      q :out STD_LOGIC);
END COMPONENT;

COMPONENT counter
	port(
			clk, reset, en: in std_logic;
			creg0, creg1, creg2, creg3, creg4, creg5 : out STD_LOGIC_VECTOR(3 downto 0)
		);
END COMPONENT;

COMPONENT cnt_clock_divider
	port ( clk, reset : in STD_LOGIC;
			 dclk : out STD_LOGIC
	);

end COMPONENT;


type state_type is (count_mode, input_mode);
signal cur_state : state_type := input_mode;

signal reset_inv, start_inv, seg_clk, key_event, start_bt : STD_LOGIC;
type seg_in is array(0 to 5) of STD_LOGIC_VECTOR(3 downto 0);
type key_data_in is array(0 to 5) of STD_LOGIC_VECTOR(3 downto 0);
signal key_pad_out: STD_LOGIC_VECTOR(3 downto 0);
signal seginput : seg_in;
signal key_data : key_data_in;

-- COUNTER를 항상 증가시키는 CLOCK
signal counter_clk : STD_LOGIC;
signal shift_clk, shift_en : std_logic;
signal counter_data : key_data_in;
signal counter_en : STD_LOGIC;
-- COUNTER를 필요할 때만 증가시키기 위해 사용되는 CLOCK
--signal counter_dclk : STD_LOGIC;

begin
	reset_inv <= not reset;
	start_inv <= not start;
	DVD1 : clock_divider port map (clk=>clk, rst=>reset_inv, dclk=>seg_clk);
	
	--여기는 1초마다 올라가는 카운터의 OUTPUT을 COUNT_MODE의 INPUT으로 
	COUNTER_DVD : cnt_clock_divider port map (clk=>clk, reset=>reset_inv, dclk=>counter_clk);
	
	KEY_PAD : key_matrix port map (reset=>reset_inv, clk=>seg_clk, key_in=>key_in,
											 key_scan=>key_scan, key_data=>key_pad_out, key_event => key_event);
	
	SHR : ShiftReg port map (clk => shift_clk, reset=>reset_inv, input=>key_pad_out,
									 shreg0=>key_data(0), shreg1=>key_data(1), shreg2=>key_data(2),
									 shreg3=>key_data(3), shreg4=>key_data(4), shreg5=>key_data(5));
	
	BTN : dff port map(d=>start_inv, clk=>seg_clk, reset=>reset_inv, en=>'1', q=>start_bt);
	
	CNT : counter port map(reset=>reset_inv, clk => counter_clk, en => counter_en,
									 creg0=>counter_data(0), creg1=>counter_data(1), creg2=>counter_data(2),
									 creg3=>counter_data(3), creg4=>counter_data(4), creg5=>counter_data(5));
									 	
	SEG : segment7 port map(clk=>seg_clk, reset=>reset_inv, start => start_bt,
									SEG_INPUT1=>seginput(0), SEG_INPUT2=>seginput(1), SEG_INPUT3=>seginput(2),
									SEG_INPUT4=>seginput(3), SEG_INPUT5=>seginput(4), SEG_INPUT6=>seginput(5),
									dig=>dig, segment=>segment);

	process(start_bt, start, reset)
	begin
		if reset = '0' then
			cur_state <= input_mode;
		elsif start_bt = '1' and start = '0' then
			if cur_state = input_mode then	
				cur_state <= count_mode;
			end if;
		end if;

	end process;
	
	process(cur_state)
	begin
		if cur_state = input_mode then
			counter_en <= '0';	
			shift_en <= '1';
			seginput(0) <= key_data(0);
			seginput(1) <= key_data(1);
			seginput(2) <= key_data(2);
			seginput(3) <= key_data(3);
			seginput(4) <= key_data(4);
			seginput(5) <= key_data(5);
		elsif cur_state = count_mode then
			shift_en <= '0';
			counter_en <= '1';--;나만의 CLOCK DIVIDER;
			seginput(0) <= counter_data(0);
			seginput(1) <= counter_data(1);
			seginput(2) <= counter_data(2);
			seginput(3) <= counter_data(3);
			seginput(4) <= counter_data(4);
			seginput(5) <= counter_data(5);
			if key_data(5) = counter_data(5) and key_data(4) = counter_data(4) and key_data(3) = counter_data(3)
					and key_data(2) = counter_data(2) and key_data(1) = counter_data(1) and key_data(0) = counter_data(0) then
						counter_en <= '0';
			else
				counter_en <= '1';
--			else
--				counter_clk <= 나만의 Clock Divider;
			end if;
			
		end if;
	end process;
	
	shift_clk <= shift_en and key_event;
	
end Behavioral;

