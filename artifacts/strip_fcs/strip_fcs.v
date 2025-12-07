module __strip_fcs__strip_fcs_0_next(
  input wire clk,
  input wire clear,
  input wire [37:0] strip_fcs__input_ch,
  input wire strip_fcs__input_ch_vld,
  input wire strip_fcs__output_ch_rdy,
  output wire strip_fcs__input_ch_rdy,
  output wire [37:0] strip_fcs__output_ch,
  output wire strip_fcs__output_ch_vld
);
  wire [37:0] __strip_fcs__input_ch_reg_init = {32'h0000_0000, 4'h0, 1'h0, 1'h0};
  wire [37:0] __strip_fcs__output_ch_reg_init = {32'h0000_0000, 4'h0, 1'h0, 1'h0};
  reg [31:0] ____state_1;
  reg ____state_4;
  reg ____state_0;
  reg [37:0] __strip_fcs__input_ch_reg;
  reg __strip_fcs__input_ch_valid_reg;
  reg [37:0] __strip_fcs__output_ch_reg;
  reg __strip_fcs__output_ch_valid_reg;
  wire strip_fcs__output_ch_valid_inv;
  wire __strip_fcs__output_ch_vld_buf;
  wire strip_fcs__output_ch_valid_load_en;
  wire strip_fcs__output_ch_load_en;
  wire p0_stage_done;
  wire strip_fcs__input_ch_valid_inv;
  wire strip_fcs__input_ch_valid_load_en;
  wire stream_tlast;
  wire [3:0] stream_tkeep;
  wire strip_fcs__input_ch_load_en;
  wire in_a_packet_next;
  wire [31:0] tuple_index_90;
  wire tuple_index_91;
  wire [37:0] __strip_fcs__output_ch_buf;
  assign strip_fcs__output_ch_valid_inv = ~__strip_fcs__output_ch_valid_reg;
  assign __strip_fcs__output_ch_vld_buf = __strip_fcs__input_ch_valid_reg & ____state_0;
  assign strip_fcs__output_ch_valid_load_en = strip_fcs__output_ch_rdy | strip_fcs__output_ch_valid_inv;
  assign strip_fcs__output_ch_load_en = __strip_fcs__output_ch_vld_buf & strip_fcs__output_ch_valid_load_en;
  assign p0_stage_done = __strip_fcs__input_ch_valid_reg & (~____state_0 | strip_fcs__output_ch_load_en);
  assign strip_fcs__input_ch_valid_inv = ~__strip_fcs__input_ch_valid_reg;
  assign strip_fcs__input_ch_valid_load_en = p0_stage_done | strip_fcs__input_ch_valid_inv;
  assign stream_tlast = __strip_fcs__input_ch_reg[1:1];
  assign stream_tkeep = __strip_fcs__input_ch_reg[5:2];
  assign strip_fcs__input_ch_load_en = strip_fcs__input_ch_vld & strip_fcs__input_ch_valid_load_en;
  assign in_a_packet_next = ~stream_tlast;
  assign tuple_index_90 = __strip_fcs__input_ch_reg[37:6];
  assign tuple_index_91 = __strip_fcs__input_ch_reg[0:0];
  assign __strip_fcs__output_ch_buf = {____state_1, stream_tkeep, stream_tlast, ____state_4};
  always @ (posedge clk) begin
    if (clear) begin
      ____state_1 <= 32'h0000_0000;
      ____state_4 <= 1'h0;
      ____state_0 <= 1'h0;
      __strip_fcs__input_ch_reg <= __strip_fcs__input_ch_reg_init;
      __strip_fcs__input_ch_valid_reg <= 1'h0;
      __strip_fcs__output_ch_reg <= __strip_fcs__output_ch_reg_init;
      __strip_fcs__output_ch_valid_reg <= 1'h0;
    end else begin
      ____state_1 <= p0_stage_done ? tuple_index_90 : ____state_1;
      ____state_4 <= p0_stage_done ? tuple_index_91 : ____state_4;
      ____state_0 <= p0_stage_done ? in_a_packet_next : ____state_0;
      __strip_fcs__input_ch_reg <= strip_fcs__input_ch_load_en ? strip_fcs__input_ch : __strip_fcs__input_ch_reg;
      __strip_fcs__input_ch_valid_reg <= strip_fcs__input_ch_valid_load_en ? strip_fcs__input_ch_vld : __strip_fcs__input_ch_valid_reg;
      __strip_fcs__output_ch_reg <= strip_fcs__output_ch_load_en ? __strip_fcs__output_ch_buf : __strip_fcs__output_ch_reg;
      __strip_fcs__output_ch_valid_reg <= strip_fcs__output_ch_valid_load_en ? __strip_fcs__output_ch_vld_buf : __strip_fcs__output_ch_valid_reg;
    end
  end
  assign strip_fcs__input_ch_rdy = strip_fcs__input_ch_load_en;
  assign strip_fcs__output_ch = __strip_fcs__output_ch_reg;
  assign strip_fcs__output_ch_vld = __strip_fcs__output_ch_valid_reg;
endmodule
