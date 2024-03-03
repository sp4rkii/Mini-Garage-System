library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sensor is
    Port ( clk : in STD_LOGIC;
           ir_sensor : in STD_LOGIC;
           ir_sensor2: in STD_LOGIC;
			  control1,control2:In Std_Logic;
           reset : in STD_LOGIC;
			  counter : In STD_LOGIC_VECTOR(7 downto 0);
           sum : out STD_LOGIC_VECTOR(7 downto 0)
			  );
			  
end sensor;

architecture Behavioral of sensor is
     signal prev_counter : STD_LOGIC_VECTOR(7 downto 0):=counter ;
      signal clk_counter : unsigned(9 downto 0) := (others => '0');
		signal counter_value :  STD_LOGIC_VECTOR(7 downto 0):=counter;
      constant target_count : unsigned(9 downto 0) := "1000000000";
      signal flag:std_logic:='0';
		signal flag2:std_logic:='0';
		signal s1:std_logic;
		signal s2:std_logic;
begin
    process(clk, reset)
    begin
		if reset = '1' then
            counter_value <= "00000000";
                flag <= '0';
        elsif rising_edge(clk) then
            clk_counter<=clk_counter+'1';
          if clk_counter = target_count then
                   if (ir_sensor = '1' and  flag ='0' and control1='1') then
                   flag<='1';
            end if;
            if (ir_sensor = '0' and flag ='1'and control1='1') then
                    if counter_value < 15 and control1='1'then
                counter_value <= counter_value + 1;
                     end if;
                flag<='0';
            end if;
				
                clk_counter <= (others => '0');
				if (ir_sensor2 = '1' and  flag2 ='0'and control2='1') then
                   flag2<='1';
            end if;
            if (ir_sensor2 = '0' and flag2 ='1'and control2='1') then
                    if counter_value >0 and control2='1'then
                counter_value <= counter_value - 1;
              end if;
                flag2<='0';
            end if;
					 
            end if;
        end if;
			
     end process;
	 sum <= counter_value + "00000110" WHEN (counter_value(3 downto 0) > 9) ELSE "00000000" + counter_value;



end Behavioral;