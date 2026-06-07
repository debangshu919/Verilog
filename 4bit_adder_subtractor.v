module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum  = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule


module adder_subtractor_4bit(
    input  [3:0] A,
    input  [3:0] B,
    input  M,
    output [3:0] Result,
    output Cout
);

wire [3:0] Bx;
wire c1, c2, c3;

assign Bx = B ^ {4{M}};

full_adder FA0 (
    .a(A[0]),
    .b(Bx[0]),
    .cin(M),
    .sum(Result[0]),
    .cout(c1)
);

full_adder FA1 (
    .a(A[1]),
    .b(Bx[1]),
    .cin(c1),
    .sum(Result[1]),
    .cout(c2)
);

full_adder FA2 (
    .a(A[2]),
    .b(Bx[2]),
    .cin(c2),
    .sum(Result[2]),
    .cout(c3)
);

full_adder FA3 (
    .a(A[3]),
    .b(Bx[3]),
    .cin(c3),
    .sum(Result[3]),
    .cout(Cout)
);

endmodule


module tg(
    output reg [3:0] A,
    output reg [3:0] B,
    output reg M,
    input [3:0] Result,
    input Cout
);

initial begin
    $monitor($time,,,,
             " A=%b    B=%b    Mode=%b    Result=%b    Cout=%b",
             A, B, M, Result, Cout);

    M = 1'b0;
    A = 4'b0000;
    B = 4'b0000;

    #2;
    A = 4'b0001;
    B = 4'b0011;

    #2;
    A = 4'b1001;
    B = 4'b0111;

    #2;
    A = 4'b0101;
    B = 4'b0110;

    #2;
    A = 4'b1110;
    B = 4'b0001;

    #10;
    M = 1'b1;
    A = 4'b0000;
    B = 4'b0000;

    #2;
    A = 4'b0001;
    B = 4'b0011;

    #2;
    A = 4'b1001;
    B = 4'b0111;

    #2;
    A = 4'b0101;
    B = 4'b0110;

    #2;
    A = 4'b1110;
    B = 4'b0001;

    #3;
    $finish;
end

endmodule


module wb;

wire [3:0] A;
wire [3:0] B;
wire M;
wire [3:0] Result;
wire Cout;

adder_subtractor_4bit dut (
    .A(A),
    .B(B),
    .M(M),
    .Result(Result),
    .Cout(Cout)
);

tg t0 (
    .A(A),
    .B(B),
    .M(M),
    .Result(Result),
    .Cout(Cout)
);

endmodule