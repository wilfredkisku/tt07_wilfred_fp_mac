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
    dut.ui_in.value = 64
    dut.uio_in.value = 64
    #dut.uio_in[0].value = 1
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 1)

    # Enable
    dut._log.info("Test project behavior")
    dut.rst_n.value = 1
    dut.ena.value = 1
    
    await ClockCycles(dut.clk, 1)

    #dut.rst_n.value = 0
    await ClockCycles(dut.clk, 2)

    assert int(dut.uo_out.value) == 74

    dut.ui_in.value = 58
    dut.uio_in.value = 192

    await ClockCycles(dut.clk, 1)
    #assert dut.uo_out.value == 0xC5

    #dut.ui_in.value = 0xEF

    await ClockCycles(dut.clk, 2)

    assert int(dut.uo_out.value) == 196
