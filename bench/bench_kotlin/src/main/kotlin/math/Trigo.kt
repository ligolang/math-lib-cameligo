package math

typealias chebychevIntervals<t> = Pair<t, t>
typealias chebychevCoef<t> = List<t>
typealias chebychev<t> = Map<chebychevIntervals<t>, chebychevCoef<t>>

interface Trigo<t> : Repr<t> {
    val zero: t
    val pi: t
    val minus_one: t
    val one: t
    val two: t
    val three: t
    val four: t
    val five: t
    val six: t
    val seven: t
    val sqrt2: t
    val sqrt3: t

    val twoPi get() = mul(pi)(two)
    val piHalf get() = div(pi)(two)
    val piQuarter get() = div(pi)(four)
    val threePiHalf get() = mul(piHalf)(three)
    val threePiQuarter get() = mul(piQuarter)(three)
    val fivePiQuarter get() = mul(piQuarter)(five)
    val sevenPiQuarter get() = mul(piQuarter)(seven)
    val piThird get() = div(pi)(three)
    val piSixth get() = div(pi)(six)

    val chebychevLookupIntervals: List<chebychevIntervals<t>> get() = listOf((zero to piHalf))

    val chebychevLookupTable: chebychev<t>

    fun findChebychevInterval(p: t): chebychevIntervals<t>? {
        tailrec fun find(x: t, lst: List<chebychevIntervals<t>>, index: Int): chebychevIntervals<t>? =
            if (index >= lst.size) {
                null
            } else if (lte(x)(lst[index].second)) {
                lst[index]
            } else {
                find(x, lst, index + 1)
            }

        return find(p, chebychevLookupIntervals, 0)
    }

    fun sin(a: t, n: Int): t {
        val intervalOpt = findChebychevInterval(a)
        val intervalCheby = intervalOpt!! // Force the value extraction from the effect
        // u = (a - (c.1+c.2)/2.0 )/ (c.2-c.1)/2.0 where c = intervalCheby
        val u = div(
            sub(a)(div(add(intervalCheby.first)(intervalCheby.second))(two))
        )(
            div(sub(intervalCheby.second)(intervalCheby.first))(two)
        )

        val coef = chebychevLookupTable[intervalCheby]!! // Force the value extraction from the effect
        val coef0 = coef[0]
        val coef1 = coef[1]

        tailrec fun compute(i: Int, acc: t, t_prev: t, t_prev_prev: t, n: Int, coef: chebychevCoef<t>): t =
            if (i <= n) {
                val t_next_u = sub(mul(mul(two)(u))(t_prev))(t_prev_prev)
                val current_coef = coef[0]
                val rest_coef = coef.subList(1, coef.size)
                val new_acc = add(acc)(mul(t_next_u)(current_coef))
                compute(i + 1, new_acc, t_next_u, t_prev, n, rest_coef)
            } else {
                acc
            }

        val y0 = add(coef0)(mul(coef1)(u))
        val coefFrom2 = coef.subList(2, coef.size)

        return compute(2, y0, u, one, n, coefFrom2)
    }

    fun sinus_symmetry(sign: t, a: t, n: Int): t =
        if (lt(a)(zero)) {
            sinus_symmetry(mul(sign)(minus_one), mul(a)(minus_one), n)
        } else {
            val aModTwoPi = modulo(a)(twoPi)

            if (lte(aModTwoPi)(piHalf)) {
                mul(sign)(sin(aModTwoPi, n))
            } else if (lte(aModTwoPi)(pi)) {
                val theta = sub(aModTwoPi)(piHalf)
                val halfPiMinus = sub(piHalf)(theta)
                mul(sign)(sin(halfPiMinus, n))
            } else if (lt(pi)(aModTwoPi)) {
                val minus_pi = sub(aModTwoPi)(pi)
                sinus_symmetry(mul(sign)(minus_one), minus_pi, n)
            } else {
                throw Exception("Out of bound angle")
            }
        }

    fun sinus(a: t, n: Int): t = sinus_symmetry(one, a, n)
    fun cosinus(a: t, n: Int): t = sinus_symmetry(one, add(a)(piHalf), n)
}