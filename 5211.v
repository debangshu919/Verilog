module counter_5bit_binary_up(
    output reg [4:0] Count
);

integer i;

initial
begin
    forever
    begin
        for(i = 0; i < 32; i = i + 1)
        begin
            Count = i;
            #10;
        end
    end
end

endmodule

module tg(
    input [4:0] Count
);

initial
begin
    $monitor($time,,,,"Count = %b", Count);

    #351 $finish;
end

endmodule

module wb;

wire [4:0] Count;

counter_5bit_binary_up dut(Count);
tg tb(Count);

endmodule