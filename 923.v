module Counter_16bit_wLoad(
    input wire Clock,
    input wire Reset,
    input wire Load,
    input wire EN,
    input wire [15:0] Count_In,
    output reg [15:0] Count_Out
);

always @(posedge Clock or posedge Reset)
begin
    if (Reset)
        Count_Out <= 16'd0;
    else if (Load)
        Count_Out <= Count_In;
    else if (EN)
        Count_Out <= Count_Out + 1'b1;
end

endmodule

module tg(
    output reg Clock,
    output reg Reset,
    output reg Load,
    output reg EN,
    output reg [15:0] Count_In,
    input [15:0] Count_Out
);

initial begin
    Clock = 0;
    forever #5 Clock = ~Clock;
end

initial begin
    $monitor($time,,,,
             " Reset=%b Load=%b EN=%b Count_In=%d Count_Out=%d",
             Reset, Load, EN, Count_In, Count_Out);

    Reset = 1;
    Load = 0;
    EN = 0;
    Count_In = 0;

    #10 Reset = 0;

    #10 EN = 1;

    #30 Load = 1;
         Count_In = 16'd100;

    #10 Load = 0;

    #30 EN = 1;

    #20 Load = 1;
         Count_In = 16'd500;

    #10 Load = 0;

    #30 $finish;
end

endmodule

module wb;

wire Clock;
wire Reset;
wire Load;
wire EN;
wire [15:0] Count_In;
wire [15:0] Count_Out;

Counter_16bit_wLoad dut(
    Clock,
    Reset,
    Load,
    EN,
    Count_In,
    Count_Out
);

tg tb(
    Clock,
    Reset,
    Load,
    EN,
    Count_In,
    Count_Out
);

endmodule