module Float = Math_lib.Float
module Test = Math_lib.Common.Test

let _test_scientific () =
  let a : Float.t = Float.inverse (Float.new' (Z.of_int 6) Z.zero) in
  let value_resolved = Float.resolve a (Z.of_int 3) in
  let () = assert (value_resolved = Z.of_int 166) in

  let a : Float.t = Float.inverse (Float.new' (Z.of_int 6) Z.zero) in
  let a : Float.t = Float.mul (Float.new' (Z.of_int (-1)) Z.zero) a in
  let value_resolved = Float.resolve a (Z.of_int 3) in
  let () = assert (value_resolved = Z.of_int (-166)) in

  let a : Float.t = Float.inverse (Float.new' (Z.of_int 3) Z.zero) in
  let b : Float.t = Float.inverse (Float.new' (Z.of_int 2) Z.zero) in
  let value : Float.t = Float.add a b in
  (* //let () = assert(value = { p=5; q=6 }) in *)
  let value_resolved = Float.resolve value (Z.of_int 3) in
  let () = assert (value_resolved = (Z.of_int 833)) in

  let a : Float.t = Float.inverse (Float.new' (Z.of_int 3) Z.zero) in
  let b : Float.t = Float.inverse (Float.new' (Z.of_int 2) Z.zero) in
  let value : Float.t = Float.sub a b in
  (* //let () = assert(value = { p=-1; q=6 }) in *)
  let value_resolved = Float.resolve value (Z.of_int 3) in
  let () = assert (value_resolved = (Z.of_int (-166))) in

  let a : Float.t = Float.inverse (Float.new' (Z.of_int 3) Z.zero) in
  let b : Float.t = Float.inverse (Float.new' (Z.of_int 2) Z.zero) in
  let value : Float.t = Float.mul a b in
  (* //let () = assert(value = { p=1; q=6 }) in *)
  let value_resolved = Float.resolve value (Z.of_int 3) in
  let () = assert (value_resolved = (Z.of_int 166)) in

  let a : Float.t = Float.inverse (Float.new' (Z.of_int 3) Z.zero) in
  let b : Float.t = Float.inverse (Float.new' (Z.of_int 2) Z.zero) in
  let value : Float.t = Float.div a b in
  (* //let () = assert(value = { p=2; q=3 }) in *)
  let value_resolved = Float.resolve value (Z.of_int 3) in
  let () = assert (value_resolved = (Z.of_int 666)) in

  (* // 1/2 % 1/3 *)
  let a : Float.t = Float.inverse (Float.new' (Z.of_int 2) Z.zero) in
  let b : Float.t = Float.inverse (Float.new' (Z.of_int 3) Z.zero) in
  let value : Float.t = Float.modulo a b in
  (* //let () = assert(value = { p=2; q=3 }) in *)
  let value_resolved = Float.resolve value (Z.of_int 3) in
  let () = assert (value_resolved = (Z.of_int 166)) in

  Test.log "Test finished"

let _ = _test_scientific ()