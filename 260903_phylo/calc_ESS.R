library(coda)

args <- commandArgs(trailingOnly = TRUE)

read_beast_log <- function(file) {
  x <- read.table(file, header = TRUE, comment.char = "#", check.names = FALSE)
  x <- x[, !names(x) %in% c("Sample", "state"), drop = FALSE]
  as.mcmc(x)
}

m1 <- read_beast_log(args[1])
m2 <- read_beast_log(args[2])

cat("\nESS run 1:\n")
print(round(effectiveSize(m1), 1))

cat("\nESS run 2:\n")
print(round(effectiveSize(m2), 1))