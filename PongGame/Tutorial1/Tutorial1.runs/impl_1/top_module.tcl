proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/pantho/Videos/Tutorial1/Tutorial1.cache/wt [current_project]
  set_property parent.project_path /home/pantho/Videos/Tutorial1/Tutorial1.xpr [current_project]
  set_property ip_repo_paths /home/pantho/Videos/Tutorial1/Tutorial1.cache/ip [current_project]
  set_property ip_output_repo /home/pantho/Videos/Tutorial1/Tutorial1.cache/ip [current_project]
  add_files -quiet /home/pantho/Videos/Tutorial1/Tutorial1.runs/synth_1/top_module.dcp
  add_files -quiet /home/pantho/Videos/Tutorial1/Tutorial1.runs/clk_wiz_0_synth_1/clk_wiz_0.dcp
  set_property netlist_only true [get_files /home/pantho/Videos/Tutorial1/Tutorial1.runs/clk_wiz_0_synth_1/clk_wiz_0.dcp]
  add_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/design_1.bmm
  set_property SCOPED_TO_REF design_1 [get_files -all /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/design_1.bmm]
  set_property SCOPED_TO_CELLS {} [get_files -all /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/design_1.bmm]
  read_xdc -ref design_1_processing_system7_0_0 -cells inst /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_axi_gpio_0_0 -cells U0 /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0_board.xdc]
  read_xdc -ref design_1_axi_gpio_0_0 -cells U0 /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_rst_processing_system7_0_50M_0 /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_50M_0/design_1_rst_processing_system7_0_50M_0_board.xdc
  set_property processing_order EARLY [get_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_50M_0/design_1_rst_processing_system7_0_50M_0_board.xdc]
  read_xdc -ref design_1_rst_processing_system7_0_50M_0 /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_50M_0/design_1_rst_processing_system7_0_50M_0.xdc
  set_property processing_order EARLY [get_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_50M_0/design_1_rst_processing_system7_0_50M_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_axi_gpio_1_0 -cells U0 /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_1_0/design_1_axi_gpio_1_0_board.xdc
  set_property processing_order EARLY [get_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_1_0/design_1_axi_gpio_1_0_board.xdc]
  read_xdc -ref design_1_axi_gpio_1_0 -cells U0 /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_1_0/design_1_axi_gpio_1_0.xdc
  set_property processing_order EARLY [get_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_1_0/design_1_axi_gpio_1_0.xdc]
  read_xdc -mode out_of_context -ref clk_wiz_0 -cells inst /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc
  set_property processing_order EARLY [get_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]
  read_xdc -prop_thru_buffers -ref clk_wiz_0 -cells inst /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc
  set_property processing_order EARLY [get_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
  read_xdc -ref clk_wiz_0 -cells inst /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc
  set_property processing_order EARLY [get_files /home/pantho/Videos/Tutorial1/Tutorial1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
  read_xdc /home/pantho/Videos/Tutorial1/Tutorial1.srcs/constrs_1/imports/Tutorial1/ZYBO_Master.xdc
  link_design -top top_module -part xc7z010clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force top_module_opt.dcp
  report_drc -file top_module_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file top_module.hwdef}
  place_design 
  write_checkpoint -force top_module_placed.dcp
  report_io -file top_module_io_placed.rpt
  report_utilization -file top_module_utilization_placed.rpt -pb top_module_utilization_placed.pb
  report_control_sets -verbose -file top_module_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force top_module_routed.dcp
  report_drc -file top_module_drc_routed.rpt -pb top_module_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file top_module_timing_summary_routed.rpt -rpx top_module_timing_summary_routed.rpx
  report_power -file top_module_power_routed.rpt -pb top_module_power_summary_routed.pb
  report_route_status -file top_module_route_status.rpt -pb top_module_route_status.pb
  report_clock_utilization -file top_module_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force top_module.mmi }
  catch { write_bmm -force top_module_bd.bmm }
  write_bitstream -force top_module.bit 
  catch { write_sysdef -hwdef top_module.hwdef -bitfile top_module.bit -meminfo top_module.mmi -file top_module.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

