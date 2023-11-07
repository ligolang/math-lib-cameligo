package math

import java.math.BigInteger

interface Repr<t> {

    fun abs(a: t): t

    fun inverse(a: t): t

    fun add(a: t): (t) -> t

    fun sub(a: t): (t) -> t

    fun lt(a: t): (t) -> Boolean

    fun lte(a: t): (t) -> Boolean

    fun gt(a: t): (t) -> Boolean = { b -> lt(b)(a) }

    fun gte(a: t): (t) -> Boolean = { b -> lte(b)(a) }

    fun mul(a: t): (t) -> t

    fun div(a: t): (t) -> t

    fun modulo(a: t): (t) -> t = { b ->
        tailrec fun compute(a: t, b: t): t =
            if (lt(a)(b)) {
                a
            } else {
                compute(sub(a)(b), b)
            }

        compute(a, b)
    }

    fun resolve(a: t): (BigInteger) -> BigInteger

}