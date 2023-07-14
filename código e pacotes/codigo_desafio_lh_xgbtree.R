###############################################################################
##                          Pré-processamento de dados                       ##                         
###############################################################################
# Carregando os conjuntos de dados
cars_train <- read_excel("cars_train.xlsx")
cars_test <- read_excel("cars_test.xlsx")

# Salvando os IDs
IDs <- cars_test$id

# Removendo coluna referente ao id dos conjuntos de treinamento e teste
cars_train <- cars_train[, -which(names(cars_train) == "Column1")]
cars_test <- cars_test[, -which(names(cars_test) == "id")]


###############################################################################
##                        Análise descritiva/exploratória                    ##                         
###############################################################################
# Calculando e exibindo a matriz de correlação
chart.Correlation((cars_train[, c(1, 5:7, 9, 28)]), histogram = TRUE)

# Exibindo estatísticas das variáveis
summary(cars_train)
summary(cars_test)

# Exibindo as categorias/níveis das variáveis qualitativas
levels(factor(cars_train$marca)) # caso desejemos analisar uma variável diferente
levels(factor(cars_test$marca))  # de "marca", basta substituir "marca" pelo nome
                                 # da variável a ser analisada.

# Exibindo as frequências de cada categoria/nível das variáveis qualitativas
table(cars_train$marca)         # caso desejemos analisar uma variável diferente
table(cars_test$marca)          # de "marca", basta substituir "marca" pelo nome
                                # da variável a ser analisada.


###############################################################################
##                      Processamento de dados pós-análise                   ##                          
###############################################################################
# Removendo as coluna "num_fotos" dos conjuntos de treinamento e teste
cars_train <- cars_train[, -which(names(cars_train) == "num_fotos")]
cars_test <- cars_test[, -which(names(cars_test) == "num_fotos")]

# Removendo as colunas "veiculo_alienado" e "elegivel_revisao" dos conjuntos de treinamento e teste
cars_train <- cars_train[, !(names(cars_train) %in% c("veiculo_alienado", "elegivel_revisao"))]
cars_test <- cars_test[, !(names(cars_test) %in% c("veiculo_alienado", "elegivel_revisao"))]

# Substindo os valores ausentes por "nao" nos conjuntos de treinamento e teste
cars_train[is.na(cars_train)] <- "nao"
cars_test[is.na(cars_test)] <- "nao"

# Criando objetos contendo as variáveis quantitativas e qualitativas
variaveis_quantitativas <- c("ano_de_fabricacao", "ano_modelo", "hodometro", "num_portas", "preco")
variaveis_qualitativas <- setdiff(names(cars_train), variaveis_quantitativas)

# Aplicando dummização nos conjuntos de "cars_train" e "cars_test" (One-Hot Coding)
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

# Corrigindo o nome da variável "ano_modelo" que foi modificado durante a dummização
cars_train <- rename(cars_train, ano_modelo = dummy_ano_modelo)
cars_test <- rename(cars_test, ano_modelo = dummy_ano_modelo)

# Dividino "cars_train" em "treino" e "teste"
n <- sample(1:2,
            size = nrow(cars_train),
            replace = TRUE,
            prob=c(0.8, 0.2))

treino <- cars_train[n==1,]
teste <- cars_train[n==2,]


###############################################################################
##                            Treinamento do Modelo                          ##                    
###############################################################################
# Definindo o parâmetro "control"
control <- caret::trainControl(
  "cv",                              # método de validação cruzada
  number = 2,                        # número de repetições da validação cruzada
  summaryFunction = defaultSummary,  # função de resumo padrão para avaliação
  classProbs = FALSE                 # não calcular probabilidades das classes
)

# Definindo o parâmetro "search_grid"
search_grid <- expand.grid(
  nrounds = 50,                      # número de iterações
  max_depth = 30,                    # profundidade máxima das árvores
  gamma = 0,                         
  eta = c(0.05, 0.4),                # taxa de aprendizado
  colsample_bytree = .7,             # fração de colunas amostradas por árvore
  min_child_weight = 1,              # peso mínimo dos nós 
  subsample = .7                     # fração de obs. a serem usadas em cada árvore
)
# Criando o modelo ("XGBoost Tree")
xgbtree_final <- caret::train(
  preco ~ .,                         # preço em função de "tudo"
  data = cars_train,
  method = "xgbTree",
  trControl = control,
  tuneGrid = search_grid,
  verbosity = 0
)


###############################################################################
##                            Avaliação do Modelo                            ##                    
###############################################################################
# Criando uma função de avaliação
avalia <- function(previsto, observado) {
  mse <- mean((previsto - observado)^2)
  rmse <- sqrt(mse)
  mae <- mean(abs(previsto - observado))
  r_squared <- 1 - (sum((observado - previsto)^2) / sum((observado - mean(observado))^2))
  
  cat("MSE:", mse, "\n")
  cat("RMSE:", rmse, "\n")
  cat("MAE:", mae, "\n")
  cat("R-squared:", r_squared, "\n")}

# Usando a função de avaliação
p_treino <- predict(xgbtree_final, cars_train) 
p_teste <- predict(xgbtree, teste) 
avalia(p_treino, cars_train$preco) 


###############################################################################
##                   Prevendo os preços para o "cars_test"                   ##                         
###############################################################################
# Identificando as variáveis dummizadas presentes no conjunto de treinamento
dummies <- grep("dummy_", colnames(cars_train), value = TRUE)

# Verificando quais variáveis dummizadas não estão presentes no conjunto de teste
dummies_faltantes <- setdiff(dummies, colnames(cars_test))

# Adicionando as variáveis ausentes ao conjunto de teste com valor 0
for (variable in dummies_faltantes) {
  cars_test[[variable]] <- 0
}

# Fazendo previsões nos dados de teste
previsoes <- predict(xgbtree_final, cars_test)

# Criando tabela com "id" e "previsoes"
tabela_previsoes <- data.frame(id = IDs, previsoes = previsoes)

# Salvando a tabela em formato "xlsx" (MS Excel)
diretorio <- getwd()
caminho <- file.path(diretorio, "tabela_previsoes.xlsx")
write.xlsx(tabela_previsoes, caminho)


###############################################################################
##                               FIM !!!!!!                                  ##
###############################################################################