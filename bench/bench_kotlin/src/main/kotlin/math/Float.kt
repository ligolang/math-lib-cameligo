package math

import math.lib.Math
import math.lib.Math.EIGHTEEN
import java.math.BigInteger
import java.math.BigInteger.ONE
import java.math.BigInteger.TEN
import java.math.BigInteger.ZERO

interface Float : Repr<Float.T> {

    data class T(val value: BigInteger, val pow: BigInteger) {
        override fun toString(): String = "$value*10^$pow"
    }


    fun new(v: Long): T = T(BigInteger.valueOf(v), ZERO)
    fun new(v: Long, p: Long): T = T(BigInteger.valueOf(v), BigInteger.valueOf(p))

    override fun abs(a: T): T = T(a.value.abs(), a.pow)

    override fun inverse(a: T): T =
        T(Math.power(TEN, EIGHTEEN) / a.value, (a.pow * -ONE) - EIGHTEEN)

    override fun add(a: T): (T) -> T = { b ->
        if (a.pow < b.pow) {
            T(b.value * Math.power(TEN, (b.pow - a.pow).abs()) + a.value, a.pow)
        } else {
            T(a.value * Math.power(TEN, (a.pow - b.pow).abs()) + b.value, b.pow)
        }
    }

    override fun sub(a: T): (T) -> T = { b ->
        if (a.pow < b.pow) {
            T(a.value - b.value * Math.power(TEN, (b.pow - a.pow).abs()), a.pow)
        } else {
            T(a.value * Math.power(TEN, (a.pow - b.pow).abs()) - b.value, b.pow)
        }
    }

    override fun lt(a: T): (T) -> Boolean = { b ->
        if (a.value < ZERO && b.value > ZERO) {
            true
        } else if (a.value > ZERO && b.value < ZERO) {
            false
        } else {
            sub(a)(b).value < ZERO
        }
    }

    override fun lte(a: T): (T) -> Boolean = { b ->
        if (a.value < ZERO && b.value > ZERO) {
            true
        } else if (a.value > ZERO && b.value < ZERO) {
            false
        } else {
            sub(a)(b).value <= ZERO
        }
    }

    override fun mul(a: T): (T) -> T = { b ->
        T(a.value * b.value, a.pow + b.pow)
    }

    override fun div(a: T): (T) -> T = { b ->
        T(a.value * Math.power(TEN, EIGHTEEN) / b.value, a.pow - b.pow - EIGHTEEN)
    }


    override fun resolve(a: T): (BigInteger) -> BigInteger = { prec ->
        fun resolve_positive(a: T, prec: BigInteger): BigInteger =
            if (a.pow > ZERO) {
                a.value * Math.power(TEN, a.pow.abs()) * Math.power(TEN, prec)
            } else {
                a.value * Math.power(TEN, prec) / Math.power(TEN, (-ONE * a.pow).abs())
            }

        if (a.value < ZERO) {
            -ONE * resolve_positive(T(a.value.abs(), a.pow), prec)
        } else {
            resolve_positive(a, prec)
        }
    }

}