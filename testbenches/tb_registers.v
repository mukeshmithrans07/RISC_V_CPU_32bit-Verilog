module tb_registers;

reg [4:0]  rs1_addr, rs2_addr, rd_addr;
reg [31:0] write_data;
reg clk, reg_WE;
wire [31:0] rs1_data, rs2_data;

registers uut (
    .rs1_addr(rs1_addr),
    .rs2_addr(rs2_addr),
    .rd_addr(rd_addr),
    .write_data(write_data),
    .clk(clk),
    .reg_WE(reg_WE),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("../waveforms/registers_wf.vcd");
    $dumpvars(0, tb_registers);
    clk = 0; reg_WE = 0; 
    rs1_addr = 0; rs2_addr = 0; rd_addr = 0; write_data = 0;
    
    $monitor("time: %2t | WE: %b | Write Reg %2d: %8h | Read Reg %2d: %8h | Read Reg %2d: %8h", $time, reg_WE, rd_addr, write_data, rs1_addr, rs1_data, rs2_addr, rs2_data);

    #10;
    reg_WE = 1;               
    rd_addr = 5;              
    write_data = 32'hAAAA;    
    rs1_addr = 5;             

    #10;
    reg_WE = 1;               
    rd_addr = 10;             
    write_data = 32'hBBBB;    
    rs2_addr = 10;           
    #10;
    reg_WE = 1;               
    rd_addr = 0;              
    write_data = 32'hFFFF;    
    rs1_addr = 0;       

    #10;
    $finish;
end

endmodule