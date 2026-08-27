module control_unit(
    input      [31:0] instr,
    input            branch_taken,
    output reg       pc_mux_sel,
    output reg [2:0] imm_sel,
    output reg       reg_WE,
    output reg [3:0] alu_op_sel,
    output reg       mux_a_sel,
    output reg       mux_b_sel,
    output reg [2:0] branch_op_sel,
    output reg       mem_WE,
    output reg [2:0] ls_type,
    output reg [1:0] rd_mux_sel
);

wire [6:0] opcode = instr[6:0];
wire [2:0] func3 = instr[14:12];
wire [6:0] func7 = instr[31:25];

always@(*) begin
    pc_mux_sel = 1'b0;
    imm_sel = 3'b0;
    reg_WE = 1'b0;
    alu_op_sel = 4'b0;
    mux_a_sel = 1'b0;
    mux_b_sel = 1'b0;
    branch_op_sel = 3'b0;
    mem_WE = 1'b0;  
    ls_type = 3'b0;
    rd_mux_sel = 2'b0;

    case(opcode)
    
    7'b0000011: begin   //3
    imm_sel = 3'b001;
    reg_WE = 1'b1;
    mux_b_sel = 1'b1;
    ls_type = func3;
    rd_mux_sel = 2'b01;
    end

    7'b0010011: begin   //19
    imm_sel = 3'b001;
    reg_WE = 1'b1;
    mux_b_sel = 1'b1;

    case (func3)
        3'b000: alu_op_sel = 4'b0000; 
        3'b001: alu_op_sel = 4'b0010; 
        3'b010: alu_op_sel = 4'b0011; 
        3'b011: alu_op_sel = 4'b0100; 
        3'b100: alu_op_sel = 4'b0101; 
        3'b110: alu_op_sel = 4'b1000; 
        3'b111: alu_op_sel = 4'b1001;
        3'b101: alu_op_sel = (func7[5]) ? 4'b0111 : 4'b0110; // SRA or SRL based on bit 30
    endcase   
    end
    
    7'b0010111: begin   //23
    imm_sel = 3'b100;
    reg_WE = 1'b1;
    mux_a_sel = 1'b1;
    mux_b_sel = 1'b1;

    end

    7'b0100011: begin   //35
    imm_sel = 3'b010;
    mux_b_sel = 1'b1;
    mem_WE = 1'b1;  
    ls_type = func3;
    end

    7'b0110011: begin   //51
    reg_WE = 1'b1;
    case (func3)
        3'b000: alu_op_sel = (func7[5]) ? 4'b0001 : 4'b0000; 
        3'b001: alu_op_sel = 4'b0010; 
        3'b010: alu_op_sel = 4'b0011; 
        3'b011: alu_op_sel = 4'b0100; 
        3'b100: alu_op_sel = 4'b0101; 
        3'b110: alu_op_sel = 4'b1000;
        3'b111: alu_op_sel = 4'b1001;
        3'b101: alu_op_sel = (func7[5]) ? 4'b0111 : 4'b0110; 
    endcase
    end

    7'b0110111: begin   //55
    imm_sel = 3'b100; 
    reg_WE = 1'b1;
    rd_mux_sel = 2'b11;
    end

    7'b1100011: begin   //99
    pc_mux_sel = branch_taken;
    imm_sel = 3'b011;
    mux_a_sel = 1'b1;
    mux_b_sel = 1'b1;
    branch_op_sel = func3;        
    end

    7'b1100111: begin   //103
    imm_sel    = 3'b001; 
    reg_WE     = 1'b1;
    mux_b_sel  = 1'b1;   
    rd_mux_sel = 2'b10;  
    pc_mux_sel = 1'b1;   
    end

    7'b1101111: begin   //111  
    imm_sel    = 3'b101; 
    reg_WE     = 1'b1;
    mux_a_sel  = 1'b1;   
    mux_b_sel  = 1'b1;
    rd_mux_sel = 2'b10;  
    pc_mux_sel = 1'b1;   
    end

    default: begin        
    end
    endcase

end 
endmodule