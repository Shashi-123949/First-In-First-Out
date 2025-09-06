# First-In-First-Out

# Key Features

Top module

Test File

DUT File

Environment File

Scoreboard File

Agent File

Sequencer File

Driver File

Monitor File

Coverage File

Interface File

Sequence File

Transaction File

Run File


# asyn_fifo(DUT File)

asyn_fifo.sv – The First-In-First-Out(FIFO) module implementation. It defines read/write operations and address handling.

# Monitor

Implements a UVM monitor (mon) to observe FIFO transaction.

It checks both read and write conditions in it.

Samples interface signals via the monitor clocking block.

Captures transactions into mem_tx objects and forwards them through an analysis port for further checking.

Ensures every valid read/write operation is reported.

# fifo_sbd.sv (Scoreboard)
Implements a UVM scoreboard (mem_sbd) to check correctness of DUT behavior.

Maintains a reference memory model using an associative array.

Compares DUT read data with expected stored data.

Tracks matches and mismatches, updating counters for result analysis.

# mem_test.sv (Test File)
Implements UVM test classes:

fifo_test: Base test that creates the environment (fifo_env), runs a sequence, and prints the UVM topology.

fifo_n_wr_n_rd_test: Extended test that runs a sequence with configurable number of write/read transactions.

Controls simulation execution by raising/dropping objections and applying drain time for clean shutdown.

# Test
mem_test.sv – Defines the overall test, configures the environment, and controls sequence execution.

# Top
top.sv-Instantiates DUT and connects it with the UVM testbench.

# Run
run.do-Simulation script (likely for ModelSim/Questa/Synopsis) to compile and run the project.

# Common
This file is used to keep all the required transactions in it.












