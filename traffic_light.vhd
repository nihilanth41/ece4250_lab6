library ieee;
use ieee.std_logic_1164.all;

entity traffic_light is
  port(clk, pb : in std_logic;
       ga, ya, ra, walk, nowalk : out std_logic);
end traffic_light;

architecture traffic_light_arch of traffic_light is

  -- component declaration
  component GenClock
    generic(time_period : integer range 1 to 4);
    port(clk : in std_logic := '1';
         Clock : out std_logic := '1');
  end component;

begin

  -- component instatiation
  CLK1: GenClock
    -- 1 second
    generic map(time_period => 2)
    -- port map(clk => clk,
   
