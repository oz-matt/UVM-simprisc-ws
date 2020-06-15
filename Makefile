# Makefile for UVM Lab4

LD_LIBRARY_PATH = ${NOVAS_HOME}/share/PLI/VCS/LINUX64

test = test_base
program_path = ./tests
PROGRAM_TOP = ./src/uvm_top.sv
package_path = ./src/pkg
PACKAGES = ${package_path}/*.svh
TEST_TOP = ${PACKAGES} ${PROGRAM_TOP}
rtl_path = ./uvm
DUT = dut/soc_top.sv
PROTOCOL_CHECKER = ./protocol_checker/axi_raddr_props.sv  ./protocol_checker/axi_rdata_props.sv ./protocol_checker/axi_waddr_props.sv  ./protocol_checker/axi_wdata_props.sv  ./protocol_checker/axi_wresp_props.sv 
TB_SCOREBOARD = ./uvm/scoreboard/sb_comparator.sv ./uvm/scoreboard/tb_scoreboard.sv 
TOP = ${PACKAGES} dut/testbench.sv

log = simv.log
verbosity = UVM_MEDIUM
uvm_ver = uvm-1.2
seed = 1
defines = +incdir+./uvm/scoreboard +incdir+./uvm +incdir+./
uvm_defines = UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR
plus = 
option = UVM_TR_RECORD +UVM_LOG_RECORD
trace =
#trace = UVM_OBJECTION_TRACE

compile_switches = -sverilog -lca -debug_access+all -assert enable_diag \
		+define+ASSERT_ON -y $VCS_HOME/packages/sva +libext+.v \
		+incdir+$VCS_HOME/packages/sva -P /home/disk/Verdi3_L-2016.06-1/share/PLI/VCS/LINUX64/novas.tab \
                 /home/disk/Verdi3_L-2016.06-1/share/PLI/VCS/LINUX64/pli.a -full64 +libext+.v+.h+.vh+.vlib \
		-kdb +vcs+vcdpluson -timescale="1ns/100ps" -l comp.log -ntb_opts ${uvm_ver} ${DUT} ${TOP} +define+${uvm_defines}+${defines}
runtime_switches = -l ${log} +UVM_TESTNAME=${test} +UVM_VERBOSITY=${verbosity} +${plus} +${trace} +${option}

tcl = packet.tcl
tr = packet_tr.tcl
cmdtr = uvm_tr.cmd
cmdi = std.cmd
cmd = none.cmd
prev = verdi.cmd

all: compile simv run

simv compile: ${DUT} ${TOP}
ifeq ($(CES64),TRUE)
	vcs -full64 ${compile_switches}
	@echo "Compiled in 64-bit mode"
else
	vcs ${compile_switches}
	@echo "Compiled in 32-bit mode"
endif

run:
	./simv +ntb_random_seed=${seed} ${runtime_switches}

random: simv
	./simv +ntb_random_seed_automatic ${runtime_switches}

dve:
	dve -vpd vcdplus.vpd -session debug_files/$(tcl) &

dve_tr:
	./simv +ntb_random_seed=$(seed) ${runtime_switches}
	dve -vpd vcdplus.vpd -session debug_files/$(tr) &

dve_i: simv
	./simv -gui=dve +ntb_random_seed=$(seed) ${runtime_switches} &

verdi:
	verdi -play verdi_scripts/${cmd} -nologo &

verdi_tr:
	./simv +ntb_random_seed=$(seed) ${runtime_switches} +UVM_VERDI_TRACE
	verdi -play verdi_scripts/${cmdtr} -nologo & 

verdi_a:
	./simv -assert success -assert verbose -assert report +ntb_random_seed=$(seed) ${runtime_switches} +UVM_VERDI_TRACE
	verdi -ssf novas.fsdb -nologo & 

verdi_i: 
	./simv +ntb_random_seed=$(seed) ${runtime_switches} +UVM_VERDI_TRACE
	verdi -play verdi_scripts/${cmdi} -nologo & 

verdi_p: 
	./simv +ntb_random_seed=$(seed) ${runtime_switches} +UVM_VERDI_TRACE
	verdi -play verdiLog/${prev} -nologo & 

solution: nuke
	cp ../../solutions/lab4/*.sv .
	cp -r ../../solutions/lab4/packages .
	cp -r ../../solutions/lab4/debug_files .
	rm -rf packages/router_env_pkg.sv.orig

original: copy

copy: nuke
	cp ../../solutions/lab3/*.sv .
	cp ../../solutions/lab4/iMonitor.sv.orig iMonitor.sv
	cp ../../solutions/lab4/input_agent.sv.orig input_agent.sv
	cp ../../solutions/lab4/router_env.sv.orig router_env.sv
	cp ../../solutions/lab4/scoreboard.sv.orig scoreboard.sv
	cp ../../solutions/lab4/test_collection.sv.orig test_collection.sv
	cp ../../solutions/lab4/output_agent.sv .
	cp ../../solutions/lab4/ms_scoreboard.sv .
	cp ../../solutions/lab4/oMonitor.sv .
	cp -r ../../solutions/lab4/packages .
	cp -r ../../solutions/lab4/debug_files .
	cp ../../solutions/lab4/packages/router_env_pkg.sv.orig packages/router_env_pkg.sv
	rm -rf packages/router_env_pkg.sv.orig

mycopy: nuke
	cp ../lab3/*.sv .
	cp ../../solutions/lab4/iMonitor.sv.orig iMonitor.sv
	cp ../../solutions/lab4/input_agent.sv.orig input_agent.sv
	cp ../../solutions/lab4/router_env.sv.orig router_env.sv
	cp ../../solutions/lab4/scoreboard.sv.orig scoreboard.sv
	cp ../../solutions/lab4/test_collection.sv.orig test_collection.sv
	cp ../../solutions/lab4/output_agent.sv .
	cp ../../solutions/lab4/ms_scoreboard.sv .
	cp ../../solutions/lab4/oMonitor.sv .
	cp -r ../../solutions/lab4/packages .
	cp -r ../../solutions/lab4/debug_files .
	cp ../../solutions/lab4/packages/router_env_pkg.sv.orig packages/router_env_pkg.sv
	rm -rf packages/router_env_pkg.sv.orig

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key log *.h temp *.log .vcs* *.txt DVE* *.hvp urg* .inter.vpd.uvm .restart* .synopsys* novas.* *.dat *.fsdb verdiL* work* vlog*

nuke: clean
	rm -rf *.sv *.tcl packages debug_files

help:
	@echo =======================================================================
	@echo  " 								       "
	@echo  " USAGE: make target <seed=xxx> <verbosity=YYY> <test=ZZZ>              "
	@echo  " 								       "
	@echo  "  xxx is the random seed.  Can be any integer except 0. Defaults to 1  "
	@echo  "  YYY sets the verbosity filter.  Defaults to UVM_MEDIUM               "
	@echo  "  ZZZ selects the uvm test.       Defaults to test_base                "
	@echo  " 								       "
	@echo  " ------------------------- Test TARGETS ------------------------------ "
	@echo  " all             => Compile TB and DUT files and run the simulation    "
	@echo  " uvm-1.1         => Compile TB and DUT files and run the simulation    "
	@echo  " uvm-1.2         => Compile TB and DUT files and run the simulation    "
	@echo  " compile         => Compile TB and DUT files                           "
	@echo  " run             => Run the simulation with seed                       "
	@echo  " random          => Run the simulation with random seed                "
	@echo  " dve             => Run DVE with preset waveform displayed             "
	@echo  " dve_tr          => Run DVE with transaction displayed                 "
	@echo  " dve_i           => Run simulation interactively with DVE              "
	@echo  " verdi           => Run verdi with preset waveform displayed           "
	@echo  " verdi_tr        => Run verdi with transaction recording enabled       "
	@echo  " verdi_i         => Run simulation interactively with verdi            "
	@echo  "                                                                       "
	@echo  " -------------------- ADMINISTRATIVE TARGETS ------------------------- "
	@echo  " help       => Displays this message                                   "
	@echo  " clean      => Remove all intermediate simv and log files              "
	@echo  " nuke       => Remove all source code and debug files                  "
	@echo  " original   => Return content of lab back to original state            "
	@echo  " copy       => Copy files from previous lab's solution directory       "
	@echo  " mycopy     => Copy files from user's previous lab directory           "
	@echo  " solution   => Copy files from solutions directory for lab             "
	@echo  "								       "
	@echo  " ---------------------- EMBEDDED SETTINGS -----------------------------"
	@echo  " -timescale=\"1ns/100ps\"                                              "
	@echo  " -debug_all                                                            "
	@echo =======================================================================