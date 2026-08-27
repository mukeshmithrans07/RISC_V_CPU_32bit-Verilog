module mux_2_1 (input wire [31:0] mux_in_0,
                input wire [31:0] mux_in_1,
                input wire mux_sel,
                output wire [31:0] mux_out);

assign mux_out = mux_sel ? mux_in_1 : mux_in_0;

endmodule