module unsig_altmult_accum2
(
	input [7:0] dataa,
	input [7:0] datab,
	input Clk, aclr, clken, sload,
	output reg [15:0] adder_out
);

	// Declare registers and wires
	reg  [15:0] dataa_reg, datab_reg;
	reg  sload_reg;
	reg	 [15:0] old_result;
	wire [15:0] multa;
	
	// Store the results of the operations on the current data
	assign multa = dataa_reg * datab_reg;
	
	// Store the value of the accumulation (or clear it)
	always @ (adder_out, sload_reg)
	begin
		if (sload_reg)
			old_result <= 0;
		else
			old_result <= adder_out;
	end
	
	// Clear or update data, as appropriate
	always @ (posedge Clk or posedge aclr)
	begin
		if (aclr)
		begin
			dataa_reg <= 0;
			datab_reg <= 0;
			sload_reg <= 0;
			adder_out <= 0;
		end
		
		else if (clken)
		begin
			dataa_reg <= dataa;
			datab_reg <= datab;
			sload_reg <= sload;
			adder_out[15:3] <= old_result[15:3] + multa[15:3];
			if (old_result[3] ^ multa[3] == 1)
			adder_out[2:0] <= 3'b111;
			else
			adder_out[2:0] <= old_result[2:0] + multa[2:0];
						
		end
	end
endmodule
