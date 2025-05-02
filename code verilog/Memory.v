`include "constants.vh"

module Memory(
    input clk,
    input read,
    input write,
    input [`ADDR_WIDTH-1:0] address,
    input [`DATA_WIDTH-1:0] data_in,
    output reg [`DATA_WIDTH-1:0] data_out
);
    reg [`DATA_WIDTH-1:0] mem [0:`MEM_SIZE-1];
    
    initial begin
        for (integer i = 0; i < `MEM_SIZE; i = i + 1)
            mem[i] = {`DATA_WIDTH{1'b0}};
    end
    
    always @(posedge clk) begin
        if (write)
            mem[address] <= data_in;
        if (read)
            data_out <= mem[address];
    end
endmodule