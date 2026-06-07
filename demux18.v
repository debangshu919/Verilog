module demux18 (input A,
                input [2:0] Sel,
                output [7:0] F);
    assign F = (Sel == 3'b000) ? (A ? 8'b00000001 : 8'b00000000) :
                 (Sel == 3'b001) ? (A ? 8'b00000010 : 8'b00000000) :
                 (Sel == 3'b010) ? (A ? 8'b00000100 : 8'b00000000) :
                 (Sel == 3'b011) ? (A ? 8'b00001000 : 8'b00000000) :
                 (Sel == 3'b100) ? (A ? 8'b00010000 : 8'b00000000) :
                 (Sel == 3'b101) ? (A ? 8'b00100000 : 8'b00000000) :
                 (Sel == 3'b110) ? (A ? 8'b01000000 : 8'b00000000) :
                                 (A ? 8'b10000000 : 8'b00000000);

endmodule

module tg (output reg A,
           output reg [2:0] Sel,
           input [7:0] F);

    initial begin
        $monitor($time,,,,"A = %b    Sel = %b    F = %b", A, Sel, F);
        A = 1'b1;
        Sel = 3'b000;

        #2
        Sel = 3'b001;
        
        #2
        Sel = 3'b010;
        
        #2
        Sel = 3'b011;
        
        #2
        Sel = 3'b100;
        
        #2
        Sel = 3'b101;
        
        #2
        Sel = 3'b110;
        
        #2
        Sel = 3'b111;

        #3
        $finish;
    end
endmodule

module wb;
    wire A;
    wire [2:0] Sel;
    wire [7:0] F;
    demux18 dut(A, Sel, F);
    tg t0(A, Sel, F);
endmodule