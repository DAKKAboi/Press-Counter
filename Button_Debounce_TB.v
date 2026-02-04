`timescale 1ns/1ps

module Button_Debounce_TB;
  reg CLK = 0;
  reg i_Button_Raw=0;
  wire o_Button_State;
  
  Button_Debounce uut(
    .CLK(CLK),
	.i_Button_Raw(i_Button_Raw),
	.o_Button_State(o_Button_State)
);

  always #5 CLK = ~CLK;
  
  initial begin
    #80;
	i_Button_Raw = 1; #70;
    i_Button_Raw = 0; #15;
	i_Button_Raw = 1; #20;
	i_Button_Raw = 0; #60;
	i_Button_Raw = 1; #80;
	$finish;
  end

endmodule
