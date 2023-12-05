`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:11:15 11/28/2023 
// Design Name: 
// Module Name:    clk_source 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_source #(FREQ = 50_000_000) (
    input clk_in,
    input rst,
    output reg clk_out
    );

localparam freq_in = 50_000_000;
localparam max_counter = freq_in/(FREQ*2);

reg [24:0] counter = 0;

always @(posedge clk_in) begin
	if(~rst) begin
		if (counter <= max_counter) begin
			counter <= counter + 1;
		end else begin
			counter <= 0;
			clk_out <= ~clk_out;
		end
	end else begin
		clk_out <= 1'b0;
	end
end


endmodule
