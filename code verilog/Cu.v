`include "constants.vh"

module ControlUnit(
    input clk,
    input reset,
    input [`DATA_WIDTH-1:0] ir,
    input [`ADDR_WIDTH-1:0] pc_in,
    input zero_flag,
    input sign_flag,
    input e_flag,
    input input_flag,
    input output_flag,
    input interrupt_flag,
    output reg pc_load,
    output reg pc_inc,
    output reg ir_load,
    output reg ac_load,
    output reg dr_load,
    output reg e_load,
    output reg mem_read,
    output reg mem_write,
    output reg [2:0] alu_op,
    output reg io_read,
    output reg io_write,
    output reg [`ADDR_WIDTH-1:0] address_bus,
    output reg interrupt_enable,
    output reg halt
);
    reg [3:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            pc_load <= 0;
            pc_inc <= 0;
            ir_load <= 0;
            ac_load <= 0;
            dr_load <= 0;
            e_load <= 0;
            mem_read <= 0;
            mem_write <= 0;
            io_read <= 0;
            io_write <= 0;
            alu_op <= `ALU_ADD;
            address_bus <= {`ADDR_WIDTH{1'b0}};
            interrupt_enable <= 0;
            halt <= 0;
        end
        else if (!halt) begin
            // Default control signals
            pc_load <= 0;
            pc_inc <= 0;
            ir_load <= 0;
            ac_load <= 0;
            dr_load <= 0;
            e_load <= 0;
            mem_read <= 0;
            mem_write <= 0;
            io_read <= 0;
            io_write <= 0;
            
            case(state)
                4'b0000: begin // Fetch instruction
                    if (interrupt_flag && interrupt_enable) begin
                        mem_write <= 1;
                        address_bus <= `MEM_SIZE-1; // Interrupt vector
                        state <= 4'b1000;
                    end
                    else begin
                        mem_read <= 1;
                        address_bus <= pc_in;
                        state <= 4'b0001;
                    end
                end
                
                // ... (rest of control unit logic as before)
                
                default: state <= 4'b0000;
            endcase
        end
    end
endmodule