# Makefile for compiling SystemVerilog files with VCS
.PHONY: compile clean run

compile:
	mkdir -p build
	# vcs -sverilog -f rtl.flist tb/internal_tbs/mux2x1_tb.sv -o build/simv -full64 -work build
	# vcs -sverilog -f rtl.flist tb/internal_tbs/adder_tb.sv -o build/simv -full64 -work build
	vcs -sverilog -f rtl.flist tb/internal_tbs/imem_tb.sv -o build/simv -full64 -work build

run:
	cd build && ./simv

gtk:
	gtkwave build/result.vcd

clean:
	rm -rf csrc build
