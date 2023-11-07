package math


import math.Rational.T
import math.TrigoRational.abs
import math.TrigoRational.add
import math.TrigoRational.cosinus
import math.TrigoRational.div
import math.TrigoRational.inverse
import math.TrigoRational.lt
import math.TrigoRational.minus_one
import math.TrigoRational.mul
import math.TrigoRational.new
import math.TrigoRational.one
import math.TrigoRational.pi
import math.TrigoRational.piHalf
import math.TrigoRational.piQuarter
import math.TrigoRational.piSixth
import math.TrigoRational.piThird
import math.TrigoRational.sinus
import math.TrigoRational.sqrt2
import math.TrigoRational.sqrt3
import math.TrigoRational.sub
import math.TrigoRational.threePiHalf
import math.TrigoRational.two
import math.TrigoRational.twoPi
import math.TrigoRational.zero
import math.lib.Math.power
import org.openjdk.jmh.annotations.Benchmark
import org.openjdk.jmh.annotations.Scope
import org.openjdk.jmh.annotations.State
import java.math.BigInteger.valueOf
import kotlin.test.Test
import kotlin.test.assertEquals

@State(Scope.Benchmark)
open class TestTrigoRational {

    private val epsilon = inverse(new(power(valueOf(10), valueOf(12))))
    private val precision = 11

    private fun testSinus(angle: T, expected: T): Boolean {
        val diff = abs(sub(sinus(angle, precision))(expected))
        return lt(diff)(epsilon)
    }

    @Test
    fun testTrigoSinus() {
        assertEquals(testSinus(zero, zero), true)
        assertEquals(testSinus(piHalf, one), true)
        assertEquals(testSinus(pi, zero), true)
        assertEquals(testSinus(threePiHalf, minus_one), true)
        assertEquals(testSinus(twoPi, zero), true)
        assertEquals(testSinus(piQuarter, div(sqrt2)(two)), true)
        assertEquals(testSinus(piSixth, inverse(two)), true)
        assertEquals(testSinus(piThird, div(sqrt3)(two)), true)
        assertEquals(testSinus(sub(zero)(piHalf), minus_one), true)
        assertEquals(testSinus(sub(piHalf)(twoPi), one), true)
    }

    private fun testCosinus(angle: T, expected: T): Boolean {
        val diff = abs(sub(cosinus(angle, precision))(expected))
        return lt(diff)(epsilon)
    }

    @Test
    fun testTrigoCosinus() {
        assertEquals(testCosinus(zero, one), true)
        assertEquals(testCosinus(piHalf, zero), true)
        assertEquals(testCosinus(pi, minus_one), true)
        assertEquals(testCosinus(threePiHalf, zero), true)
        assertEquals(testCosinus(twoPi, one), true)
        assertEquals(testCosinus(piQuarter, div(sqrt2)(two)), true)
        assertEquals(testCosinus(piSixth, div(sqrt3)(two)), true)
        assertEquals(testCosinus(piThird, inverse(two)), true)
        assertEquals(testCosinus(sub(zero)(piHalf), zero), true)
        assertEquals(testCosinus(sub(piHalf)(twoPi), zero), true)
    }

    @Test
    fun testTrigo() {
        val precision = 11
        val angle = piHalf
        val cos = cosinus(angle, precision)
        val sin = sinus(angle, precision)
        val res = add(mul(cos)(cos))(mul(sin)(sin))
        val diff = abs(sub(res)(one))
        assertEquals(lt(diff)(epsilon), true);
    }

    @Benchmark
    fun all() {
        testTrigoSinus()
        testTrigoCosinus()
        testTrigo()
    }
}