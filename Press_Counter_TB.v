`timescale 1ns/1ps

module Press_Counter_TB;
  reg CLK = 0;
  reg i_Up_Button_Raw = 0;
  reg i_Down_Button_Raw = 0;
  wire o_LED_0;
  wire o_LED_1;
  wire o_LED_2;
  wire o_LED_3;
  
  Press_Counter uut(
    .CLK(CLK),
	.i_Up_Button_Raw(i_Up_Button_Raw),
	.i_Down_Button_Raw(i_Down_Button_Raw),
	.o_LED_0(o_LED_0),
	.o_LED_1(o_LED_1),
	.o_LED_2(o_LED_2),
	.o_LED_3(o_LED_3)
);

  always #5 CLK = ~CLK;
  
  initial begin
    #10;
	i_Up_Button_Raw = 1; #50;
	i_Up_Button_Raw = 0; #50;
	i_Down_Button_Raw = 1; #50;
	i_Down_Button_Raw = 0; #50;
	$finish;
  end

endmodule
