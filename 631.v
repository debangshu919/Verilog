module SystemI(
    input wire [3:0] ABCD,
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

integer i;
reg expected;

initial begin
    for(i = 0; i < 16; i = i + 1)
    begin
        ABCD = i;
        #10;

        case(ABCD)
            4'b0001,
            4'b0011,
            4'b1001,
            4'b1011: expected = 1'b1;
            default: expected = 1'b0;
        endcase

        if(F === expected)
            $display("PASS : ABCD=%b F=%b", ABCD, F);
        else
            $display("FAIL : ABCD=%b F=%b Expected=%b",
                     ABCD, F, expected);
    end

    $finish;
end

endmodule

module wb;

wire [3:0] ABCD;
wire F;

SystemI dut(ABCD, F);
tg tb(ABCD, F);

endmodule