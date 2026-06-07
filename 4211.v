module circuit(
    input A, B, C, D,
    output F
);
nand U0 (F, C, D);
endmodule

module tg(
    output reg A, B, C, D,
    input F
);
initial begin
    $monitor($time,,,,"[A, B, C] = %b%b%b%b    F = %b", A, B, C, D, F);
    {A, B, C, D} = 4'b0001;
    #2 {A, B, C, D} = 4'b0011;
    #2 {A, B, C, D} = 4'b1001;
    #2 {A, B, C, D} = 4'b1011;
    #5 $finish;
end
endmodule

module wb;
wire A, B, C, D, F;
circuit dut(A, B, C, D, F);
tg tb(A, B, C, D, F);
endmodule