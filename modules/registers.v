module registers (
    input [4:0] rs1_addr,
    input [4:0] rs2_addr,
    input [4:0] rd_addr,
    input [31:0] write_data,
    input clk,
    input reg_WE,
    output wire [31:0] rs1_data,
    output wire [31:0] rs2_data
);

reg [31:0] reg_array [0:31];
integer i;

initial begin
    for (i = 0; i < 32; i = i + 1) begin
        reg_array[i] = 32'b0;
    end
end

assign rs1_data = (rs1_addr == 5'd0) ? 32'b0 : reg_array[rs1_addr];
assign rs2_data = (rs2_addr == 5'd0) ? 32'b0 : reg_array[rs2_addr];

always @(posedge clk) begin
    if (reg_WE && rd_addr != 5'd0) begin
        reg_array[rd_addr] <= write_data;
    end
end

endmodule