module tb_control_unit;

    // Inputs to the Control Unit
    reg [31:0] instr;
    reg        branch_taken;

    // Outputs from the Control Unit
    wire       pc_mux_sel;
    wire [2:0] imm_sel;
    wire       reg_WE;
    wire [3:0] alu_op_sel;
    wire       mux_a_sel;
    wire       mux_b_sel;
    wire [2:0] branch_op_sel;
    wire       mem_WE;
    wire [2:0] ls_type;
    wire [1:0] rd_mux_sel;

    // Instantiate the Control Unit
    control_unit uut (
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

    initial begin
        
        $dumpfile("../waveforms/control_unit_wf.vcd");
        $dumpvars(0, tb_control_unit);
        $display("Time |   Instr  | BrTkn || pc_mux | imm | regW | alu | muxA | muxB | br_op | memW | ls | rd_mux");
        $display("--------------------------------------------------------------------------------------------------");
        
        $monitor("%4t | %h |   %b   ||   %b    |  %d  |  %b   |  %d  |  %b   |  %b   |   %d   |  %b   |  %d |   %d", 
                  $time, instr, branch_taken, pc_mux_sel, imm_sel, reg_WE, alu_op_sel, mux_a_sel, mux_b_sel, branch_op_sel, mem_WE, ls_type, rd_mux_sel);

        instr = 32'h002081b3; branch_taken = 0; #10; //R-type
        instr = 32'h00002103; branch_taken = 0; #10; //I-type
        instr = 32'h00102023; branch_taken = 0; #10; //S-type
        instr = 32'hfe0218e3; branch_taken = 1; #10; //B-type

        $finish;
    end

endmodule