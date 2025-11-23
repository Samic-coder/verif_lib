`ifndef SMC_MACROS_SV
`define SMC_MACROS_SV

`define check_null_handle(handle)\
    if(handle == null)
        `uvm_fatal("NULL_HANDLE", $sformatf("Null handle: %s", `"handle`"))

`define insert_delay_cycles(clk, count) \
    if(count > 0) begin                 \
        repeat(count) @(posedge clk);   \
    end







`endif // SMC_MACROS_SV
