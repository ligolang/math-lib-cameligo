package math.lib

import java.math.BigInteger
import java.math.BigInteger.ONE
import java.math.BigInteger.TWO
import java.math.BigInteger.ZERO

object Math {

    val EIGHTEEN: BigInteger = BigInteger.valueOf(18)

    fun iSqrt(y: BigInteger): BigInteger =
        if (y > BigInteger.valueOf(3)) {
            tailrec fun iter(x: BigInteger, y: BigInteger, z: BigInteger): BigInteger =
                if (x < z)
                    iter(((y / x) + x) / TWO, y, x)
                else
                    z

            iter((y / TWO) + ONE, y, y)
        } else if (y != ZERO) {
            ONE
        } else {
            ZERO
        }

    @Suppress("NAME_SHADOWING")
    fun power(x: BigInteger, y: BigInteger): BigInteger {
        tailrec fun multiply(a: BigInteger, b: BigInteger, result: BigInteger): BigInteger =
            if (b == ZERO) {
                result
            } else {
                val result = if (b.and(ONE) == ONE) result * a else result
                val b = b.shr(1);
                val a = a * a
                multiply(a, b, result)
            }

        return multiply(x, y, ONE)
    }

    fun factorial(n: BigInteger): BigInteger {
        tailrec fun factorial(acc: BigInteger, i: BigInteger): BigInteger =
            if (i < TWO) {
                acc
            } else {
                factorial(acc * i, i - ONE)
            }

        return factorial(ONE, n)
    }

    fun min(a: BigInteger, b: BigInteger): BigInteger =
        if (a < b) {
            a
        } else {
            b
        }

    fun max(a: BigInteger, b: BigInteger): BigInteger =
        if (a < b) {
            b
        } else {
            a
        }

    fun log10(x: BigInteger): BigInteger {
        tailrec fun checkPower(x: BigInteger, i: BigInteger): BigInteger =
            if (x % power(BigInteger.TEN, i) > ZERO) {
                (i - ONE).abs()
            } else {
                checkPower(x, i + ONE)
            }

        return checkPower(x, ONE)
    }
}