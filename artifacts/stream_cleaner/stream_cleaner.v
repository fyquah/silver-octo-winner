module __stream_cleaner__stream_cleaner_0_next(
  input wire clk,
  input wire clear,
  input wire [37:0] stream_cleaner__input_ch,
  input wire stream_cleaner__input_ch_vld,
  input wire stream_cleaner__output_ch_rdy,
  output wire stream_cleaner__input_ch_rdy,
  output wire [37:0] stream_cleaner__output_ch,
  output wire stream_cleaner__output_ch_vld
);
  wire [37:0] __stream_cleaner__input_ch_reg_init = {32'h0000_0000, 4'h0, 1'h0, 1'h0};
  wire [37:0] __stream_cleaner__output_ch_reg_init = {32'h0000_0000, 4'h0, 1'h0, 1'h0};
  reg ____state;
  reg [37:0] __stream_cleaner__input_ch_reg;
  reg __stream_cleaner__input_ch_valid_reg;
  reg [37:0] __stream_cleaner__output_ch_reg;
  reg __stream_cleaner__output_ch_valid_reg;
  wire data_tfirst__1;
  wire or_100;
  wire stream_cleaner__output_ch_valid_inv;
  wire __stream_cleaner__output_ch_vld_buf;
  wire stream_cleaner__output_ch_valid_load_en;
  wire [1:0] ____state__next_value_predicates;
  wire stream_cleaner__output_ch_not_pred;
  wire stream_cleaner__output_ch_load_en;
  wire [2:0] one_hot_91;
  wire p0_stage_done;
  wire stream_cleaner__input_ch_valid_inv;
  wire data_tlast__1;
  wire stream_cleaner__input_ch_valid_load_en;
  wire ____state__at_most_one_next_value;
  wire [1:0] concat_115;
  wire stream_cleaner__input_ch_load_en;
  wire or_146;
  wire one_hot_sel_116;
  assign data_tfirst__1 = __stream_cleaner__input_ch_reg[0:0];
  assign or_100 = ____state | data_tfirst__1;
  assign stream_cleaner__output_ch_valid_inv = ~__stream_cleaner__output_ch_valid_reg;
  assign __stream_cleaner__output_ch_vld_buf = __stream_cleaner__input_ch_valid_reg & or_100;
  assign stream_cleaner__output_ch_valid_load_en = stream_cleaner__output_ch_rdy | stream_cleaner__output_ch_valid_inv;
  assign ____state__next_value_predicates = {~____state, ____state};
  assign stream_cleaner__output_ch_not_pred = ~or_100;
  assign stream_cleaner__output_ch_load_en = __stream_cleaner__output_ch_vld_buf & stream_cleaner__output_ch_valid_load_en;
  assign one_hot_91 = {____state__next_value_predicates[1:0] == 2'h0, ____state__next_value_predicates[1] && !____state__next_value_predicates[0], ____state__next_value_predicates[0]};
  assign p0_stage_done = __stream_cleaner__input_ch_valid_reg & (stream_cleaner__output_ch_not_pred | stream_cleaner__output_ch_load_en);
  assign stream_cleaner__input_ch_valid_inv = ~__stream_cleaner__input_ch_valid_reg;
  assign data_tlast__1 = __stream_cleaner__input_ch_reg[1:1];
  assign stream_cleaner__input_ch_valid_load_en = p0_stage_done | stream_cleaner__input_ch_valid_inv;
  assign ____state__at_most_one_next_value = ~____state == one_hot_91[1] & ____state == one_hot_91[0];
  assign concat_115 = {~____state & p0_stage_done, ____state & p0_stage_done};
  assign stream_cleaner__input_ch_load_en = stream_cleaner__input_ch_vld & stream_cleaner__input_ch_valid_load_en;
  assign or_146 = ~p0_stage_done | ____state__at_most_one_next_value | clear;
  assign one_hot_sel_116 = ~data_tlast__1 & concat_115[0] | ~(~data_tfirst__1 | data_tlast__1) & concat_115[1];
  always @ (posedge clk) begin
    if (clear) begin
      ____state <= 1'h0;
      __stream_cleaner__input_ch_reg <= __stream_cleaner__input_ch_reg_init;
      __stream_cleaner__input_ch_valid_reg <= 1'h0;
      __stream_cleaner__output_ch_reg <= __stream_cleaner__output_ch_reg_init;
      __stream_cleaner__output_ch_valid_reg <= 1'h0;
    end else begin
      ____state <= p0_stage_done ? one_hot_sel_116 : ____state;
      __stream_cleaner__input_ch_reg <= stream_cleaner__input_ch_load_en ? stream_cleaner__input_ch : __stream_cleaner__input_ch_reg;
      __stream_cleaner__input_ch_valid_reg <= stream_cleaner__input_ch_valid_load_en ? stream_cleaner__input_ch_vld : __stream_cleaner__input_ch_valid_reg;
      __stream_cleaner__output_ch_reg <= stream_cleaner__output_ch_load_en ? __stream_cleaner__input_ch_reg : __stream_cleaner__output_ch_reg;
      __stream_cleaner__output_ch_valid_reg <= stream_cleaner__output_ch_valid_load_en ? __stream_cleaner__output_ch_vld_buf : __stream_cleaner__output_ch_valid_reg;
    end
  end
  assign stream_cleaner__input_ch_rdy = stream_cleaner__input_ch_load_en;
  assign stream_cleaner__output_ch = __stream_cleaner__output_ch_reg;
  assign stream_cleaner__output_ch_vld = __stream_cleaner__output_ch_valid_reg;
endmodule
