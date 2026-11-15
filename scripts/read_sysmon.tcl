set server localhost:3121

open_hw_manager
try {
    connect_hw_server -url $server
    set targets [get_hw_targets -quiet]
    if {[llength $targets] != 1} { error "Expected one target: $targets" }
    open_hw_target [lindex $targets 0]
    try {
        set devices [get_hw_devices]
        if {[llength $devices] != 1} { error "Expected one FPGA: $devices" }
        set device [lindex $devices 0]
        set sysmons [get_hw_sysmons -quiet -of_objects $device]
        if {[llength $sysmons] != 1} { error "Expected one SysMon: $sysmons" }
        set sysmon [lindex $sysmons 0]
        refresh_hw_sysmon -properties {TEMPERATURE VCCINT VCCAUX VCCBRAM} $sysmon
        puts "DEVICE=[get_property PART $device]"
        puts "IDCODE=[get_property IDCODE_HEX $device]"
        foreach property {TEMPERATURE VCCINT VCCAUX VCCBRAM} {
            puts "SYSMON_${property}=[get_property $property $sysmon]"
        }
    } finally {
        close_hw_target
    }
} finally {
    disconnect_hw_server
    close_hw_manager
}
