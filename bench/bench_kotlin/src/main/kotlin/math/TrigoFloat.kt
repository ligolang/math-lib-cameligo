package math

import math.Float.T
import java.math.BigInteger

object TrigoFloat : Float, Trigo<T> {

    override val zero: T get() = new(0)
    override val pi: T
        get() = T(
            BigInteger("31415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679"),
            BigInteger("-100")
        )
    override val minus_one: T get() = new(-1)
    override val one: T get() = new(1)
    override val two: T get() = new(2)
    override val three: T get() = new(3)
    override val four: T get() = new(4)
    override val five: T get() = new(5)
    override val six: T get() = new(6)
    override val seven: T get() = new(7)
    override val sqrt2: T get() = T(BigInteger("1414213562373095048801688724209"), BigInteger("-30"))
    override val sqrt3: T get() = T(BigInteger("17320508075688772935"), BigInteger("-19"))

    override val chebychevLookupTable: chebychev<T>
        get() = mapOf(
            (zero to piHalf) to
                    listOf(
                        T(BigInteger("6021947012555463"), BigInteger("-16")),
                        T(BigInteger("513625166679107"), BigInteger("-15")),
                        T(BigInteger("-10354634426296383"), BigInteger("-17")),
                        T(BigInteger("-13732034234358675"), BigInteger("-18")),
                        T(BigInteger("13586698380902013"), BigInteger("-19")),
                        T(BigInteger("10726309440570181"), BigInteger("-20")),
                        T(BigInteger("-7046296793891682"), BigInteger("-21")),
                        T(BigInteger("-3963902510811801"), BigInteger("-22")),
                        T(BigInteger("194995972671759"), BigInteger("-22")),
                        T(BigInteger("8522923894416223"), BigInteger("-25")),
                        T(BigInteger("-3351717514643582"), BigInteger("-26")),
                        T(BigInteger("-11987008607938776"), BigInteger("-28")),
                        T(BigInteger("3835820550079916"), BigInteger("-29"))
                    )
        )
}