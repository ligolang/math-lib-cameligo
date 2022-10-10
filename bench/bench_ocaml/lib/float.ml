open Common

(* #import "math-lib-core/math.mligo" "Math" *)

(* n = a * 10^b *)
type t = { val_ : int; pow: int }

let new' (val_ : int) (pow: int) : t = 
    { val_=val_; pow=pow }

let inverse (a : t) : t = 
    { val_= 1 (* 1n *) * Math.power(10 (* 10n *), 18 (* 18n *)) / a.val_; pow=(a.pow * -1) - 18 (* 18n *) }

let add (a : t) (b : t) : t = 
    if (a.pow < b.pow) then
        { val_= b.val_ * Math.power(10 (* 10n *), abs(b.pow - a.pow)) + a.val_; pow=a.pow }
    else
        { val_= a.val_ * Math.power(10 (* 10n *), abs(a.pow - b.pow)) + b.val_; pow=b.pow }

let sub (a : t) (b : t) : t =
    if (a.pow < b.pow) then
        { val_= a.val_ - b.val_ * Math.power(10(* 10n*), abs(b.pow - a.pow)); pow=a.pow }
    else
        { val_= a.val_ * Math.power(10(* 10n *), abs(a.pow - b.pow)) - b.val_; pow=b.pow }

let lt (a : t) (b : t) : bool = 
    if (a.val_ < 0) && (b.val_ > 0) then
        true
    else if (a.val_ > 0) && (b.val_ < 0) then
        false
    else 
        let diff = sub a b in
        diff.val_ < 0  

let lte (a : t) (b : t) : bool = 
        if (a.val_ < 0) && (b.val_ > 0) then
        true
    else if (a.val_ > 0) && (b.val_ < 0) then
        false
    else 
        let diff = sub a b in
        diff.val_ <= 0  

let gte (a : t) (b : t) : bool = 
    if (a.val_ >= 0) && (b.val_ < 0) then
        true
    else if (a.val_ <= 0) && (b.val_ > 0) then
        false
    else 
        let diff = sub a b in
        diff.val_ >= 0  

let gt (a : t) (b : t) : bool = 
    if (a.val_ > 0) && (b.val_ < 0) then
        true
    else if (a.val_ < 0) && (b.val_ > 0) then
        false
    else 
        let diff = sub a b in
        diff.val_ > 0  

let mul (a : t) (b : t) : t =
    { val_= a.val_ * b.val_ ; pow=a.pow + b.pow }

let div (a : t) (b : t) : t =
    { val_= a.val_ * Math.power(10(* 10n *), 18(* 18n *)) / b.val_ ; pow=a.pow - b.pow - 18(* 18n *) }

let modulo (a : t) (b : t) : t =
    let rec compute (a, b : t * t) : t =
        if (lt a b) then 
            a 
        else
            compute((sub a b), b)
    in
    compute(a, b)

let resolve (a: t) (prec: nat) : int =
    let resolve_positif (a: t) (prec: nat) : int =
        if (a.pow > 0) then
            a.val_ * Math.power(10(* 10n *), abs(a.pow)) * Math.power(10 (* 10n *), prec) 
        else
            a.val_ * Math.power(10(* 10n *), prec) / Math.power(10(* 10n *), abs(-a.pow)) 
    in
    if (a.val_ < 0) then
        -1 * (resolve_positif (new' (int'(abs(a.val_))) a.pow) prec)
    else
        resolve_positif a prec