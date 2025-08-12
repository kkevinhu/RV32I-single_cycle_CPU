`include "./include.v"

module Controller(
    input [4:0]      opcode,
    input [2:0]      func3,
    input            func7,
    input            b,
    output reg       next_pc_sel,
    output reg  [3:0] im_w_en,
    output reg       wb_en,
    output reg       jb_op1_sel,
    output reg       alu_op1_sel,
    output reg       alu_op2_sel,
    output reg       wb_sel,
    output reg [3:0] dm_w_en,
    output     [4:0] opcode_,
    output     [2:0] func3_,
    output           func7_
);

assign opcode_ = opcode;
assign func3_  = func3;
assign func7_  = func7;

always @(*) begin
    case (opcode)
        `R_TYPE : begin 
            next_pc_sel <= 1'b1;
            im_w_en     <= 4'd0;
            wb_en       <= 1'b1;
            jb_op1_sel  <= 1'bx;
            alu_op1_sel <= 1'b0;
            alu_op2_sel <= 1'b0;
            wb_sel      <= 1'b0;
            dm_w_en     <= 4'd0;
        end
        `IMME : begin
            next_pc_sel <= 1'b1;
            im_w_en     <= 4'd0;
            wb_en       <= 1'b1;
            jb_op1_sel  <= 1'bx;
            alu_op1_sel <= 1'b0;
            alu_op2_sel <= 1'b1;
            wb_sel      <= 1'b0;
            dm_w_en     <= 4'd0;
        end
        `LOAD : begin 
            next_pc_sel <= 1'b1;
            im_w_en     <= 4'd0;
            wb_en       <= 1'b1;
            jb_op1_sel  <= 1'bx;
            alu_op1_sel <= 1'b0;
            alu_op2_sel <= 1'b1;
            wb_sel      <= 1'b1;
            dm_w_en     <= 4'd0;
        end
        `JALR : begin      
            next_pc_sel <= 1'b0;
            im_w_en     <= 4'd0;
            wb_en       <= 1'b1;
            jb_op1_sel  <= 1'b0;
            alu_op1_sel <= 1'b1;
            alu_op2_sel <= 1'bx; 
            wb_sel      <= 1'b0;
            dm_w_en     <= 4'd0;
        end
        `STORE : begin  
            next_pc_sel <= 1'b1;
            im_w_en     <= 4'd0;
            wb_en       <= 1'b0;
            jb_op1_sel  <= 1'bx;
            alu_op1_sel <= 1'b0;
            alu_op2_sel <= 1'b1;
            wb_sel      <= 1'bx;
            case (func3)
                `S_BYTE : dm_w_en <= 4'b0001;
                `S_HALF : dm_w_en <= 4'b0011;
                `S_WORD : dm_w_en <= 4'b1111; 
            endcase
        end
        `BRANCH : begin
            next_pc_sel <= !b; 
            im_w_en     <= 4'd0;
            wb_en       <= 1'b0;
            jb_op1_sel  <= 1'b1;
            alu_op1_sel <= 1'b0;
            alu_op2_sel <= 1'b0;
            wb_sel      <= 1'bx;
            dm_w_en     <= 4'd0;
        end
        `LUI : begin 
            next_pc_sel <= 1'b1;
            im_w_en     <= 4'd0;
            wb_en       <= 1'b1;
            jb_op1_sel  <= 1'bx;
            alu_op1_sel <= 1'bx;
            alu_op2_sel <= 1'b1;
            wb_sel      <= 1'b0;
            dm_w_en     <= 4'd0;
        end
        `AUIPC : begin 
            next_pc_sel <= 1'b1;
            im_w_en     <= 4'd0;
            wb_en       <= 1'b1;
            jb_op1_sel  <= 1'bx;
            alu_op1_sel <= 1'b1;
            alu_op2_sel <= 1'b1;
            wb_sel      <= 1'b0;
            dm_w_en     <= 4'd0;
        end
        `JAL : begin 
            next_pc_sel <= 1'b0;
            im_w_en     <= 4'd0;
            wb_en       <= 1'b1;
            jb_op1_sel  <= 1'b1;
            alu_op1_sel <= 1'b1;
            alu_op2_sel <= 1'bx; 
            wb_sel      <= 1'b0;
            dm_w_en     <= 4'd0;
        end
    endcase
end
endmodule