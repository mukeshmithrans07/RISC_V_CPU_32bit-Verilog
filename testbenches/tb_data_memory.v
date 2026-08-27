module tb_data_memory;

reg [31:0] addr;
reg [31:0] write_data;
reg [2:0]  ls_type;
reg  clk;
reg  mem_we;
wire [31:0] mem_read_data;

data_memory uut (
    .addr(addr),
    .write_data(write_data),
    .ls_type(ls_type),
    .clk(clk),
    .mem_we(mem_we),
    .mem_read_data(mem_read_data)
);

always #5 clk = ~clk;

initial begin
    
    $dumpfile("../waveforms/data_memory_wf.vcd");
    $dumpvars(0, tb_data_memory);

    clk = 0;
    mem_we = 0;
    addr = 0;
    write_data = 0;
    ls_type = 0;
    
    $display("Time | WE | Addr | ls_type | Write Data | Read Data");
    $monitor("%4t |  %b | %h |   %b   |  %h  | %h", $time, mem_we, addr, ls_type, write_data, mem_read_data);

    #15;
    mem_we = 1; addr = 32'h00000010; write_data = 32'hAABBCCDD; ls_type = 3'b010; #10;
    mem_we = 0; #10;
    $finish;
end

endmodule