module Counter_16bit_Up(
    input wire Clock,
    input wire Reset,
    output reg [15:0] Count_Out
);

always @(posedge Clock or posedge Reset)
begin
    if (Reset)
        Count_Out <= 16'd0;
    else if (Count_Out >= 16'd60000)
        Count_Out <= 16'd0;
    else
        Count_Out <= Count_Out + 1'b1;
end

endmodule

module tg(
    output reg Clock,
    output reg Reset,
    input [15:0] Count_Out
);

initial begin
    Clock = 0;
    forever #5 Clock = ~Clock;
end

initial begin
    $monitor($time,,,," Count_Out = %d", Count_Out);

    Reset = 1;
    #10 Reset = 0;

    #20 dut.Count_Out = 16'd59998;

    #50 $finish;
end

endmodule

module wb;

wire Clock;
wire Reset;
wire [15:0] Count_Out;

Counter_16bit_Up dut(
    Clock,
    Reset,
    Count_Out
);

tg tb(
    Clock,
    Reset,
    Count_Out
);

endmodule