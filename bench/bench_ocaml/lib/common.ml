type int = Z.t
type nat = int

let ( + ) = Z.add
let ( - ) = Z.sub
let ( * ) = Z.mul
let ( > ) = Z.gt
let ( / ) = Z.div
let ( land ) = Z.logand
let ( lsr ) = Z.shift_right
let ( mod ) = Z.rem
let two = Z.of_int 2
let three = Z.of_int 3
let four = Z.of_int 4
let five = Z.of_int 5
let six = Z.of_int 6
let seven = Z.of_int 7
let ten = Z.of_int 10
let eighteen = Z.of_int 18
let minus_one = Z.of_int (-1)
let abs x = if Z.lt x Z.zero then Z.mul minus_one x else x
let int' x = x
let assert_with_error b s = if b then () else failwith s

module Option = struct
  include Option

  let unopt = function Some x -> x | None -> failwith "Optinal value is none"
end

module List = struct
  include List

  let head_opt = function x :: _ -> Some x | _ -> None
  let tail_opt = function _ :: xs -> Some xs | _ -> None
end

module Test = struct
  let log = print_endline
end