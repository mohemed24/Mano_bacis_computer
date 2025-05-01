
# Mano Computer Project - 16-bit Architecture (Verilog)

## Project Description

This project is a simulation and implementation of the **Mano Computer** using **Verilog HDL**.  
The Mano Computer is a simplified educational computer architecture designed to teach the fundamentals of computer organization and instruction processing.  
The goal of this project is to build a fully functional 16-bit computer that includes a control unit, ALU, memory, registers, and a timing unit.

## Components

- Control Unit (CU)
- Arithmetic Logic Unit (ALU)
- General-purpose Registers (AC, DR, IR, TR, etc.)
- Program Counter (PC)
- Memory (RAM)
- Timing Unit
- Data Bus
- Testbenches

## Requirements

To run this project, you will need:

- **ModelSim** or any other Verilog simulator
- Basic knowledge of **Verilog HDL**
- Familiarity with the Mano Computer architecture

## How to Use

1. Open the project in ModelSim (or your preferred Verilog environment).
2. Compile all Verilog source files.
3. Run the provided testbenches for each module.
4. Observe the simulation output and verify behavior against the architecture specifications.

## Test Cases

The following functionalities are tested:

- Register load operations
- Instruction execution (LOAD, ADD, AND, JMP, etc.)
- Conditional instructions
- Memory read and write operations

## Notes

- The design strictly follows the specifications from the book *Computer System Architecture* by M. Morris Mano.
- Instruction execution is synchronized using a timing sequence similar to the one in the original architecture.

## Author

This project is created for educational purposes and is open for further development and extension.
