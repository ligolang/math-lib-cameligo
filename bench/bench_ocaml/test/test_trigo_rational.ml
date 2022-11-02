open Math_lib.Common
module Math = Math_lib.Math
module Rational = Math_lib.Rational
module Trigo = Math_lib.Trigo_rational

let _test_trigo_sinus ?(log = false) () =
  let error_threshold =
    Rational.inverse
      (Rational.new' (int' (Math.power (Z.of_int 10, Z.of_int 12))))
  in
  let precision : nat = Z.of_int 11 in
  let test_sinus ((angle, expected) : Rational.t * Rational.t) : bool =
    let diff = Rational.sub (Trigo.sinus (angle, precision)) expected in
    Rational.lt diff error_threshold
  in
  (* // sin(0) *)
  let () = if log then Test.log "sin(0)" in
  let angle = Trigo.zero in
  let expected = Rational.new' Z.zero in
  let () = assert (test_sinus (angle, expected)) in

  (* // sin(PI/2) *)
  let () = if log then Test.log "sin(Pi/2)" in
  let angle = Trigo.pi_half in
  let expected = Rational.new' Z.one in
  let () = assert (test_sinus (angle, expected)) in

  (* // sin(PI) *)
  let () = if log then Test.log "sin(Pi)" in
  let angle = Trigo.pi in
  let expected = Rational.new' Z.zero in
  let () = assert (test_sinus (angle, expected)) in

  (* // sin(3*PI/2) *)
  let () = if log then Test.log "sin(3*Pi/2)" in
  let angle = Trigo.three_pi_half in
  let expected = Rational.new' minus_one in
  let () = assert (test_sinus (angle, expected)) in

  (* // sin(2*PI) *)
  let () = if log then Test.log "sin(2*Pi)" in
  let angle = Trigo.two_pi in
  let expected = Rational.new' Z.zero in
  let () = assert (test_sinus (angle, expected)) in

  (* // sin(PI/4) *)
  let () = if log then Test.log "sin(Pi/4)" in
  let angle = Trigo.pi_quarter in
  let expected = Rational.div Trigo.sqrt_2 (Rational.new' two) in
  let () = assert (test_sinus (angle, expected)) in

  (* // sin(PI/6) *)
  let () = if log then Test.log "sin(Pi/6)" in
  let angle = Trigo.pi_sixth in
  let expected = Rational.inverse (Rational.new' two) in
  let () = assert (test_sinus (angle, expected)) in

  (* // sin(PI/3) *)
  let () = if log then Test.log "sin(Pi/3)" in
  let angle = Trigo.pi_third in
  let expected = Rational.div Trigo.sqrt_3 (Rational.new' two) in
  let () = assert (test_sinus (angle, expected)) in

  (* // sin(-PI/2) *)
  let () = if log then Test.log "sin(-Pi/2)" in
  let angle = Rational.sub (Rational.new' Z.zero) Trigo.pi_half in
  let expected = Rational.new' minus_one in
  let () = assert (test_sinus (angle, expected)) in

  (* // sin(-3*PI/2) *)
  let () = if log then Test.log "sin(-3*Pi/2)" in
  (* //let angle = Rational.sub Trigo.zero Trigo.three_pi_half in *)
  let angle = Rational.sub Trigo.pi_half Trigo.two_pi in
  let expected = Rational.new' Z.one in
  let () = assert (test_sinus (angle, expected)) in

  if log then Test.log "Test 'trigo sinus (with rational)' finished"

let _test_trigo_cosinus ?(log = false) () =
  let error_threshold =
    Rational.inverse
      (Rational.new' (int' (Math.power (Z.of_int 10, Z.of_int 12))))
  in
  let precision : nat = Z.of_int 11 in
  let test_cosinus ((angle, expected) : Rational.t * Rational.t) : bool =
    let diff = Rational.sub (Trigo.cosinus (angle, precision)) expected in
    Rational.lt diff error_threshold
  in
  (* // cos(0) *)
  let () = if log then Test.log "cos(0)" in
  let angle = Trigo.zero in
  let expected = Rational.new' Z.one in
  let () = assert (test_cosinus (angle, expected)) in

  (* // cos(PI/2) *)
  let () = if log then Test.log "cos(Pi/2)" in
  let angle = Trigo.pi_half in
  let expected = Rational.new' Z.zero in
  let () = assert (test_cosinus (angle, expected)) in

  (* // cos(PI) *)
  let () = if log then Test.log "cos(Pi)" in
  let angle = Trigo.pi in
  let expected = Rational.new' minus_one in
  let () = assert (test_cosinus (angle, expected)) in

  (* // cos(3*PI/2) *)
  let () = if log then Test.log "cos(3*Pi/2)" in
  let angle = Trigo.three_pi_half in
  let expected = Rational.new' Z.one in
  let () = assert (test_cosinus (angle, expected)) in

  (* // cos(2*PI) *)
  let () = if log then Test.log "cos(2*Pi)" in
  let angle = Trigo.two_pi in
  let expected = Rational.new' Z.one in
  let () = assert (test_cosinus (angle, expected)) in

  (* // cos(PI/4) *)
  let () = if log then Test.log "cos(Pi/4)" in
  let angle = Trigo.pi_quarter in
  let expected = Rational.div Trigo.sqrt_2 (Rational.new' two) in
  let () = assert (test_cosinus (angle, expected)) in

  (* // cos(PI/6) *)
  let () = if log then Test.log "cos(Pi/6)" in
  let angle = Trigo.pi_sixth in
  let expected = Rational.div Trigo.sqrt_3 (Rational.new' two) in
  let () = assert (test_cosinus (angle, expected)) in

  (* // cos(PI/3) *)
  let () = if log then Test.log "cos(Pi/3)" in
  let angle = Trigo.pi_third in
  let expected = Rational.inverse (Rational.new' (Z.of_int 2)) in
  let () = assert (test_cosinus (angle, expected)) in

  (* // cos(-PI/2) *)
  let () = if log then Test.log "cos(-Pi/2)" in
  let angle = Rational.sub (Rational.new' Z.zero) Trigo.pi_half in
  let expected = Rational.new' Z.zero in
  let () = assert (test_cosinus (angle, expected)) in

  (* // cos(-3*PI/2) *)
  let () = if log then Test.log "cos(-3*Pi/2)" in
  (* //let angle = Rational.sub Trigo.zero Trigo.three_pi_half in *)
  let angle = Rational.sub Trigo.pi_half Trigo.two_pi in
  let expected = Rational.new' Z.zero in
  let () = assert (test_cosinus (angle, expected)) in

  if log then Test.log "Test 'trigo cosinus (with rational)' finished"

let _test_trigo ?(log = false) () =
  let error_threshold =
    Rational.inverse
      (Rational.new' (int' (Math.power (Z.of_int 10, Z.of_int 12))))
  in
  let precision : nat = Z.of_int 11 in
  (* // cos²(a) + sin²(a) = 1 *)
  let () = if log then Test.log "cos^2(a) + sin^2(a) = 1" in
  let angle = Trigo.pi_half in
  let expected = Rational.new' Z.one in
  let cos_a = Trigo.cosinus (angle, precision) in
  let sin_a = Trigo.sinus (angle, precision) in
  let res =
    Rational.add (Rational.mul cos_a cos_a) (Rational.mul sin_a sin_a)
  in
  let diff = Rational.sub res expected in
  let () = assert (Rational.lt diff error_threshold) in

  if log then Test.log "Test 'trigo (with rational)' finished"

let all ?log () =
  _test_trigo ?log ();
  _test_trigo_sinus ?log ();
  _test_trigo_cosinus ?log ()
