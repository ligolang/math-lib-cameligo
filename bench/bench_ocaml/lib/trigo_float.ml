open Common

(* #import "./float.mligo" "Float" *)

type chebychev_coef = Float.t list

let zero : Float.t = { val_ = Z.zero; pow = Z.zero }
let one : Float.t = { val_ = Z.one; pow = Z.zero }
let minus_one : Float.t = { val_ = minus_one; pow = Z.zero }
let two : Float.t = { val_ = two; pow = Z.zero }

(* //PI = 1.414213562373095048801688724209698078569671875376948073176679737990732478462107038850387534327641572735013846230912297024924836055850737212644121497099935831413222665927505592755799950501152782060571 *)
let pi : Float.t =
  let val_ =
    Z.of_string
      "31415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679"
  in
  let pow = Z.of_string "-100" in
  { val_; pow }

let two_pi : Float.t = Float.mul pi (Float.new' Common.two Z.zero)
let pi_half : Float.t = Float.div pi (Float.new' Common.two Z.zero)
let pi_quarter : Float.t = Float.div pi (Float.new' Common.four Z.zero)
let three_pi_half : Float.t = Float.mul pi_half (Float.new' Common.three Z.zero)

let three_pi_quarter : Float.t =
  Float.mul pi_quarter (Float.new' Common.three Z.zero)

let five_pi_quarter : Float.t =
  Float.mul pi_quarter (Float.new' Common.five Z.zero)

let seven_pi_quarter : Float.t =
  Float.mul pi_quarter (Float.new' Common.seven Z.zero)

let pi_third : Float.t = Float.div pi (Float.new' Common.three Z.zero)
let pi_sixth : Float.t = Float.div pi (Float.new' Common.six Z.zero)

let sqrt_2 : Float.t =
  let val_ = Z.of_string "1414213562373095048801688724209" in
  let pow = Z.of_int (-30) in
  { val_; pow }

let sqrt_3 : Float.t =
  let val_ = Z.of_string "17320508075688772935" in
  let pow = Z.of_int (-19) in
  { val_; pow }

(* computes sinus for an ange between zero and half_pi *)
let sin ((a, n) : Float.t * nat) : Float.t =
  let _check_angle_positive =
    assert_with_error (Float.gte a zero)
      "[Trigo_float.sinus] given angle is out of bound"
  in
  let _check_angle_pi_half =
    assert_with_error (Float.lte a pi_half)
      "[Trigo_float.sinus] given angle is out of bound"
  in
  let one = Float.new' Z.one Z.zero in
  let two = Float.new' Common.two Z.zero in
  (* //let u = (x - (a+b)/2.0 )/ (b-a)/2.0 *)
  let u =
    Float.div
      (Float.sub a (Float.div (Float.add zero pi_half) two))
      (Float.div (Float.sub pi_half zero) two)
  in
  let coef : chebychev_coef =
    [
      { val_ = Z.of_int (6021947012555463)  ; pow = Z.of_int (-16) };
      { val_ = Z.of_int (513625166679107)   ; pow = Z.of_int (-15) };
      { val_ = Z.of_int (-10354634426296383); pow = Z.of_int (-17) };
      { val_ = Z.of_int (-13732034234358675); pow = Z.of_int (-18) };
      { val_ = Z.of_int (13586698380902013) ; pow = Z.of_int (-19) };
      { val_ = Z.of_int (10726309440570181) ; pow = Z.of_int (-20) };
      { val_ = Z.of_int (-7046296793891682) ; pow = Z.of_int (-21) };
      { val_ = Z.of_int (-3963902510811801) ; pow = Z.of_int (-22) };
      { val_ = Z.of_int (194995972671759)   ; pow = Z.of_int (-22) };
      { val_ = Z.of_int (8522923894416223)  ; pow = Z.of_int (-25) };
      { val_ = Z.of_int (-3351717514643582) ; pow = Z.of_int (-26) };
      { val_ = Z.of_int (-11987008607938776); pow = Z.of_int (-28) };
      { val_ = Z.of_int (3835820550079916)  ; pow = Z.of_int (-29) };
    ]
  in

  let coef_0 = Option.unopt (List.head_opt coef) in
  let coef_1 =
    Option.unopt (List.head_opt (Option.unopt (List.tail_opt coef)))
  in
  let y0 = Float.add coef_0 (Float.mul coef_1 u) in
  let t0 : Float.t = one in
  let t1 : Float.t = u in
  let coef_from_2 =
    Option.unopt (List.tail_opt (Option.unopt (List.tail_opt coef)))
  in
  let rec compute
      ((i, acc, t_prev, t_prev_prev, n, coef) :
        nat * Float.t * Float.t * Float.t * nat * chebychev_coef) : Float.t =
    if i <= n then
      let t_next_u =
        Float.sub (Float.mul (Float.mul two u) t_prev) t_prev_prev
      in
      let current_coef = Option.unopt (List.head_opt coef) in
      let rest_coef = Option.unopt (List.tail_opt coef) in
      let new_acc = Float.add acc (Float.mul t_next_u current_coef) in
      compute (i + Z.one, new_acc, t_next_u, t_prev, n, rest_coef)
    else acc
  in
  (compute (Common.two, y0, t1, t0, n, coef_from_2) [@private])

let rec sinus_symetry ((sign, a, n) : Float.t * Float.t * nat) : Float.t =
  (* // sin(-a) = - sin(a) *)
  if Float.lt a zero then
    sinus_symetry
      ( Float.mul sign (Float.new' Common.minus_one Z.zero),
        Float.mul a (Float.new' Common.minus_one Z.zero),
        n )
  else
    let a_mod_two_pi = Float.modulo a two_pi in
    (* //[0, pi_half] *)
    if Float.lte a_mod_two_pi pi_half then
      Float.mul sign (sin (a_mod_two_pi, n))
      (* //[pi_half, pi] -> sin(Pi/2 + a) = sin(Pi/2 - a) *)
    else if Float.lte a_mod_two_pi pi then
      let theta = Float.sub a_mod_two_pi pi_half in
      let half_pi_minus_a = Float.sub pi_half theta in
      Float.mul sign (sin (half_pi_minus_a, n))
      (* //[pi, two_pi] -> sin(Pi + a) = - sin(a) *)
    else if Float.lt pi a_mod_two_pi then
      let minus_pi = Float.sub a_mod_two_pi pi in
      sinus_symetry
        (Float.mul sign (Float.new' Common.minus_one Z.zero), minus_pi, n)
    else (failwith "[Trigo_float.sinus] ERROR out of bound angle" : Float.t)

let sinus ((a, n) : Float.t * nat) : Float.t =
  sinus_symetry (Float.new' Z.one Z.zero, a, n)

let cosinus ((a, n) : Float.t * nat) : Float.t =
  let plus_half_PI = Float.add a pi_half in
  sinus_symetry (Float.new' Z.one Z.zero, plus_half_PI, n)
