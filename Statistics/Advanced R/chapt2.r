library(lobstr)
library(tidyverse)

x <- c(1, 2, 3)
y <- x

obj_addr(x)
obj_addr(y)


a <- 1:10
b <- a
c <- b
d <- 1:10

obj_addr(a)
obj_addr(b)
obj_addr(c)
obj_addr(d)

obj_addr(mean)
obj_addr(base::mean)
obj_addr(get("mean"))
obj_addr(evalq(mean))
obj_addr(match.fun("mean"))
