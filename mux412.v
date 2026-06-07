module mux41 (input [1:0] a,
              input [1:0] b,
              input [1:0] c,
              input [1:0] d,
              input [1:0] s,
              output [1:0] e);

    wire [1:0] t0, t1, t2, t3;

    assign t0 = a & {2{~s[1] & ~s[0]}};
    assign t1 = b & {2{~s[1] &  s[0]}};
    assign t2 = c & {2{ s[1] & ~s[0]}};
    assign t3 = d & {2{ s[1] &  s[0]}};

    assign e = t0 | t1 | t2 | t3;
endmodule

module tg (output reg [1:0] a,
           output reg [1:0] b,
           output reg [1:0] c,
           output reg [1:0] d,
           output reg [1:0] s,
           input [1:0] e);

    initial begin
        $monitor($time,,,,"[a, b, c, d] = %b %b %b %b    s = %b    e = %b", a, b, c, d, s, e);
        {a, b, c, d} = 8'b01100101;
        s = 2'b00;

        #2
        s = 2'b01;

        #2
        s = 2'b10;

        #2
        s = 2'b11;

        #3
        $finish;
    end
endmodule

module wb;
    wire [1:0] a;
    wire [1:0] b;
    wire [1:0] c;
    wire [1:0] d;
    wire [1:0] s;
    wire [1:0] e;
    mux41 dut(a, b, c, d, s, e);
    tg t0(a, b, c, d, s, e);
endmodule