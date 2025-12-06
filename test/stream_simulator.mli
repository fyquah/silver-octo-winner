open Hardcaml 

module Stream = Foo_lib.Stream
module Step = Hardcaml_step_testbench_effectful.Imperative_cyclesim

module Send_ports : sig
  type t =
    { source : Bits.t ref Stream.t 
    ; valid  : Bits.t ref
    ; ready  : Bits.t ref Before_and_after_edge.t
    }
end

type config =
  | Always_high 
  | Rng of { rng : Random.State.t; probability_high : float }

val send_packet
   : ?config: config 
   -> Step.Handler.t @ local
  -> Send_ports.t
  -> string
  -> unit

val receive_packet
   : ?config: config 
  -> Step.Handler.t @ local
  -> Receive_ports.t
  -> unit