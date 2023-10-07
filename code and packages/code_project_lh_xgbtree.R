###############################################################################
##                          Data Preprocessing                               ##                         
###############################################################################
# Loading the datasets
cars_train <- read_excel("cars_train.xlsx")
cars_test <- read_excel("cars_test.xlsx")

# Saving the IDs
IDs <- cars_test$id

# Removing the id column from the training and test sets
cars_train <- cars_train[, -which(names(cars_train) == "Column1")]
cars_test <- cars_test[, -which(names(cars_test) == "id")]


###############################################################################
##                   Post-analysis Data Processing                           ##                          
###############################################################################
# Removing the "num_fotos" column from the training and test sets
cars_train <- cars_train[, -which(names(cars_train) == "num_fotos")]
cars_test <- cars_test[, -which(names(cars_test) == "num_fotos")]

# Removing the columns "veiculo_alienado" and "elegivel_revisao" from the training and test sets
cars_train <- cars_train[, !(names(cars_train) %in% c("veiculo_alienado", "elegivel_revisao"))]
cars_test <- cars_test[, !(names(cars_test) %in% c("veiculo_alienado", "elegivel_revisao"))]

# Replacing missing values with "nao" in the training and test sets
cars_train[is.na(cars_train)] <- "nao"
cars_test[is.na(cars_test)] <- "nao"

# Creating objects containing quantitative and qualitative variables
variaveis_quantitativas <- c("ano_de_fabricacao", "ano_modelo", "hodometro", "num_portas", "preco")
variaveis_qualitativas <- setdiff(names(cars_train), variaveis_quantitativas)

# Applying dummy coding to the "cars_train" and "cars_test" sets (One-Hot Coding)
cars_train <- dummy_columns(.data = cars_train,
                            select_columns = variaveis_qualitativas,
                            remove_selected_columns = TRUE,
                            remove_most_frequent_dummy = TRUE) %>%
  rename_with(.cols = contains(variaveis_qualitativas), .fn = ~ paste0("dummy_", .))

cars_test <- dummy_columns(.data = cars_test,
                           select_columns = variaveis_qualitativas,
                           remove_selected_columns = TRUE,
                           remove_most_frequent_dummy = TRUE) %>%
  rename_with(.cols = contains(variaveis_qualitativas), .fn = ~ paste0("dummy_", .))

# Correcting the name of the variable "ano_modelo" that was modified during dummy coding
cars_train <- rename(cars_train, ano_modelo = dummy_ano_modelo)
cars_test <- rename(cars_test, ano_modelo = dummy_ano_modelo)

# Dividing "cars_train" into "train" and "test"
n <- sample(1:2,                                
            size = nrow(cars_train),            # "train" and "test" were
            replace = TRUE,                     # used to test different types of models
            prob=c(0.8, 0.2))                   # and choose a "definitive model" to be 
                                                # trained with the data from "cars_train". The 
treino <- cars_train[n==1,]                     # definitive model could then be used to predict 
teste <- cars_train[n==2,]                      # the prices of the observations from "cars_test"


###############################################################################
##                            Model Training                                 ##                    
###############################################################################
# Defining the "control" parameter
control <- caret::trainControl(
  "cv",                              # cross-validation method
  number = 2,                        # number of cross-validation repetitions
  summaryFunction = defaultSummary,  # default summary function for evaluation
  classProbs = FALSE                 # do not calculate class probabilities
)

# Defining the "search_grid" parameter
search_grid <- expand.grid(
  nrounds = 50,                      # number of iterations
  max_depth = 30,                    # maximum depth of trees
  gamma = 0,                         
  eta = c(0.05, 0.4),                # learning rate
  colsample_bytree = .7,             # fraction of columns sampled per tree
  min_child_weight = 1,              # minimum weight of nodes 
  subsample = .7                     # fraction of obs. to be used in each tree
)
# Creating the model ("XGBoost Tree")
xgbtree_final <- caret::train(
  preco ~ .,                         # price as a function of "everything"
  data = cars_train,
  method = "xgbTree",
  trControl = control,
  tuneGrid = search_grid,
  verbosity = 0
)


###############################################################################
##                            Model Evaluation                               ##                    
###############################################################################
# Creating an evaluation function
avalia <- function(previsto, observado) {
  mse <- mean((previsto - observado)^2)
  rmse <- sqrt(mse)
  mae <- mean(abs(previsto - observado))
  r_squared <- 1 - (sum((observado - previsto)^2) / sum((observado - mean(observado))^2))
  
  cat("MSE:", mse, "\n")
  cat("RMSE:", rmse, "\n")
  cat("MAE:", mae, "\n")
  cat("R-squared:", r_squared, "\n")}

# Using the evaluation function
p_treino <- predict(xgbtree_final, cars_train)    # thanks to the "avalia" function it is possible to evaluate the MSE, RMSE, MAE and R² of the created models in a practical way.
p_teste <- predict(xgbtree_final, teste)          # The xgbtree_final was the model with the best metrics in the "train" dataset, and for this reason it was chosen as the "definitive model".
avalia(p_treino, cars_train$preco)                # practical way. The xgbtree_final was the model with better metrics in the dataset "train", and for this reason it was chosen as the "definitive model".
                                                  # metrics in the dataset "train", and for this reason it was chosen as the "definitive model".
###############################################################################
##                   Predicting prices for "cars_test"                       ##                         
###############################################################################
# Identifying dummy variables present in the training set
dummies <- grep("dummy_", colnames(cars_train), value = TRUE)

# Checking which dummy variables are not present in the test set
dummies_faltantes <- setdiff(dummies, colnames(cars_test))

# Adding missing variables to test set with value 0
for (variable in dummies_faltantes) {
  cars_test[[variable]] <- 0
}

# Making predictions on test data
previsoes <- predict(xgbtree_final, cars_test)
# Creating a table with "id" and "previsoes"
tabela_previsoes <- data.frame(id = IDs, previsoes = previsoes)

# Saving the table in "csv" format (MS Excel)
diretorio <- getwd()
caminho <- file.path(diretorio, "predicted.csv")
write.csv(tabela_previsoes, caminho, row.names = FALSE)


###############################################################################
##                               THE END !!!!!!                              ##
###############################################################################

