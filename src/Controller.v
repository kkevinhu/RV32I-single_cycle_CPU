module Controller(
    input [4:0]  opcode,
    input [2:0]  func3,
    input        func7,
    input        b,
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
        5'b01100 : begin        // R type
            next_pc_sel <= 1;
            im_w_en <= 0;
            wb_en <= 1;
            jb_op1_sel <= 1'bx;
            alu_op1_sel <= 0;
            alu_op2_sel <= 0;
            wb_sel <= 0;
            dm_w_en <= 0;
        end
        5'b00100 : begin        // immediate
            next_pc_sel <= 1;
            im_w_en <= 0;
            wb_en <= 1;
            jb_op1_sel <= 1'bx;
            alu_op1_sel <= 0;
            alu_op2_sel <= 1;
            wb_sel <= 0;
            dm_w_en <= 0;
        end
        5'b00000 : begin         // load
            next_pc_sel <= 1;
            im_w_en <= 0;
            wb_en <= 1;
            jb_op1_sel <= 1'bx;
            alu_op1_sel <= 0;
            alu_op2_sel <= 1;
            wb_sel <= 1;
            dm_w_en <= 0;
        end
        5'b11001 : begin       // jalr
            next_pc_sel <= 0;
            im_w_en <= 0;
            wb_en <= 1;
            jb_op1_sel <= 1;
            alu_op1_sel <= 1;
            alu_op2_sel <= 1'bx; 
            wb_sel <= 0;
            dm_w_en <= 0;
        end
        5'b01000 : begin       // store
            next_pc_sel <= 1;
            im_w_en <= 0;
            wb_en <= 0;
            jb_op1_sel <= 1'bx;
            alu_op1_sel <= 0;
            alu_op2_sel <= 1;
            wb_sel <= 1'bx;
            case (func3)
                3'b000 : dm_w_en <= 4'b0001; // sb
                3'b001 : dm_w_en <= 4'b0011; // sh
                3'b010 : dm_w_en <= 4'b1111; // sw
            endcase
        end
        5'b11000 : begin      // branch
            next_pc_sel <= !b; 
            im_w_en <= 0;
            wb_en <= 0;
            jb_op1_sel <= 1'b1;
            alu_op1_sel <= 0;
            alu_op2_sel <= 0;
            wb_sel <= 1'bx;
            dm_w_en <= 0;
        end
        5'b01101 : begin      // lui
            next_pc_sel <= 1;
            im_w_en <= 0;
            wb_en <= 1;
            jb_op1_sel <= 1'bx;
            alu_op1_sel <= 1'bx;
            alu_op2_sel <= 1;
            wb_sel <= 0;
            dm_w_en <= 0;
        end
        5'b00101 : begin      // auipc
            next_pc_sel <= 1;
            im_w_en <= 0;
            wb_en <= 1;
            jb_op1_sel <= 1'bx;
            alu_op1_sel <= 1;
            alu_op2_sel <= 1;
            wb_sel <= 0;
            dm_w_en <= 0;
        end
        5'b11011 : begin      // jal
            next_pc_sel <= 0;
            im_w_en <= 0;
            wb_en <= 1;
            jb_op1_sel <= 1'bx;
            alu_op1_sel <= 1;
            alu_op2_sel <= 1'bx; 
            wb_sel <= 0;
            dm_w_en <= 0;
        end
    endcase
end
endmodule

/* opcode
R : 01100
I : 00100 00000 11001
S : 01000 
B : 11000
U : 01101 00101
J : 11011
*/