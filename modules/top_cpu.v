module top_cpu(
    input clk,
    input reset
);

wire [31:0] pc_current;
wire [31:0] pc_next;
wire [31:0] pc4;
wire [31:0] instr;

wire        pc_mux_sel;
wire [2:0]  imm_sel;
wire        reg_WE;
wire [3:0]  alu_op_sel;
wire        mux_a_sel;
wire        mux_b_sel;
wire [2:0]  branch_op_sel;
wire        mem_WE;
wire [2:0]  ls_type;
wire [1:0]  rd_mux_sel;

wire [31:0] imm_ext;
wire [31:0] rs1_data;
wire [31:0] rs2_data;
wire [31:0] alu_a;
wire [31:0] alu_b;
wire [31:0] alu_result;
wire        branch_taken;
wire [31:0] mem_read_data;
wire [31:0] writeback_data;

program_counter cpu_pc (
    .next_pc(pc_next),
    .clk(clk),
    .rst(reset),
    .pc(pc_current)
);

pc_plus_4 cpu_pc_plus_4 (
    .pc(pc_current),
    .pc4(pc4)
);

mux_2_1 cpu_pc_mux (
    .mux_in_0(pc4),
    .mux_in_1(alu_result),
    .mux_sel(pc_mux_sel),
    .mux_out(pc_next)
);

instruction_memory cpu_imem (
    .pc(pc_current),
    .instr(instr)
);

control_unit cpu_cu (
    .instr(instr),
    .branch_taken(branch_taken),
    .pc_mux_sel(pc_mux_sel),
    .imm_sel(imm_sel),
    .reg_WE(reg_WE),
    .alu_op_sel(alu_op_sel),
    .mux_a_sel(mux_a_sel),
    .mux_b_sel(mux_b_sel),
    .branch_op_sel(branch_op_sel),
    .mem_WE(mem_WE),
    .ls_type(ls_type),
    .rd_mux_sel(rd_mux_sel)
);

registers cpu_registers (
    .rs1_addr(instr[19:15]),
    .rs2_addr(instr[24:20]),
    .rd_addr(instr[11:7]),
    .write_data(writeback_data),
    .clk(clk),
    .reg_WE(reg_WE),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
);

imm_generator cpu_imm_gen (
    .instr(instr),
    .imm_sel(imm_sel),
    .imm_ext(imm_ext)
);

comparator cpu_comparator (
    .rs1_data(rs1_data),
    .rs2_data(rs2_data),
    .branch_sel(branch_op_sel),
    .branch_taken(branch_taken)
);

mux_2_1 cpu_mux_a (
    .mux_in_0(rs1_data),
    .mux_in_1(pc_current),
    .mux_sel(mux_a_sel),
    .mux_out(alu_a)
);

mux_2_1 cpu_mux_b (
    .mux_in_0(rs2_data),
    .mux_in_1(imm_ext),
    .mux_sel(mux_b_sel),
    .mux_out(alu_b)
);

alu cpu_alu (
    .alu_a(alu_a),
    .alu_b(alu_b),
    .alu_sel(alu_op_sel),
    .alu_out(alu_result)
);

data_memory cpu_dmem (
    .addr(alu_result),
    .write_data(rs2_data),
    .ls_type(ls_type),
    .clk(clk),
    .mem_we(mem_WE),
    .mem_read_data(mem_read_data)
);

mux_4_1 writeback_mux (
    .mux_in_0(alu_result),
    .mux_in_1(mem_read_data),
    .mux_in_2(pc4),
    .mux_in_3(imm_ext),
    .mux_sel(rd_mux_sel),
    .mux_out(writeback_data)
);

endmodule