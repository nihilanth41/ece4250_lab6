library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GenClock is 
	generic(time_period : integer range 1 to 4);
	port(clk : in std_logic := '1';
	Clock : out std_logic := '1');
end GenClock;

architecture GenClock_arch of GenClock is 
   type period_array is array(1 to 4) of integer;
	constant period_lookup : period_array := (25000000, 50000000, 100000000, 200000000);
begin
	process(clk) -- 50 mhz
	variable count : integer := 0;
	variable clk_tmp : std_logic := '0';
	begin
		if(clk'event and clk='1') then -- rising edge
			count := count + 1; -- event is every 1 cycle = 40ns
			if(count >= period_lookup(time_period)) then
				clk_tmp := not clk_tmp;
				count := 0;
			end if;
		end if;
		Clock <= clk_tmp;
	end process;
	
end GenClock_arch;
