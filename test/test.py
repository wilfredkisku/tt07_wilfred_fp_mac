# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: MIT

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.rst_n.value = 0
    
    dut.ui_in.value = 0x40
    dut.uio_in.value = 0x40
    
    await ClockCycles(dut.clk, 1)

    # Enable
    dut._log.info("Test project behavior")
    dut.rst_n.value = 1
    dut.ena.value = 1
    dut.ui_in.value = 0x40
    dut.uio_in.value = 0x40
    
    await ClockCycles(dut.clk, 1)
    await ClockCycles(dut.clk, 3)

    assert dut.uo_out.value == 0x4A

    dut.ui_in.value = 0x3A
    dut.uio_in.value = 0xC0

    await ClockCycles(dut.clk, 1)
    await ClockCycles(dut.clk, 3)

    assert dut.uo_out.value == 0xC4
