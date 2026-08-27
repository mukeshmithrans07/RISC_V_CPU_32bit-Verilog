module data_memory(
    input [31:0] addr,
    input [31:0] write_data,
    input [2:0] ls_type,
    input clk,
    input mem_we,
    output reg [31:0] mem_read_data
);

reg [7:0] ram [0:1023];
integer i;
wire [9:0] short_addr = addr[9:0];

initial begin
    for (i = 0; i < 1024; i = i + 1) begin
        ram[i] = 8'b0;
    end
end


always @(posedge clk) begin
    if (mem_we) begin
        case (ls_type)
        3'b000: begin 
            ram[short_addr] <= write_data[7:0];
        end
        3'b001: begin 
            ram[short_addr]         <= write_data[7:0];
            ram[short_addr + 10'd1] <= write_data[15:8];
        end
        3'b010: begin
            ram[short_addr]         <= write_data[7:0];
            ram[short_addr + 10'd1] <= write_data[15:8];
            ram[short_addr + 10'd2] <= write_data[23:16];
            ram[short_addr + 10'd3] <= write_data[31:24];
        end
        endcase
    end
end

always @(*) begin
    case (ls_type)
        3'b000: mem_read_data = { {24{ram[short_addr][7]}}, ram[short_addr] };
        3'b001: mem_read_data = { {16{ram[short_addr + 10'd1][7]}}, ram[short_addr + 10'd1], ram[short_addr] };
        3'b010: mem_read_data = { ram[short_addr + 10'd3], ram[short_addr + 10'd2], ram[short_addr + 10'd1], ram[short_addr] };
        3'b100: mem_read_data = { 24'b0, ram[short_addr] };
        3'b101: mem_read_data = { 16'b0, ram[short_addr + 10'd1], ram[short_addr] };
        default: mem_read_data = 32'b0;
    endcase
end

endmodule