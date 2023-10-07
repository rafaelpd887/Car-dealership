# Lighthouse Challenge - Data Scientist 
This directory contains files related to the Lighthouse challenge from Indicium.

- Requirement files with all used packages can be found in “codes and packages” in the script “packages_project_lh.R”.

- Report of the analyses and EDA can be found in “statistical analyses and EDA”.

- The modeling codes can be found in “codes and packages” in the script “code_project_lh_xgbtree.R”.

- predicted.csv can be found in “datasets”.
  
# How to install and run the project?
My project was made using the R language through the IDE “RStudio”. Thus, to execute the codes available in this repository, I recommend that you do it on a computer with R and RStudio installed. Both are available at this link.

With R and RStudio installed, just open and run “packages_project_lh.R” and “code_project_lh_xgbtree.R” through RStudio. Use “ctrl+a” to select the entire code, and “crtl+enter” to execute all lines in sequence.

“packages_project_lh.R” and “code_project_lh_xgbtree.R” are available in the directory/folder “code and packages”.

For the script “code_project_lh_xgbtree.R” to be executed correctly, the datasets “cars_train.xlsx” and “cars_test.xlsx” available in the directory “datasets” are necessary. They are necessary because the datasets provided in “csv” format were not being read correctly by RStudio on my computer. However, no changes were made to the data and they are identical to those that were provided."


<sub>PS: Depending on the computer, the “Model Training” step in the “codigo_desafio_lh_xgbtree.R” script may take several minutes…</sub>

<sub>PPS: Due to the random nature of the xgboost tree model, it is unlikely that the predictions obtained by running the “codigo_desafio_lh_xgbtree.R” script will be identical to those I am sending in the “predicted.csv” file.</sub>

<sub>PSS: If possible, please visit my [portfolio](https://rafaelpd.netlify.app).</sub>
