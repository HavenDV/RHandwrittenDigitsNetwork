## =========== Used libraries =========== 
library(R.matlab)
        
## =========== Includes =========== 
source("functions.R")

## =========== Setup the parameters =========== 
input_layer_size <- 400;  # 20x20 Input Images of Digits
hidden_layer_size <- 25;  # 25 hidden units
num_labels <- 10;         # 10 labels, from 1 to 10   
# (note that we have mapped "0" to label 10)

## =========== Part 1: Loading and Visualizing Data =============
cat("Loading and Visualizing Data ...\n")

data <- readMat("data.mat")
X <- data[["X"]]
y <- data[["y"]]
m <- dim(X)[1]

# Randomly select 100 data points to display and display it
sel <- X[sample(nrow(X),size = 100),]
displayData(sel);

## ================ Part 2: Loading Pameters ================
cat('Loading Saved Neural Network Parameters ...\n')

# Load the weights into variables Theta1 and Theta2
weights <- readMat('weights.mat')
Theta1 <- weights[["Theta1"]]
Theta2 <- weights[["Theta2"]]

## ================= Part 3: Implement Predict =================
pred <- predict(Theta1, Theta2, X);

compared <- apply(pred,2,`==`,y)
cat(paste('Training Set Accuracy: \n', mean(as.double(compared)) * 100));