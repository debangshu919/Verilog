module circuit(
    input A, B, C,
    output F
);
wire An, Bn, Cn;
wire m0, m1, m4;

not U0 (An, A);
not U1 (Bn, B);
not U2 (Cn, C);

and U3 (m0, An, Bn, Cn);
and U4 (m1, An, Bn, C);
and U5 (m4, A, Bn, Cn);

or U6 (F, m0, m1, m4);
endmodule

module tg(
    output reg A, B, C,
    input F
);
initial begin
    $monitor($time,,,,"[A, B, C] = %b%b%b    F = %b", A, B, C, F);
    {A, B, C} = 3'b000;
    #2 {A, B, C} = 3'b001;
    #2 {A, B, C} = 3'b100;
    #2 {A, B, C} = 3'b010;
    #5 $finish;
end
endmodule

module wb;
wire A, B, C, F;
circuit dut(A, B, C, F);
tg tb(A, B, C, F);
endmodule