packages <- c("readxl", # allows "reading" "xlsx" files
             "dplyr", # functions for statistical analysis 
             "PerformanceAnalytics", # adds other functions for analysis, 
             "fastDummies", # "dummy coding" of qualitative variables (One Hot Coding). 
             "ggplot2", # functions for plotting graphs
             "car", # functions for statistical analysis
             "caret" , # xgbtree among other functions
             "readr"  # allows saving "csv" files
             )
if(sum(as.numeric(!packages %in% installed.packages())) != 0){
  installer <- packages[!packages %in% installed.packages()]
  for(i in 1:length(installer)) {
    install.packages(installer, dependencies = T)
    break()}
  sapply(packages, require, character = T) 
} else {
  sapply(packages, require, character = T) 
}




