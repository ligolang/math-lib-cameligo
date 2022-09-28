# math-lib-cameligo

This repository contains a math library for [LIGO](https://ligolang.org/), it is
provided in two flavors (`Float` & `Rational`), and library is packaged as 
follows 

1. [math-lib-core](math-lib-core): This package contains basic math functions
   like `isqrt`, `power`, `factorial`, `min`, `max`, `log_10`
2. [math-lib-float](math-lib-float): This package provides basic operations &
   trigonometric functions on an internal representation of floating point numbers 
3. [math-lib-rational](math-lib-rational): This package provides basic operations &
   trigonometric functions on an internal representation of rational numbers
4. [math-lib](math-lib): This is the complete package, it provides the features
   of 3 libraries `math-lib-core`, `math-lib-float` & `math-lib-rational`