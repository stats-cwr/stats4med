## ---- echo=FALSE, include=FALSE------------------------------------------

# Apenas para criar o link para download
aula <- "rcourse02"
knitr::purl(paste0(aula, ".Rmd"))


## ------------------------------------------------------------------------

# Algumas funções para construir gráficos em R
apropos("plot$")
apropos("chart$")


## ---- eval=FALSE---------------------------------------------------------
## 
## # Parâmetros gráficos do pacote graphics
## help(par)
## 
## # Uma demostração (impressione-se)
## demo(graphics)
## 

## ------------------------------------------------------------------------

# Lendo os dados
dados <- read.table(
    "./data/medicos.csv",   # o caminho para o .csv
    header = TRUE,          # tem cabeçalho
    sep = ";",              # Separador ;
    dec = ",",              # Decimais com ,
    quote = "",             # Nada define caracteres no .csv
    skip = 1,               # Pula a primeira linha
    encoding = "UTF-8"      # Codificação de caracteres uft-8
)
# Ajustes da leitura
dados <- dados[, c(-2, -6)]
colnames(dados) <- c("estado", "municipio", "med1", "med2")

# Verificando a estrutura
str(dados)


## ------------------------------------------------------------------------

# Tabela de frequências por estado (número de municípios em cada estado)
xt_estado <- table(dados$estado)
xt_estado


## ---- eval=FALSE---------------------------------------------------------
## 
## # Gráfico de barras
## barplot(xt_estado)
## 
## # Gráfico de setores
## pie(xt_estado)
## 

## ------------------------------------------------------------------------

# Customizando o gráfico de barras
val <- sort(xt_estado)
bp <- barplot(val,
              horiz = TRUE,
              col = "darkturquoise",
              las = 1,
              xlim = extendrange(c(0, max(val))))
grid(ny = 0, col = "gray70", lty = 2)
text(x = val, y = bp, labels = val, adj = 0)
title(main = "Frequência de municípios no Brasil nos anos de 1991 e 2000",
      xlab = "Número de municípios",
      ylab = "Estado da federação")


## ------------------------------------------------------------------------

# Há municípios cujo não temos os valores da proporção de médios em
# alguns dos anos de avaliação, esses casos serão descartados para
# construção dos gráficos
dados <- na.omit(dados)

str(dados)


## ---- eval=FALSE---------------------------------------------------------
## 
## # Histograma
## hist(dados$med1)
## hist(dados$med2)
## 
## # Densidade
## plot(density(dados$med1))
## plot(density(dados$med2))
## 
## # Boxplot
## boxplot(dados$med1)
## boxplot(dados$med2)
## 
## # Traço dos valores (inútil neste exemplo)
## plot(dados$med1)
## plot(dados$med2)
## 

## ------------------------------------------------------------------------

# Somente as observações com algum médico residente
tmed1 <- dados$med1[dados$med1 > 0]
tmed2 <- dados$med1[dados$med2 > 0]

##----------------------------------------------------------------------
## Um histograma mais elaborado

# Estimando a densidade
dens1 <- density(tmed1)
dens2 <- density(tmed2)

# Cores para os gráficos
col1 <- rgb(0.4, 0.4, 1)
col2 <- rgb(1, 0.4, 0.4)

# Exibindo graficamente
hist(tmed1,
     ylim = c(0, max(c(dens1$y, dens2$y))),
     probability = TRUE,
     col = rgb(0.4, 0.4, 1, 0.5),
     border = "white",
     xlab = "Proporção de médicos residentes",
     ylab = "Densidade",
     main = "Comportamento da proporção de médicos residentes")
hist(tmed2,
     probability = TRUE,
     add = TRUE,
     col = rgb(1, 0.5, 0.5, 0.5),
     border = "white")
box()
grid()

# Incluindo as curvas de densidade
lines(dens1, col = col1, lwd = 2)
lines(dens2, col = col2, lwd = 2)

# Incluindo os valores das observações
rug(tmed1, col = rgb(0.4, 0.4, 1, 0.1))
rug(tmed2, col = rgb(1, 0.4, 0.4, 0.1))

# Incluindo a legenda
legend("topright",
       legend = c("Ano de 1991", "Ano de 2000"),
       fill = c(col1, col2),
       bty = "n",
       border = "white"
       )


## ---- eval=FALSE---------------------------------------------------------
## 
## # Médicos residentes em cada estado no ano de 1991 e 2000
## plot(med1 ~ estado, data = dados)
## plot(med2 ~ estado, data = dados)
## 
## # Relação dos médicos residentes entre os anos avaliados
## plot(med2 ~ med1, data = dados)
## abline(a = 0, b = 1)
## 

## ---- echo=FALSE---------------------------------------------------------

sessionInfo()


## ---- results="asis", echo=FALSE-----------------------------------------

cat(paste0(
    "<div id='update-message'>",
    format(Sys.time(),
           format = "Atualizado em %d de %B de %Y."),
    "</div>"),
    sep = "\n")


