def over_or_under(num1, num2):
    if num1 < num2:
        return -1
    elif num1 == num2:
        return 0
    else:
        return 1


def make_adder(x):
    def adder(y):
        return x + y
    return adder


def composed(f, g):
    def helper(x):
        return f(g(x))
    return helper


def repeat(f, n):
    assert n > 0
    def helper(x):
        if n == 1:
            return f(x)
        else:
            return f(repeat(f, n - 1)(x))
    return helper


# Greatest Common Divisor
def gcd(m, n):
    assert m > 0 and n > 0
    # 辗转相除法 m = 1 * n + m - n
    while m != n:
        m, n = min(m, n), abs(m - n)
    return m