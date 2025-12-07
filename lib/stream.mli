open! Hardcaml 

type 'a t  =
  { tdata : 'a 
  ; tkeep : 'a 
  ; tlast : 'a
  ; tfirst : 'a
  }
[@@deriving hardcaml]

include functor With_valid.Wrap.Include.F
