module tb_instruction_memory;

reg  [31:0] pc;
wire [31:0] instr;

instruction_memory uut (
    .pc(pc),
    .instr(instr)
);

initial begin
    $dumpfile("../waveforms/instruction_memory_wf.vcd");
    $dumpvars(0, tb_instruction_memory);
    $display("Time | PC | Instruction");
    $monitor("%4t | %h |  %h", $time, pc, instr);
    
    pc = 32'h00000000;  #10;
    pc = 32'h00000004;  #10;
    pc = 32'h00000008;  #10;
    $finish;
end

endmodule