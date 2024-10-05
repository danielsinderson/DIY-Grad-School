# programming for the final in my MTH 361 class
log(19/10)
e
exp(-3)


qnorm(0.95, 1700, 190)
qchisq(0.95, 3)
1 - pchisq(4.2, 3)

curve(dbeta(x, 2, 5))

qbeta(0.9, 2, 5)
1 - pbeta(0.5, 2, 5)


qnorm(0.99, 0, 1)
qt(0.99, 10)
qchisq(0.99, 4)
qf(0.99, 3, 4)

1 - pnorm(70, 64, 10)
1 - pchisq(70, 4, ncp = 64)



s <- matrix(c(9, 3, 3, 25), 2, 2)
s_inv <- s^(-1)
mu <- c(6, 10)

s1 <- sqrt(s[1, 1])
s2 <- sqrt(s[2, 2])
s_c <- s[1, 2]
rho <- s_c / (s1 * s2)

c(s1, s2, s_c, rho)

x1 <- 7
m2 <- mu[2] + rho * s2 * (x1 - mu[1]) / s1
d2 <- (1 - rho)^2 * s2^2
c(rho, m2, d2)

qnorm(0.9, m2, sqrt(d2))
pnorm(12, m2, sqrt(d2))


qchisq(c(0.05, 0.5, 0.95), 2)

pchisq(0.5, 4)
