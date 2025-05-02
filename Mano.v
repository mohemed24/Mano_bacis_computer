`include "constants.vh"
`include "program_counter.v"
`include "memory.v"
`include "registers/instruction_register.v"
`include "registers/accumulator.v"
`include "registers/data_register.v"
`include "registers/extended_accumulator.v"
`include "registers/io_register.v"
`include "alu.v"
`include "control_unit.v"
`include "io/keyboard_interface.v"
`include "io/display_output.v"

module MANO_Computer(
    input clk,
    input reset,
    input ps2_clk,
    input ps2_data,
    output [7:0] segment,
    output [3:0] digit_select,
    input [`DATA_WIDTH-1:0] input_data,
    output [`DATA_WIDTH-1:0] output_data,
    
    // Testbench access ports
    output [`ADDR_WIDTH-1:0] tb_pc_out,
    output [`DATA_WIDTH-1:0] tb_ir_out,
    output [`DATA_WIDTH-1:0] tb_ac_out,
    output [`DATA_WIDTH-1:0] tb_dr_out,
    output tb_e_out,
    output [`DATA_WIDTH-1:0] tb_mem_data_out,
    output tb_keyboard_data_ready,
    output tb_keyboard_interrupt
);
    // Internal wires and component instantiations
    // ... (same as original top module, but using the new modular structure)
endmodule