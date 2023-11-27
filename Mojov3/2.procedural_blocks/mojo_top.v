module mojo_top(
    // 50MHz clock input
    input clk,
    // Input from reset button (active low)
    input rst_n,
    // cclk input from AVR, high when AVR is ready
    input cclk,
    // Outputs to the 8 onboard LEDs
    output [7:0]led,
    // AVR SPI connections
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    // AVR ADC channel select
    output [3:0] spi_channel,
    // Serial connections
    input avr_tx, // AVR Tx => FPGA Rx
    output avr_rx, // AVR Rx => FPGA Tx
    input avr_rx_busy // AVR Rx buffer full
    );

wire rst = ~rst_n; // make reset active high

// these signals should be high-z when not used
assign spi_miso = 1'bz;
assign avr_rx = 1'bz;
assign spi_channel = 4'bzzzz;

assign led[7:1] = 7'b0;

reg blink_state;
assign led[0] = blink_state;

reg [24:0] counter = 0;
reg [23:0] time_out = 50_000_000;

always @(posedge clk) begin
	if (~rst) begin
		if(counter <= time_out) begin
			counter <= counter + 1 ;
		end else begin
			counter <= 0;
			blink_state <= ~blink_state;
		end
	end else begin
		blink_state <= 1'b0;
	end
	
	
end

endmodule
