module instruction_memory (
    input wire [31:0] pc,
    output wire [31:0] instr
);

reg [31:0] rom [0:255];
integer i;

initial begin
    for (i = 0; i < 256; i = i + 1) begin
        rom[i] = 32'b0;
    end
    $readmemh("../modules/program.hex", rom);
end

assign instr = rom[pc[9:2]];
endmodule