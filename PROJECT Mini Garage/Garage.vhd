library ieee;
use ieee.std_logic_1164.all;

entity Garage is
    Port (
        clk, enter_button, exit_button, reset, enter_sensor, exit_sensor: in std_logic;
        enter_gate, exit_gate: out std_logic;
        Hex1: out std_logic_vector(7 downto 0);
        Hex2: out std_logic_vector(7 downto 0)
    );
end Garage;

architecture arch of Garage is
    signal sum: std_logic_vector(7 downto 0) := "00000000";
    begin 
		Gate1: entity work.gate(main)
                PORT MAP (
                    clk => clk,
                    test1 => enter_button,
                    test2 => exit_button,
                    pwm1 => enter_gate,
                    pwm2 => exit_gate
                );
		sensor1: entity work.sensor(Behavioral)
                Port Map(
						  clk => clk,
                    ir_sensor => enter_sensor,
                    ir_sensor2 => exit_sensor,
						  control1=>enter_button,
						  control2=>exit_button,
                    reset => reset,
                    counter=> sum,
                    sum => sum
                );			 
		
        
        Hex1(0) <= NOT (sum(3) OR sum(1) OR (sum(0) XNOR sum(2)));
        Hex1(1) <= NOT (NOT sum(2) OR (sum(1) XNOR sum(0)));
        Hex1(2) <= NOT (sum(0) OR NOT sum(1) OR sum(2));
        Hex1(3) <= NOT (sum(3) OR (sum(1) AND NOT sum(0)) OR (NOT sum(2) AND sum(1)) OR (sum(2) AND NOT sum(1) AND sum(0)) OR (NOT sum(2) AND NOT sum(0)));
        Hex1(4) <= NOT ((NOT sum(2) AND NOT sum(0)) OR (sum(1) AND NOT sum(0)));
        Hex1(5) <= NOT (sum(3) OR (sum(2) AND NOT sum(0)) OR (sum(2) AND NOT sum(1)) OR (NOT sum(1) AND NOT sum(0)));
        Hex1(6) <= NOT (sum(3) OR (sum(2) AND NOT sum(0)) OR (sum(2) XOR sum(1)));
        Hex1(7) <= '1';
        Hex2(0) <= NOT (sum(7) OR sum(5) OR (sum(4) XNOR sum(6)));
        Hex2(1) <= NOT (NOT sum(6) OR (sum(5) XNOR sum(4)));
        Hex2(2) <= NOT (sum(4) OR NOT sum(5) OR sum(6));
        Hex2(3) <= NOT (sum(7) OR (sum(5) AND NOT sum(4)) OR (NOT sum(6) AND sum(5)) OR (sum(6) AND NOT sum(5) AND sum(4)) OR (NOT sum(6) AND NOT sum(4)));
        Hex2(4) <= NOT ((NOT sum(6) AND NOT sum(4)) OR (sum(5) AND NOT sum(4)));
        Hex2(5) <= NOT (sum(7) OR (sum(6) AND NOT sum(4)) OR (sum(6) AND NOT sum(5)) OR (NOT sum(5) AND NOT sum(4)));
        Hex2(6) <= NOT (sum(7) OR (sum(6) AND NOT sum(4)) OR (sum(6) XOR sum(5)));
        Hex2(7) <= '1';
    end arch;