module smart_traffic_controller (
    input clk,
    input rst,
    input sensor,
    output reg [2:0] light_main, // [Red, Yellow, Green]
    output reg [2:0] light_side  // [Red, Yellow, Green]
);

    // State Encoding
    localparam S_MAIN_G = 2'b00; // Main Green, Side Red
    localparam S_MAIN_Y = 2'b01; // Main Yellow, Side Red
    localparam S_SIDE_G = 2'b10; // Main Red, Side Green
    localparam S_SIDE_Y = 2'b11; // Main Red, Side Yellow

    reg [1:0] state, next_state;

    // 1. State Memory: Updates state on clock edge or reset
    always @(posedge clk or posedge rst) begin
        if (rst) 
            state <= S_MAIN_G; // Start state (Fixes the XXX issue)
        else 
            state <= next_state;
    end

    // 2. Next State Logic: Decides what happens next
    always @(*) begin
        case (state)
            S_MAIN_G: next_state = (sensor) ? S_MAIN_Y : S_MAIN_G;
            S_MAIN_Y: next_state = S_SIDE_G;
            S_SIDE_G: next_state = S_SIDE_Y;
            S_SIDE_Y: next_state = S_MAIN_G;
            default:  next_state = S_MAIN_G;
        endcase
    end

    // 3. Output Logic: Maps states to light colors
    // Format: 3'b(Red)(Yellow)(Green)
    always @(*) begin
        case (state)
            S_MAIN_G: begin light_main = 3'b001; light_side = 3'b100; end
            S_MAIN_Y: begin light_main = 3'b010; light_side = 3'b100; end
            S_SIDE_G: begin light_main = 3'b100; light_side = 3'b001; end
            S_SIDE_Y: begin light_main = 3'b100; light_side = 3'b010; end
            default:  begin light_main = 3'b100; light_side = 3'b100; end
        endcase
    end

endmodule
