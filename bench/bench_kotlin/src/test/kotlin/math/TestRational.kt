package math

import org.openjdk.jmh.annotations.Benchmark
import org.openjdk.jmh.annotations.Scope
import org.openjdk.jmh.annotations.State
import java.math.BigInteger
import kotlin.test.Test
import kotlin.test.assertEquals

@State(Scope.Benchmark)
open class TestRational {

    object Rational : math.Rational

    @Test
    fun testScientific00() {
        val a = Rational.inverse(Rational.new(6))
        val resolved = Rational.resolve(a)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(166))
    }

    @Test
    fun testScientific01() {
        val a = Rational.inverse(Rational.new(6))
        val b = Rational.mul(Rational.new(-1))(a)
        val resolved = Rational.resolve(b)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(-166))
    }

    @Test
    fun testScientific02() {
        val a = Rational.inverse(Rational.new(3))
        val b = Rational.inverse(Rational.new(2))
        val v = Rational.add(a)(b)
        val resolved = Rational.resolve(v)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(833))
    }

    @Test
    fun testScientific03() {
        val a = Rational.inverse(Rational.new(3))
        val b = Rational.inverse(Rational.new(2))
        val v = Rational.sub(a)(b)
        val resolved = Rational.resolve(v)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(-166))
    }

    @Test
    fun testScientific04() {
        val a = Rational.inverse(Rational.new(3))
        val b = Rational.inverse(Rational.new(2))
        val v = Rational.mul(a)(b)
        val resolved = Rational.resolve(v)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(166))
    }

    @Test
    fun testScientific05() {
        val a = Rational.inverse(Rational.new(3))
        val b = Rational.inverse(Rational.new(2))
        val v = Rational.div(a)(b)
        val resolved = Rational.resolve(v)(BigInteger.valueOf(3))
        assertEquals(resolved, BigInteger.valueOf(666)) // Hell yeah
    }

    @Test
    fun testScientific06() {
        val a = Rational.inverse(Rational.new(2))
        val b = Rational.inverse(Rational.new(3))
        val v = Rational.modulo(a)(b)
        val resolved = Rational.resolve(v)(BigInteger.valueOf(3))
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