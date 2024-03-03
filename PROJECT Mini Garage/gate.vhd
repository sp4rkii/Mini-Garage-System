library ieee;
use ieee.std_logic_1164.all;

ENTITY gate IS
    PORT(
        clk, test1, test2: in std_logic;
        pwm1, pwm2: out std_logic
    );
END gate;

ARCHITECTURE main OF gate IS
    constant clk_hz : real := 10.0e6; -- Lattice iCEstick clock
    constant pulse_hz : real := 50.0;
    constant min_pulse_us : real := 500.0; -- TowerPro SG90 values
    constant max_pulse_us : real := 2500.0; -- TowerPro SG90 values
    constant step_bits : positive := 8; -- 0 to 255
    constant step_count : positive := 2**step_bits;

    signal position1 : integer range 0 to step_count - 1;
    signal position2 : integer range 0 to step_count - 1;

BEGIN
    position1 <= 0 when test1 = '0' else 127;
    position2 <= 0 when test2 = '0' else 127;

    -- Servo Motor 1
    SERVO1 : entity work.servo(rtl)
        generic map (
            clk_hz => clk_hz,
            pulse_hz => pulse_hz,
            min_pulse_us => min_pulse_us,
            max_pulse_us => max_pulse_us,
            step_count => step_count
        )
        port map (
            clk => clk,
            rst => '0',
            position => position1,
            pwm => pwm1
        );

    -- Servo Motor 2
    SERVO2 : entity work.servo(rtl)
        generic map (
            clk_hz => clk_hz,
            pulse_hz => pulse_hz,
            min_pulse_us => min_pulse_us,
            max_pulse_us => max_pulse_us,
            step_count => step_count
        )
        port map (
            clk => clk,
            rst => '0',
            position => position2,
            pwm => pwm2
        );

END main;
