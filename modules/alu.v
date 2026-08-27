module alu (
    input wire [31:0] alu_a,
    input wire [31:0] alu_b,
    input wire [3:0] alu_sel, 
    output reg [31:0] alu_out
    );

always@(*) begin

    case(alu_sel)

    4'b0000: alu_out = alu_a + alu_b;
    4'b0001: alu_out = alu_a - alu_b;
    4'b0010: alu_out = alu_a << alu_b[4:0] ;
    4'b0011: alu_out = ($signed(alu_a) < $signed(alu_b)) ? 32'd1 : 32'd0;
    4'b0100: alu_out = (alu_a < alu_b) ? 32'd1 : 32'd0;
    4'b0101: alu_out = alu_a ^ alu_b;
    4'b0110: alu_out = alu_a >> alu_b[4:0];
    4'b0111: alu_out = $signed(alu_a) >>> alu_b[4:0];
    4'b1000: alu_out = alu_a | alu_b;
    4'b1001: alu_out = alu_a & alu_b;
    default: alu_out = 32'b0;
    endcase

end

endmodule