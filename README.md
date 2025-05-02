# 🧰 Verilog & Proteus  
🔗 **Video Link:** *https://drive.google.com/drive/folders/13KVklbSsxx21-d4szbK2ETUkNM5KYemO?usp=drive_link*
*https://www.dropbox.com/scl/fi/bj4l3cjmk85vk40e7akbv/.mp4?rlkey=7s3qqdzy0awncjgdb4vad68yt&st=ab9blxz3&dl=0*
---

## 📌 Project Overview  
This project implements **Mano's Basic Computer** — a simplified computer architecture model — using **Verilog HDL** for digital design and **Proteus** for simulation. The system supports the **complete instruction set** defined in Mano's original architecture.

---

## 🧾 Instruction Set Implementation

### 🔹 Memory Reference Instructions
- **AND (0x00):** Bitwise AND between memory content and AC  
- **ADD (0x01):** Adds memory content to AC with carry handling  
- **LDA (0x02):** Loads data from memory into AC  
- **STA (0x03):** Stores AC content into memory  
- **BUN (0x04):** Unconditional branch  
- **BSA (0x05):** Branch and save return address  
- **ISZ (0x06):** Increment memory content and skip if zero  

### 🔹 Register Reference Instructions (0x7000–0x7FFF)
- **CLA (0x7800):** Clear AC  
- **CLE (0x7400):** Clear E flag  
- **CMA (0x7200):** Complement AC  
- **CME (0x7100):** Toggle E  
- **CIR (0x7080):** Circular right shift via E  
- **CIL (0x7040):** Circular left shift via E  
- **INC (0x7020):** Increment AC  
- **SPA (0x7010):** Skip if AC is positive  
- **SNA (0x7008):** Skip if AC is negative  
- **SZA (0x7004):** Skip if AC is zero  
- **SZE (0x7002):** Skip if E is zero  
- **HLT (0x7001):** Halt execution  

### 🔹 I/O Instructions (0xF000–0xFFFF)
- **INP (0xF800):** Read input into AC  
- **OUT (0xF400):** Output AC content  
- **SKI (0xF200):** Skip if input ready  
- **SKO (0xF100):** Skip if output ready  
- **ION (0xF080):** Enable interrupts  
- **IOF (0xF040):** Disable interrupts  
- **PUSH (0xF008):** Push AC to stack  
- **POP (0xF004):** Pop stack to AC  

---

## 🏗 Project Architecture

### 📁 Verilog Modules
- **Memory.v:** 4K×16-bit dual-port RAM  
- **ALU.v:** Arithmetic Logic Unit  
- **ControlUnit.v:** FSM for instruction cycles  
- **Registers.v:** General-purpose and flag registers  
- **IO_Module.v:** I/O operations handler  
- **ManoComputer.v:** Top-level integration module  

---

## 🌟 Key Features
- Full 16-bit data path  
- Complete instruction support  
- Interrupt system support  
- Stack-based operations  
- Conditional branching  
- I/O device communication  

---

## 🧪 Testing Methodology

### 🧮 Arithmetic Test
```assembly
LDA [0x100]    // Load first operand  
ADD [0x101]    // Add second operand  
CMA            // Complement result  
STA [0x102]    // Store result  
HLT            // Halt  
```

### 🔁 I/O Test
```assembly
INP            // Read character  
OUT            // Output character  
SKI            // Check input ready  
SKO            // Check output ready  
HLT  
```

### 🗂 Stack Test
```assembly
LDA [0x100]    // Load initial value  
PUSH           // Push to stack  
POP            // Pop from stack  
STA [0x101]    // Store restored value  
HLT  
```

---

## ✅ Simulation Results
- Accurate timing for all instructions  
- Correct flag behavior (E, S, Z)  
- Proper interrupt responses  
- Valid memory access  
- Functional I/O communication  

---

## 🔭 Future Development Roadmap
- Add Floating-Point Unit (FPU)  
- Expand with memory-mapped I/O  
- Develop assembler tool  
- FPGA hardware porting  
- Add cache memory  
- Pipeline enhancements  

---

## 📝 Implementation Notes
- Instructions take 1–3 cycles  
- Memory uses 12-bit addressing  
- I/O is synchronous  
- Stack grows downward  
- Interrupts are maskable  
- Conditional skips affect PC  

---

📚 *This documentation serves as a complete technical reference for both educational and development use of the Mano Basic Computer implementation.*
