package math

import math.lib.Math
import java.math.BigInteger

interface Rational : Repr<Rational.T> {

    data class T(val p: BigInteger, val q: BigInteger) {
        override fun toString(): String = "$p/$q"

    }
    
    fun new(p: Long): T = T(BigInteger.valueOf(p), BigInteger.ONE)

    fun new(p: Long, q: Long): T = T(BigInteger.valueOf(p), BigInteger.valueOf(q))

    fun new(p: BigInteger): T = T(p, BigInteger.ONE)

    override fun abs(a: T): T = T(a.p.abs(), a.q.abs())

    override fun inverse(a: T): T = T(a.q, a.p)

    override fun add(a: T): (T) -> T = { b ->
        T(a.p * b.q + a.q * b.p, a.q * b.q)
    }

    override fun sub(a: T): (T) -> T = { b ->
        T(a.p * b.q - a.q * b.p, a.q * b.q)
    }

    override fun lt(a: T): (T) -> Boolean = { b ->
        a.p * b.q < a.q * b.p
    }

    override fun lte(a: T): (T) -> Boolean = { b ->
        a.p * b.q <= a.q * b.p
    }

    override fun mul(a: T): (T) -> T = { b ->
        T(a.p * b.p, a.q * b.q)
    }

    override fun div(a: T): (T) -> T = { b ->
        T(a.p * b.q, a.q * b.p)
    }

    override fun resolve(a: T): (BigInteger) -> BigInteger = { prec ->
        val input = if (a.p > BigInteger.ZERO) {
            T(a.p * -BigInteger.ONE, a.q * -BigInteger.ONE)
        } else {
            a
        }
        input.p * Math.power(BigInteger.TEN, prec) / input.q
    }

}