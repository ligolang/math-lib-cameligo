module Core = Math_lib_tests.Test_core
module Float = Math_lib_tests.Test_float
module Rational = Math_lib_tests.Test_rational
module Trigo_float = Math_lib_tests.Test_trigo_float
module Trigo_rational = Math_lib_tests.Test_trigo_rational

let _ = Core._test_isqrt ()
let _ = Core._test_factorial ()

let _ = Float._test_scientific ()

let _ = Rational._test_rational ()

let _ = Trigo_float._test_trigo_sinus ()
let _ = Trigo_float._test_trigo_cosinus ()
let _ = Trigo_float._test_trigo ()

let _ = Trigo_rational._test_trigo_sinus ()
let _ = Trigo_rational._test_trigo_cosinus ()
let _ = Trigo_rational._test_trigo_cosinus ()
