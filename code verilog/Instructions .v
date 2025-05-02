// Instruction Definitions
`define AND   4'b0000
`define ADD   4'b0001
`define LDA   4'b0010
`define STA   4'b0011
`define BUN   4'b0100
`define BSA   4'b0101
`define ISZ   4'b0110

// Register Reference Instructions
`define CLA   16'h7800
`define CLE   16'h7400
`define CMA   16'h7200
`define CME   16'h7100
`define CIR   16'h7080
`define CIL   16'h7040
`define INC   16'h7020
`define SPA   16'h7010
`define SNA   16'h7008
`define SZA   16'h7004
`define SZE   16'h7002
`define HLT   16'h7001

// I/O Instructions
`define INP   16'hF800
`define OUT   16'hF400
`define SKI   16'hF200
`define SKO   16'hF100
`define ION   16'hF080
`define IOF   16'hF040

// Memory Constants
`define MEM_SIZE 4096
`define ADDR_WIDTH 12
`define DATA_WIDTH 16

// ALU Operations
`define ALU_ADD 3'b000
`define ALU_SUB 3'b001
`define ALU_AND 3'b010
`define ALU_OR  3'b011
`define ALU_XOR 3'b100
`define ALU_NOT 3'b101
`define ALU_CIR 3'b110
`define ALU_CIL 3'b111