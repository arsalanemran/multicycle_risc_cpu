// module DataMemory(input logic clk, MemWrite, MemRead,
// input logic [63:0] DataAdr,
// input logic [63:0] WriteData,
// output logic [63:0] MemOut);


// logic [63:0] RAM[0:1023];

// initial 
//     begin 
//     // load datas
//     RAM[0] <= 64'd1;
//     RAM[1] <= 64'd2;
//     RAM[2] <= 64'd3;
//     RAM[3] <= 64'd4;
//     RAM[4] <= 64'd10;

//     // load instructions 
//     RAM[10] <=  64'b00000000000000001011010100000011;
//     RAM[11] <=  64'b00000110000000001000010001100011;
//     RAM[12] <=  64'b00000000000000000011001000000011;
//     RAM[13] <=  64'b01100110010001010110001010000000;
//     RAM[14] <=  64'b00000000000000101011000000100011;
//     RAM[15] <=  64'b00000000010000000000000000110011;
//     RAM[16] <=  64'b00000110101001010000010001100011;

//     end
		  
// 	 assign MemOut = (MemRead) ? RAM[DataAdr >> 3] : 0; // double-word aligned
// 	 always @(posedge clk)
// 	 if (MemWrite) RAM[DataAdr >> 3] <= WriteData;



    module DataMemory(input logic clock,
                input logic MemWrite, MemRead,
                input logic [63:0] DataAdr,
                input logic [63:0] WriteData,
                input logic [63:0] WriteAddr,
                output logic [63:0] MemOut);

        logic [63:0] Memory[0:1023];

        initial 
        begin 
        // load datas
        Memory[0] <= 64'd1;
        Memory[1] <= 64'd2;
        Memory[2] <= 64'd3;
        Memory[3] <= 64'd4;
        Memory[4] <= 64'd10;

        // load instructions 
        Memory[10] <=  64'b00000000000000001011010100000011;
        Memory[11] <=  64'b00000010000000001000010001100011;
        Memory[12] <=  64'b00000000000000000011001000000011;
        Memory[13] <=  64'b01100110010001010110001010110011;
        Memory[14] <=  64'b00000000000000101011000000100011;
        Memory[15] <=  64'b00000000010000000000000000110011;
        Memory[16] <=  64'b11111100101001010000100011100011;
        end

         assign MemOut = MemRead ? Memory[DataAdr >> 3] : 0;
	//assign MemOut = MemRead ? Memory[(IorD ? WriteAddr : DataAdr) >> 3] : 0;	
        always @(posedge clock)
    begin
        if (MemWrite) Memory[WriteAddr >> 3] <= WriteData;
    end

endmodule

