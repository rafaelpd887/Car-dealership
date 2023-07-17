# Desafio_Lighthouse
Esse diretório contém arquivos relacionados ao desafio Lighthouse da Indicium.

- Arquivos de requisitos com todos pacotes utilizados pode ser encontrado em "códigos e pacotes" no script "pacotes_desafio_lh.R".

- Relatório das análises e EDA podem ser encontrados em "análises estatísticas e EDA".

- Códigos de modelagem podem ser encontrados em "códigos e pacotes" no script "codigo_desafio_lh_xgbtree.R".

- predicted.csv pode ser encontrado em "datasets".

# Como instalar e executar o projeto?
Meu projeto foi feito usando a linguagem R através do IDE "RStudio". Assim, para executar os códigos disponibilizados nesse repositório, recomendo que o faça em um computador com o R e o RStudio instalados. Ambos estão disponíveis nesse [link](https://posit.co/download/rstudio-desktop/).

Com o R e o RStudio instalados, basta abrir e executar "pacotes_desafio_lh.R" e "codigo_desafio_lh_xgbtree.R" através do RStudio. Use "ctrl+a" para selecionar o codigo inteiro, e "crtl+enter" para executar todas as linhas em sequencia. 

"pacotes_desafio_lh.R" e "codigo_desafio_lh_xgbtree.R" estão disponíveis no diretório/pasta "código e pacotes".

Para que o script "codigo_desafio_lh_xgbtree.R" seja executado corretamente são necessários os datasets "cars_train.xlsx" e "cars_test.xlsx" disponíveis no diretório "datasets". Eles são necessários porque os datasets originalmente disponibilizados não estavam sendo corretamente lidos pelo RStudio no meu computador. Entretanto, nenhuma alteração foi feita nos dados e eles são idênticos aos que foram disponibilizados.


<sub>PS: dependendo do computador, a etapa de "Treinamento do Modelo" no script "codigo_desafio_lh_xgbtree.R" pode demorar vários minutos...</sub>

<sub>PPS: devido a natureza aleatória do modelo xgboost tree, é improvável que as previsões obtidas ao executar o script "codigo_desafio_lh_xgbtree.R" sejam identicas as que estou enviando no arquivo "predicted.csv".</sub>

<sub>PSS: se possível, visitem meu [portfólio](https://rafaelpd.netlify.app).</sub>
