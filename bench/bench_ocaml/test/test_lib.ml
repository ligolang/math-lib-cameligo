module Core = Math_lib_tests.Test_core
module Float = Math_lib_tests.Test_float
module Rational = Math_lib_tests.Test_rational
module Trigo_float = Math_lib_tests.Test_trigo_float
module Trigo_rational = Math_lib_tests.Test_trigo_rational

let log = true
let _ = Core.all ~log ()
let _ = Float.all ~log ()
let _ = Rational.all ~log ()
let _ = Trigo_float.all ~log ()
let _ = Trigo_rational.all ~log ()
