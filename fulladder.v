module fulladder (input a, b, cin,
                  output s, cout);
    assign s = a ^ b ^ cin;
    assign cout = (a&b) | (b&cin) | (a&cin);
endmodule

module tg (output reg a, b, cin,
           input s, cout);
    initial begin
        $monitor($time,,,,"[a, b, cin] = %b %b %b   s = %b    c = %b", a, b, cin, s, cout);
        {a, b, cin} = 3'b000;

        #2
        {a, b, cin} = 3'b001;
        
        #2
        {a, b, cin} = 3'b010;
        
        #2
        {a, b, cin} = 3'b011;
        
        #2
        {a, b, cin} = 3'b100;
        
        #2
        {a, b, cin} = 3'b101;
        
        #2
        {a, b, cin} = 3'b110;
        
        #2
        {a, b, cin} = 3'b111;

        #3
        $finish;
    end
endmodule

module wb;
    wire a, b, cin, s, cout;
    fulladder dut(a, b, cin, s, cout);
    tg t0(a, b, cin, s, cout);
endmodule