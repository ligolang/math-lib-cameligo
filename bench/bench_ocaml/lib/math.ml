open Common

(** This function is the integer square root function. *)
let isqrt (y: nat) =
  if y > 3 (* 3n *) then
      let z = y in
      let x = y / 2 (* 2n *) + 1 (* 1n *) in
      let rec iter (x, y, z: nat * nat * nat): nat =
          if x < z then
              iter ((y / x + x) / 2 (* n *) , y, x)
          else
              z
      in
      iter (x, y, z)
  else if y <> 0 (* n *) then
      1 (* 1n *)
  else
      0 (* 0n *)

let rec fast_power : nat -> nat -> nat -> nat = fun a b result ->
  if b = 0 (* 0n *) then result
  else 
      let result = if (b land 1 (* 1n *)) = 1 (* 1n *) then result * a else result in
      let b = b lsr 1 (* 1n *) in
      let a = a * a in
      fast_power a b result

(** return x ^ y *)
let power (x, y : nat * nat) : nat = fast_power x y 1 (* n *)

(** It computes the factorial n! for a given nat n. (i.e. n*(n-1)*(n-2)*...*1n ) *)
let factorial (n : nat) : nat = 
  let rec fact(acc, i : nat * nat) : nat = 
      if (i < 2 (* n *)) then acc else fact(acc * i, abs(i - 1 (* 1n *))) in
  fact(1 (* 1n *), n)

let min (a: nat) (b: nat) : nat =
  if (a < b) then a else b

let max (a: nat) (b: nat) : nat =
  if (a > b) then a else b

(* // TODO : optimize log algorithm ! *)
let log_10 (x : nat) : nat =
  let rec check_power(x, i : nat * nat) : nat =
      if (x mod power(10 (* 10n *), i) > 0 (* 0n *)) then
          abs(i - 1 (* 1n *))
      else
          check_power(x, i + 1 (* 1n *))
  in 
  check_power(x, 1 (* 1n *))
