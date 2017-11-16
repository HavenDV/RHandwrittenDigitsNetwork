rotate <- function(x) t(apply(x, 2, rev))

displayDataArray <- function(sel) {
  n <- sqrt(nrow(sel))
  width <- sqrt(nrow(matrix(sel[1,])))
  height <- width
  full_img <- matrix(nrow = 0, ncol = width * n)
  for (i in 1:n) {
    row <- matrix(nrow = height, ncol = 0)
    for (j in 1:n) {
      img <- matrix(sel[n * (i - 1) + j,], nrow = height, ncol = width)
      row <- cbind(row, img)
    }
    full_img <- rbind(full_img, row)
  }
  full_img <- rotate(full_img)
  image(full_img, axes = FALSE, col = grey(seq(0, 1, length = 256))) 
}

displayData <- function(sel) {
  width <- sqrt(ncol(sel))
  mat <- matrix(sel, nrow = width, ncol = width)
  mat <- rotate(mat)
  image(mat, axes = FALSE, col = grey(seq(0, 1, length = 256))) 
}

pause <- function() {
  ANSWER <- readline(prompt="Program paused. Press enter to continue.\n")
  if (substr(ANSWER, 1, 1) == "q")
    stop("Interrupted")
}

sigmoid <- function(z) {
  return(1.0 / (1.0 + exp(-z)))
}

predict <- function(Theta1, Theta2, X) {
  m <- nrow(X)
  extendedX <- cbind(matrix(1, m, 1), X)
  z2 <- extendedX %*% t(Theta1)
  a2 <- sigmoid(z2)
  extendeda2 <- cbind(matrix(1, m, 1), a2)
  z3 <- extendeda2 %*% t(Theta2)
  h <- sigmoid(z3)
  
  return(matrix(apply(h, 1, which.max)))
}