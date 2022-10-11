open Common

(* #import "math-lib-core/math.mligo" "Math" *)

(* // n = p / q *)
type t = { p : int; q : int }

let compare a b =
  if a.q = b.q then Z.compare a.p b.p else Z.compare (a.p * b.q) (b.p * a.q)

let new' (init : int) : t = { p = init; q = Z.one }
let inverse (a : t) : t = { p = a.q; q = a.p }
let lt (a : t) (b : t) : bool = a.p * b.q < a.q * b.p
let lte (a : t) (b : t) : bool = a.p * b.q <= a.q * b.p
let add (a : t) (b : t) : t = { p = (a.p * b.q) + (b.p * a.q); q = a.q * b.q }
let sub (a : t) (b : t) : t = { p = (a.p * b.q) - (b.p * a.q); q = a.q * b.q }
let mul (a : t) (b : t) : t = { p = a.p * b.p; q = a.q * b.q }
let div (a : t) (b : t) : t = { p = a.p * b.q; q = a.q * b.p }

let modulo (a : t) (b : t) : t =
  let rec compute ((a, b) : t * t) : t =
    if lt a b then a else compute (sub a b, b)
  in
  compute (a, b)

let resolve (a : t) (prec : nat) : int =
  let input : t =
    if a.p < Z.zero then { p = a.p * minus_one; q = a.q * minus_one } else a
  in
  input.p * Math.power (ten, prec) / input.q
