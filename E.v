module ExtendedAccumulator(
    input clk,
    input reset,
    input load,
    input in,
    output reg out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b0;
        else if (load)
            out <= in;
    end
endmodule