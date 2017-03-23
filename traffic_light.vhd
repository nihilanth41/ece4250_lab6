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

  signal CLK_1, CLK_4, CLK_INT : std_logic := '0';
  signal state, next_state : integer range 0 to 13; -- assumes 0 from lower range bound
  signal count : integer := 0 ;

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

  process (state, pb)
  begin
    -- initialize default values
    ga <= '0';
    ya <= '0';
    ra <= '0';
    walk <= '0';
    nowalk <='0';
    -- set default clock to 4 seconds
    CLK_INT <= CLK_4;

    case state is
      when 0 to 6 =>
        next_state <= state + 1;
        ga <= '1';
        nowalk <= '1';
      when 7 =>
        ga <= '1';
        nowalk <= '1';
        if (PB='1') then 
          next_state <= state + 1;
        elsif (PB='0') then
          next_state <= state;
        end if;
      when 8 => -- Yellow light is on, but not walk yet.
        next_state <= state + 1;
        Ya <= '1';
        nowalk <= '1';
      when 9 => -- light is red, ped can walk
        next_state <= state + 1;
        Ra <= '1';
        walk <= '1';
        CLK_INT <= CLK_1;
        counter2 <= 1; -- default val 0 -> 1 indicates 1 sec clk period
      when 10 to 12 =>
        next_state <= state + 1;
        Ra <= '1';
        walk = '1';
      when 13 =>
        next_state <= 0;
        Ga <= '1';
        nowalk <= '1';
      when others => NULL;
    end case;
  end process;

  process(CLK_INT)
    variable walk_tmp : std_logic := 0;
  begin
    walk_tmp := walk;
    if(CLK_INT'EVENT and CLK_INT='1') then
      if(counter2=0) then
        state <= next_state;
      elsif(counter2=4) then
        -- reset counter2
        counter2 <= 0;
        CLK_INT <= CLK_4;
      else	-- between 1 and 4 
        -- toggle WALK (flash)
        walk <= not walk_tmp;-- not walk
        counter2 <= counter2 + 1;
      end if;
    end if;
  end process;
