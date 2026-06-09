module Counter_16bit_wEN(
    input wire Clock,
    input wire Reset,
    input wire EN,
    output reg [15:0] Count_Out
);

always @(posedge Clock or posedge Reset)
begin
    if (Reset)
        Count_Out <= 16'd0;
    else if (EN)
        Count_Out <= Count_Out + 1'b1;
end

endmodule

module tg(
    output reg Clock,
    output reg Reset,
    output reg EN,
    input [15:0] Count_Out
);

initial begin
    Clock = 0;
    forever #5 Clock = ~Clock;
end

initial begin
    $monitor($time,,,,
             " EN=%b Count_Out=%d",
             EN, Count_Out);

    Reset = 1;
    EN = 0;

    #10 Reset = 0;

    #10 EN = 1;

    #40 EN = 0;

    #20 EN = 1;

    #40 $finish;
end

endmodule

module wb;

wire Clock;
wire Reset;
wire EN;
wire [15:0] Count_Out;

Counter_16bit_wEN dut(
    Clock,
    Reset,
    EN,
    Count_Out
);

tg tb(
    Clock,
    Reset,
    EN,
    Count_Out
);

endmodule