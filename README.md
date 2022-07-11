# math-lib-cameligo

This repository is meant to provide support of floating-point numbers and extra features related to the native type `Bytes`.

This library introduces a `bytes_to_nat` function that allows to convert bytes to nat. 

This library introduces a `is_implicit_account` function that allows to discriminate KT1 addersses and tz1 addresses. This function is available on the native type `address` and also on native type `bytes` (usefull when an `address` value is packed into bytes, with the `Byte.pack` function).

This library introduces 2 representations of floating-point numbers:
- rationnal: where a number is represented by a couple (p, q) where n = p / q. All operations are applied in order to keep the number as a product and division of rationals.  
- float: where a number is represented by a couple (a,b) where n = a * 10^b. The scientifc notation considers that the `a` is defined as a float betwen -10 and 10) and `b` is a `nat`. Since there is no native float type, the `a` is a `nat` and can be greater than 10. All operations are applied in order to keep the number as a couple (a,b) where n = a * 10^b.

Basde on floating-point representation, this library introduces an implementation of trigonometric functions (cosinus, sinus). The implementation of sinus is based on Chebychev polynoms interpolation.

### Tests

A makefile is provided to launch tests.
```
make test
```

