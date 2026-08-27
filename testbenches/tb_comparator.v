module tb_comparator;

reg [31:0] rs1_data, rs2_data;
reg [2:0] branch_sel;
wire branch_taken;

comparator uut( 
    .rs1_data(rs1_data),
    .rs2_data(rs2_data),
    .branch_sel(branch_sel),
    .branch_taken(branch_taken)
);

initial begin
    $dumpfile("../waveforms/comparator_wf.vcd");
    $dumpvars(0, tb_comparator);
    $display("------------------------------------------------");
    $monitor("Time = %0t, R1: %h, R2: %h, Sel: %d, Out: %b", $time, rs1_data, rs2_data, branch_sel, branch_taken);
    $display("------------------------------------------------");

    rs1_data = 32'hAAAAAAAA;
    rs2_data = 32'hBBBBBBBB;
    branch_sel = 3'd0; #10;
    branch_sel = 3'd1; #10;
    branch_sel = 3'd4; #10;
    branch_sel = 3'd5; #10;
    branch_sel = 3'd6; #10;
    branch_sel = 3'd7; #10;

    $finish;

end
endmodule