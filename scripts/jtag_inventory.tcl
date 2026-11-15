open_hw_manager
try {
    connect_hw_server -url localhost:3121
    foreach target [get_hw_targets -quiet] { puts "JTAG_TARGET=$target" }
} finally {
    disconnect_hw_server
    close_hw_manager
}
