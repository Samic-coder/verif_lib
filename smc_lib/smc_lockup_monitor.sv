`ifndef SMC_LOCKUP_MONITOR_SV
`define SMC_LOCKUP_MONITOR_SV

class smc_lockup_monitor extends uvm_component;

    uvm_callbacks_objection     m_heartbeat_objection;
    uvm_event                   m_heartbeat_event;
    uvm_heartbeat               m_heartbeat;

    time                        m_heartbeat_window;
    uvm_component               m_heartbeat_comps[$];


    `uvm_component_utils(smc_lockup_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);

        m_heartbeat_objection = new("m_heartbeat_objection");
        m_heartbeat_event     = new("m_heartbeat_event");
        m_heartbeat           = new("m_heartbeat", this.get_parent(), m_heartbeat_objection);

        uvm_config_db#(uvm_callbacks_objection)::set(m_parent, "*", "m_heartbeat_objection", m_heartbeat_objection);

    endfunction: new


    virtual function void set_mode(time heartbeat_window = 10us, uvm_heartbeat_modes mode = UVM_NO_HB_MODE);
        m_heartbeat_window = heartbeat_window;
        m_heartbeat.set_mode(mode);
    endfunction: set_mode


    virtual function void add_component(uvm_component comp);
        m_heartbeat_comps.push_back(comp);
    endfunction: add_component

     
    function void start_of_simulation_phase(uvm_phase phase);
        m_heartbeat.set_heartbeat(null, m_heartbeat_comps);
    endfunction: start_of_simulation_phase

    
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        m_heartbeat.start(m_heartbeat_event);
        
        forever begin
            #m_heartbeat_window;
            m_heartbeat_event.trigger();
        end

    endtask: run_phase

endclass

`endif //SMC_LOCKUP_MONITOR_SV
