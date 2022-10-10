open Common

(* #import "math-lib-core/math.mligo" "Math" *)

(* // n = p / q *)
type t = { p : int; q: int }

let new' (init : int) : t = 
    { p= init; q=1 }

let inverse (a : t) : t = 
    { p= a.q; q=a.p }

let lt (a : t) (b : t) : bool = 
    (a.p * b.q < a.q * b.p)

let lte (a : t) (b : t) : bool = 
    (a.p * b.q <= a.q * b.p)

let add (a : t) (b : t) : t =
    { p= a.p * b.q + b.p * a.q ; q=a.q * b.q }

let sub (a : t) (b : t) : t =
    { p= a.p * b.q - b.p * a.q ; q=a.q * b.q }

let mul (a : t) (b : t) : t =
    { p= a.p * b.p ; q=a.q * b.q }

let div (a : t) (b : t) : t =
    { p= a.p * b.q ; q=a.q * b.p }

let modulo (a : t) (b : t) : t =
    let rec compute (a, b : t * t) : t =
        if (lt a b) then 
            a 
        else
            compute((sub a b), b)
    in
    compute(a, b)

let resolve (a: t) (prec: nat) : int =
    let input : t = if (a.p < 0) then
        { p= a.p * -1; q=a.q * -1 }
    else
        a
    in
    (input.p * Math.power(10 (* 10n *), prec)) / input.q