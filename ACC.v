`include "constants.vh"

module Accumulator(
    input clk,
    input reset,
    input load,
    input [`DATA_WIDTH-1:0] in,
    output reg [`DATA_WIDTH-1:0] out,
    output reg sign_flag
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= {`DATA_WIDTH{1'b0}};
            sign_flag <= 1'b0;
        end
        else if (load) begin
            out <= in;
            sign_flag <= in[`DATA_WIDTH-1];
        end
    end
endmodule