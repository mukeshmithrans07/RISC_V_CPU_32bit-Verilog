module comparator    (
    input wire [31:0] rs1_data,
    input wire [31:0] rs2_data,
    input wire [2:0] branch_sel, 
    output reg branch_taken
    );

always@(*) begin

    case(branch_sel)

    3'b000: branch_taken = rs1_data == rs2_data;
    3'b001: branch_taken = rs1_data != rs2_data;
    3'b100: branch_taken = $signed(rs1_data) < $signed(rs2_data);
    3'b101: branch_taken = $signed(rs1_data) >= $signed(rs2_data);
    3'b110: branch_taken = rs1_data < rs2_data;
    3'b111: branch_taken = rs1_data >= rs2_data;
    default: branch_taken = 1'b0;

    endcase

end

endmodule