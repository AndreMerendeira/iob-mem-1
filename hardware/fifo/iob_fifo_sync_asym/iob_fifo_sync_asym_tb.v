`timescale 1ns / 1ps
`include "iob_lib.vh"

//test defines
<<<<<<< HEAD:hardware/fifo/iob_fifo_sync_asym/iob_fifo_sync_asym_tb.v
`define W_DATA_W 8
`define R_DATA_W 32
`define ADDR_W 10
`define TESTSIZE 256
=======
`define R_DATA_W 32
`define W_DATA_W 8
`define ADDR_W 4
`define TESTSIZE 256 //bytes
>>>>>>> bd4957c41a98b22d8674d6835f5921ffdb292c35:hardware/fifo/iob_fifo_sync_asym/iob_sync_fifo_asym_tb.v


module iob_fifo_sync_asym_tb;

   localparam TESTSIZE = `TESTSIZE; //bytes
   localparam W_DATA_W = `W_DATA_W;
   localparam R_DATA_W = `R_DATA_W;
   localparam MAXDATA_W = `max(W_DATA_W, R_DATA_W);
   localparam MINDATA_W = `min( W_DATA_W, R_DATA_W );
   localparam ADDR_W = `ADDR_W;
   localparam MINADDR_W = ADDR_W-$clog2(MAXDATA_W/MINDATA_W);//lower ADDR_W (higher DATA_W)
   localparam W_ADDR_W = W_DATA_W == MAXDATA_W? MINADDR_W : ADDR_W;
   localparam R_ADDR_W = R_DATA_W == MAXDATA_W? MINADDR_W : ADDR_W;

   reg reset = 0;
   reg                 clk = 0;

   //write port
   reg                 w_en = 0;
   reg [W_DATA_W-1:0]  w_data;
   wire                w_full;
<<<<<<< HEAD:hardware/fifo/iob_fifo_sync_asym/iob_fifo_sync_asym_tb.v
   wire [W_ADDR_W-1:0] w_level;

   //read port
=======
   wire [ADDR_W-1:0]   w_level;
   
   //read port 
>>>>>>> bd4957c41a98b22d8674d6835f5921ffdb292c35:hardware/fifo/iob_fifo_sync_asym/iob_sync_fifo_asym_tb.v
   reg                 r_en = 0;
   wire [R_DATA_W-1:0] r_data;
   wire                r_empty;
   wire [ADDR_W-1:0]   r_level;

   parameter clk_per = 10; // clk period = 10 timeticks
   always
     #(clk_per/2) clk = ~clk;

   integer             i,j; //iterators

   reg [W_DATA_W*2**W_ADDR_W-1:0] test_data;
   reg [W_DATA_W*2**W_ADDR_W-1:0] read;

   //
   //WRITE PROCESS
   //
   initial begin

      if(W_DATA_W > R_DATA_W)
        $display("W_DATA_W > R_DATA_W");
      else if (W_DATA_W < R_DATA_W)
        $display("W_DATA_W < R_DATA_W");
      else
        $display("W_DATA_W = R_DATA_W");

      $display("W_DATA_W=%d", W_DATA_W);
      $display("R_DATA_W=%d", R_DATA_W);
      $display("ADDR_W=%d", ADDR_W);

      //create the test data bytes
      for (i=0; i < TESTSIZE; i=i+1)
        test_data[i*8 +: 8] = i;

      // optional VCD
`ifdef VCD
      $dumpfile("uut.vcd");
      $dumpvars();
`endif
      repeat(4) @(posedge clk) #1;


      //reset FIFO
      #clk_per;
      @(posedge clk) #1;
      reset = 1;
      @(posedge clk) #1;
      reset = 0;


      //pause for 1ms to allow the reader to test the empty flag
      #1000000 @(posedge clk) #1;


      //write test data to fifo
      for(i = 0; i < ((TESTSIZE*8)/W_DATA_W); i = i + 1) begin
         if( i == ((TESTSIZE*8)/W_DATA_W/2) ) //another pause
           #1000000 @(posedge clk) #1;

         while(w_full)  @(posedge clk) #1;
         w_en = 1;
         w_data = test_data[i*W_DATA_W +: W_DATA_W];
         @(posedge clk) #1;
         w_en = 0;
      end

   end // end of writer process

<<<<<<< HEAD:hardware/fifo/iob_fifo_sync_asym/iob_fifo_sync_asym_tb.v
   initial begin //reader process
=======
   //
   // READ PROCESS
   //
   initial begin
>>>>>>> bd4957c41a98b22d8674d6835f5921ffdb292c35:hardware/fifo/iob_fifo_sync_asym/iob_sync_fifo_asym_tb.v

      //wait for reset to be de-asserted
      @(negedge reset) repeat(4) @(posedge clk) #1;

      //read data from fifo
      for(j = 0; j < ((TESTSIZE*8)/R_DATA_W); j = j + 1) begin
         while(r_empty) @(posedge clk) #1;
         r_en = 1;
         @(posedge clk) #1;
         read[j*R_DATA_W +: R_DATA_W] = r_data;
         r_en = 0;
      end

<<<<<<< HEAD:hardware/fifo/iob_fifo_sync_asym/iob_fifo_sync_asym_tb.v
      if(read !== test_data)
        $display("ERROR: data read does not match the test data.");
=======
      if(!(read === test_data))
        $display("ERROR: data read does not match the test data.");   

      #(5*clk_per) $finish;

>>>>>>> bd4957c41a98b22d8674d6835f5921ffdb292c35:hardware/fifo/iob_fifo_sync_asym/iob_sync_fifo_asym_tb.v
   end

   // Instantiate the Unit Under Test (UUT)
<<<<<<< HEAD:hardware/fifo/iob_fifo_sync_asym/iob_fifo_sync_asym_tb.v
   iob_fifo_sync_asym
=======
   iob_fifo_sync_asym 
>>>>>>> bd4957c41a98b22d8674d6835f5921ffdb292c35:hardware/fifo/iob_fifo_sync_asym/iob_sync_fifo_asym_tb.v
     #(
       .W_DATA_W(W_DATA_W),
       .R_DATA_W(R_DATA_W),
       .ADDR_W(ADDR_W)
       )
   uut
     (
      .rst(reset),
      .clk(clk),

      .r_en(r_en),
      .r_data(r_data),
      .r_empty(r_empty),
      .r_level(r_level),

      .w_en(w_en),
      .w_data(w_data),
      .w_full(w_full),
      .w_level(w_level)
      );

endmodule // iob_sync_fifo_asym_tb
