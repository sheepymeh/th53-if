set server localhost:13121

open_hw_manager
try {
    connect_hw_server -url $server
    set targets [get_hw_targets -quiet]
    if {[llength $targets] != 1} { error "Expected one target: $targets" }
    open_hw_target [lindex $targets 0]
    try {
        set devices [get_hw_devices]
        if {[llength $devices] != 1} { error "Expected one FPGA: $devices" }
        set sysmons [get_hw_sysmons -quiet -of_objects [lindex $devices 0]]
        if {[llength $sysmons] != 1} { error "Expected one SysMon: $sysmons" }
        set sysmon [lindex $sysmons 0]
        while {1} {
            refresh_hw_sysmon -properties {VCCINT} $sysmon
            puts "SYSMON_VCCINT_V=[get_property VCCINT $sysmon]"
            after 1000
        }
    } finally {
        close_hw_target
    }
} finally {
    disconnect_hw_server
    close_hw_manager
}
