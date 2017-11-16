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