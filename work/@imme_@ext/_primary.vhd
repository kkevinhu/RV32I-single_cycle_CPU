library verilog;
use verilog.vl_types.all;
entity Imme_Ext is
    port(
        inst            : in     vl_logic_vector(31 downto 0);
        imme_ext_out    : out    vl_logic_vector(31 downto 0)
    );
end Imme_Ext;
