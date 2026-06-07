module Shift_Register_16bit_x8(
    input wire Clock,
    input wire Reset,
    input wire [15:0] Din,

    output reg [15:0] A,
    output reg [15:0] B,
    output reg [15:0] C,
    output reg [15:0] D,
    output reg [15:0] E,
    output reg [15:0] F,
    output reg [15:0] G,
    output reg [15:0] H
);

always @(posedge Clock)
begin
    if (Reset)
    begin
        A <= 16'h0000;
        B <= 16'h0000;
        C <= 16'h0000;
        D <= 16'h0000;
        E <= 16'h0000;
        F <= 16'h0000;
        G <= 16'h0000;
        H <= 16'h0000;
    end
    else
    begin
        A <= Din;
        B <= A;
        C <= B;
        D <= C;
        E <= D;
        F <= E;
        G <= F;
        H <= G;
    end
end

endmodule

module tg(
    output reg Clock,
    output reg Reset,
    output reg [15:0] Din,

    input [15:0] A,
    input [15:0] B,
    input [15:0] C,
    input [15:0] D,
    input [15:0] E,
    input [15:0] F,
    input [15:0] G,
    input [15:0] H
);

initial begin
    Clock = 0;
    forever #5 Clock = ~Clock;
end

initial begin
    $monitor($time,,,,
        " Din=%h A=%h B=%h C=%h D=%h E=%h F=%h G=%h H=%h",
        Din, A, B, C, D, E, F, G, H);

    Reset = 1;
    Din = 16'h0000;

    #10 Reset = 0;

    #10 Din = 16'h1111;
    #10 Din = 16'h2222;
    #10 Din = 16'h3333;
    #10 Din = 16'h4444;
    #10 Din = 16'h5555;
    #10 Din = 16'h6666;
    #10 Din = 16'h7777;
    #10 Din = 16'h8888;

    #80 $finish;
end

endmodule

module wb;

wire Clock;
wire Reset;
wire [15:0] Din;

wire [15:0] A;
wire [15:0] B;
wire [15:0] C;
wire [15:0] D;
wire [15:0] E;
wire [15:0] F;
wire [15:0] G;
wire [15:0] H;

Shift_Register_16bit_x8 dut(
    Clock,
    Reset,
    Din,
    A, B, C, D, E, F, G, H
);

tg tb(
    Clock,
    Reset,
    Din,
    A, B, C, D, E, F, G, H
);

endmodule