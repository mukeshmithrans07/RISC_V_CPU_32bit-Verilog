`timescale 1ns/1ps

module tb_pc_plus_4;

reg [31:0] pc;
wire [31:0] pc4;

pc_plus_4 uut(.pc(pc), .pc4(pc4));

initial begin

    $dumpfile("../waveforms/pc_plus_4_wf.vcd");
    $dumpvars(0, tb_pc_plus_4);
    $monitor("Time: %0t, PC: %h, PC+4: %h", $time, pc, pc4); 

    pc = 32'hAAAAAAAA; #10;
    pc = 32'hFFFFFFF3; #10;
    
    repeat(6) begin
        pc = pc4;
        #20;
    end
    
    $finish;

end
endmodule