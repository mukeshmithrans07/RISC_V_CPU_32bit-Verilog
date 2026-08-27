module mux_4_1 (input wire [31:0] mux_in_0,
                input wire [31:0] mux_in_1,
                input wire [31:0] mux_in_2,
                input wire [31:0] mux_in_3,
                input wire [1:0] mux_sel,
                output reg [31:0] mux_out);

always@(*) begin

    case(mux_sel)

    2'b01: mux_out = mux_in_1;
    2'b00: mux_out = mux_in_0; 
    2'b10: mux_out = mux_in_2;
    2'b11: mux_out = mux_in_3;
    default: mux_out = 32'b0;
    endcase

end
endmodule   