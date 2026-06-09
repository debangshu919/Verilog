module tlc(
    output reg GRN,
    output reg YLW,
    output reg RED,

    input wire Clock,
    input wire Reset,
    input wire CAR,
    input wire TIMEOUT
);

parameter GREEN  = 2'b00,
          YELLOW = 2'b01,
          RED_S  = 2'b10;

reg [1:0] present_state;
reg [1:0] next_state;

always @(posedge Clock or posedge Reset)
begin
    if (Reset)
        present_state <= GREEN;
    else
        present_state <= next_state;
end

always @(*)
begin
    case (present_state)

        GREEN:
            if (CAR)
                next_state = YELLOW;
            else
                next_state = GREEN;

        YELLOW:
            next_state = RED_S;

        RED_S:
            if (TIMEOUT)
                next_state = GREEN;
            else
                next_state = RED_S;

        default:
            next_state = GREEN;

    endcase
end

always @(*)
begin
    GRN = 0;
    YLW = 0;
    RED = 0;

    case (present_state)

        GREEN:
            GRN = 1;

        YELLOW:
            YLW = 1;

        RED_S:
            RED = 1;

    endcase
end

endmodule

module tg(
    output reg Clock,
    output reg Reset,
    output reg CAR,
    output reg TIMEOUT,

    input GRN,
    input YLW,
    input RED
);

initial begin
    Clock = 0;
    forever #5 Clock = ~Clock;
end

initial begin
    $monitor($time,,,,
        " CAR=%b TIMEOUT=%b GRN=%b YLW=%b RED=%b",
        CAR, TIMEOUT, GRN, YLW, RED);

    Reset = 1;
    CAR = 0;
    TIMEOUT = 0;

    #10 Reset = 0;

    #20 CAR = 1;

    #10 CAR = 0;

    #30 TIMEOUT = 1;

    #10 TIMEOUT = 0;

    #20 CAR = 1;
    #10 CAR = 0;

    #20 TIMEOUT = 1;
    #10 TIMEOUT = 0;

    #20 $finish;
end

endmodule

module wb;

wire Clock;
wire Reset;
wire CAR;
wire TIMEOUT;

wire GRN;
wire YLW;
wire RED;

tlc dut(
    GRN,
    YLW,
    RED,
    Clock,
    Reset,
    CAR,
    TIMEOUT
);

tg tb(
    Clock,
    Reset,
    CAR,
    TIMEOUT,
    GRN,
    YLW,
    RED
);

endmodule