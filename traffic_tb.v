`timescale 1ns/1ps

module traffic_tb;
    // Signals
    reg clk;
    reg rst;
    reg sensor;
    wire [2:0] light_main;
    wire [2:0] light_side;

    // Instantiate the Unit Under Test (UUT)
    smart_traffic_controller uut (
        .clk(clk),
        .rst(rst),
        .sensor(sensor),
        .light_main(light_main),
        .light_side(light_side)
    );

    // Generate Clock (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Setup for GTKWave
        $dumpfile("traffic_waves.vcd");
        $dumpvars(0, traffic_tb);

        // Initialize signals
        clk = 0;
        rst = 1;      // Start with Reset HIGH
        sensor = 0;

        #20 rst = 0;  // Release Reset after 20ns
        
        #40 sensor = 1; // Car arrives on side road
        #20 sensor = 0; // Car passes
        
        #100 $display("Simulation Finished");
        $finish;
    end
endmodule
