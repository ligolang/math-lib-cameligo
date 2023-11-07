open Common

type chebychev_intervals = Rational.t * Rational.t
type chebychev_coef = Rational.t list

module Map' = Map.Make (struct
  type t = chebychev_intervals

  let compare (ra, rb) (rc, rd) =
    Int.compare (Rational.compare ra rc) (Rational.compare rb rd)
end)

module Map = struct
  include Map'

  let literal xs = List.fold_left (fun m (k, v) -> Map'.add k v m) Map'.empty xs
end

type chebychev = chebychev_coef Map.t

let zero : Rational.t =
  let p = Z.zero in
  let q = Z.one in
  { p; q }

let pi : Rational.t =
  let p =
    Z.of_string
      "31415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679"
  in
  let q =
    Z.of_string
      "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
  in
  { p; q }

let two_pi : Rational.t = Rational.mul pi (Rational.new' two)
let pi_half : Rational.t = Rational.div pi (Rational.new' two)
let pi_quarter : Rational.t = Rational.div pi (Rational.new' four)
let three_pi_half : Rational.t = Rational.mul pi_half (Rational.new' three)

let three_pi_quarter : Rational.t =
  Rational.mul pi_quarter (Rational.new' three)

let five_pi_quarter : Rational.t = Rational.mul pi_quarter (Rational.new' five)

let seven_pi_quarter : Rational.t =
  Rational.mul pi_quarter (Rational.new' seven)

let pi_third : Rational.t = Rational.div pi (Rational.new' three)
let pi_sixth : Rational.t = Rational.div pi (Rational.new' six)

(* //1.414213562373095048801688724209698078569671875376948073176679737990732478462107038850387534327641572735013846230912297024924836055850737212644121497099935831413222665927505592755799950501152782060571 *)
(* //1.7320508075688772935 *)

let sqrt_2 : Rational.t =
  let p = Z.of_string "1414213562373095048801688724209" in
  let q = Z.of_string "1000000000000000000000000000000" in
  { p; q }

let sqrt_3 : Rational.t =
  let p = Z.of_string "17320508075688772935" in
  let q = Z.of_string "10000000000000000000" in
  { p; q }

let chebychev_lookup_intervals : chebychev_intervals list =
  [
    (* // (zero,pi_quarter);
       // (pi_quarter,pi_half);
       // (pi_half,three_pi_quarter);
       // (three_pi_quarter,pi);
       // (pi,five_pi_quarter);
       // (five_pi_quarter,three_pi_half);
       // (three_pi_half,seven_pi_quarter);
       // (seven_pi_quarter,two_pi); *)
    (zero, pi_half);
  ]

(* //0.0, 1.5707963267948966, 0.6021947012555463, 0.513625166679107, -0.10354634426296383, -0.013732034234358675, 0.0013586698380902013, 0.00010726309440570181, -7.046296793891682e-06, -3.963902510811801e-07, 1.94995972671759e-08, 8.522923894416223e-10, -3.351717514643582e-11, -1.1987008607938776e-12, 3.835820550079916e-14, 4.163336342344337e-16, -6.591949208711867e-16, -1.9290125052862095e-15 *)

let chebychev_lookup_table : chebychev =
  Map.literal
    [
      (* // ((zero,pi_quarter),({p=0;q=1}, {p=0;q=1}, {p=0;q=1}) );
         // ((pi_quarter,pi_half),({p=0;q=1}, {p=0;q=1}, {p=0;q=1}) );
         // ((pi_half,three_pi_quarter),({p=0;q=1}, {p=0;q=1}, {p=0;q=1}) );
         // ((three_pi_quarter,pi),({p=0;q=1}, {p=0;q=1}, {p=0;q=1}) );
         // ((pi,five_pi_quarter),({p=0;q=1}, {p=0;q=1}, {p=0;q=1}) );
         // ((five_pi_quarter,three_pi_half),({p=0;q=1}, {p=0;q=1}, {p=0;q=1}) );
         // ((three_pi_half,seven_pi_quarter),({p=0;q=1}, {p=0;q=1}, {p=0;q=1}) );
         // ((seven_pi_quarter,two_pi),({p=0;q=1}, {p=0;q=1}, {p=0;q=1}) ); *)
      ( (zero, pi_half),
        [
          Rational.
            {
              p = Z.of_int 6021947012555463;
              q = Z.of_string "10000000000000000";
            };
          {
            p = Z.of_int 513625166679107;
            q = Z.of_string "1000000000000000";
          };
          {
            p = Z.of_int (-10354634426296383);
            q = Z.of_string "100000000000000000";
          };
          {
            p = Z.of_int (-13732034234358675);
            q = Z.of_string "1000000000000000000";
          };
          {
            p = Z.of_int 13586698380902013;
            q = Z.of_string "10000000000000000000";
          };
          {
            p = Z.of_int (10726309440570181);
            q = Z.of_string "100000000000000000000";
          };
          {
            p = Z.of_int (-7046296793891682);
            q = Z.of_string "1000000000000000000000";
          };
          {
            p = Z.of_int (-3963902510811801);
            q = Z.of_string "10000000000000000000000";
          };
          {
            p = Z.of_int 194995972671759;
            q = Z.of_string "10000000000000000000000";
          };
          {
            p = Z.of_int 8522923894416223;
            q = Z.of_string "10000000000000000000000000";
          };
          {
            p = Z.of_int (-3351717514643582);
            q = Z.of_string "100000000000000000000000000";
          };
          {
            p = Z.of_int (-11987008607938776);
            q = Z.of_string "10000000000000000000000000000";
          };
          {
            p = Z.of_int 3835820550079916;
            q = Z.of_string "100000000000000000000000000000";
          };
        ] );
    ]

let find_chebychev_interval (p : Rational.t) : chebychev_intervals option =
  let rec find ((x, lst) : Rational.t * chebychev_intervals list) :
      chebychev_intervals option =
    match lst with
    | [] -> None
    | ((_, hd1) as hd) :: tl ->
        if Rational.lte x hd1 then Some hd else find (x, tl)
  in
  find (p, chebychev_lookup_intervals)

(* // let find_chebychev_coef(a : Rational.t) : chebychev_coef =
   //     let interval_opt : chebychev_intervals option = find_chebychev_interval(a) in
   //     match interval_opt with
   //     | None -> failwith("given angle is out of bound")
   //     | Some interval -> (match Map.find_opt interval chebychev_lookup_table with
   //         | None -> failwith("chebychev_lookup_intervals does not match chebychev_lookup_table")
   //         | Some coef -> coef
   //     ) *)

let sin ((a, n) : Rational.t * nat) : Rational.t =
  let interval_opt : chebychev_intervals option = find_chebychev_interval a in
  let interval_cheby0, interval_cheby1 =
    match interval_opt with
    | None -> failwith "given angle is out of bound"
    | Some interval -> interval
  in
  let interval_cheby = (interval_cheby0, interval_cheby1) in
  let two = Rational.new' Common.two in
  (* //let u = (x - (a+b)/2.0 )/ (b-a)/2.0 *)
  let u =
    Rational.div
      (Rational.sub a
         (Rational.div (Rational.add interval_cheby0 interval_cheby1) two))
      (Rational.div (Rational.sub interval_cheby1 interval_cheby0) two)
  in
  let coef : chebychev_coef =
    match Map.find_opt interval_cheby chebychev_lookup_table with
    | None ->
        failwith
          "chebychev_lookup_intervals does not match chebychev_lookup_table"
    | Some coef -> coef
  in

  let coef_0 = Option.unopt (List.head_opt coef) in
  let coef_1 =
    Option.unopt (List.head_opt (Option.unopt (List.tail_opt coef)))
  in
  let y0 = Rational.add coef_0 (Rational.mul coef_1 u) in
  let one = Rational.new' Z.one in
  let two = Rational.new' Common.two in
  let t0 : Rational.t = one in
  let t1 : Rational.t = u in
  let coef_from_2 =
    Option.unopt (List.tail_opt (Option.unopt (List.tail_opt coef)))
  in
  let rec compute
      ((i, acc, t_prev, t_prev_prev, n, coef) :
        nat * Rational.t * Rational.t * Rational.t * nat * chebychev_coef) :
      Rational.t =
    if i <= n then
      let t_next_u =
        Rational.sub (Rational.mul (Rational.mul two u) t_prev) t_prev_prev
      in
      let current_coef = Option.unopt (List.head_opt coef) in
      let rest_coef = Option.unopt (List.tail_opt coef) in
      let new'_acc = Rational.add acc (Rational.mul t_next_u current_coef) in
      compute (i + Z.one, new'_acc, t_next_u, t_prev, n, rest_coef)
    else acc
  in
  compute (Common.two, y0, t1, t0, n, coef_from_2)

let rec sinus_symetry ((sign, a, n) : Rational.t * Rational.t * nat) :
    Rational.t =
  (* // sin(-a) = - sin(a) *)
  if Rational.lt a zero then
    sinus_symetry
      ( Rational.mul sign (Rational.new' minus_one),
        Rational.mul a (Rational.new' minus_one),
        n )
  else
    let a_mod_two_pi = Rational.modulo a two_pi in
    (* //[0, pi_half] *)
    if Rational.lte a_mod_two_pi pi_half then
      Rational.mul sign (sin (a_mod_two_pi, n))
      (* //[pi_half, pi] -> sin(Pi/2 + a) = sin(Pi/2 - a) *)
    else if Rational.lte a_mod_two_pi pi then
      let theta = Rational.sub a_mod_two_pi pi_half in
      let half_pi_minus_a = Rational.sub pi_half theta in
      Rational.mul sign (sin (half_pi_minus_a, n))
      (* //[pi, two_pi] -> sin(Pi + a) = - sin(a) *)
    else if Rational.lt pi a_mod_two_pi then
      let minus_pi = Rational.sub a_mod_two_pi pi in
      sinus_symetry (Rational.mul sign (Rational.new' minus_one), minus_pi, n)
    else (failwith "ERROR out of bound angle" : Rational.t)

let sinus ((a, n) : Rational.t * nat) : Rational.t =
  sinus_symetry (Rational.new' Z.one, a, n)

let cosinus ((a, n) : Rational.t * nat) : Rational.t =
  let plus_half_PI = Rational.add a pi_half in
  sinus_symetry (Rational.new' Z.one, plus_half_PI, n)
