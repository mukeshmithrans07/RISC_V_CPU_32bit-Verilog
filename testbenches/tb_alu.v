module tb_alu;

reg [31:0] alu_a, alu_b;
reg [3:0] alu_sel;
wire [31:0] alu_out;

alu uut( 
    .alu_a(alu_a),
    .alu_b(alu_b),
    .alu_sel(alu_sel),
    .alu_out(alu_out)
);

initial begin
    $dumpfile("../waveforms/alu_wf.vcd");
    $dumpvars(0, tb_alu);
    $monitor("Time = %0t, A: %h, B: %h, Sel: %d, Out: %h", $time, alu_a, alu_b, alu_sel, alu_out);

    alu_a = 32'hFFFFFFF0;
    alu_b = 32'h00000004;
    alu_sel = 4'd0; #10;
    alu_sel = 4'd1; #10; 
    alu_sel = 4'd2; #10;
    alu_sel = 4'd3; #10;
    alu_sel = 4'd4; #10;
    alu_sel = 4'd5; #10;
    alu_sel = 4'd6; #10;
    alu_sel = 4'd7; #10;
    alu_sel = 4'd8; #10;
    alu_sel = 4'd9; #10;

    $finish;

end
endmodule