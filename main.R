library(utils)
library(R.matlab)

## Setup the parameters you will use for this exercise
input_layer_size <- 400;  # 20x20 Input Images of Digits
hidden_layer_size <- 25;   # 25 hidden units
num_labels <- 10;          # 10 labels, from 1 to 10   
# (note that we have mapped "0" to label 10)

## =========== Part 1: Loading and Visualizing Data =============
# We start the exercise by first loading and visualizing the dataset. 
# You will be working with a dataset that contains handwritten digits.
# 

# Load Training Data
cat("Loading and Visualizing Data ...\n")

data <- readMat("data.mat")
X <- data[["X"]]
y <- data[["y"]]
m <- dim(X)[1]

# Randomly select 100 data points to display
sel <- X[sample(nrow(X),size = 100),]

# displayData(X(sel, :));

readline(prompt="Program paused. Press enter to continue.\n")

