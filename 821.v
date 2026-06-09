module fsm1(
    output reg Dout,
    input wire Clock,
    input wire Reset,
    input wire Din
);

parameter Start  = 2'b00,
          Midway = 2'b01,
          Done   = 2'b10;

reg [1:0] present_state;
reg [1:0] next_state;

always @(posedge Clock or posedge Reset)
begin
    if (Reset)
        present_state <= Start;
    else
        present_state <= next_state;
end

always @(*)
begin
    case (present_state)

        Start:
            if (Din)
                next_state = Midway;
            else
                next_state = Start;

        Midway:
            if (Din)
                next_state = Done;
            else
                next_state = Start;

        Done:
            next_state = Start;

        default:
            next_state = Start;

    endcase
end

always @(*)
begin
    case (present_state)

        Start:
            Dout = 1'b0;

        Midway:
            if (Din)
                Dout = 1'b1;
            else
                Dout = 1'b0;

        Done:
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
    $monitor($time,,,," Din=%b Dout=%b Reset=%b",
             Din, Dout, Reset);

    Reset = 1;
    Din = 0;

    #10 Reset = 0;

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

fsm1 dut(
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