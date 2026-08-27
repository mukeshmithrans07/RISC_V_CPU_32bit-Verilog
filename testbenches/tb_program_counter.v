`timescale 1ns/1ps
module tb_program_counter;
    reg [31:0] next_pc;
    reg clk;
    wire [31:0] pc;

program_counter uut (
    .next_pc(next_pc),
    .clk(clk),
    .pc(pc)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("../waveforms/program_counter_wf.vcd");
    $dumpvars(0, tb_program_counter);
    $monitor("Time = %0t, clk = %b, next_pc: %h, pc: %h", $time, clk, next_pc, pc);

    clk = 0;
    next_pc = 32'hAAAAAAAA; #20;
    next_pc = 32'hFFFFFFFF; #20;
    $finish;

end

endmodule