`timescale 1ns/1ps
module fifo_tb;//no ports
  reg clk,reset;
  reg wr_en,rd_en;
  reg [7:0]din;
  wire [7:0]dout;
  wire full,empty;
  
 fifo UUT(clk,reset,wr_en,rd_en,din,dout,full,empty); //instantiation

  initial begin
    clk =0;
    $display("clock initialize---------------");
      
  end
  
  task rst;
    begin
    #10  reset = 1;
      $display("reset initialize---------------");
    
      #20  reset = 0;//20 ns delay
         end
  endtask
  
  always #5 clk = ~clk;//T=10 ns, f=100Mhz
  
  task wr_rd_init;
    begin
    	wr_en =0;
      	rd_en =0;
      	din = 0;
      $display("write read initialize---------------");
    
    end
  endtask
  
  task write;
    input [7:0]wdata;
    begin
       @(posedge clk)
      begin
        wr_en =  1;
        din =  wdata;
      end
    end
  endtask
  
  task write16;
    begin
      write(8'd45);
      write(8'd73);
      write(8'd34);
      write(8'd94);
      write(8'd05);
      write(8'd23);
      write(8'd87);
      write(8'd72);
      write(8'd11);
      write(8'd41);
      write(8'd66);
      write(8'd21);
      write(8'd88);
      write(8'd50);
      write(8'd28);
      write(8'd32);
      write(8'd11);    
    end
  endtask
  
  task endwrite;
    begin
      wr_en = 0;
      din =  0;
    end
  endtask
  
  //read process
  task read;
    begin
      @(posedge clk)
      begin
        rd_en = 1;
      end
    end
  endtask
  
  task read16;
    begin
      read;read;read;read;
      read;read;read;read;
      read;read;read;read;
      read;read;read;read;
      
    end
  endtask
  
  task endread;
    begin
       @(posedge clk)
      begin
        rd_en = 0;
      end
    end
  endtask
  
  initial begin
    $display("start--- initialize---------------");
    
    rst;
    wr_rd_init;
    write16;
    endwrite;
    #2 read16;
    #10 endread;
    $display("stopped---------------");
    
    #10 $finish;//finish the simulation
        
  end
  
  //waveform generation
 initial
 begin
    $dumpfile("fifo.vcd");
    $dumpvars(0,fifo_tb);
 end
endmodule
