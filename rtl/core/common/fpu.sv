//Floating Point Unit. Single Percision.
module fpu(clk, rst_n, decoder_fp_we, inp1, inp2, inp3, opcode, StartF,
        BusyF, DoneF, out, FPU_fp_we);
    input  logic         clk;
    input  logic         rst_n;
    input  logic         decoder_fp_we;
    input  logic [31: 0] inp1, inp2, inp3;
    input  logic [ 3: 0] opcode;
    output logic [31: 0] out;
    output logic         FPU_fp_we;

    //Handshake Protocol Signals.
    input  logic StartF;
    output logic BusyF, DoneF;

    //Rounding Mode parameters.
    parameter [2: 0] RNE = 3'b000;
    parameter [2: 0] RTZ = 3'b001;
    parameter [2: 0] RDN = 3'b010;
    parameter [2: 0] RUP = 3'b011;
    parameter [2: 0] RMM = 3'b100;
    parameter [2: 0] DYN = 3'b111;


    //Floating Point Add Instruction. --- fadd.s fd, fs1, fs2, rne ---


    // Simple counter to verify the proper stalling and flushing of the pipelined processor in case of
    // a floating point instruction.

    logic [2:0] count;  // 3-bit counter
    logic counting;     // Internal flag to track counting state
    logic done_flag;    // Holds the done state for one cycle

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count     <= 3'b000; // Reset count
            BusyF     <= 1'b0;   // Initially not busy
            DoneF     <= 1'b0;   // Done is low initially
            counting  <= 1'b0;   // Not counting initially
            done_flag <= 1'b0;   // Clear done_flag
        end
        else if (StartF && !counting) begin
            counting  <= 1'b1;   // Start counting when StartF=1
            BusyF     <= 1'b1;   // Set busy
            DoneF     <= 1'b0;   // Ensure done is cleared
            done_flag <= 1'b0;   // Clear done_flag
        end
        else if (counting) begin
            if (count < 3'b111) begin
                count <= count + 1;  // Increment counter
            end

            if (count == 3'b111) begin  // If 7 is reached
                BusyF     <= 1'b0;   // Clear busy
                DoneF     <= 1'b1;   // Set DoneF (one cycle pulse)
                counting  <= 1'b0;   // Stop counting
                done_flag <= 1'b1;   // Mark that we hit done
            end
        end
        else if (done_flag) begin
            DoneF     <= 1'b0;   // Clear DoneF in the next cycle
            done_flag <= 1'b0;   // Clear the flag
        end
    end



endmodule