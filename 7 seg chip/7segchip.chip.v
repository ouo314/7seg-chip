// Wokwi Custom Chip - For docs and examples see:
// https://docs.wokwi.com/chips-api/getting-started
//
// SPDX-License-Identifier: MIT
// Copyright 2023 chen ken


module decoder(
  input wire [3:0] result,
  input wire show,
  output reg [6:0] seg
);
  always @(*)
  begin
    if(show) begin
      case(result)
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
    else begin
      seg = 7'b1111111;
    end
  end
endmodule

module wokwi (
  input wire a0, a1, a2, b0, b1, b2,
  input wire show,sw,
  output wire a, b, c, d, e, f, g, dp,
  output wire al, bl, cl, dl, el, fl, gl, dpl
);

  wire [5:0] result;
  wire [3:0] tens, ones;
  wire [6:0] dh, dl;

  always@(*)
  begin
    case(sw)
      1'b0: result = {a2,a1,a0} + {b2,b1,b0};
      1'b1: result = {a2,a1,a0} * {b2,b1,b0};
    endcase
  end
  assign tens = sum / 10;
  assign ones = sum % 10;


  decoder decoder_tens(
    .result(tens),
    .seg(dh),
    .show(show)
  );

  decoder decoder_ones(
    .result(ones),
    .seg(dl),
    .show(show)
  );

  assign {a,b,c,d,e,f,g} = dh;
  assign {al,bl,cl,dl,el,fl,gl} = dl;
  assign dp = 0;
  assign dpl = 0;

endmodule