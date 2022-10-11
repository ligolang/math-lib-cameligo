open Core_bench

let _ =
  Command_unix.run
    (Bench.make_command
       [
         Bench.Test.create ~name:"Float lib" (fun () ->
             Math_lib_tests.Test_float.all ());
         Bench.Test.create ~name:"Rational lib" (fun () ->
             Math_lib_tests.Test_rational.all ());
       ])

let _ =
  Command_unix.run
    (Bench.make_command
       [
         Bench.Test.create ~name:"Trigonomery Float lig" (fun () ->
             Math_lib_tests.Test_trigo_float.all ());
         Bench.Test.create ~name:"Trigonomery Rational lig" (fun () ->
             Math_lib_tests.Test_trigo_rational.all ());
       ])
