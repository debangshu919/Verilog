module SystemK(
    input wire [3:0] ABCD,
    output reg F
);

always @(*) begin
    case (ABCD)
        4'd3,
        4'd7,
        4'd11,
        4'd15: F = 1'b0;
        default: F = 1'b1;
    endcase
end

endmodule

module tg(
    output reg [3:0] ABCD,
    input F
);

integer infile, outfile;
integer status;

initial begin
    infile  = $fopen("input.txt", "r");
    outfile = $fopen("output.txt", "w");

    if(infile == 0) begin
        $display("ERROR: Cannot open input.txt");
        $finish;
    end

    while(!$feof(infile))
    begin
        status = $fscanf(infile, "%b\n", ABCD);

        #10;

        $fwrite(outfile,
                "ABCD=%b F=%b\n",
                ABCD, F);
    end

    $fclose(infile);
    $fclose(outfile);

    $finish;
end

endmodule

module wb;

wire [3:0] ABCD;
wire F;

SystemK dut(ABCD, F);
tg tb(ABCD, F);

endmodule