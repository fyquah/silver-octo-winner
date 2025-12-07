open Base

let verilog_design =
  Hardcaml_of_verilog.Verilog_design.t_of_sexp
   (Parsexp.Single.parse_string_exn {|
((top
  ((module_name __stream_cleaner__stream_cleaner_0_next)
   (path ../artifacts/stream_cleaner/stream_cleaner.v) (instantiates ())
   (parameters ()) (blackbox false)))
 (defines ()))
|})

let name =
  Hardcaml_of_verilog.Verilog_design.Module.module_name
    (Hardcaml_of_verilog.Verilog_design.top verilog_design)

module type P = sig

end

module P = struct

end

module I = struct
  type 'a t = {
    clk : 'a [@rtlname "clk"];
    clear : 'a [@rtlname "clear"];
    stream_cleaner__input_ch : 'a [@rtlname "stream_cleaner__input_ch"];
    stream_cleaner__input_ch_vld : 'a [@rtlname "stream_cleaner__input_ch_vld"];
    stream_cleaner__output_ch_rdy : 'a [@rtlname "stream_cleaner__output_ch_rdy"];
  }[@@deriving hardcaml ~rtlmangle:false]
end

module O = struct
  type 'a t = {
    stream_cleaner__input_ch_rdy : 'a [@rtlname "stream_cleaner__input_ch_rdy"];
    stream_cleaner__output_ch : 'a [@rtlname "stream_cleaner__output_ch"];
    stream_cleaner__output_ch_vld : 'a [@rtlname "stream_cleaner__output_ch_vld"];
  }[@@deriving hardcaml ~rtlmangle:false]
end

module From_verilog(P : P)(X : sig
  val verbose : bool
  val map_verilog_design
    :  Hardcaml_of_verilog.Verilog_design.t
    -> Hardcaml_of_verilog.Verilog_design.t
end) = struct
  let params = [

  ]

  include Hardcaml_of_verilog.Ocaml_module.Rebuild_interfaces(I)(O)(struct
    let verilog_design =
      Hardcaml_of_verilog.Verilog_design.override_parameters
        (X.map_verilog_design verilog_design) params

    let loaded_design =
      let create () =
        let%bind.Or_error netlist =
          Hardcaml_of_verilog.Netlist.create ~verbose:X.verbose verilog_design
        in
        Hardcaml_of_verilog.Verilog_circuit.create
          netlist
          ~top_name:
            (Hardcaml_of_verilog.Verilog_design.Module.module_name
              (Hardcaml_of_verilog.Verilog_design.top verilog_design))
      in
      create () |> Or_error.ok_exn
  end)
end

module From_json(X : sig val json : string end) = struct
  include Hardcaml_of_verilog.Ocaml_module.Rebuild_interfaces(I)(O)(struct
    let verilog_design = verilog_design

    let loaded_design =
      let create () =
        let%bind.Or_error yosys_netlist = Hardcaml_of_verilog.Expert.Yosys_netlist.of_string X.json in
        let%bind.Or_error netlist = Hardcaml_of_verilog.Netlist.of_yosys_netlist yosys_netlist in
        Hardcaml_of_verilog.Verilog_circuit.create
          netlist
          ~top_name:
            (Hardcaml_of_verilog.Verilog_design.Module.module_name
              (Hardcaml_of_verilog.Verilog_design.top verilog_design))
      in
      create () |> Or_error.ok_exn
    end)
end
