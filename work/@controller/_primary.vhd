library verilog;
use verilog.vl_types.all;
entity Controller is
    port(
        opcode          : in     vl_logic_vector(4 downto 0);
        func3           : in     vl_logic_vector(2 downto 0);
        func7           : in     vl_logic;
        b               : in     vl_logic;
        next_pc_sel     : out    vl_logic;
        im_w_en         : out    vl_logic_vector(3 downto 0);
        wb_en           : out    vl_logic;
        jb_op1_sel      : out    vl_logic;
        alu_op1_sel     : out    vl_logic;
        alu_op2_sel     : out    vl_logic;
        wb_sel          : out    vl_logic;
        dm_w_en         : out    vl_logic_vector(3 downto 0);
        \opcode_\       : out    vl_logic_vector(4 downto 0);
        \func3_\        : out    vl_logic_vector(2 downto 0);
        \func7_\        : out    vl_logic
    );
end Controller;
