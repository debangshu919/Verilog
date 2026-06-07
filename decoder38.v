module decoder38 (
    input [2:0] s,
    input e,
    output [7:0] out
);
    assign out[0] = e & ~s[2] & ~s[1] & ~s[0];
    assign out[1] = e & ~s[2] & ~s[1] & s[0]; 
    assign out[2] = e & ~s[2] & s[1] & ~s[0]; 
    assign out[3] = e & ~s[2] & s[1] & s[0]; 
    assign out[4] = e & s[2] & ~s[1] & ~s[0]; 
    assign out[5] = e & s[2] & ~s[1] & s[0]; 
    assign out[6] = e & s[2] & s[1] & ~s[0]; 
    assign out[7] = e & s[2] & s[1] & s[0];
endmodule

module tg (
    output reg [2:0] s,
    output reg e,
    input [7:0] out
);
    initial begin
        $monitor($time,,,,"s = %b   e = %b    out = %b", s, e, out);
        e = 1'b1;
        s = 3'b000;

        #2
        s = 3'b001;
        
        #2
        s = 3'b010;
        
        #2
        s = 3'b011;
        
        #2
        s = 3'b100;
        
        #2
        s = 3'b101;
        
        #2
        s = 3'b110;
        
        #2
        s = 3'b111;

        #3
        $finish;
    end
endmodule

module wb;
    wire [2:0] s;
    wire e;
    wire [7:0] out;
    decoder38 dut(s, e, out);
    tg t0(s, e, out);
endmodule