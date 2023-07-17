pacotes <- c("readxl", # permite "ler" arquivos "xlsx"
             "dplyr", # funções para análise estatística 
             "PerformanceAnalytics", # adiciona outras funções para análise, 
             "fastDummies", # "dummização" de variáveis qualitativas (One Hot Coding). 
             "ggplot2", # funções para plotagem de gráficos
             "car", # funções para análise estatística
             "olsrr", # ols_test_breusch_pagan
             "nortest", # sf_test
             "openxlsx", # permite salvar em formato "xlsx"
             "rpart", # árvores
             "caret" , # xgbtree entre outras funções
             "readr"  # permite salvar arquivos "csv"
             )
if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}



lapply(pacotes, library, character.only = TRUE)


saveRDS(modelo_cars2, "modelo_cars.rds")
saveRDS(bc_modelo_cars, "bc_modelo_cars.rds")
modelo_cars <- readRDS("modelo_cars.rds")






# Avaliando o modelo1 (usando modelo e versao e cidade)

summary(modelo_cars) ## R² = 0.7821
## através do summary do modelo, podemos ver que muitas das variáveis não 
## possuem significância estatistica se considerarmos um nível de confiança de 95%.

vif(modelo_cars)
## ao executarmos a função `vif`, retornamos um erro relacionado a alta correlação entre algumas
## variáveis.

##modelo2 (- modelo,-versao, -cidade) R² = 0.55 (R² stepwise tbm = 0.55)
##modelo3 (- versao, -cidade) R2 = 0.68
##MODELO4 (-VERSAO) R2 = 0.70
##MODELO5 (-NUM_PORTAS) R² = 0.7809
