# Desafio Cientista de Dados
esse arquivo visa responder as perguntas feitas no item 3 da seção "Entregas" do arquivo "[Lighthouse] Desafio Cientista de Dados 2023-9".

# Explique como você faria a previsão do preço a partir dos dados.
Para que os resultados de um projeto de ciência de dados sejam os melhores possíveis, é interessante que tenhamos um plano de ações a ser seguido. Um plano de ações bem conhecido e que pode ser utilizado em ciência de dados é o CRISP-DM (Cross Industry Standard Process for Data Mining). 

O CRISP-DM consiste em 6 etapas principais: Entendimento do Negócio, Entendimento dos Dados, Preparação dos Dados, Modelagem, Avaliação e Implantação. 

As etapas listadas acima resumem a abordagem adotada por mim para tentar prever o preço dos carros a partir dos dados disponibilizados.

# Quais variáveis e/ou transformações você utilizou e por quê?
A maioria das variáveis foram utilizadas no modelo final. Porém, algumas das variáveis eram inúteis para o objetivo e foram removidas dos dados.

"id" do "cars_test", e "Column1" do "cars_train" foram removidas por serem um valores únicos e exclusivos de cada observação, consegquentemente elas não possuiam poder preditivo para a variável "preco".

"num_fotos" foi removida porque mostrou possuir uma correlação irrelevante com a variável de saída, porque o meu conhecimento do domínio me permite saber que o "número de fotos" de um automóvel não é uma característica usada na sua precificação.

"veiculo_alienado" e "elegivel_revisao" pareciam ser duas variáveis qualitativas supostamente binárias, porém todas as observações possuíam valores vazios (NA) em ambas. Logo, também foram excluídas dos dados.

Os datasets diponibilizados possuiam muitos outros valores NA em outras variáveis, mas diferente de "veiculo_alienado" e "elegivel_revisao", essas outras variáveis possuíam categorias/níveis alternativos aos NAs. Elas foram mantidas nos dados e tiveram seus NAs substituídos pela palavra "nao", pois os NAs estavam representando as categorias "negativas" das variáveis qualitativas binárias.

Por fim, as variáveis qualitativas foram todas "dummizadas" afim de permitir um melhor desempenho do modelo a ser criado.

# Qual o tipo de problema estamos resolvendo (regressão, classificação)?
Estamos resolvendo um problema de regressão. Classificações são indicadas quando a variável de saída é qualitativa.

# Qual modelo melhor se aproxima dos dados e quais seus prós e contras?
Acredito que os modelos mais indicados seriam a regressão linear e a árvore de decisão. Testei abordagens diferentes para ambos os tipos de modelo e decidi focar apenas nas árvores de decisão devido aos melhores resultados de R².

