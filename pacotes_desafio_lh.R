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
             "caret"  # xgbtree entre outras funções
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



