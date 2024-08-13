// Wokwi Custom Chip - For docs and examples see:
// https://docs.wokwi.com/chips-api/getting-started
//
// SPDX-License-Identifier: MIT
// Copyright 2023 chen ken


module decoder(
  input wire [3:0] sum,
  output reg [6:0] seg
);
  always @(*)
  begin
    case(sum)
      4'd0: seg = 7'h01; 
      4'd1: seg = 7'h4F;  
      4'd2: seg = 7'h12;  
      4'd3: seg = 7'h06;  
      4'd4: seg = 7'h4C;  
      4'd5: seg = 7'h24; 
      4'd6: seg = 7'h60;  
      4'd7: seg = 7'h0F;  
      4'd8: seg = 7'h00;  
      4'd9: seg = 7'h0C; 
      default: seg = 7'b1111111; 
    endcase
  end
endmodule

module wokwi (
  input wire a0, a1, a2, b0, b1, b2,
  output wire a, b, c, d, e, f, g, dp,
  output wire al, bl, cl, dl, el, fl, gl, dpl
);

  wire [5:0] sum;
  wire [3:0] tens, ones;
  wire [6:0] dh, dl;

  assign sum = {a2,a1,a0} + {b2,b1,b0};


  assign tens = sum / 10;
  assign ones = sum % 10;


  decoder decoder_tens(
    .sum(tens),
    .seg(dh)
  );

  decoder decoder_ones(
    .sum(ones),
    .seg(dl)
  );

  assign {a,b,c,d,e,f,g} = dh;
  assign {al,bl,cl,dl,el,fl,gl} = dl;
  assign dp = 0;
  assign dpl = 0;

endmodule