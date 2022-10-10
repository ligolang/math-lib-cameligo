type nat = int

(* int' *)
let int' x = x

let assert_with_error b s = if b then () else failwith s

module Option = struct
  include Option
  let unopt = function Some x -> x | None -> failwith "Optinal value is none"
end

module List = struct
  include List
  let head_opt = function x::_ -> Some x | _ -> None
  let tail_opt = function _::xs -> Some xs | _ -> None
end

type ('a,'b) map = unit