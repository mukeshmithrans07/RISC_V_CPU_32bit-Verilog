# RV32I CPU Architecture

This document describes the datapath and control unit routing for a 32-bit RISC-V (RV32I) single-cycle processor.

## Core Modules

*   **PC (Program Counter):** Holds the current instruction address. Updates on the clock edge.
*   **PC + 4:** Adder that computes the sequential next instruction address.
*   **Instr. Mem. (Instruction Memory):** Takes the PC address and outputs the 32-bit instruction word.
*   **Imm. Gen (Immediate Generator):** Extracts and sign-extends immediate values from the instruction.
*   **Control Unit:** Decodes the instruction and generates selection and enable signals for the datapath components.
*   **Registers:** A 32x32-bit register file featuring two read ports and one write port.
*   **PC Mux:** Selects between the sequential `PC + 4` address or an `alu_res` branch/jump address to feed the next PC.
*   **Comparator:** Evaluates branch conditions by comparing `rs1_data` and `rs2_data`.
*   **ALU (Arithmetic Logic Unit):** Performs arithmetic and bitwise operations on selected operands.
*   **Data Memory:** Handles Load/Store operations, taking an address from the ALU and data from the register file.
*   **Mux A / Mux B:** Operand routing multiplexers for the ALU inputs.
*   **Writeback MUX:** Selects which result (ALU, Memory, PC+4, or Immediate) to write back into the destination register.

## Datapath & Signal Routing

The datapath is interconnected via a standardized signal numbering system. All standard data buses are 32-bit unless otherwise specified (e.g., register addresses are 5-bit, and control signals vary).

| Signal ID | Signal Name | Source | Destination(s) | Description |
| :---: | :--- | :--- | :--- | :--- |
| **1** | `pc` | PC | Instr. Mem., PC+4, Mux A | Current instruction address. |
| **2** | `pc_next` | PC+4 | PC Mux, Writeback MUX | Sequential next instruction address. |
| **3** | `instr` | Instr. Mem. | Control Unit, Imm. Gen, Registers | 32-bit instruction fetched from memory. |
| **4** | `pc_mux_sel` | Control Unit | PC Mux | Selects the next PC source. |
| **5** | `imm_sel` | Control Unit | Imm. Gen | Selects the immediate extraction format. |
| **6** | `reg WE` | Control Unit | Registers | Register File Write Enable. |
| **7** | `alu_op_sel` | Control Unit | ALU | Selects the ALU operation. |
| **8** | `mux_a_sel` | Control Unit | Mux A | Selects ALU operand A source. |
| **9** | `mux_b_sel` | Control Unit | Mux B | Selects ALU operand B source. |
| **10** | `branch_op_sel` | Control Unit | Comparator | Selects the branch condition to evaluate. |
| **11** | `mem WE` | Control Unit | Data Memory | Memory Write Enable. |
| **12** | `LSU_type` | Control Unit | Data Memory | Load/Store Unit operation type (e.g., byte, word). |
| **13** | `rd_mux_sel` | Control Unit | Writeback MUX | Selects the data source to write to the register. |
| **14** | `rs1_data` | Registers | Comparator, Mux A | Data read from source register 1. |
| **15** | `rs2_data` | Registers | Comparator, Mux B, Data Mem. | Data read from source register 2. |
| **16** | `imm_ext` | Imm. Gen | Mux B, Writeback MUX | Sign-extended immediate value. |
| **17** | `branch_taken` | Comparator | Control Unit | 1-bit flag indicating if branch condition is true. |
| **18** | `alu_src_A` | Mux A | ALU | Resolved operand A for the ALU. |
| **19** | `alu_src_B` | Mux B | ALU | Resolved operand B for the ALU. |
| **20** | `alu_res` | ALU | Data Mem, Writeback MUX, PC Mux | ALU execution result / memory address. |
| **21** | `mem_read_data`| Data Memory | Writeback MUX | Data retrieved from memory during a Load. |
| **22** | `write_data` | Writeback MUX| Registers | Final data to be written into the destination register. |
| **23** | `next_pc` | PC Mux | PC | The resolved address for the next clock cycle. |
