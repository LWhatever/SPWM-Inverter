module BUS
(
input clk,rst_n,
input [11:0]ADDR,
input RD,WR,
inout [15:0]DATA,
//output reg software_rst_n,
output cs0,cs1,cs2,cs3,//cs4,cs5,cs6,cs7,
//output [7:0]addr,
//output [23:0]addr24,
input [15:0]rddat0,rddat1,rddat2,rddat3,rddat4,rddat5,//rddat6,rddat7,
output reg [15:0] wrdat
);

assign cs0=(ADDR[11:8]==4'd0);
assign cs1=(ADDR[11:8]==4'd1);
assign cs2=(ADDR[11:8]==4'd2);
assign cs3=(ADDR[11:8]==4'd3);

//wire ADDR_H_cs=(ADDR[11:8]==4'd15);
reg [15:0]rdmux;
always @(posedge clk)
	case(ADDR[11:8])
	4'd0:rdmux<=rddat0;
	4'd1:rdmux<=rddat1;
	4'd2:rdmux<=rddat2;
	4'd3:rdmux<=rddat3;
	4'd4:rdmux<=rddat4;
	4'd5:rdmux<=rddat5;
	default:;
	endcase

//reg [15:0]ADDR_H;
//always @(posedge clk)
//	if(ADDR_H_cs&WR)
//		wrdat <= DATA;
//		case(ADDR[7:0])
//		8'd0:ADDR_H<=DATA;
//		8'd1:software_rst_n<=DATA[0];
//		endcase

always @(posedge WR)
	if(WR)
	wrdat <= DATA;

//assign wrdat = WR? DATA : 16'h0000;
assign DATA = RD? rdmux : 16'hzzzz;
//assign addr=ADDR[7:0];
//assign addr24={ADDR_H,ADDR[7:0]};
endmodule

	