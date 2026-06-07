module mux41 (input [3:0] in,
              input [1:0] s,
              output e);

    wire [3:0] t;

    assign t[0] = in[0] & (~s[1]) & (~s[0]);
    assign t[1] = in[1] & (~s[1]) & ( s[0]);
    assign t[2] = in[2] & ( s[1]) & (~s[0]);
    assign t[3] = in[3] & ( s[1]) & ( s[0]);

    assign e = t[0] | t[1] | t[2] | t[3];
endmodule

module tg (output reg [3:0] in,
           output reg [1:0] s,
           input e);

    initial begin
        $monitor($time,,,,"input = %b    s = %b    e = %b", in, s, e);
        in = 4'b0101;
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
    wire [3:0] in;
    wire [1:0] s;
    wire e;
    mux41 dut(in, s, e);
    tg t0(in, s, e);
endmodule