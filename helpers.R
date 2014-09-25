df.stats <- function(data, size, num) {
  # For i to num, sample data at given size
  # Returns 'num' lists of size 'size'
  samples <- lapply(1:num, function(i) sample(data, size = size))
  
  # Fill stat vectors with the statistic for each list
  stat.min <- sapply(samples, min)
  stat.max <- sapply(samples, max)
  stat.mean <- sapply(samples, mean)
  stat.median <- sapply(samples, median)
  
  result <- data.frame(stat.min, stat.max, stat.mean, stat.median)
  result
}