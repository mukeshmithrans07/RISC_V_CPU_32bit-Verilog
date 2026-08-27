module tb_cpu;

reg clk;
reg reset;

top_cpu uut (
    .clk(clk),
    .reset(reset)
);
always #5 clk = ~clk;

initial begin
    $dumpfile("../waveforms/cpu_wf.vcd");
    $dumpvars(0, tb_cpu);

    $display("Time |   PC   |  Instruction  | ALU Out  | Writeback");
    $monitor("%4t | %h |   %h  | %h | %h", $time, uut.pc_current, uut.instr, uut.alu_result, uut.writeback_data);

    clk = 0;
    reset = 1; 
    
    #10 reset = 0;
    #500; 
   
    $display("Simulation complete.");
    $finish;
end

endmodule