package math

import math.TestFloat.Float.add
import math.TestFloat.Float.inverse
import math.TestFloat.Float.mul
import math.TestFloat.Float.new
import math.TestFloat.Float.sub
import org.openjdk.jmh.annotations.Benchmark
import org.openjdk.jmh.annotations.Scope
import org.openjdk.jmh.annotations.State
import java.math.BigInteger
import kotlin.test.Test
import kotlin.test.assertEquals

@State(Scope.Benchmark)
open class TestFloat {

    object Float : math.Float

    @Test
    fun testScientific00() {
        val a = inverse(new(6))
        val resolved = Float.resolve(a)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(166))
    }

    @Test
    fun testScientific01() {
        val a = inverse(new(6))
        val b = mul(new(-1))(a)
        val resolved = Float.resolve(b)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(-166))
    }

    @Test
    fun testScientific02() {
        val a = inverse(new(3))
        val b = inverse(new(2))
        val v = add(a)(b)
        val resolved = Float.resolve(v)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(833))
    }

    @Test
    fun testScientific03() {
        val a = inverse(new(3))
        val b = inverse(new(2))
        val v = sub(a)(b)
        val resolved = Float.resolve(v)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(-166))
    }

    @Test
    fun testScientific04() {
        val a = inverse(new(3))
        val b = inverse(new(2))
        val v = mul(a)(b)
        val resolved = Float.resolve(v)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(166))
    }

    @Test
    fun testScientific05() {
        val a = inverse(new(3))
        val b = inverse(new(2))
        val v = Float.div(a)(b)
        val resolved = Float.resolve(v)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(666)) // Hell yeah
    }

    @Test
    fun testScientific06() {
        val a = inverse(new(2))
        val b = inverse(new(3))
        val v = Float.modulo(a)(b)
        val resolved = Float.resolve(v)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(166)) // Hell yeah
    }

    @Benchmark
    fun all() {
        testScientific00()
        testScientific01()
        testScientific02()
        testScientific03()
        testScientific04()
        testScientific05()
        testScientific06()
    }
}