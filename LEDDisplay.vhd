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

entity LEDDisplay is
  port (   Ga, Ya, Ra, WALK, NOWALK	: 	in std_logic;  -- Inputs		
	   counter:	in std_logic_vector(2 downto 0);
        segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g :	out std_logic);
end LEDDisplay;

architecture Behav of LEDDisplay is

component dec_7seg 
	port (hex_digit:	in std_logic_vector (3 downto 0);
		 segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g:	out std_logic);
end component;

signal segment_a1, segment_a2, segment_b1, segment_b2, segment_c1, segment_c2, 
       segment_d1, segment_d2, segment_e1, segment_e2, segment_f1, segment_f2, segment_g1, segment_g2: std_logic;
signal hex_digit1:	std_logic_vector (3 downto 0);
signal hex_digit2: std_logic_vector (3 downto 0);

begin
process (_______________)	-- Fill in the sensitivity list
begin
	if (WALK='1' and NOWALK='0') then
		hex_digit1 <= "0000";
	elsif (WALK='0' and NOWALK='1') then
		hex_digit1 <= "0010";
	else 
		hex_digit1 <= "0010";
	end if;
end process;

process (______________)	-- Fill in the sensitivity list
begin
	if (Ga='1' and Ya='0' and Ra='0') then
		hex_digit2 <= "0010";
	elsif (Ga='0' and Ya='1' and Ra='0') then
		hex_digit2 <= "0000";
	elsif (Ga='0' and Ya='0' and Ra='1') then
		hex_digit2 <= "0001";
	else
		hex_digit2 <= "0010";
	end if;		
end process;

process (counter, segment_a1,segment_b1,segment_c1,segment_d1,segment_e1,segment_f1,segment_g1,segment_a2,segment_b2,segment_c2,segment_d2,segment_e2,segment_f2,segment_g2)
begin
	case counter is
--	when "1110" =>
	when "000" =>
		segment_a <= segment_a1;
		segment_b <= segment_b1;
		segment_c <= segment_c1;
		segment_d <= segment_d1;
		segment_e <= segment_e1;
		segment_f <= segment_f1;
		segment_g <= segment_g1;
--	when "1101" =>
	when "010" =>
		segment_a <= segment_a2;
		segment_b <= segment_b2;
		segment_c <= segment_c2;
		segment_d <= segment_d2;
		segment_e <= segment_e2;
		segment_f <= segment_f2;
		segment_g <= segment_g2;
--	when "1011" =>
	when "100" =>
		segment_a <= '1';
		segment_b <= '1';
		segment_c <= '1';
		segment_d <= '1';
		segment_e <= '1';
		segment_f <= '1';
		segment_g <= '1';
--	when "0111" =>
	when "110" =>
		segment_a <= '1';
		segment_b <= '1';
		segment_c <= '1';
		segment_d <= '1';
		segment_e <= '1';
		segment_f <= '1';
		segment_g <= '1';
	when others =>
		segment_a <= '1';
		segment_b <= '1';
		segment_c <= '1';
		segment_d <= '1';
		segment_e <= '1';
		segment_f <= '1';
		segment_g <= '1';
	end case;
end process;

LED_Display1: 	dec_7seg  port map (hex_digit1, segment_a1, segment_b1, segment_c1, segment_d1, segment_e1, segment_f1, segment_g1);
LED_Display2: 	dec_7seg  port map (hex_digit2, segment_a2, segment_b2, segment_c2, segment_d2, segment_e2, segment_f2, segment_g2);

end Behav;
