# math-lib-cameligo

This repository contains a math library for [LIGO](https://ligolang.org/). It is
provided in two flavors (`Float` & `Rational`), and is packaged as 
follows 

1. [math-lib-core](./core/README.md): This package contains basic math functions
   like `isqrt`, `power`, `factorial`, `min`, `max`, `log_10`.
2. [math-lib-float](./float/README.md): This package provides floating point arithmetic
   for LIGO (which is not supported natively by Michelson). It also provides some
   useful trigonometric functions.
3. [math-lib-rational](./rational/README.md): This package provides rational arithmetic
   for LIGO (which is not supported natively by Michelson). It also provides some
   useful trigonometric functions.
4. [math-lib](./README.md): It provides the features from the above libraries in one
   package.