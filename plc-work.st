PROGRAM program0
  VAR
    pump1_start AT %QX0.0 : BOOL := TRUE;
    pump1_work AT %IX0.0 : BOOL := FALSE;
    pump1_speed_in AT %QW10 : INT := 50;
    pump1_speed_out AT %IW10 : INT := 50;
    pump1_temp AT %IW11 : INT := 0;
    pump1_pressure AT %IW12 : INT := 0;
    pump1_valve1 AT %IX0.1 : BOOL := FALSE;
    pump1_valve2 AT %IX0.2 : BOOL := FALSE;
    pump1_valve3 AT %IX0.3 : BOOL := FALSE;
    pump2_start AT %QX1.0 : BOOL := FALSE;
    pump2_work AT %IX1.0 : BOOL := FALSE;
    pump2_speed_in AT %QW20 : INT := 50;
    pump2_speed_out AT %IW20 : INT := 50;
    pump2_temp AT %IW21 : INT := 0;
    pump2_pressure AT %IW22 : INT := 0;
    pump2_valve1 AT %IX1.1 : BOOL := FALSE;
    pump2_valve2 AT %IX1.2 : BOOL := FALSE;
    pump2_valve3 AT %IX1.3 : BOOL := FALSE;
    pressure_in AT %IW1 : INT := 2758;
    pressure_out AT %IW2 : INT := 6205;
  END_VAR
  VAR
    pressure_in_norm : INT := 2758;
    pressure_out_norm : INT := 6205;
  END_VAR
  VAR
    flow_rate_in AT %IW3 : INT := 4;
    flow_rate_out AT %IW4 : INT := 4;
    temp_in AT %IW5 : INT := 15;
    temp_out AT %IW6 : INT := 15;
  END_VAR

  pressure_in := pressure_in_norm;
  flow_rate_in := 4;
  flow_rate_out := 4;

  IF pump1_start = TRUE THEN
      pump1_work := TRUE;
      pump1_valve1 := TRUE;
      pump1_valve2 := TRUE;
      pump1_valve3 := FALSE;
      pump1_speed_out := pump1_speed_in;
      pump1_temp := temp_in + 1;
      pump1_pressure := pressure_in + 21 * pump1_speed_in;
      pressure_in := pressure_in - 21 * pump1_speed_in;
      flow_rate_in := flow_rate_in + 15;
      flow_rate_out := flow_rate_out + 15;
  ELSE
      pump1_work := FALSE;
      pump1_valve1 := FALSE;
      pump1_valve2 := FALSE;
      pump1_valve3 := TRUE;
      pump1_speed_out := 0;
      pump1_pressure := pressure_in_norm;
      pump1_temp := temp_in;
  END_IF;

  IF pump2_start = TRUE THEN
      pump2_work := TRUE;
      pump2_valve1 := TRUE;
      pump2_valve2 := TRUE;
      pump2_valve3 := FALSE;
      pump2_speed_out := pump1_speed_in;
      pump2_temp := pump1_temp + 1;
      pump2_pressure := pump1_pressure + 21 * pump2_speed_in;
      pressure_in := pressure_in - 21 * pump2_speed_in;
      flow_rate_in := flow_rate_in + 15;
      flow_rate_out := flow_rate_out + 15;
  ELSE
      pump2_work := FALSE;
      pump2_valve1 := FALSE;
      pump2_valve2 := FALSE;
      pump2_valve3 := TRUE;
      pump2_speed_out := 0;
      pump2_pressure:= pump1_pressure;
      pump2_temp := pump1_temp;
  END_IF;


  pressure_out := pump2_pressure - 50;
  temp_out := pump2_temp;
  flow_rate_out := flow_rate_in;
END_PROGRAM