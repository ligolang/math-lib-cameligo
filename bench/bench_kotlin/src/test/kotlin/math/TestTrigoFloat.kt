package math

import math.Float.T
import math.TrigoFloat.abs
import math.TrigoFloat.add
import math.TrigoFloat.cosinus
import math.TrigoFloat.div
import math.TrigoFloat.inverse
import math.TrigoFloat.lt
import math.TrigoFloat.minus_one
import math.TrigoFloat.mul
import math.TrigoFloat.new
import math.TrigoFloat.one
import math.TrigoFloat.pi
import math.TrigoFloat.piHalf
import math.TrigoFloat.piQuarter
import math.TrigoFloat.piSixth
import math.TrigoFloat.piThird
import math.TrigoFloat.sinus
import math.TrigoFloat.sqrt2
import math.TrigoFloat.sqrt3
import math.TrigoFloat.sub
import math.TrigoFloat.threePiHalf
import math.TrigoFloat.two
import math.TrigoFloat.twoPi
import math.TrigoFloat.zero
import org.openjdk.jmh.annotations.Benchmark
import org.openjdk.jmh.annotations.Scope
import org.openjdk.jmh.annotations.State
import kotlin.test.Test
import kotlin.test.assertEquals

@State(Scope.Benchmark)
open class TestTrigoFloat {

    private val epsilon = inverse(new(1, 12))
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