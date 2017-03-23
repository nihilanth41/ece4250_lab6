library ieee;
use ieee.std_logic_1164.all;

entity traffic_light is
  port(clk, pb : in std_logic := '0' ;
       ga, ya, ra, nowalk : out std_logic := '0' ;
	walk : out std_logic := '0' );
end traffic_light;

architecture traffic_light_arch of traffic_light is

  -- component declaration
  component GenClock
    generic(time_period : integer range 1 to 4);
    port(clk : in std_logic := '1';
         Clock : out std_logic := '1');
  end component;

  signal CLK_1 : std_logic := '0';
  signal state, next_state : integer range 1 to 14; -- assumes 0 from lower range bound
  signal counter : integer range 0 to 3 ;
  signal button_pressed : std_logic := '0';
begin

  -- component instatiation
  CLK1: GenClock
    -- 1 second
    generic map(time_period => 1)
    -- component_name => entity_name ( clk => clk , Clock => CLK_1 );
    port map ( clk => clk , Clock => CLK_1 );
	 
 process(clk)
 begin
	if(clk'event and clk='1') then
		if(pb='1') then 
			button_pressed <= '1';
		elsif(next_state=14) then
			button_pressed <= '0';
		end if;
	end if;
 end process;

  process (state, button_pressed, counter) -- pb replace?
  begin
    -- initialize default values
    ga <= '0';
    ya <= '0';
    ra <= '0';
    walk <= '0';
    nowalk <='0';
	 next_state <= state;

    case state is
      when 1 to 7 =>
        next_state <= state + 1;
        ga <= '1';
        nowalk <= '1';
      when 8 =>
        ga <= '1';
        nowalk <= '1';
        if (button_pressed='1') then 
          next_state <= state + 1;
        elsif (button_pressed='0') then
          next_state <= state;
        end if;
      when 9 => -- Yellow light is on, but not walk yet.
        next_state <= state + 1;
        Ya <= '1';
        nowalk <= '1';
      when 10 to 12=> -- light is red, ped can walk
        next_state <= state + 1;
        Ra <= '1';
        walk <= '1';

      when 13 =>
        next_state <= state + 1;
        Ra <= '1';

  		case counter is
			when 0 => walk <= '0';
			when 1 => walk <= '1';
			when 2 => walk <= '0';
			when 3 => walk <= '1';
		end case;
      when 14 =>
        next_state <= 1;
        Ga <= '1';
        nowalk <= '1';
      when others => NULL;
    end case;
  end process;

  process(CLK_1)
  begin
    if(CLK_1'EVENT and CLK_1='1') then
	if ( counter < 3 ) then
           counter <= counter + 1;
	else
	   counter <= 0;
           state <= next_state;
	end if;
    end if;
  end process;
end traffic_light_arch;