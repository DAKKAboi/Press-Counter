module Button_Debounce(
  input CLK,
  input i_Button_Raw,
  output o_Button_State
);
  reg Button_Flop_1 = 0;
  reg Button_Flop_2 = 0;
  reg [15:0] Timer = 0;
  reg Button_State = 0;
  parameter Stable_Time = 10000000;

  always @(posedge CLK) begin
    Button_Flop_1 <= i_Button_Raw;
    Button_Flop_2 <= Button_Flop_1;
  end
  
  always @(posedge CLK) begin
    if (Button_State == Button_Flop_2)
	  Timer <= 0;
	else
	  Timer <= Timer + 1;
  end
  /* what happens when B_F_2 changes as Timer hits Stable_Time? Think about tommorow, issue with assigning Timer twice in one clock?*/
  always @(posedge CLK) begin
    if (Timer == Stable_Time)
	  Button_State <= ~ Button_State;
	else
	  Button_State <= Button_State;
  end

  assign o_Button_State = Button_State;
endmodule
