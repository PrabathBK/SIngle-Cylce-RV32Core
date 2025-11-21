
module IMemory (
    input  logic [ 7:0] a,
    output logic [31:0] rd
);

  logic [31:0] ROM[255:0];

  initial $readmemh("rv32core-sc/src/imemfile.mem", ROM);

  assign rd = ROM[a];

endmodule
