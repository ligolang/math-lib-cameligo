open Common

(** This function is the integer square root function. *)
let isqrt (y : nat) =
  if y > three then
    let z = y in
    let x = (y / two) + Z.one in
    let rec iter ((x, y, z) : nat * nat * nat) : nat =
      if x < z then iter (((y / x) + x) / two, y, x) else z
    in
    iter (x, y, z)
  else if y <> Z.zero then Z.one
  else Z.zero

let rec fast_power : nat -> nat -> nat -> nat =
 fun a b result ->
  if b = Z.zero then result
  else
    let result = if b land Z.one = Z.one then result * a else result in
    let b = b lsr 1 in
    let a = a * a in
    fast_power a b result

(** return x ^ y *)
let power ((x, y) : nat * nat) : nat = fast_power x y Z.one

(** It computes the factorial n! for a given nat n. (i.e. n*(n-1)*(n-2)*...*1n ) *)
let factorial (n : nat) : nat =
  let rec fact ((acc, i) : nat * nat) : nat =
    if i < two then acc else fact (acc * i, abs (i - Z.one))
  in
  fact (Z.one, n)

let min (a : nat) (b : nat) : nat = if a < b then a else b
let max (a : nat) (b : nat) : nat = if a > b then a else b

(* // TODO : optimize log algorithm ! *)
let log_10 (x : nat) : nat =
  let rec check_power ((x, i) : nat * nat) : nat =
    if x mod power (ten, i) > Z.zero then abs (i - Z.one)
    else check_power (x, i + Z.one)
  in
  check_power (x, Z.one)
