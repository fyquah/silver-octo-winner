open Core
open Hardcaml
open Xls_demo_designs
open Stream_cleaner
module Step = Hardcaml_step_testbench_effectful.Imperative.Cyclesim
module Before_and_after_edge = Hardcaml_step_testbench_effectful.Before_and_after_edge
module Sim = Cyclesim.With_interface(I)(O)

let create_sim () =
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (create scope) in
  sim
;;

let%expect_test "" =
  let simulator = create_sim () in
  let inputs = Cyclesim.inputs simulator in
  let outputs =
    { Before_and_after_edge.
      before_edge = Cyclesim.outputs ~clock_edge:Before simulator
    ; after_edge  = Cyclesim.outputs ~clock_edge:After  simulator
    }
  in
  Step.run_until_finished () ~simulator ~testbench:(fun h ->
    inputs.clocking.clear := Bits.vdd;
    Step.cycle ~num_cycles:3 h ();
    inputs.clocking.clear := Bits.gnd;
    Step.cycle ~num_cycles:3 h ();
    let task =
      Step.spawn h (fun h () ->
        Stream_simulator.receive_packet
          h
          { source = Before_and_after_edge.map outputs ~f:(fun o -> o.dn_src)
          ; ready = inputs.dn_ready
          })
    in
    Stream_simulator.send_packet
      h
      { source = inputs.up_src
      ; ready  = Before_and_after_edge.map outputs ~f:(fun o -> o.up_ready)
      }
      "Hello, World!";
    let received = Step.wait_for h task in
    print_s [%message (received : String.Hexdump.t)];
  );
;;
