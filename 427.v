module circuit(
    input A, B, C, D,
    output F
);
wire An, Bn, Cn, Dn;
wire m1, m3, m9, m11;

not U0 (An, A);
not U1 (Bn, B);
not U2 (Cn, C);
not U3 (Dn, D);

and U4 (m1, An, Bn, Cn, D);
and U5 (m3, An, Bn, C, D);
and U6 (m9, A, Bn, Cn, D);
and U7 (m11, A, Bn, C, D);

or U8 (F, m1, m3, m9, m11);
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