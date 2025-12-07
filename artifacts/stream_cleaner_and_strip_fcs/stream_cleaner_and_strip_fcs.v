module __stream_cleaner_and_strip_fcs__stream_cleaner_and_strip_fcs_0_next__1(
  input wire clk,
  input wire clear
);

endmodule


module __stream_cleaner_and_strip_fcs__stream_cleaner_and_strip_fcs__stream_cleaner_0_next(
  input wire clk,
  input wire clear,
  input wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_rdy,
  input wire [37:0] stream_cleaner_and_strip_fcs__input_ch,
  input wire stream_cleaner_and_strip_fcs__input_ch_vld,
  output wire [37:0] stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs,
  output wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld,
  output wire stream_cleaner_and_strip_fcs__input_ch_rdy
);
  wire [37:0] __stream_cleaner_and_strip_fcs__input_ch_reg_init = {32'h0000_0000, 4'h0, 1'h0, 1'h0};
  wire [37:0] __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg_init = {32'h0000_0000, 4'h0, 1'h0, 1'h0};
  reg ____state;
  reg [37:0] __stream_cleaner_and_strip_fcs__input_ch_reg;
  reg __stream_cleaner_and_strip_fcs__input_ch_valid_reg;
  reg [37:0] __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg;
  reg __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg;
  wire data_tfirst__1;
  wire or_195;
  wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_inv;
  wire __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld_buf;
  wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_load_en;
  wire [1:0] ____state__next_value_predicates;
  wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_not_pred;
  wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_load_en;
  wire [2:0] one_hot_186;
  wire p0_stage_done;
  wire stream_cleaner_and_strip_fcs__input_ch_valid_inv;
  wire data_tlast__1;
  wire stream_cleaner_and_strip_fcs__input_ch_valid_load_en;
  wire ____state__at_most_one_next_value;
  wire [1:0] concat_210;
  wire stream_cleaner_and_strip_fcs__input_ch_load_en;
  wire or_333;
  wire one_hot_sel_211;
  assign data_tfirst__1 = __stream_cleaner_and_strip_fcs__input_ch_reg[0:0];
  assign or_195 = ____state | data_tfirst__1;
  assign stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_inv = ~__stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg;
  assign __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld_buf = __stream_cleaner_and_strip_fcs__input_ch_valid_reg & or_195;
  assign stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_load_en = stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_rdy | stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_inv;
  assign ____state__next_value_predicates = {~____state, ____state};
  assign stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_not_pred = ~or_195;
  assign stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_load_en = __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld_buf & stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_load_en;
  assign one_hot_186 = {____state__next_value_predicates[1:0] == 2'h0, ____state__next_value_predicates[1] && !____state__next_value_predicates[0], ____state__next_value_predicates[0]};
  assign p0_stage_done = __stream_cleaner_and_strip_fcs__input_ch_valid_reg & (stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_not_pred | stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_load_en);
  assign stream_cleaner_and_strip_fcs__input_ch_valid_inv = ~__stream_cleaner_and_strip_fcs__input_ch_valid_reg;
  assign data_tlast__1 = __stream_cleaner_and_strip_fcs__input_ch_reg[1:1];
  assign stream_cleaner_and_strip_fcs__input_ch_valid_load_en = p0_stage_done | stream_cleaner_and_strip_fcs__input_ch_valid_inv;
  assign ____state__at_most_one_next_value = ~____state == one_hot_186[1] & ____state == one_hot_186[0];
  assign concat_210 = {~____state & p0_stage_done, ____state & p0_stage_done};
  assign stream_cleaner_and_strip_fcs__input_ch_load_en = stream_cleaner_and_strip_fcs__input_ch_vld & stream_cleaner_and_strip_fcs__input_ch_valid_load_en;
  assign or_333 = ~p0_stage_done | ____state__at_most_one_next_value | clear;
  assign one_hot_sel_211 = ~data_tlast__1 & concat_210[0] | ~(~data_tfirst__1 | data_tlast__1) & concat_210[1];
  always @ (posedge clk) begin
    if (clear) begin
      ____state <= 1'h0;
      __stream_cleaner_and_strip_fcs__input_ch_reg <= __stream_cleaner_and_strip_fcs__input_ch_reg_init;
      __stream_cleaner_and_strip_fcs__input_ch_valid_reg <= 1'h0;
      __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg <= __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg_init;
      __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg <= 1'h0;
    end else begin
      ____state <= p0_stage_done ? one_hot_sel_211 : ____state;
      __stream_cleaner_and_strip_fcs__input_ch_reg <= stream_cleaner_and_strip_fcs__input_ch_load_en ? stream_cleaner_and_strip_fcs__input_ch : __stream_cleaner_and_strip_fcs__input_ch_reg;
      __stream_cleaner_and_strip_fcs__input_ch_valid_reg <= stream_cleaner_and_strip_fcs__input_ch_valid_load_en ? stream_cleaner_and_strip_fcs__input_ch_vld : __stream_cleaner_and_strip_fcs__input_ch_valid_reg;
      __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg <= stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_load_en ? __stream_cleaner_and_strip_fcs__input_ch_reg : __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg;
      __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg <= stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_load_en ? __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld_buf : __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg;
    end
  end
  assign stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs = __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg;
  assign stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld = __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg;
  assign stream_cleaner_and_strip_fcs__input_ch_rdy = stream_cleaner_and_strip_fcs__input_ch_load_en;
endmodule


module __stream_cleaner_and_strip_fcs__stream_cleaner_and_strip_fcs__strip_fcs_0_next(
  input wire clk,
  input wire clear,
  input wire [37:0] stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs,
  input wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld,
  input wire stream_cleaner_and_strip_fcs__output_ch_rdy,
  output wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_rdy,
  output wire [37:0] stream_cleaner_and_strip_fcs__output_ch,
  output wire stream_cleaner_and_strip_fcs__output_ch_vld
);
  wire [37:0] __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg_init = {32'h0000_0000, 4'h0, 1'h0, 1'h0};
  wire [37:0] __stream_cleaner_and_strip_fcs__output_ch_reg_init = {32'h0000_0000, 4'h0, 1'h0, 1'h0};
  reg [31:0] ____state_1;
  reg ____state_4;
  reg ____state_0;
  reg [37:0] __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg;
  reg __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg;
  reg [37:0] __stream_cleaner_and_strip_fcs__output_ch_reg;
  reg __stream_cleaner_and_strip_fcs__output_ch_valid_reg;
  wire stream_cleaner_and_strip_fcs__output_ch_valid_inv;
  wire __stream_cleaner_and_strip_fcs__output_ch_vld_buf;
  wire stream_cleaner_and_strip_fcs__output_ch_valid_load_en;
  wire stream_cleaner_and_strip_fcs__output_ch_load_en;
  wire p0_stage_done;
  wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_inv;
  wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_load_en;
  wire stream_tlast;
  wire [3:0] stream_tkeep;
  wire stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_load_en;
  wire in_a_packet_next;
  wire [31:0] tuple_index_262;
  wire tuple_index_263;
  wire [37:0] __stream_cleaner_and_strip_fcs__output_ch_buf;
  assign stream_cleaner_and_strip_fcs__output_ch_valid_inv = ~__stream_cleaner_and_strip_fcs__output_ch_valid_reg;
  assign __stream_cleaner_and_strip_fcs__output_ch_vld_buf = __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg & ____state_0;
  assign stream_cleaner_and_strip_fcs__output_ch_valid_load_en = stream_cleaner_and_strip_fcs__output_ch_rdy | stream_cleaner_and_strip_fcs__output_ch_valid_inv;
  assign stream_cleaner_and_strip_fcs__output_ch_load_en = __stream_cleaner_and_strip_fcs__output_ch_vld_buf & stream_cleaner_and_strip_fcs__output_ch_valid_load_en;
  assign p0_stage_done = __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg & (~____state_0 | stream_cleaner_and_strip_fcs__output_ch_load_en);
  assign stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_inv = ~__stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg;
  assign stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_load_en = p0_stage_done | stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_inv;
  assign stream_tlast = __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg[1:1];
  assign stream_tkeep = __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg[5:2];
  assign stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_load_en = stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld & stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_load_en;
  assign in_a_packet_next = ~stream_tlast;
  assign tuple_index_262 = __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg[37:6];
  assign tuple_index_263 = __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg[0:0];
  assign __stream_cleaner_and_strip_fcs__output_ch_buf = {____state_1, stream_tkeep, stream_tlast, ____state_4};
  always @ (posedge clk) begin
    if (clear) begin
      ____state_1 <= 32'h0000_0000;
      ____state_4 <= 1'h0;
      ____state_0 <= 1'h0;
      __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg <= __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg_init;
      __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg <= 1'h0;
      __stream_cleaner_and_strip_fcs__output_ch_reg <= __stream_cleaner_and_strip_fcs__output_ch_reg_init;
      __stream_cleaner_and_strip_fcs__output_ch_valid_reg <= 1'h0;
    end else begin
      ____state_1 <= p0_stage_done ? tuple_index_262 : ____state_1;
      ____state_4 <= p0_stage_done ? tuple_index_263 : ____state_4;
      ____state_0 <= p0_stage_done ? in_a_packet_next : ____state_0;
      __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg <= stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_load_en ? stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs : __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_reg;
      __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg <= stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_load_en ? stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld : __stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_valid_reg;
      __stream_cleaner_and_strip_fcs__output_ch_reg <= stream_cleaner_and_strip_fcs__output_ch_load_en ? __stream_cleaner_and_strip_fcs__output_ch_buf : __stream_cleaner_and_strip_fcs__output_ch_reg;
      __stream_cleaner_and_strip_fcs__output_ch_valid_reg <= stream_cleaner_and_strip_fcs__output_ch_valid_load_en ? __stream_cleaner_and_strip_fcs__output_ch_vld_buf : __stream_cleaner_and_strip_fcs__output_ch_valid_reg;
    end
  end
  assign stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_rdy = stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_load_en;
  assign stream_cleaner_and_strip_fcs__output_ch = __stream_cleaner_and_strip_fcs__output_ch_reg;
  assign stream_cleaner_and_strip_fcs__output_ch_vld = __stream_cleaner_and_strip_fcs__output_ch_valid_reg;
endmodule


module __stream_cleaner_and_strip_fcs__stream_cleaner_and_strip_fcs_0_next(
  input wire clk,
  input wire clear,
  input wire [37:0] stream_cleaner_and_strip_fcs__input_ch,
  input wire stream_cleaner_and_strip_fcs__input_ch_vld,
  input wire stream_cleaner_and_strip_fcs__output_ch_rdy,
  output wire stream_cleaner_and_strip_fcs__input_ch_rdy,
  output wire [37:0] stream_cleaner_and_strip_fcs__output_ch,
  output wire stream_cleaner_and_strip_fcs__output_ch_vld
);
  wire [37:0] instantiation_output_308;
  wire instantiation_output_309;
  wire instantiation_output_322;
  wire instantiation_output_316;
  wire [37:0] instantiation_output_326;
  wire instantiation_output_327;
  wire instantiation_output_310;
  wire [37:0] instantiation_output_314;
  wire instantiation_output_315;

  // ===== Instantiations
  __stream_cleaner_and_strip_fcs__stream_cleaner_and_strip_fcs_0_next__1 __stream_cleaner_and_strip_fcs__stream_cleaner_and_strip_fcs_0_next__1_inst0 (
    .clear(clear),
    .clk(clk)
  );
  __stream_cleaner_and_strip_fcs__stream_cleaner_and_strip_fcs__stream_cleaner_0_next __stream_cleaner_and_strip_fcs__stream_cleaner_and_strip_fcs__stream_cleaner_0_next_inst1 (
    .clear(clear),
    .stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_rdy(instantiation_output_310),
    .stream_cleaner_and_strip_fcs__input_ch(stream_cleaner_and_strip_fcs__input_ch),
    .stream_cleaner_and_strip_fcs__input_ch_vld(stream_cleaner_and_strip_fcs__input_ch_vld),
    .stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs(instantiation_output_308),
    .stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld(instantiation_output_309),
    .stream_cleaner_and_strip_fcs__input_ch_rdy(instantiation_output_322),
    .clk(clk)
  );
  __stream_cleaner_and_strip_fcs__stream_cleaner_and_strip_fcs__strip_fcs_0_next __stream_cleaner_and_strip_fcs__stream_cleaner_and_strip_fcs__strip_fcs_0_next_inst2 (
    .clear(clear),
    .stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs(instantiation_output_314),
    .stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_vld(instantiation_output_315),
    .stream_cleaner_and_strip_fcs__output_ch_rdy(stream_cleaner_and_strip_fcs__output_ch_rdy),
    .stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs_rdy(instantiation_output_316),
    .stream_cleaner_and_strip_fcs__output_ch(instantiation_output_326),
    .stream_cleaner_and_strip_fcs__output_ch_vld(instantiation_output_327),
    .clk(clk)
  );
  xls_fifo_wrapper #(
    .Width(32'd38),
    .Depth(32'd0),
    .EnableBypass(1'd1),
    .RegisterPushOutputs(1'd0),
    .RegisterPopOutputs(1'd0)
  ) fifo_stream_cleaner_and_strip_fcs__cleaner_to_strip_fcs (
    .clk(clk),
    .rst(clear),
    .push_data(instantiation_output_308),
    .push_valid(instantiation_output_309),
    .pop_ready(instantiation_output_316),
    .push_ready(instantiation_output_310),
    .pop_data(instantiation_output_314),
    .pop_valid(instantiation_output_315)
  );
  assign stream_cleaner_and_strip_fcs__input_ch_rdy = instantiation_output_322;
  assign stream_cleaner_and_strip_fcs__output_ch = instantiation_output_326;
  assign stream_cleaner_and_strip_fcs__output_ch_vld = instantiation_output_327;
endmodule
