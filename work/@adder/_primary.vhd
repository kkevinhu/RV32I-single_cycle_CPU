library verilog;
use verilog.vl_types.all;
entity Adder is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        C               : out    vl_logic_vector(31 downto 0)
    );
end Adder;
