

b.stat <- function(data, size, num, type) {
  b.min <- function(data, size, num) {
    cat("params\n", "str of data\n", str(data),
        "\n size \n", size, num)
    samples <- lapply(1:num, function(i) sample(data, size = size))
    cat("samples\n", str(samples))
    r.stat <- sapply(samples, min)
    std.err <- sqrt(var(r.stat))
    cat("rstat", str(r.stat))
    test <- data.frame(std.err = std.err, stats = r.stat)
    cat("test", str(test))
    test
  }
  
  b.max <- function(data, size, num) {
    samples <- lapply(1:num, function(i) sample(data, size = size))
    r.stat <- sapply(samples, max)
    std.err <- sqrt(var(r.stat))
    data.frame(std.err = std.err, stats = r.stat)
  }
  cat("str of data\n", str(data))
  min <- b.min(data, size, num)
  max <- b.max(data, size, num)
  test <- ifelse(type == "1",
         min, max)
  test
}

# last.min <- function(data)
# 
# test <- b.min(diamonds$carat, 10, 100)
# test2 <- test[,ncol(test)-1]
