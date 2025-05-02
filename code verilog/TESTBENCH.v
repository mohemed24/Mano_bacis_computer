`timescale 1ns/1ps
`include "constants.vh"

module MANO_Computer_TB;

    // Clock and reset
    reg clk;
    reg reset;
    
    // I/O signals
    reg ps2_clk;
    reg ps2_data;
    wire [7:0] segment;
    wire [3:0] digit_select;
    reg [15:0] input_data;
    wire [15:0] output_data;
    
    // Testbench monitoring signals
    wire [11:0] tb_pc_out;
    wire [15:0] tb_ir_out;
    wire [15:0] tb_ac_out;
    wire [15:0] tb_dr_out;
    wire tb_e_out;
    wire [15:0] tb_mem_data_out;
    wire tb_keyboard_data_ready;
    wire tb_keyboard_interrupt;
    
    // Instantiate the MANO Computer
    MANO_Computer dut (
        .clk(clk),
        .reset(reset),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .segment(segment),
        .digit_select(digit_select),
        .input_data(input_data),
        .output_data(output_data),
        .tb_pc_out(tb_pc_out),
        .tb_ir_out(tb_ir_out),
        .tb_ac_out(tb_ac_out),
        .tb_dr_out(tb_dr_out),
        .tb_e_out(tb_e_out),
        .tb_mem_data_out(tb_mem_data_out),
        .tb_keyboard_data_ready(tb_keyboard_data_ready),
        .tb_keyboard_interrupt(tb_keyboard_interrupt)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Reset generation
    initial begin
        reset = 1;
        #20 reset = 0;
    end
    
    // Test sequence
    initial begin
        // Initialize inputs
        ps2_clk = 1;
        ps2_data = 1;
        input_data = 16'h0000;
        
        // Wait for reset to complete
        #30;
        
        // Test 1: Verify basic instruction fetch and PC increment
        $display("Test 1: Instruction Fetch and PC Increment");
        monitor_state();
        #10;
        
        // Test 2: Load a simple program into memory
        $display("\nTest 2: Loading Test Program into Memory");
        load_program();
        #10;
        
        // Test 3: Execute AND instruction
        $display("\nTest 3: AND Instruction");
        execute_and_test();
        #10;
        
        // Test 4: Execute ADD instruction
        $display("\nTest 4: ADD Instruction");
        execute_add_test();
        #10;
        
        // Test 5: Test LDA and STA instructions
        $display("\nTest 5: LDA and STA Instructions");
        execute_lda_sta_test();
        #10;
        
        // Test 6: Test BUN instruction
        $display("\nTest 6: BUN Instruction");
        execute_bun_test();
        #10;
        
        // Test 7: Test Register Reference Instructions
        $display("\nTest 7: Register Reference Instructions");
        execute_register_ref_test();
        #10;
        
        // Test 8: Test I/O Instructions
        $display("\nTest 8: I/O Instructions");
        execute_io_test();
        #10;
        
        // End simulation
        $display("\nAll tests completed");
        $finish;
    end
    
    // Task to monitor current state
    task monitor_state;
        begin
            $display("Time=%0t: PC=%h, IR=%h, AC=%h, DR=%h, E=%b", 
                     $time, tb_pc_out, tb_ir_out, tb_ac_out, tb_dr_out, tb_e_out);
        end
    endtask
    
    // Task to load a test program into memory
    task load_program;
        begin
            // This would normally be done through a memory initialization file
            // For simulation, we'll directly write to memory
            $display("Loading test program into memory...");
            
            // Program 1: Simple arithmetic
            write_mem(12'h000, 16'h2001); // LDA 001
            write_mem(12'h001, 16'h0005); // Data: 5
            write_mem(12'h002, 16'h1002); // ADD 002
            write_mem(12'h003, 16'h0003); // Data: 3
            write_mem(12'h004, 16'h0003); // AND 003
            write_mem(12'h005, 16'h00FF); // Data: FF
            write_mem(12'h006, 16'h3004); // STA 004
            write_mem(12'h007, 16'h0000); // Data location
            
            // Program 2: Branching
            write_mem(12'h010, 16'h2005); // LDA 005
            write_mem(12'h011, 16'h0001); // Data: 1
            write_mem(12'h012, 16'h4015); // BUN 015
            write_mem(12'h013, 16'h2006); // LDA 006 (should be skipped)
            write_mem(12'h014, 16'hFFFF); // Data: FFFF
            write_mem(12'h015, 16'h7001); // HLT
            
            // Register reference instructions
            write_mem(12'h020, 16'h7800); // CLA
            write_mem(12'h021, 16'h7400); // CLE
            write_mem(12'h022, 16'h7200); // CMA
            write_mem(12'h023, 16'h7100); // CME
            write_mem(12'h024, 16'h7080); // CIR
            write_mem(12'h025, 16'h7040); // CIL
            write_mem(12'h026, 16'h7020); // INC
            write_mem(12'h027, 16'h7001); // HLT
            
            // I/O instructions
            write_mem(12'h030, 16'hF800); // INP
            write_mem(12'h031, 16'hF400); // OUT
            write_mem(12'h032, 16'hF200); // SKI
            write_mem(12'h033, 16'hF100); // SKO
            write_mem(12'h034, 16'hF080); // ION
            write_mem(12'h035, 16'hF040); // IOF
            write_mem(12'h036, 16'h7001); // HLT
            
            $display("Test program loaded");
        end
    endtask
    
    // Helper task to write to memory
    task write_mem;
        input [11:0] addr;
        input [15:0] data;
        begin
            dut.memory.mem[addr] = data;
        end
    endtask
    
    // Test AND instruction
    task execute_and_test;
        begin
            $display("Executing AND test...");
            
            // Initialize AC with A5A5
            write_mem(12'h100, 16'h2001); // LDA 101
            write_mem(12'h101, 16'hA5A5); // Data: A5A5
            write_mem(12'h102, 16'h0002); // AND 102
            write_mem(12'h103, 16'h00FF); // Data: 00FF
            write_mem(12'h104, 16'h7001); // HLT
            
            // Set PC to start of test
            dut.pc.out = 12'h100;
            #100;
            
            // Verify results
            if (tb_ac_out !== 16'h00A5) begin
                $display("ERROR: AND test failed. Expected AC=00A5, got AC=%h", tb_ac_out);
            end else begin
                $display("AND test passed");
            end
        end
    endtask
    
    // Test ADD instruction
    task execute_add_test;
        begin
            $display("Executing ADD test...");
            
            // Initialize test
            write_mem(12'h110, 16'h2001); // LDA 111
            write_mem(12'h111, 16'h0005); // Data: 5
            write_mem(12'h112, 16'h1002); // ADD 112
            write_mem(12'h113, 16'h0003); // Data: 3
            write_mem(12'h114, 16'h7001); // HLT
            
            // Set PC to start of test
            dut.pc.out = 12'h110;
            #150;
            
            // Verify results
            if (tb_ac_out !== 16'h0008) begin
                $display("ERROR: ADD test failed. Expected AC=0008, got AC=%h", tb_ac_out);
            end else begin
                $display("ADD test passed");
            end
        end
    endtask
    
    // Test LDA and STA instructions
    task execute_lda_sta_test;
        begin
            $display("Executing LDA/STA test...");
            
            // Initialize test
            write_mem(12'h120, 16'h2001); // LDA 121
            write_mem(12'h121, 16'h1234); // Data: 1234
            write_mem(12'h122, 16'h3002); // STA 122
            write_mem(12'h123, 16'h0000); // Data location
            write_mem(12'h124, 16'h2002); // LDA 122 (should get 1234)
            write_mem(12'h125, 16'h7001); // HLT
            
            // Set PC to start of test
            dut.pc.out = 12'h120;
            #200;
            
            // Verify results
            if (tb_ac_out !== 16'h1234) begin
                $display("ERROR: LDA/STA test failed. Expected AC=1234, got AC=%h", tb_ac_out);
            end else begin
                $display("LDA/STA test passed");
            end
        end
    endtask
    
    // Test BUN instruction
    task execute_bun_test;
        begin
            $display("Executing BUN test...");
            
            // Initialize test
            write_mem(12'h130, 16'h4012); // BUN 132 (skip next instruction)
            write_mem(12'h131, 16'h2001); // LDA 131 (should be skipped)
            write_mem(12'h132, 16'h7800); // CLA
            write_mem(12'h133, 16'h7001); // HLT
            
            // Set PC to start of test
            dut.pc.out = 12'h130;
            #100;
            
            // Verify results
            if (tb_pc_out !== 12'h132 || tb_ac_out !== 16'h0000) begin
                $display("ERROR: BUN test failed. PC=%h, AC=%h", tb_pc_out, tb_ac_out);
            end else begin
                $display("BUN test passed");
            end
        end
    endtask
    
    // Test Register Reference instructions
    task execute_register_ref_test;
        begin
            $display("Executing Register Reference tests...");
            
            // Initialize test
            write_mem(12'h140, 16'h2001); // LDA 141
            write_mem(12'h141, 16'hA5A5); // Data: A5A5
            write_mem(12'h142, 16'h7200); // CMA
            write_mem(12'h143, 16'h7080); // CIR
            write_mem(12'h144, 16'h7040); // CIL
            write_mem(12'h145, 16'h7020); // INC
            write_mem(12'h146, 16'h7800); // CLA
            write_mem(12'h147, 16'h7001); // HLT
            
            // Set PC to start of test
            dut.pc.out = 12'h140;
            #350;
            
            // Verify results
            if (tb_ac_out !== 16'h0000) begin
                $display("ERROR: Register Reference test failed. AC=%h", tb_ac_out);
            end else begin
                $display("Register Reference tests passed");
            end
        end
    endtask
    
    // Test I/O instructions
    task execute_io_test;
        begin
            $display("Executing I/O tests...");
            
            // Initialize test
            write_mem(12'h150, 16'hF800); // INP
            write_mem(12'h151, 16'hF400); // OUT
            write_mem(12'h152, 16'hF200); // SKI
            write_mem(12'h153, 16'hF100); // SKO
            write_mem(12'h154, 16'hF080); // ION
            write_mem(12'h155, 16'hF040); // IOF
            write_mem(12'h156, 16'h7001); // HLT
            
            // Simulate input data
            input_data = 16'h55AA;
            
            // Set PC to start of test
            dut.pc.out = 12'h150;
            #300;
            
            // Verify results
            if (output_data !== 16'h55AA) begin
                $display("ERROR: I/O test failed. Output data=%h", output_data);
            end else begin
                $display("I/O tests passed");
            end
        end
    endtask
    
    // Monitor for simulation
    always @(posedge clk) begin
        $display("CLK: PC=%h, IR=%h, AC=%h", tb_pc_out, tb_ir_out, tb_ac_out);
    end
    
endmodule