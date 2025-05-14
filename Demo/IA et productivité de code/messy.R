# messy_code.R  – volontairement « anti-tidyverse » ----

data(iris)

# 1. Création manuelle d'une nouvelle variable, syntaxe base R
iris$SepalArea <- iris$Sepal.Length * iris$Sepal.Width



# 2. Filtre sans %>%, ni dplyr
sub <- iris[ iris$SepalArea > mean(iris$SepalArea), ]

# 3. Boucle for inutile pour résumer les longueurs de pétales
petal_sum <- c()
for (sp in unique(sub$Species)) {
  petal_sum <- c(
    petal_sum,
    sum(sub$Petal.Length[sub$Species == sp])
  )
}


# 4. aggregate() avec une fonction anonyme verbeuse
summary_tbl <- aggregate(
  sub[ , 1:4],
  by = list(species = sub$Species),
  FUN = function(x) { sum(x) / length(x) }
)

rownames(summary_tbl) <- NULL
print(summary_tbl)

# 5. Construction manuelle d’un plot basique
plot(
  summary_tbl$Sepal.Length,
  summary_tbl$Sepal.Width,
  col = c("red", "green", "blue"),
  pch = 19,
  main = "Sepal dims (> Aire moyenne)"
)
text(summary_tbl$Sepal.Length, summary_tbl$Sepal.Width,
     labels = summary_tbl$species, pos = 4, cex = 0.8)













# messy.R – exemple de script truffé de mauvaises pratiques ----
# Objectif : servir de terrain de jeu à gander / air.

library(dplyr)# BAD: manque d’espace avant le commentaire, un seul package par ligne c’est préférable
library(ggplot2);library(stringr) # BAD: sémi‑colonnes inutiles + plusieurs calls sur la même ligne

Data<-read.csv("myData.csv",header=T,sep=";") # BAD: nom d’objet en UpperCamel; préférer readr::read_csv; header=T au lieu de TRUE
attach(Data) # BAD: attach() pollue l’environnement et crée des ambiguïtés

# Calcul grossier de l’âge moyen
mean_Age=mean(age) # BAD: opérateur « = » au lieu de « <- »; variable pas en snake_case
print ( mean_Age ) # BAD: espace après la fonction; pas besoin d’espace supplémentaire

# Remplacement d’un code NA magique
Data$income[Data$income==9999]<-NA # BAD: nombre magique; préférer na_if(); pas d’espaces autour des opérateurs

# Boucle inefficace pour incrémenter l’âge
for (i in 1:length(Data$age)){
  Data$age[i]<-Data$age[i]+1            # BAD: boucle explicite; préférer dplyr::mutate(age = age + 1)
}

# Création de facteurs manuelle
Data$continent<-factor(Data$continent,levels=c("Asia","Europe","Americas","Africa","Oceania")) # BAD: ligne trop longue (>80 car.)

# Exemple de pipeline mal espacée et non‑tibble
summary_tbl <- Data %>%group_by(continent)%>% summarise(meanGDP= mean(gdp ,na.rm=TRUE)) # BAD: espaces incohérents dans le pipe; nom de variable en UpperCamel; gdp pas en snake_case

# Dataviz avec esthétique durement codée
plot <- ggplot(Data,aes(gdpPercap,lifeExp,color=continent))+geom_point(size=2,alpha=.6)+theme_bw() # BAD: pas d’espaces après les virgules; ligne trop longue; variables camelCase
print(plot)

# Fonction bricolée sans roxygen ni type checking
calcRatio<-function(x , y){x/y} # BAD: espace erratique; nom de fonction pas snake_case; pas de validation d’entrée
result<-calcRatio(sum(income ,na.rm=T),          sum(population,na.rm=T)) # BAD: TRUE abrégé ; aligne pas les arguments

cat("Ratio =",result ,"\n") # BAD: espace superflu avant la virgule

# Nettoyage inutile : detach et rm(list=ls())
detach(Data) # BAD: detach encore plus dangereux si d’autres data frames attachés
rm(list=ls()) # BAD: supprime tout l’environnement – dangereux en script partagé
