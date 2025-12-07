open! Hardcaml 

type 'a t  =
  { tdata : 'a [@bits 32]
  ; tkeep : 'a [@bits 32]
  ; tlast : 'a
  ; tfirst : 'a
  }
[@@deriving hardcaml]

include functor With_valid.Wrap.Include.Make