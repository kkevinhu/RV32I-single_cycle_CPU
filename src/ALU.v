`include "./include.v"

module ALU (
    input      [4:0]  opcode,
    input      [2:0]  func3,
    input             func7,
    input      [31:0] operand1,
    input      [31:0] operand2,
    output reg [31:0] alu_out
);

always @(*) begin
    case (opcode)
        `R_TYPE, `IMME : 
        begin
            case (func3)
                `ADD_OR_SUB : 
                begin
                    if (opcode == `R_TYPE)
                        alu_out <= (func7) ? (operand1 - operand2) : (operand1 + operand2);
                    else
                        alu_out <= operand1 + operand2;
                end
                `SLL        : alu_out <= operand1 << operand2[4:0]; 
                `SLT        : alu_out <= $signed(operand1)   < $signed(operand2);
                `SLTU       : alu_out <= $unsigned(operand1) < $unsigned(operand2);
                `XOR        : alu_out <= operand1 ^ operand2;
                `SRL_OR_SRA : alu_out <= (func7) ? $signed(($signed(operand1) >>> operand2[4:0])) : (operand1 >> operand2[4:0]);
                `OR         : alu_out <= operand1 | operand2;
                `AND        : alu_out <= operand1 & operand2;                
            endcase
        end
        `BRANCH : 
        begin   
            case (func3)
                `BEQ  : alu_out <= (operand1 == operand2);
                `BNE  : alu_out <= (operand1 != operand2);
                `BLT  : alu_out <= ($signed(operand1)   < $signed(operand2));
                `BLTU : alu_out <= ($unsigned(operand1) < $unsigned(operand2)); 
                `BGE  : alu_out <= ($signed(operand1) >= $signed(operand2)); 
                `BGEU : alu_out <= ($unsigned(operand1) >= $unsigned(operand2));
            endcase
        end
        `LOAD, `STORE : alu_out <= operand1 + operand2;
        `JAL , `JALR  : alu_out <= operand1 + 4;
        `LUI          : alu_out <= operand2;
        `AUIPC        : alu_out <= operand1 + operand2;
    endcase
end
endmodule