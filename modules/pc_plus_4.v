module pc_plus_4   (input wire [31:0] pc,
                    output wire [31:0] pc4);

assign pc4 = pc + 32'd4;

endmodule