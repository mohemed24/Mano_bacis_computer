`include "constants.vh"

module InstructionRegister(
    input clk,
    input load,
    input [`DATA_WIDTH-1:0] in,
    output reg [`DATA_WIDTH-1:0] out
);
    always @(posedge clk) begin
        if (load)
            out <= in;
    end
endmodule