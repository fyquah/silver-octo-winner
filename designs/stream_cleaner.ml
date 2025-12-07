open! Core
open! Hardcaml
open! Xls_demo_lib

module I = struct
  type 'a t = {
    clocking : 'a Clocking.t;
    up_src : 'a Stream.With_valid.t;
    dn_ready : 'a;
  }
  [@@deriving hardcaml ~rtlmangle:false]
end

module O = struct
  type 'a t = { up_ready : 'a; dn_src : 'a Stream.With_valid.t }
  [@@deriving hardcaml ~rtlmangle:false]
end

let create (_ : Scope.t) (i : _ I.t) : _ O.t =
  let module X =
    Stream_cleaner_inner.From_verilog (struct end)
      (struct
        let verbose = false
        let map_verilog_design x = x
      end)
  in
  let o_inner =
    X.create
      {
        clk = i.clocking.clock;
        clear = i.clocking.clear;
        stream_cleaner__input_ch = Stream.Of_signal.pack i.up_src.value;
        stream_cleaner__input_ch_vld = i.up_src.valid;
        stream_cleaner__output_ch_rdy = i.dn_ready;
      }
  in
  {
    O.up_ready = o_inner.stream_cleaner__input_ch_rdy;
    dn_src =
      {
        valid = o_inner.stream_cleaner__output_ch_vld;
        value = Stream.Of_signal.unpack o_inner.stream_cleaner__output_ch;
      };
  }
