`timescale 1ns/1ps
module tb_mux_2_1;

reg [31:0] in_0;
reg [31:0] in_1;
reg sel;
wire [31:0] out;

mux_2_1 uut (
    .mux_in_0(in_0), 
    .mux_in_1(in_1), 
    .mux_sel(sel), 
    .mux_out(out)
    );

initial begin
    $dumpfile("../waveforms/mux_2_1_wf.vcd");
    $dumpvars(0, tb_mux_2_1);
    $monitor("Time = %0t, Sel = %b, In0: %h, In1: %h, Out: %h", $time, sel, in_0, in_1, out);

    in_0 = 32'hAAAAAAAA;
    in_1 = 32'hFFFFFFFF;
    sel = 0; #10;
    sel = 1; #10;
    $finish;
end
        
endmodule