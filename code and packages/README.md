# Desafio Cientista de Dados
Esse README.md visa responder as perguntas feitas no item 3 da seção "Entregas" do arquivo "[Lighthouse] Desafio Cientista de Dados 2023-9".

# Explique como você faria a previsão do preço a partir dos dados.
Para que os resultados de um projeto de ciência de dados sejam os melhores possíveis, é interessante que tenhamos um plano de ações a ser seguido. Um plano de ações bem conhecido e que pode ser utilizado em ciência de dados é o CRISP-DM (Cross Industry Standard Process for Data Mining). 

O CRISP-DM consiste em 6 etapas principais: Entendimento do Negócio, Entendimento dos Dados, Preparação dos Dados, Modelagem, Avaliação e Implantação. 

As etapas listadas acima resumem a abordagem adotada por mim para tentar prever o preço dos carros a partir dos dados disponibilizados.

# Quais variáveis e/ou transformações você utilizou e por quê?
A maioria das variáveis foram utilizadas no modelo final. Porém, algumas das variáveis eram inúteis para o objetivo e foram removidas dos dados.

"id" do "cars_test", e "Column1" do "cars_train" foram removidas por serem um valores únicos e exclusivos de cada observação, consegquentemente elas não possuiam poder preditivo para a variável "preco".

"num_fotos" foi removida porque mostrou possuir uma correlação irrelevante com a variável de saída e porque o meu conhecimento do domínio me permite saber que o "número de fotos" de um automóvel não é uma característica usada na sua precificação.

"veiculo_alienado" e "elegivel_revisao" pareciam ser duas variáveis qualitativas supostamente binárias, porém todas as observações possuíam valores vazios (NA) em ambas. Logo, também foram excluídas dos dados.

Os datasets diponibilizados possuiam muitos outros valores NA em outras variáveis, mas diferente de "veiculo_alienado" e "elegivel_revisao", essas outras variáveis possuíam categorias/níveis alternativos aos NAs. Logo, elas foram mantidas nos dados e tiveram seus NAs substituídos por valores coerentes.

Por fim, as variáveis qualitativas foram todas "dummizadas" afim de permitir um melhor desempenho em certos modelos.

# Qual o tipo de problema estamos resolvendo (regressão, classificação)?
Estamos resolvendo um problema de regressão. Classificações são indicadas quando a variável dependente é qualitativa.

# Qual modelo melhor se aproxima dos dados e quais seus prós e contras?
Acredito que os modelos mais indicados seriam a regressão linear e a árvore de decisão. Testei abordagens diferentes para ambos os tipos de modelo e decidi focar apenas nas árvores de decisão devido aos melhores resultados de R².

A avaliação dos modelos foi feita a partir da divisão do "cars_train" em dois datasets na proporção 80/20. O primeiro dataset foi chamado "treino" e o segundo "teste". Essa medida foi necessária pois o "cars_test" não possuia a variável "preco".

Todos os modelos cogitados foram incialmente, treinados com os dados do "treino" e avaliados com o "teste". Os modelos cogitados foram regressão linear OLS, floresta aleatória, árvore de decisão, e xgboost utilizando árvore como modelo base (xgboost tree).
Dentre esses, o modelo que obteve melhor desempenho na previsão dos preços para o dataset "teste" foi a árvore com xgboost. 

O XGBoost é um modelo de boosting que trabalha executando repetidamente um modelo base a fim de melhorá-lo com base nos seus resíduos. Ele é um algoritmo versátil e computacionalmente eficiente, sendo adequado para lidar com conjuntos de dados extensos devido à sua natureza iterativa, que permite capturar padrões nos dados que poderiam passar despercebidos em outros modelos. A principal desvantagem do XGBoost é a necessidade de ajustar seus parâmetros, o que pode tornar sua implementação complexa e menos prática em determinadas situações.

O XGBoost Tree foi o modelo que melhor se adequou aos dados provavelmente porque além dos dados serem extensos, com muitas observações e com muitas variáveis, eles também possuiam relações não lineares entre si. Os modelos XGBoost são especialmente indicados para dados extensos, enquanto as árvores de decisão são adequadas para capturar relações não lineares. Logo, o XGBoost Tree deve ter sido capaz de se aproximar bem dos dados por combinar essas características.

# Qual medida de performance do modelo foi escolhida e por quê?
A medida de desempenho principal escolhida foi o coeficiente de determinação (R²). O R² é uma métrica amplamente utilizada para a avaliação de modelos de regressão. Ele mede o quão bem um modelo se ajusta aos dados e o quão bem ele captura a variação total explicada pelas variáveis independentes.
De maneira secundaria, os modelos também foram avaliados a partir do MSE e MAE, pois eles fornecem informações sobre o tamanho dos erros entre as previsões e os valores reais.

