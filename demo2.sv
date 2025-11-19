// Bohdan Purtell
// University of Florida
// Sequential Logic in SystemVerilog

module demo2 # (
  parameter int WIDTH=64,
  parameter int WIDTH2=32
) (
  input logic clk, rst,
  input logic go, 
  input logic a, b,
  output logic done,

  output logic ctrl1, ctrl2,

  output logic reg_c
);


// always_comb
// begin
//   reg_c = a && b;
// end

// always @(*)
// begin
//   reg_c = a && b;
//
//
//
// end

// always_ff @(posedge clk or posedge rst)
// always_ff @(posedge clk, posedge rst)

// type state : bruh (state1, staet2);
// (* FSM_ENCODING = "one-hot" *)
typedef enum logic [2:0] {
  INIT_STATE,
  COMPUTE_STATE,
  DONE_STATE,
  TEST_STATE
} state_t;

// localparam logic [7:0] BITMASK1 = 8'b10100000;

state_t current_state, next_state;

// state_t current_state = INIT_STATE;
// state_t next_state;


// binary encoding
// state 1 = 00
// state 2 = 01
// state 3 = 10
// state 4 = 11

// one hot encoding
// state 1 = 0001
// state 2 = 0010
// state 3 = 0100
// state 4 = 1000

logic reg_c_next;

logic [7:0] accumulator;
logic [7:0] accumulator_next;

// register process
always_ff @(posedge clk)
begin
  if (rst) begin // sync 
    reg_c <= 0;
    accumulator <= 0;
    current_state <= INIT_STATE;
  end else begin
    // reg_c <= 0;
    // reg_c <= 1;
    reg_c <= reg_c_next;
    current_state <= next_state;
    accumulator <= accumulator_next;
  end
end

// always_ff @(posedge clk)
// begin
//   if (rst) begin // sync 
//     current_state <= INIT_STATE;
//     done <= 0;
//     accumulator <= 0;
//   end else begin
//     case(current_state) 
//       INIT_STATE : begin
//         if (go) begin
//           current_state <= COMPUTE_STATE;
//         end
//       end
//
//       COMPUTE_STATE : begin
//         if (accumulator == 'd10) begin
//           current_state <= DONE_STATE;
//           done = 1;
//         end else begin
//           current_state <= COMPUTE_STATE;
//           accumulator <= accumulator + 1;
//         end
//       end
//
//       DONE_STATE : begin
//         current_state <= DONE_STATE;
//         if (!go) current_state <= INIT_STATE;
//       end
//
//       default : begin
//         current_state <= current_state;
//       end
//
//     endcase
//
//   end
// end

// next state logic
always_comb
begin
  reg_c_next = 0;
  accumulator_next = accumulator;
  // reg_c_next = 1;

  case (current_state)

    INIT_STATE : begin
      next_state = INIT_STATE;

      if (go) begin
        next_state = COMPUTE_STATE;
      end
    end

    COMPUTE_STATE : begin
      next_state = COMPUTE_STATE;

      if (accumulator == 'd10) begin
        next_state = DONE_STATE;
      end else begin
        accumulator_next = accumulator + 1;
        done = 1;
      end
    end

    DONE_STATE : begin
      next_state = DONE_STATE;

      // if (go) begin
      //   next_state = DONE_STATE;
      // end else begin
      //   next_state = INIT_STATE;
      // end
      if (!go) next_state = INIT_STATE;
    end

    // default : begin
    //
    // end

    default : next_state = current_state;
  endcase

end

endmodule

