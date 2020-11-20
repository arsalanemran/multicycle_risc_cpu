module RISCVCPU (clk, reset, DataAdr, MemOut, PC, PCWrite,PCWriteCond,
ALUCtl, Zero, tempE, PCWriteE, MDR, ALUOut, IR,
PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, stateNum, ALUResultOut, A, B, RS1, RS2, ALUAin, ALUBin);


// parameter LD = 7'b000_0011, SD = 7'b010_0011, BEQ = 7'b110_0011, ALUop
// = 7'b001_0011;

input logic clk, reset;
output logic [63:0] MemOut, PC,MDR, ALUOut, IR,ALUResultOut, A, B , RS1, RS2, ALUAin, ALUBin;
output logic [31:0] DataAdr ;

output logic [3:0] ALUCtl, stateNum; // the ALU control lines
output logic Zero, tempE, PCWriteE,
PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst; // the Zero out signal from the ALU




// reg [2:0] state;
//logic [1:0] ALUOp, ALUSrcB;
logic [6:0] opcode;

//logic MemtoReg, MemRead, MemWrite, IorD, RegWrite, IRWrite, ALUSrcA, PCSource, RegDst;


// DataMemory dataMemory(clk, MemWrite, MemRead, DataAdr, B, MemOut);


// Create an instance of the RISC-V datapath 
// the inputs are the control signals + MemOut
// outputs are opcode, DataAdr + B(RS2 - for store instruction)
Datapath RISCVDP (ALUOp, MemtoReg, MemRead, MemWrite, IorD, RegWrite,
IRWrite,
PCWrite, PCWriteCond, ALUSrcA, ALUSrcB, PCSource,
opcode, clk, RegDst, MemOut, DataAdr, B, reset, PC,
ALUCtl, Zero, tempE, PCWriteE, MDR, ALUOut, IR ,ALUResultOut, A, B, RS1, RS2, ALUAin, ALUBin);



Controller RISCVC (clk, reset, opcode, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, stateNum);






// initial begin state = 1; end // start the state machine in state 1
// // These are the definitions of the control signals
// assign MemoryOp = (opcode == LD) || (opcode == SD); // a memory // MemoryOp o hazf krdm signalesho
// operation
// assign ALUOp = ((state == 1) || (state == 2) || ((state == 3) &&
// MemoryOp)) ? 2'b00 : // add
// ((state == 3) && (opcode == BEQ)) ? 2'b01 : 2'b10; //
// subtract or use function code
// assign MemtoReg = ((state == 4) && (opcode == ALUop)) ? 0 : 1;
// assign MemRead = (state == 1) || ((state == 4) && (opcode == LD));
// assign MemWrite = (state == 4) && (opcode == SD);
// assign IorD = (state == 1) ? 0 : 1;
// assign RegWrite = (state == 5) || ((state == 4) && (opcode == ALUop));
// assign IRWrite = (state == 1);
// assign PCWrite = (state == 1);
// assign PCWriteCond = (state == 3) && (opcode == BEQ);
// assign ALUSrcA = ((state == 1) || (state == 2)) ? 0 : 1;
// assign ALUSrcB = ((state == 1) || ((state == 3) && (opcode == BEQ)))?
// 2'b01 :
// (state == 2) ? 2'b11 :
// ((state == 3) && MemoryOp) ? 2'b10 : 2'b00; // memory
// operation or other
// assign PCSource = (state == 1) ? 0 : 1;
// // Here is the state machine, which only has to sequence states
// always @(posedge clk)
// begin // all state updates on a positive clk edge
// case (state)
// 1: state <= 2; // unconditional next state
// 2: state <= 3; // unconditional next state
// 3: state <= (opcode == BEQ) ? 1 : 4; // branch go back else next
// state
// 4: state <= (opcode == LD) ? 5 : 1; // R-type and SD finish
// 5: state <= 1; // go back
// endcase
// end
endmodule