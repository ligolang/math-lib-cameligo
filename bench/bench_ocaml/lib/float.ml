open Common

(* #import "math-lib-core/math.mligo" "Math" *)

(* n = a * 10^b *)
type t = { val_ : int; pow : int }

let new' (val_ : int) (pow : int) : t = { val_; pow }

let inverse (a : t) : t =
  {
    val_ = Z.one * Math.power (ten, eighteen) / a.val_;
    pow = (a.pow * minus_one) - eighteen;
  }

let add (a : t) (b : t) : t =
  if a.pow < b.pow then
    {
      val_ = (b.val_ * Math.power (ten, abs (b.pow - a.pow))) + a.val_;
      pow = a.pow;
    }
  else
    {
      val_ = (a.val_ * Math.power (ten, abs (a.pow - b.pow))) + b.val_;
      pow = b.pow;
    }

let sub (a : t) (b : t) : t =
  if a.pow < b.pow then
    {
      val_ = a.val_ - (b.val_ * Math.power (ten, abs (b.pow - a.pow)));
      pow = a.pow;
    }
  else
    {
      val_ = (a.val_ * Math.power (ten, abs (a.pow - b.pow))) - b.val_;
      pow = b.pow;
    }

let lt (a : t) (b : t) : bool =
  if a.val_ < Z.zero && b.val_ > Z.zero then true
  else if a.val_ > Z.zero && b.val_ < Z.zero then false
  else
    let diff = sub a b in
    diff.val_ < Z.zero

let lte (a : t) (b : t) : bool =
  if a.val_ < Z.zero && b.val_ > Z.zero then true
  else if a.val_ > Z.zero && b.val_ < Z.zero then false
  else
    let diff = sub a b in
    diff.val_ <= Z.zero

let gte (a : t) (b : t) : bool =
  if a.val_ >= Z.zero && b.val_ < Z.zero then true
  else if a.val_ <= Z.zero && b.val_ > Z.zero then false
  else
    let diff = sub a b in
    diff.val_ >= Z.zero

let gt (a : t) (b : t) : bool =
  if a.val_ > Z.zero && b.val_ < Z.zero then true
  else if a.val_ < Z.zero && b.val_ > Z.zero then false
  else
    let diff = sub a b in
    diff.val_ > Z.zero

let mul (a : t) (b : t) : t = { val_ = a.val_ * b.val_; pow = a.pow + b.pow }

let div (a : t) (b : t) : t =
  {
    val_ = a.val_ * Math.power (ten, eighteen) / b.val_;
    pow = a.pow - b.pow - eighteen;
  }

let modulo (a : t) (b : t) : t =
  let rec compute ((a, b) : t * t) : t =
    if lt a b then a else compute (sub a b, b)
  in
  compute (a, b)

let resolve (a : t) (prec : nat) : int =
  let resolve_positif (a : t) (prec : nat) : int =
    if a.pow > Z.zero then
      a.val_
      * Math.power (ten, abs a.pow)
      * Math.power (ten, prec)
    else
      a.val_
      * Math.power (ten, prec)
      / Math.power (ten, abs (minus_one * a.pow))
  in
  if a.val_ < Z.zero then minus_one * resolve_positif (new' (int' (abs a.val_)) a.pow) prec
  else resolve_positif a prec
