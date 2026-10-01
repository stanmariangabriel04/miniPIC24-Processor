# miniPIC24

University project focused on the design and simulation of a small processor based on a subset of the PIC24E instruction set.

## Project Overview

The processor was designed to execute a predefined set of PIC24E instructions, including arithmetic, logical, data transfer and branch instructions.

The processor architecture includes:

* 6-bit Program Counter
* 32 × 24-bit Program Memory
* 16 general-purpose registers (W0–W15)
* 16 × 16-bit Data Memory locations
* Additional special memory locations

## Implemented Instructions

The project includes the common instructions required by the assignment:

* ADD Wb, Ws, Wd
* SUB Wb, Ws, Wd
* AND Wb, Ws, Wd
* IOR Wb, Ws, Wd
* MOV Wns, f
* MOV f, Wnd
* BRA Expr

Additional project-specific instructions were also implemented.
- ASR Wb, #lit4, Wnd
- SUB Wb, #lit5, Wd
- COM Ws, Wd
- AND #lit10, Wn

## Processor Components

The processor is divided into several main blocks:

* Program Counter and PC update logic
* Program ROM
* Register File
* ALU
* Control Unit
* Data Memory
* Multiplexers for instruction decoding and data routing

The Control Unit generates the control signals required for instruction execution, while the ALU performs the arithmetic and logical operations.

## Flags

The processor implements the following condition flags:

* N – Negative
* OV – Overflow
* Z – Zero
* C – Carry

The flags are updated only by the instructions that affect them.

## Verification

The processor was verified using ROM-based test programs and simulation sequences covering the implemented instructions, flags and conditional branches.

The repository contains the source files, test programs and project documentation.

## Project Requirements

The original assignment required:

* processor block diagram and description of the main blocks and control signals
* opcode table for all implemented instructions
* control unit truth table
* simulation results for the test programs
* test programs for the project-specific instructions
* the ISE project used for processor simulation

## Tools

* Xilinx ISE
* MPLAB IDE X (used for comparison with PIC24 behavior)

