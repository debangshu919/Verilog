module ShiftRegister(
    input wire [3:0] D,
    input wire Clock,
    input wire Reset,
    output reg [3:0] W,
    output reg [3:0] X,
    output reg [3:0] Y,
    output reg [3:0] Z
);

always @(posedge Clock or negedge Reset)
begin
    if (!Reset)
    begin
        W <= 4'b0000;
        X <= 4'b0000;
        Y <= 4'b0000;
        Z <= 4'b0000;
    end
    else
    begin
        W <= D;
        X <= W;
        Y <= X;
        Z <= Y;
    end
end

endmodule

module tg(
    output reg [3:0] D,
    output reg Clock,
    output reg Reset,
    input [3:0] W,
    input [3:0] X,
    input [3:0] Y,
    input [3:0] Z
);

initial
begin
    Clock = 0;
    forever #1 Clock = ~Clock;
end

initial
begin
    $monitor($time,,,,
    " D=%b W=%b X=%b Y=%b Z=%b Reset=%b",
    D, W, X, Y, Z, Reset);

    Reset = 0;
    D = 4'b0000;

    #2 Reset = 1;

    #2 D = 4'b1010;
    #2 D = 4'b1100;
    #2 D = 4'b1111;
    #2 D = 4'b0001;
    #8 $finish;
end

endmodule

module wb;

wire [3:0] D;
wire [3:0] W;
wire [3:0] X;
wire [3:0] Y;
wire [3:0] Z;
wire Clock;
wire Reset;

ShiftRegister dut(
    D,
    Clock,
    Reset,
    W,
    X,
    Y,
    Z
);

tg tb(
    D,
    Clock,
    Reset,
    W,
    X,
    Y,
    Z
);

endmodule