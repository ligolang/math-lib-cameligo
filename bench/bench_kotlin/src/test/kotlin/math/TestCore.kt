package math

import math.lib.Math
import java.math.BigInteger
import kotlin.test.Test
import kotlin.test.assertEquals

internal class TestCore {

    @Test
    fun testISqrt() {
        assertEquals(Math.iSqrt(BigInteger.valueOf(4)), BigInteger.TWO)
        assertEquals(Math.iSqrt(BigInteger.valueOf(8)), BigInteger.TWO)
        assertEquals(Math.iSqrt(BigInteger.valueOf(9)), BigInteger.valueOf(3))
        assertEquals(Math.iSqrt(BigInteger.valueOf(15)), BigInteger.valueOf(3))
        assertEquals(Math.iSqrt(BigInteger.valueOf(16)), BigInteger.valueOf(4))
    }

    @Test
    fun testFactorial() {
        assertEquals(Math.factorial(BigInteger.ZERO), BigInteger.ONE)
        assertEquals(Math.factorial(BigInteger.ONE), BigInteger.ONE)
        assertEquals(Math.factorial(BigInteger.TWO), BigInteger.TWO)
        assertEquals(Math.factorial(BigInteger.valueOf(3)), BigInteger.valueOf(6))
        assertEquals(Math.factorial(BigInteger.valueOf(4)), BigInteger.valueOf(24))
        assertEquals(Math.factorial(BigInteger.valueOf(5)), BigInteger.valueOf(120))
        assertEquals(Math.factorial(BigInteger.valueOf(6)), BigInteger.valueOf(720))
    }
}