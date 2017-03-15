---------------------------------------------------------------------------------
----  ECE 7250/4250 Lab
----  Digital Systems Design - VHDL and Programmable Logic Devices 
----  Instructor: Dr.Harry Tyrer & Fadi Muheidat
----  T.A.: Sruthikesh Surineni
---------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Lab6Bench is
  port (   Sb	: 	in std_logic;  -- Inputs
	   clk	:	in std_logic;
	   AN0, AN1, AN2, AN3	:	out std_logic;
        segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g, segment_dp :	out std_logic);
end Lab6Bench;

architecture Behavioral of Lab6Bench is

component AnodeControl 
port (clk	: in std_logic;  
  	   counter_out	:	out std_logic_vector (2 downto 0);
	   Anode	:	out std_logic_vector (3 downto 0));
end component;

component traffic_light is
	PORT (clk, PB:	in std_logic;
		Ga, Ya, Ra, WALK, NOWALK:	out std_logic);
END component;

component LEDDisplay is
  port (   Ga, Ya, Ra, WALK, NOWALK	: 	in std_logic;  -- Inputs
    	   counter:	in std_logic_vector (2 downto 0);
        segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g:	out std_logic);
end component;

signal counter:	std_logic_vector (2 downto 0);
signal Anode:	std_logic_vector (3 downto 0);
signal PB, Ga, Ya, Ra, WALK, NOWALK: std_logic;

begin

AN0 <= Anode(0);
AN1 <= Anode(1);
AN2 <= Anode(2);
AN3 <= Anode(3);

segment_dp <= '1';

TrafficLight:	traffic_light port map (_________________________________);	--clk is 50 MHz
LEDDisplay0: 	LEDDisplay  port map (___________________________________________________________);
ANDisplay:	AnodeControl port map (____________________________);

end Behavioral;
