displayData <- function(sel) {
  full_img <- matrix(nrow = 0, ncol = 200)
  for (i in 1:10) {
    row <- matrix(nrow = 20, ncol = 0)
    for (j in 1:10) {
      img <- matrix(sel[10 * (i - 1) + j,], nrow = 20, ncol = 20)
      row <- cbind(row, img)
    }
    full_img <- rbind(full_img, row)
  }
  rotate <- function(x) t(apply(x, 2, rev))
  full_img <- rotate(full_img)
  image(full_img, axes = FALSE, col = grey(seq(0, 1, length = 256))) 
}

pause <- function() {
  readline(prompt="Program paused. Press enter to continue.\n")
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