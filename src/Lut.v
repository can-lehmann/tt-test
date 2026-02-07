// Copyright (c) 2026 Can Joshua Lehmann

module Lut #(
  parameter INPUTS = 2
) (
  input clock,
  input rst_n,
  input wire [INPUTS-1:0] in,
  input wire [(1 << INPUTS + 1)-1:0] conf,
  output wire out
);

  wire lut = in[0] & in[1] ? conf[3] :
             in[0] & ~in[1] ? conf[2] :
             ~in[0] & in[1] ? conf[1] :
             conf[0];

  reg register;

  always @(posedge clock)
    if (!rst_n)
      register <= 0;
    else
      register <= lut;
  
  assign out = conf[1 << INPUTS] ? register : lut;
endmodule
