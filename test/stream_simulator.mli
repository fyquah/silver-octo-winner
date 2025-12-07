open Core
open Hardcaml
module Stream = Xls_demo_lib.Stream
module Step = Hardcaml_step_testbench_effectful.Imperative.Cyclesim

module Before_and_after_edge =
  Hardcaml_step_testbench_effectful.Before_and_after_edge

module Send_ports : sig
  type t = {
    source : Bits.t ref Stream.With_valid.t;
    ready : Bits.t ref Before_and_after_edge.t;
  }
end

module Receive_ports : sig
  type t = {
    source : Bits.t ref Stream.With_valid.t Before_and_after_edge.t;
    ready : Bits.t ref;
  }
end

type config =
  | Always_high
  | Rng of { rng : Random.State.t; probability_high : float }

val send_packet :
  ?config:config -> Step.Handler.t @ local -> Send_ports.t -> string -> unit

val receive_packet :
  ?config:config -> Step.Handler.t @ local -> Receive_ports.t -> string
