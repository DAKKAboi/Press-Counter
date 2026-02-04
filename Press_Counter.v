module Press_Counter(
  input CLK,
  input i_Up_Button_Raw,
  input i_Down_Button_Raw,
  output o_LED_0,
  output o_LED_1,
  output o_LED_2,
  output o_LED_3
);

  reg [3:0] counter = 0;
  wire Up_Button_State;
  wire Down_Button_State;
  reg Up_Button_Last = 0;
  reg Down_Button_Last = 0;
  reg Up_Event = 0;
  reg Down_Event = 0;
  
  Button_Debounce Up_Button(
    .CLK(CLK),
	.i_Button_Raw(i_Up_Button_Raw),
	.o_Button_State(Up_Button_State)
  );
  
  Button_Debounce Down_Button(
    .CLK(CLK),
	.i_Button_Raw(i_Down_Button_Raw),
	.o_Button_State(Down_Button_State)
  );
  
  always @(posedge CLK) begin
    if ((Up_Button_State != Up_Button_Last)&&Up_Button_State)
	  Up_Event <= 1;
	else
	  Up_Event <= 0;
	  
	Up_Button_Last <= Up_Button_State;
  end
  
  always @(posedge CLK) begin
    if ((Down_Button_State != Down_Button_Last)&&Down_Button_State)
	  Down_Event <= 1;
	else
	  Down_Event <= 0;
	  
	Down_Button_Last <= Down_Button_State;
  end
  
  always @(posedge CLK) begin
    case({Up_Event, Down_Event})
	  2'b01   : counter <= counter - 1;
	  2'b10   : counter <= counter + 1;
	  default : counter <= counter;
	endcase
  end
  
  assign o_LED_0 = counter[0];
  assign o_LED_1 = counter[1];
  assign o_LED_2 = counter[2];
  assign o_LED_3 = counter[3];
endmodule