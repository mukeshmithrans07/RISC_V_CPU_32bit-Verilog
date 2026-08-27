module tb_imm_generator;

reg [31:0] instr;
reg [2:0]  imm_sel;
wire [31:0] imm_ext;

imm_generator uut (
    .instr(instr),
    .imm_sel(imm_sel),
    .imm_ext(imm_ext)
);

initial begin
    $dumpfile("../waveforms/imm_generator_wf.vcd");
    $dumpvars(0, tb_imm_generator);
    $monitor("Time=%0t | Sel=%b | Instr=%h | Ext_Imm=%h", $time, imm_sel, instr, imm_ext);

    instr = 32'hF24AAAAA; 
    
    imm_sel = 3'b000; #10; // R-Type
    imm_sel = 3'b001; #10; // I-Type
    imm_sel = 3'b010; #10; // S-Type
    imm_sel = 3'b011; #10; // B-Type
    imm_sel = 3'b100; #10; // U-Type
    imm_sel = 3'b101; #10; // J-Type

    $finish;
end

endmodule