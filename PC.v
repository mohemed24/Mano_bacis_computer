`include "constants.vh"

module ProgramCounter(
    input clk,
    input reset,
    input load,
    input inc,
    input [`ADDR_WIDTH-1:0] in,
    output reg [`ADDR_WIDTH-1:0] out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= {`ADDR_WIDTH{1'b0}};
        else if (load)
            out <= in;
        else if (inc)
            out <= out + 1;
    end
endmodule