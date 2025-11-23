`ifndef SMC_CLONE_SV
`define SMC_CLONE_SV

class smc_clone #(type RSP = uvm_sequence_item);
    
    static function RSP clone(uvm_object from);
        RSP to;
        
        if (from == null) begin
            `uvm_fatal("CLONE_FAIL", "Source object is null")
            return null;
        end
        
        if (!$cast(to, from.clone())) begin
            `uvm_fatal("CLONE_FAIL", "Clone or cast failed")
            return null;
        end        

        return to;

    endfunction

endclass


`endif// SMC_CLONE_SV
