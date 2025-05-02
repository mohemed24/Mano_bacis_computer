`include "constants.vh"

module ALU(
    input [`DATA_WIDTH-1:0] a,
    input [`DATA_WIDTH-1:0] b,
    input e_in,
    input [2:0] op,
    output reg [`DATA_WIDTH-1:0] out,
    output reg e_out,
    output reg zero_flag
);
    always @(*) begin
        case(op)
            `ALU_ADD: {e_out, out} = {1'b0, a} + {1'b0, b};
            `ALU_SUB: {e_out, out} = {1'b0, a} - {1'b0, b};
            `ALU_AND: begin out = a & b; e_out = e_in; end
            `ALU_OR:  begin out = a | b; e_out = e_in; end
            `ALU_XOR: begin out = a ^ b; e_out = e_in; end
            `ALU_NOT: begin out = ~a; e_out = e_in; end
            `ALU_CIR: begin out = {e_in, a[`DATA_WIDTH-1:1]}; e_out = a[0]; end
            `ALU_CIL: begin out = {a[`DATA_WIDTH-2:0], e_in}; e_out = a[`DATA_WIDTH-1]; end
            default: begin out = {`DATA_WIDTH{1'b0}}; e_out = e_in; end
        endcase
        
        zero_flag = (out == {`DATA_WIDTH{1'b0}});
    end
endmodule