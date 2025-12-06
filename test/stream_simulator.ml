open Core
open Hardcaml 

module Stream = Foo_lib.Stream
module Step = Hardcaml_step_testbench_effectful.Imperative_cyclesim

module Send_ports = struct
  type t =
    { source : Bits.t ref Stream.t 
    ; valid  : Bits.t ref
    ; ready  : Bits.t ref Before_and_after_edge.t
    }
end

type config =
  | Always_high 
  | Rng of { rng : Random.State.t; probability_high : float }

let sample_from_config config =
  match config with 
  | Always_high -> true 
  | Rng { rng; probability_high } ->
    Float.(<) (Random.State.float rng 1.0) probability_high

let default_config = Rng { rng = Random.State.default ;probability_high = 0.95 }

let send_packet ?(config = default_config) (h @ local) { source; valid; ready } (packet : string) =
  let num_words = (String.length packet + 3) / 4 in
  let get x =
    if x < String.length packet then 
      Char.to_int packet.[x]
    else
      0
  in
  let tkeep_last =
    let l = String.length packet mod 4 i n
    if l = 0 then
      0xF
    else
      (1 lsl l) - 1
  in
  for i = 0 to num_words - 1 do
    let ch3 = get packet (i * 4 + 3) in
    let ch2 = get packet (i * 4 + 2) in
    let ch1 = get packet (i * 4 + 1) in
    let ch0 = get packet (i * 4 + 0) in
    while not (sample_from_config (config)) do
      Step.cycle h ();
    done;
    valid := Bits.vdd;
    source.tdata  := Bits.of_unsigned_int ~width:32 ((ch3 lsl 24) + (ch2 lsl 16) + (ch1 lsl 8) + ch0);
    source.tfirst := Bits.of_bool (i = 0);
    source.tlast  := Bits.of_bool (i = num_words - 1);
    source.tkeep  := (if i = num_words - 1 then tkeep_last else 0xF);
    Step.cycle h ();
    while not (Bits.to_bool !(ready.before_edge)) do
      Step.cycle h ();
    done;
    valid := Bits.gnd;
  done;
;;

module Receive_ports = struct
  type t =
    { source : Bits.t ref Stream.With_valid.t Before_and_after_edge.t
    ; ready  : Bits.t ref 
    }
end

let receive_packet ?(config = default_config) (h @ local)  (ports : Receive_ports.t) =
  let collected = Vec.create () in
  let is_first_word = ref true in
  let loop () =
    ports.ready := Bits.gnd;
    while (not (sample_from_config config)) do
      Step.cycle h ();
    done;
    (* Now, spin until we algin with a valid pulse *)
    while 
      Step.cycle h ();
      not (Bits.to_bool !(ports.source.before_edge.valid))
    do
      ()
    done;
    let stream =
      Stream.map ~f:(!) ports.source.before_edge.value
    in
    assert (Bool.equal !is_first_word (Bits.to_bool !(stream.valid)));
    let this_word =
      let popcount = Bits.to_unsigned_int (Bits.popcount !(stream.tkeep)) in
      Bits.sel_bottom ~width:(popcount * 8) !(stream.tdata)
    in
    Vec.push_back collected this_word;
    if not (Bits.to_bool !(stream.tlast)) then 
      loop ()
  in
  loop ();
  (Vec.to_list collected) 
  |> List.map ~f:(fun x -> Constant.Raw.to_string (Bits.to_constant x))
  |> String.concat ~sep:""
;;