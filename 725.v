module Agents_on_Bus(
    input wire Clock,
    input wire Reset,
    input wire [15:0] Data_Bus,

    input wire A_EN,
    input wire B_EN,
    input wire C_EN,
    input wire D_EN,

    output reg [15:0] RegA,
    output reg [15:0] RegB,
    output reg [15:0] RegC,
    output reg [15:0] RegD
);

always @(posedge Clock)
begin
    if (Reset)
        RegA <= 16'h0000;
    else if (A_EN)
        RegA <= Data_Bus;
end

always @(posedge Clock)
begin
    if (Reset)
        RegB <= 16'h0000;
    else if (B_EN)
        RegB <= Data_Bus;
end

always @(posedge Clock)
begin
    if (Reset)
        RegC <= 16'h0000;
    else if (C_EN)
        RegC <= Data_Bus;
end

always @(posedge Clock)
begin
    if (Reset)
        RegD <= 16'h0000;
    else if (D_EN)
        RegD <= Data_Bus;
end

endmodule

module tg(
    output reg Clock,
    output reg Reset,
    output reg [15:0] Data_Bus,

    output reg A_EN,
    output reg B_EN,
    output reg C_EN,
    output reg D_EN,

    input [15:0] RegA,
    input [15:0] RegB,
    input [15:0] RegC,
    input [15:0] RegD
);

initial begin
    Clock = 0;
    forever #5 Clock = ~Clock;
end

initial begin
    $monitor($time,,,,
        " Bus=%h A=%h B=%h C=%h D=%h A_EN=%b B_EN=%b C_EN=%b D_EN=%b",
        Data_Bus, RegA, RegB, RegC, RegD,
        A_EN, B_EN, C_EN, D_EN);

    Reset = 1;
    Data_Bus = 16'h0000;
    A_EN = 0;
    B_EN = 0;
    C_EN = 0;
    D_EN = 0;

    #10 Reset = 0;

    #10 Data_Bus = 16'h1111; A_EN = 1;
    #10 A_EN = 0;

    #10 Data_Bus = 16'h2222; B_EN = 1;
    #10 B_EN = 0;

    #10 Data_Bus = 16'h3333; C_EN = 1;
    #10 C_EN = 0;

    #10 Data_Bus = 16'h4444; D_EN = 1;
    #10 D_EN = 0;

    #10 Data_Bus = 16'hAAAA;
         A_EN = 1;
         B_EN = 1;

    #10 A_EN = 0;
         B_EN = 0;

    #20 $finish;
end

endmodule

module wb;

wire Clock;
wire Reset;
wire [15:0] Data_Bus;

wire A_EN;
wire B_EN;
wire C_EN;
wire D_EN;

wire [15:0] RegA;
wire [15:0] RegB;
wire [15:0] RegC;
wire [15:0] RegD;

Agents_on_Bus dut(
    Clock,
    Reset,
    Data_Bus,
    A_EN,
    B_EN,
    C_EN,
    D_EN,
    RegA,
    RegB,
    RegC,
    RegD
);

tg tb(
    Clock,
    Reset,
    Data_Bus,
    A_EN,
    B_EN,
    C_EN,
    D_EN,
    RegA,
    RegB,
    RegC,
    RegD
);

endmodule