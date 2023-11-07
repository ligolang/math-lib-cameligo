module Math = Math_lib.Math
module Test = Math_lib.Common.Test

let _test_isqrt ?(log = false) () =
  let () = assert (Math.isqrt (Z.of_int 4) = Z.of_int 2) in
  let () = assert (Math.isqrt (Z.of_int 8) = Z.of_int 2) in
  let () = assert (Math.isqrt (Z.of_int 9) = Z.of_int 3) in
  let () = assert (Math.isqrt (Z.of_int 15) = Z.of_int 3) in
  let () = assert (Math.isqrt (Z.of_int 16) = Z.of_int 4) in
  let () = assert (Math.isqrt (Z.of_int 17) = Z.of_int 4) in

  if log then Test.log "Test 'isqrt' finished"

let _test_factorial ?(log = false) () =
  let () = assert (Math.factorial (Z.of_int 0) = Z.of_int 1) in
  let () = assert (Math.factorial (Z.of_int 1) = Z.of_int 1) in
  let () = assert (Math.factorial (Z.of_int 2) = Z.of_int 2) in
  let () = assert (Math.factorial (Z.of_int 3) = Z.of_int 6) in
  let () = assert (Math.factorial (Z.of_int 4) = Z.of_int 24) in
  let () = assert (Math.factorial (Z.of_int 5) = Z.of_int 120) in
  let () = assert (Math.factorial (Z.of_int 6) = Z.of_int 720) in

  if log then Test.log "Test 'factorial' finished"

let all ?log () =
  _test_isqrt ?log ();
  _test_factorial ?log ()