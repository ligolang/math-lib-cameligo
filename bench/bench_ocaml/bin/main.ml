open Core_bench

let _ =
  Command_unix.run (Bench.make_command [
    Bench.Test.create ~name:"YoJson small" 
      (fun () -> ());
    Bench.Test.create ~name:"MyJson small" 
      (fun () -> ());
    Bench.Test.create ~name:"YoJson big" 
      (fun () -> ());
    Bench.Test.create ~name:"MyJson big" 
      (fun () -> ());
  ])