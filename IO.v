`include "constants.vh"

module IORegister(
    input clk,
    input reset,
    input load,
    input [`DATA_WIDTH-1:0] in,
    output reg [`DATA_WIDTH-1:0] out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= {`DATA_WIDTH{1'b0}};
        else if (load)
            out <= in;
    end
endmodule