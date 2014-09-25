b.min <- function(data, size, num) {
  samples <- lapply(1:num, function(i) sample(data, size = size))
  r.stat <- sapply(samples, min)
  std.err <- sqrt(var(r.stat))
  result <- data.frame(std.err = std.err, stats = r.stat)
  result
}

b.max <- function(data, size, num) {
  samples <- lapply(1:num, function(i) sample(data, size = size))
  r.stat <- sapply(samples, max)
  std.err <- sqrt(var(r.stat))
  result <- data.frame(std.err = std.err, stats = r.stat)
  result
}

#b.min(diamonds$carat, 10, 10)
