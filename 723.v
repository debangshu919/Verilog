module RegisterX_32bit_RTL(
    input wire Clock,
    input wire Reset,
    input wire EN,
    input wire [31:0] Data_In,
    output reg [31:0] Data_Out
);

always @(posedge Clock)
begin
    if (Reset)
        Data_Out <= 32'b0;
    else if (EN)
        Data_Out <= Data_In;
end

endmodule

module tg(
    output reg Clock,
    output reg Reset,
    output reg EN,
    output reg [31:0] Data_In,
    input [31:0] Data_Out
);

initial begin
    Clock = 0;
    forever #5 Clock = ~Clock;
end

initial begin
    $monitor($time,,,,
             " Reset=%b EN=%b Data_In=%h Data_Out=%h",
             Reset, EN, Data_In, Data_Out);

    Reset = 1;
    EN = 0;
    Data_In = 32'h00000000;

    #10 Reset = 0;

    #10 EN = 1; Data_In = 32'hA5A5A5A5;
    #10 Data_In = 32'h12345678;

    #10 EN = 0; Data_In = 32'hFFFFFFFF;

    #10 EN = 1; Data_In = 32'hDEADBEEF;

    #10 Reset = 1;

    #10 Reset = 0; EN = 1; Data_In = 32'hCAFEBABE;

    #20 $finish;
end

endmodule

module wb;

wire Clock;
wire Reset;
wire EN;
wire [31:0] Data_In;
wire [31:0] Data_Out;

RegisterX_32bit_RTL dut(
    Clock,
    Reset,
    EN,
    Data_In,
    Data_Out
);

tg tb(
    Clock,
    Reset,
    EN,
    Data_In,
    Data_Out
);

endmodule