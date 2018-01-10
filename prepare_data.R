library(keras)
library(ggplot2)

image_size <- 400

data <- R.matlab::readMat('data/data.mat')
X <- data[['X']]
y <- data[['y']]
n <- nrow(X)

weights <- R.matlab::readMat('data/weights.mat')
Theta1 <- weights[['Theta1']]
Theta2 <- weights[['Theta2']]

set_layer_weights <- function(model, index, theta) {
  current_weights <- model %>% get_layer(index = index) %>% get_weights()
  current_weights[[1]] = t(theta[,2:ncol(theta)])
  current_weights[[2]][] = c(theta[,1])[]
  model %>% get_layer(index = index) %>% set_weights(current_weights)
}

model <- keras_model_sequential() 
model %>% 
  layer_dense(units = 25, activation = "sigmoid", input_shape = c(image_size)) %>%
  layer_dense(units = 10, activation = "sigmoid")

model %>% set_layer_weights(1, Theta1)
model %>% set_layer_weights(2, Theta2)

summary(model)

## Compile
model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_adamax(),
  metrics = c("accuracy")
)
# 
# callbacks_list <- list(
#   callback_tensorboard("logs_r"),
#   callback_early_stopping(monitor = "val_python_function",
#                           min_delta = 1e-4,
#                           patience = 8,
#                           verbose = 1,
#                           mode = "max"),
#   #callback_reduce_lr_on_plateau(monitor = "val_python_function",
#   #                              factor = 0.1,
#   #                              patience = 4,
#   #                              verbose = 1,
#   #                              epsilon = 1e-4,
#   #                             mode = "max"),
#   callback_model_checkpoint(filepath = "weights_r/unet128_{epoch:02d}.h5",
#                             monitor = "val_python_function",
#                             save_best_only = TRUE,
#                             save_weights_only = TRUE,
#                             mode = "max" )
# )
# 
# ## Training and Evaluation
# history <- model %>% fit(
#   x_train,
#   y_train,
#   epochs = 10,
#   batch_size = 1024,
#   validation_data = list(x_test, y_test),
#   shuffle = TRUE,
#   callbacks = callbacks_list,
#   verbose = 2
# )
# 
# plot(history)

## Evaluate
evaluated <- model %>% evaluate(X, to_categorical(y - 1, 10),verbose = 0)
cat(paste("Accuracy: ", evaluated$acc))

model %>% save_model_hdf5("data/model.h5")
#model %>% model_to_json()
model %>% save_model_weights_hdf5("data/weights.h5")

model <- load_model_hdf5("data/model.h5")
model %>% load_model_weights_hdf5("data/weights.h5")
evaluated <- model %>% evaluate(X, to_categorical(y - 1, 10),verbose = 0)
cat(paste("Accuracy: ", evaluated$acc))
