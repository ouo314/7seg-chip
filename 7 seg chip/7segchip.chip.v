// Wokwi Custom Chip - For docs and examples see:
// https://docs.wokwi.com/chips-api/getting-started
//
// SPDX-License-Identifier: MIT
// Copyright 2023 chen ken


module decoder(
  input wire [3:0] result,
  output wire [6:0] seg // if set seg as reg sometimes it won't work
);
  always @(*)
  begin
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
endmodule

module wokwi (
  input wire a0, a1, a2, b0, b1, b2,
  input wire show, sw,
  output wire a, b, c, d, e, f, g, dp,
  output wire al, bl, cl, dl, el, fl, gl, dpl
);

  wire [6:0] result;
  wire [3:0] tens, ones;
  wire [6:0] dh_,dl_; // can't be dh,dl maybe these names are special?

  always@(*)
  begin
    if (show == 1'b0) begin
      tens = {a2,a1,a0};
      ones = {b2,b1,b0};
    end
    else begin
      case(sw)
        1'b0: result = {a2,a1,a0} + {b2,b1,b0};
        1'b1: result = {a2,a1,a0} * {b2,b1,b0};
      endcase
      tens = result / 10;
      ones = result % 10;
    end
  end

  decoder decoder_tens(
    .result(tens),
    .seg(dh_)
  );

  decoder decoder_ones(
    .result(ones),
    .seg(dl_)
  );

  assign {a,b,c,d,e,f,g} = dh_;
  assign {al,bl,cl,dl,el,fl,gl} = dl_;
  assign dp = 0;
  assign dpl = 0;

endmodule