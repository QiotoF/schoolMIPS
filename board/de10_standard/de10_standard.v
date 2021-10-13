

module de10_standard
(
    input                       CLOCK2_50,
    input                       CLOCK3_50,
    input                       CLOCK4_50,
    input                       CLOCK_50,

    input            [3:0]      KEY,

    input            [9:0]      SW,


    output           [9:0]      LEDR,

    output           [6:0]      HEX0,
    output           [6:0]      HEX1,
    output           [6:0]      HEX2,
    output           [6:0]      HEX3,
    output           [6:0]      HEX4,
    output           [6:0]      HEX5,

    inout           [35:0]     GPIO
);

    // wires & inputs
    wire          clk;
    wire [7:0]    dip;
    wire          clkIn     =  CLOCK_50;
    wire          rst_n     =  KEY[0];
    wire          clkEnable =  dip[7] | ~KEY[1]; //SW [9] | ~KEY[1];
    wire [  3:0 ] clkDevide =  SW [8:5];
    wire [  4:0 ] regAddr   =  dip[4:0];//SW [4:0];
    wire [ 31:0 ] regData;

    assign dip[7:0] = GPIO[35:28];

    //cores
    sm_top sm_top
    (
        .clkIn      ( clkIn     ),
        .rst_n      ( rst_n     ),
        .clkDevide  ( clkDevide ),
        .clkEnable  ( clkEnable ),
        .clk        ( clk       ),
        .regAddr    ( regAddr   ),
        .regData    ( regData   )
    );

    //outputs
    assign LEDR[0]   = clk;
    assign LEDR[9:1] = regData[8:0];
    
    wire [ 31:0 ] h7segment = regData;

    // sm_hex_display digit_5 ( h7segment [23:20] , HEX5 [6:0] );
    // sm_hex_display digit_4 ( h7segment [19:16] , HEX4 [6:0] );
    sm_hex_display digit_3 ( h7segment [15:12] , HEX3 [6:0] );
    sm_hex_display digit_2 ( h7segment [11: 8] , HEX2 [6:0] );
    sm_hex_display digit_1 ( h7segment [ 7: 4] , HEX1 [6:0] );
    sm_hex_display digit_0 ( h7segment [ 3: 0] , HEX0 [6:0] );

     wire [6:0] digit0  = {~HEX0[6],~HEX0[5],~HEX0[4],~HEX0[3],~HEX0[2],~HEX0[1],~HEX0[0]};
	 wire [6:0] digit1  = {~HEX1[6],~HEX1[5],~HEX1[4],~HEX1[3],~HEX1[2],~HEX1[1],~HEX1[0]};
	 wire [6:0] digit2  = {~HEX2[6],~HEX2[5],~HEX2[4],~HEX2[3],~HEX2[2],~HEX2[1],~HEX2[0]};
	 wire [6:0] digit3  = {~HEX3[6],~HEX3[5],~HEX3[4],~HEX3[3],~HEX3[2],~HEX3[1],~HEX3[0]};

    sm_hex_display_digit segment_indicators ( digit0[6:0], digit1[6:0], digit2[6:0], digit3[6:0], CLOCK_50, GPIO[11:0] );

endmodule
