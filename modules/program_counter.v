module program_counter (input wire [31:0] next_pc,
                        input clk,
                        input rst,
                        output reg [31:0] pc);

always @(posedge clk) begin
    if (rst) pc <= 32'b0;
    else pc <= next_pc;
end
endmodule