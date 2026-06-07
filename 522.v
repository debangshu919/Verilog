module circuit (
    input  wire [3:0] ABCD,
    output reg F
);

always @(*) begin
    case (ABCD)
        4'b0001,
        4'b0011,
        4'b1001,
        4'b1011: F = 1'b1;
        default: F = 1'b0;
    endcase
end

endmodule

module tg(
    output reg [3:0] ABCD,
    input F
);
initial begin
    $monitor($time,,,,"ABCD = %b    F = %b", ABCD, F);

    ABCD = 4'b0001;
    #2 ABCD = 4'b0011;
    #2 ABCD = 4'b1001;
    #2 ABCD = 4'b1011;

    #5 $finish;
end
endmodule

module wb;
wire [3:0] ABCD;
wire F;

circuit dut(ABCD, F);
tg tb(ABCD, F);

endmodule