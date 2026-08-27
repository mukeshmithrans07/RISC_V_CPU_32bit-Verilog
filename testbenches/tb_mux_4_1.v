`timescale 1ns/1ps
module tb_mux_4_1;

reg [31:0] in_0;
reg [31:0] in_1;
reg [31:0] in_2;
reg [31:0] in_3;
reg [1:0] sel;
wire [31:0] out;

mux_4_1 uut (
    .mux_in_0(in_0), 
    .mux_in_1(in_1), 
    .mux_in_2(in_2), 
    .mux_in_3(in_3), 
    .mux_sel(sel), 
    .mux_out(out)
    );

initial begin

    $dumpfile("../waveforms/mux_4_1_wf.vcd");
    $dumpvars(0, tb_mux_4_1);
    $monitor("Time = %0t, Sel = %b, In0: %h, In1: %h, In2: %h, In3: %h, Out: %h", $time, sel, in_0, in_1, in_2, in_3, out);

    in_0 = 32'hAAAAAAAA;
    in_1 = 32'hBBBBBBBB;
    in_2 = 32'hCCCCCCCC;
    in_3 = 32'hDDDDDDDD;

    sel = 2'b00; #10;
    sel = 2'b01; #10;
    sel = 2'b10; #10;
    sel = 2'b11; #10;
    
    $finish;
end
        
endmodule