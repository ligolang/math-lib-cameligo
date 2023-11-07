module Rational = Math_lib.Rational
module Test = Math_lib.Common.Test

let _test_rational ?(log = false) () =
  let a = Rational.new' (Z.of_int 6) in
  let a = Rational.inverse a in
  let value_resolved = Rational.resolve a (Z.of_int 3) in
  let () = assert (value_resolved = Z.of_int 166) in

  let a : Rational.t = { p = Z.of_int 1; q = Z.of_int 6 } in
  let value_resolved = Rational.resolve a (Z.of_int 3) in
  let () = assert (value_resolved = Z.of_int 166) in

  let a : Rational.t = { p = Z.of_int (-1); q = Z.of_int 6 } in
  let value_resolved = Rational.resolve a (Z.of_int 3) in
  let () = assert (value_resolved = Z.of_int (-166)) in

  let a : Rational.t = { p = Z.of_int 1; q = Z.of_int 3 } in
  let b : Rational.t = { p = Z.of_int 1; q = Z.of_int 2 } in
  let value : Rational.t = Rational.add a b in
  let () = assert (value = { p = Z.of_int 5; q = Z.of_int 6 }) in
  let value_resolved = Rational.resolve value (Z.of_int 3) in
  let () = assert (value_resolved = Z.of_int 833) in

  let a : Rational.t = { p = Z.of_int 1; q = Z.of_int 3 } in
  let b : Rational.t = { p = Z.of_int 1; q = Z.of_int 2 } in
  let value : Rational.t = Rational.sub a b in
  let () = assert (value = { p = Z.of_int (-1); q = Z.of_int 6 }) in
  let value_resolved = Rational.resolve value (Z.of_int 3) in
  let () = assert (value_resolved = Z.of_int (-166)) in

  let a : Rational.t = { p = Z.of_int 1; q = Z.of_int 3 } in
  let b : Rational.t = { p = Z.of_int 1; q = Z.of_int 2 } in
  let value : Rational.t = Rational.mul a b in
  let () = assert (value = { p = Z.of_int 1; q = Z.of_int 6 }) in
  let value_resolved = Rational.resolve value (Z.of_int 3) in
  let () = assert (value_resolved = Z.of_int 166) in

  let a : Rational.t = { p = Z.of_int 1; q = Z.of_int 3 } in
  let b : Rational.t = { p = Z.of_int 1; q = Z.of_int 2 } in
  let value : Rational.t = Rational.div a b in
  let () = assert (value = { p = Z.of_int 2; q = Z.of_int 3 }) in
  let value_resolved = Rational.resolve value (Z.of_int 3) in
  let () = assert (value_resolved = Z.of_int 666) in

  if log then Test.log "Test finished"

let all ?log () = _test_rational ?log ()