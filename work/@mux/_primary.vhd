library verilog;
use verilog.vl_types.all;
entity Mux is
    port(
        sel             : in     vl_logic;
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end Mux;
