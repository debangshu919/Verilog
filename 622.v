module SystemJ(
    input wire [3:0] ABCD,
    output reg F
);

always @(*) begin
    case (ABCD)
        4'd4,
        4'd5,
        4'd7,
        4'd12,
        4'd13,
        4'd15: F = 1'b1;

        default: F = 1'b0;
    endcase
end

endmodule

module tg(
    output reg [3:0] ABCD,
    input F
);

integer i;

initial begin
    $monitor($time,,,,"ABCD = %b    F = %b", ABCD, F);

    for(i = 0; i < 16; i = i + 1)
    begin
        ABCD = i;
        #10;
    end

    $finish;
end

endmodule

module wb;

wire [3:0] ABCD;
wire F;

SystemJ dut(ABCD, F);
tg tb(ABCD, F);

endmodule