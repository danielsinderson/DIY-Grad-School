# probability stuff
library(tidyverse)
library(ISLR)
set.seed(1)
Auto[sample(row.names(Auto), 3), ]

#probability stuff actually now
#simulating urn problem
urn <- c("white", "white", "white", "white", "black", "black", "black")
set.seed(1)
sample(urn, 2)

simulation_runs <- 10
simulation_results <- matrix(nrow = simulation_runs, ncol = 2)
for (i in 1:simulation_runs) {
    set.seed(i)
    x <- sample(urn, 2)
    simulation_results[i, ] <- x
    # if (i < 10) print(x)
}
head(simulation_results)
