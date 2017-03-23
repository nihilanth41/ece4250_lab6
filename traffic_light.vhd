
library ieee;
use ieee.std_logic_1164.all;

entity traffic_light is
  port(clk, pb : in std_logic := '0' ;
       ga, ya, ra, walk, nowalk : out std_logic := '0' );
end traffic_light;

architecture traffic_light_arch of traffic_light is

  -- component declaration
  component GenClock
    generic(time_period : integer range 1 to 4);
    port(clk : in std_logic := '1';
         Clock : out std_logic := '1');
  end component;

signal CLK_1,CLK_4, CLK_INT : std_logic <= '1';
signal current_state, next_state : integer range 0 to 13; -- assumes 0 from lower range bound
signal count : integer <= 0 ;

begin

  -- component instatiation
  CLK1: GenClock
    -- 1 second
    generic map(time_period => 2)
    -- component_name => entity_name ( clk => clk , Clock => CLK_1 );
    port map ( clk => clk , Clock => CLK_1 );

  CLK4: GenClock
    -- 4 second    
    generic map ( time_period => 4 )
    -- component_name => entity_name ( clk => clk , Clock => CLK_4 );
    port map ( clk => clk, Clock => CLK_4 );



process ( current_state, pb )
	begin

	-- set default clock to 4 seconds
	CLK_INT <= CLK_4;

	case current_state is
	
	when 0 to 6 =>
		next_state <= current_state + 1;
		Ga <= 1;
		nowalk <= 1;
		walk <= 0;
	when 7 =>
		Ga <= 1;
		nowalk <= 1;
		walk <= 0;
		if ( PB ) then 
			next_state <= current_state + 1;

		elsif ( not PB ) then
			next_state <= current_state;
		end if;
	when 8 => -- Yellow light is on, but not walk yet.
		next_state <= current_state + 1;
		Ya <= 1;
		Ga <= 0;
		nowalk <= 1;
		walk <= 0;
	when 9 => -- light is red, ped can walk
		next_state <= current_state + 1;
		Ya <= 0;
		Ra <= 1;
		Ga <= 0;
		walk <= 1;
		nowalk <= 0;
		CLK_INT <= CLK_1;
		counter2 <= 1; -- default val 0 -> 1 indicates 1 sec clk period
	when 10 to 12 =>
		next_state <= current_state + 1;
		Ya <= 0;
		Ra <= 1;
		Ga <= 0;
		nowalk = 0;
		walk = 1;
	when 13 =>
		next_state <= 0;
		Ra <= 0;
		Ya <= 0;
		Ga <= 1;
		nowalk <= 1;
		walk <= 0;

	when others => -- can't happen --
		NULL;

	end case;
	
	
end process;

process ( CLK_INT )

	begin
	if ( CLK_INT'EVENT and CLK = '1' )
		if(counter2=0) then
			current_state <= next_state;
		elsif(counter2=4) then
			-- reset counter2
			counter2 <= 0;
			CLK_INT <= CLK_4;
		else	-- between 1 and 4 
			-- toggle WALK (flash)
			WALK <= not walk;-- not walk
		end if;

	end if;
end process;