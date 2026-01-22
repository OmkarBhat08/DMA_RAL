# --- Directory Paths ---
SRC      = ../src
REGISTER = $(SRC)/register

# --- UVM Variables ---
PKG      = dma_pkg.sv
FILE     = top.sv
TOP      = top
#TEST     = dma_intr_test
TEST     = dma_ctrl_test
#TEST     = dma_io_addr_test

# --- Coverage Variables ---
COV_LOG_FILE   = dma_log.log
COV_DB_FILE    = coverage.ucdb
COV_REPORT_DIR = covReport

# --- Simulation Options ---
VERBOSITY ?= UVM_MEDIUM
VSIM_OPTS = 

# Set verbosity
ifeq ($(VERBOSITY), HIGH)
	VSIM_OPTS += +UVM_VERBOSITY=UVM_HIGH
endif
ifeq ($(VERBOSITY), DEBUG)
	VSIM_OPTS += +UVM_VERBOSITY=UVM_DEBUG
endif

# Set Testname
ifneq ($(TEST),)
	VSIM_OPTS += +UVM_TESTNAME=$(TEST)
endif

# --- Main Targets ---
.PHONY: all compile simulate clean h d cov

all: simulate

# --- Shortcut Targets ---
h:
	@$(MAKE) --no-print-directory simulate VERBOSITY=HIGH

d:
	@$(MAKE) --no-print-directory simulate VERBOSITY=DEBUG

# --- Compilation ---
# We compile the Package FIRST, then the Top
# +incdir+$(SRC) allows the compiler to find files included via "register/..."
compile:
	@echo "--- Compiling Source Files ---"
	@vlog -sv +incdir+$(SRC) -l $(COV_LOG_FILE) $(SRC)/$(PKG) $(SRC)/$(FILE)

# --- Simulation ---
simulate: compile
	@echo "--- Running Simulation (Test: $(TEST)) ---"
	@vsim -voptargs=+acc=npr -c -l $(COV_LOG_FILE) $(TOP) $(VSIM_OPTS) -do "run -all; quit"

# --- Coverage Target ---
cov: 
	@echo "--- Running Coverage ---"
	@vlog -sv +acc +cover +fcover +incdir+$(SRC) -l $(COV_LOG_FILE) $(SRC)/$(PKG) $(SRC)/$(FILE)
	@vsim -vopt work.$(TOP) -voptargs=+acc=npr -assertdebug -l simulation.log -coverage $(VSIM_OPTS) -c -do "coverage save -onexit -assert -directive -cvg -codeAll $(COV_DB_FILE); run -all; exit"
	@vcover report -html $(COV_DB_FILE) -htmldir $(COV_REPORT_DIR) -details
	@echo "Report generated at $(COV_REPORT_DIR)/index.html"

# --- Clean ---
clean:
	@rm -rf transcript vsim.wlf work *.log *.ucdb $(COV_REPORT_DIR)
