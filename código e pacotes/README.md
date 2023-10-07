# Data Scientist Challenge
This README.md aims to answer the questions asked in item 3 of the “Tasks” section of the file “[Lighthouse] Data Scientist Challenge 2023-9".

# Explain how you would predict the price from the data.
For the results of a data science project to be as good as possible, it is interesting to have an action plan to follow. A well-known action plan that can be used in data science is CRISP-DM (Cross Industry Standard Process for Data Mining).

CRISP-DM consists of 6 main steps: Business Understanding, Data Understanding, Data Preparation, Modeling, Evaluation, and Deployment.

The steps listed above summarize the approach adopted by me to try to predict the price of cars from the data provided.

# What variables and/or transformations did you use and why? 
Most of the variables were used in the final model. However, some of the variables were useless for the objective and were removed from the data.

“id” from “cars_test”, and “Column1” from “cars_train” were removed because they are unique and exclusive values of each observation, consequently they do not have predictive power for the variable “preco”.

“num_fotos” was removed because it showed an irrelevant correlation with the output variable and because my domain knowledge allows me to know that the “number of photos” of a car is not a characteristic used in its pricing.

“veiculo_alienado” and “elegivel_revisao” seemed to be two supposedly binary qualitative variables, but all observations had empty values (NA) in both. So, they were also excluded from the data.

The datasets provided had many other NA values in other variables, but unlike “veiculo_alienado” and “elegivel_revisao”, these other variables had alternative categories/levels to NAs. So, they were kept in the data and had their NAs replaced by coherent values.

Finally, all qualitative variables were “dummy coded” in order to allow better performance in certain models.

# What type of problem are we solving (regression, classification)? 
We are solving a regression problem. Classifications are indicated when the dependent variable is qualitative.

# Which model best approximates the data and what are its pros and cons? 
The evaluation of the models was done by dividing “cars_train” into two datasets in a 80/20 proportion. The first dataset was called “train” and the second one “test”. This measure was necessary because “cars_test” did not have the variable “preco”.

All considered models were initially trained with “train” data and evaluated with “test”. The considered models were OLS linear regression, random forest, decision tree, and xgboost using tree as base model (xgboost tree). Among these, the model that performed best in predicting prices for the “test” dataset was tree with xgboost.

XGBoost is a boosting model that works by repeatedly running a base model to improve it based on its residuals. It is a versatile and computationally efficient algorithm, suitable for handling extensive datasets due to its iterative nature, which allows capturing patterns in data that could go unnoticed in other models. The main disadvantage of XGBoost is the need to adjust its parameters, which can make its implementation complex and less practical in certain situations.

The XGBoost Tree was the model that best fit the data probably because besides being extensive data, with many observations and many variables, they also had non-linear relationships. XGBoost models are especially suitable for extensive data, while decision trees are suitable for capturing non-linear relationships. Therefore, the XGBoost Tree should have been able to approximate the data well by combining these characteristics.

# What performance measure of the model was chosen and why?
The main performance measure chosen was the coefficient of determination (R²). R² is a widely used metric for the evaluation of regression models. It measures how well a model fits the data and how well it captures the total variation explained by the independent variables. Secondarily, the models were also evaluated based on MSE and MAE, as they provide information about the size of the errors between predictions and actual values.
