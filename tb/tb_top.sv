// 
`timescale 1ns / 1ps

module tb_top;

  logic clk, reset;
  logic [1:0] flag;
  logic [31:0] instr, memWdata, addr, pc, aluIn1, aluIn2, Simm, Jimm, Bimm, Iimm, memRdata;
  logic [4:0] rs1Id, rs2Id, rdId, leds;
  logic [3:0] memWMask, aluControl;
  logic
      isALUreg,
      regWrite,
      isJAL,
      isJALR,
      isBranch,
      isLUI,
      isAUIPC,
      isALUimm,
      isLoad,
      isStore,
      isShamt;

  RiscV dut (
      clk,
      reset,
      pc,
      instr,
      memWdata,
      addr,
      aluIn1,
      aluIn2,
      Simm,
      Jimm,
      Bimm,
      Iimm,
      memRdata,
      rs1Id,
      rs2Id,
      rdId,
      memWMask,
      aluControl,
      isALUreg,
      regWrite,
      isJAL,
      isJALR,
      isBranch,
      isLUI,
      isAUIPC,
      isALUimm,
      isLoad,
      isStore,
      isShamt,
      leds
  );

  initial begin
    flag  = 0;
    reset = 1;
    #15;
    reset = 0;
    #2;
  end

  always begin
    clk <= 1;
    #5;
    clk <= 0;
    #5;
  end

  always @(negedge clk) begin
    if (pc == 8'h2c && leds == 5'he) flag = 1;
    if (rdId == 8'h1e && addr == 8'h36 && flag) flag = flag + 1;
    if (rdId == 8'h0 && flag == 2'b10) $finish;
  end

  initial begin
    $dumpfile("sim/tb_top.vcd");
    $dumpvars(0, tb_top);
  end

endmodule
// module tb_top;
//   logic        clk;
//   logic        rst_n;
//
//   logic [31:0] imem_addr;
//   logic [31:0] imem_data;
//
//   logic [31:0] dmem_addr;
//   logic [31:0] dmem_wdata;
//   logic [ 3:0] dmem_be;
//   logic        dmem_we;
//   logic [31:0] dmem_rdata;
//
//   // Clock generation
//   initial begin
//     clk = 0;
//     forever #5 clk = ~clk;
//   end
//
//   // Instruction memory
//   logic [31:0] imem[1024];
//   initial begin
//     $readmemh("tb/program.hex", imem);
//   end
//   assign imem_data = imem[imem_addr[11:2]];
//
//   // Data memory
//   logic [31:0] dmem[1024];
//   always_ff @(posedge clk) begin
//     if (dmem_we) begin
//       if (dmem_be[0]) dmem[dmem_addr[11:2]][7:0] <= dmem_wdata[7:0];
//       if (dmem_be[1]) dmem[dmem_addr[11:2]][15:8] <= dmem_wdata[15:8];
//       if (dmem_be[2]) dmem[dmem_addr[11:2]][23:16] <= dmem_wdata[23:16];
//       if (dmem_be[3]) dmem[dmem_addr[11:2]][31:24] <= dmem_wdata[31:24];
//     end
//   end
//   assign dmem_rdata = dmem[dmem_addr[11:2]];
//
//   // DUT instantiation
//   riscv_core dut (
//       .clk_i(clk),
//       .rst_ni(rst_n),
//       .imem_addr_o(imem_addr),
//       .imem_data_i(imem_data),
//       .dmem_addr_o(dmem_addr),
//       .dmem_wdata_o(dmem_wdata),
//       .dmem_be_o(dmem_be),
//       .dmem_we_o(dmem_we),
//       .dmem_rdata_i(dmem_rdata)
//   );
//
//   // Test stimulus
//   initial begin
//     // Initialize
//     rst_n = 0;
//
//     // Wait 100ns and release reset
//     #100 rst_n = 1;
//
//     // Run for some time
//     #1000;
//
//     // Check results
//     if (dut.registers[10] == 32'h12345678) $display("Test passed!");
//     else $display("Test failed!");
//
//     $finish;
//   end
//
//   // Dump waves
//   initial begin
//     $dumpfile("sim/tb_top.vcd");
//     $dumpvars(0, tb_top);
//   end
//
// endmodule
