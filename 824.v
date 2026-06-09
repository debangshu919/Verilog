module fsm2(
    output reg Dout,
    input wire Clock,
    input wire Reset,
    input wire Din
);

parameter S0 = 4'b0001,
          S1 = 4'b0010,
          S2 = 4'b0100,
          S3 = 4'b1000;

reg [3:0] present_state;
reg [3:0] next_state;

always @(posedge Clock or posedge Reset)
begin
    if (Reset)
        present_state <= S0;
    else
        present_state <= next_state;
end

always @(*)
begin
    case (present_state)

        S0:
            if (Din)
                next_state = S1;
            else
                next_state = S0;

        S1:
            if (Din)
                next_state = S3;
            else
                next_state = S2;

        S2:
            if (Din)
                next_state = S3;
            else
                next_state = S0;

        S3:
            if (Din)
                next_state = S0;
            else
                next_state = S3;

        default:
            next_state = S0;

    endcase
end

always @(*)
begin
    case (present_state)

        S0:
            Dout = 1'b0;

        S1:
            if (Din)
                Dout = 1'b0;
            else
                Dout = 1'b1;

        S2:
            if (Din)
                Dout = 1'b1;
            else
                Dout = 1'b0;

        S3:
            if (Din)
                Dout = 1'b1;
            else
                Dout = 1'b0;

        default:
            Dout = 1'b0;

    endcase
end

endmodule

module tg(
    output reg Clock,
    output reg Reset,
    output reg Din,
    input Dout
);

initial begin
    Clock = 0;
    forever #5 Clock = ~Clock;
end

initial begin
    $monitor($time,,,,
             " Din=%b Dout=%b Reset=%b",
             Din, Dout, Reset);

    Reset = 1;
    Din = 0;

    #10 Reset = 0;

    #10 Din = 1;
    #10 Din = 0;
    #10 Din = 1;
    #10 Din = 1;
    #10 Din = 0;
    #10 Din = 1;
    #10 Din = 0;

    #20 $finish;
end

endmodule

module wb;

wire Clock;
wire Reset;
wire Din;
wire Dout;

fsm2 dut(
    Dout,
    Clock,
    Reset,
    Din
);

tg tb(
    Clock,
    Reset,
    Din,
    Dout
);

endmodule