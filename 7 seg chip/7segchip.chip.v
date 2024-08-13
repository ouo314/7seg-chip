// Wokwi Custom Chip - For docs and examples see:
// https://docs.wokwi.com/chips-api/getting-started
//
// SPDX-License-Identifier: MIT
// Copyright 2023 chen ken

// Input / output names must match the pins defined in the chip's JSON file:
module wokwi (
  input wire a0,a1,a2,b0,b1,b2,
  output wire a,b,c,d,e,f,g,dp
  );

  reg [6:0] dout;
  reg [2:0] sum;


  always@(*)
  begin
    assign sum = {a2,a1,a0} + {b2,b1,b0};
    case(sum)
      3'b000: dout = 7'h01;
      3'b001: dout = 7'h4F;
      3'b010: dout = 7'h12;
      3'b011: dout = 7'h06;
      3'b100: dout = 7'h4C;
      3'b101: dout = 7'h24;
      3'b110: dout = 7'h60;
      3'b111: dout = 7'h0F;
    endcase
    assign {a,b,c,d,e,f,g} = dout;
    assign dp =0;
  end


endmodule