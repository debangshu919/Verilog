module decoder416 (
    input [3:0] abcd,
    output [15:0] f
);

    assign f[0]  = ~abcd[3] & ~abcd[2] & ~abcd[1] & ~abcd[0];
    assign f[1]  = ~abcd[3] & ~abcd[2] & ~abcd[1] &  abcd[0];
    assign f[2]  = ~abcd[3] & ~abcd[2] &  abcd[1] & ~abcd[0];
    assign f[3]  = ~abcd[3] & ~abcd[2] &  abcd[1] &  abcd[0];

    assign f[4]  = ~abcd[3] &  abcd[2] & ~abcd[1] & ~abcd[0];
    assign f[5]  = ~abcd[3] &  abcd[2] & ~abcd[1] &  abcd[0];
    assign f[6]  = ~abcd[3] &  abcd[2] &  abcd[1] & ~abcd[0];
    assign f[7]  = ~abcd[3] &  abcd[2] &  abcd[1] &  abcd[0];

    assign f[8]  =  abcd[3] & ~abcd[2] & ~abcd[1] & ~abcd[0];
    assign f[9]  =  abcd[3] & ~abcd[2] & ~abcd[1] &  abcd[0];
    assign f[10] =  abcd[3] & ~abcd[2] &  abcd[1] & ~abcd[0];
    assign f[11] =  abcd[3] & ~abcd[2] &  abcd[1] &  abcd[0];

    assign f[12] =  abcd[3] &  abcd[2] & ~abcd[1] & ~abcd[0];
    assign f[13] =  abcd[3] &  abcd[2] & ~abcd[1] &  abcd[0];
    assign f[14] =  abcd[3] &  abcd[2] &  abcd[1] & ~abcd[0];
    assign f[15] =  abcd[3] &  abcd[2] &  abcd[1] &  abcd[0];

endmodule

module tg (
    output reg [3:0] abcd,
    input [15:0] f
);
    initial begin
        $monitor($time,,,,"abcd = %b   f = %b", abcd, f);
        abcd = 4'b0000;

        #2
        abcd = 4'b0001;
        
        #2
        abcd = 4'b0010;
        
        #2
        abcd = 4'b0011;
        
        #2
        abcd = 4'b0100;
        
        #2
        abcd = 4'b0101;
        
        #2
        abcd = 4'b0110;
        
        #2
        abcd = 4'b0111;
        
        #2
        abcd = 4'b1000;
        
        #2
        abcd = 4'b1001;
        
        #2
        abcd = 4'b1010;
        
        #2
        abcd = 4'b1011;
        
        #2
        abcd = 4'b1100;
        
        #2
        abcd = 4'b1101;
        
        #2
        abcd = 4'b1110;
        
        #2
        abcd = 4'b1111;        

        #3
        $finish;
    end
endmodule

module wb;
    wire [3:0] abcd;
    wire [15:0] f;
    decoder416 dut(abcd, f);
    tg t0(abcd, f);
endmodule