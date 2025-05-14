# Présentation ASSQ – Mai 2025

Bienvenue dans ce dépôt GitHub contenant le matériel de la présentation intitulée **« Quoi de neuf dans les outils en science des données ? »**, présentée lors de l'événement de l'ASSQ le **15 mai 2025**.

## 🌟 Objectif de la présentation

Cette présentation vise à faire découvrir aux statisticiens, enseignants, praticiens et curieux les **outils récents, interactifs et innovants** dans l'univers de la science des données, notamment dans l'écosystème R. Chaque outil est accompagné d'une **démonstration interactive** ou d'un exemple reproductible.

## 🗂 Contenu du dépôt

- `presentation mai 2025.qmd` : Fichier source de la présentation (format Quarto)
- `presentation mai 2025.html` : Présentation HTML autoportante générée
- `demo/` : Répertoire contenant les démonstrations (code R, Shiny, notebooks, etc.)
- `README.md` : Ce fichier de description

## 🚀 Visualiser la présentation

Pour visualiser la présentation :

1. Télécharger le dépôt :
   ```bash
   git clone https://github.com/TON-UTILISATEUR/assq2025-presentation.git
   cd assq2025-presentation
   ```

2. Ouvrir le fichier HTML dans votre navigateur :
   ```
   prsentation mai 2025.html
   ```

3. *(Optionnel)* Pour recompiler la présentation à partir du `.qmd` :
   - Ouvrir `presentation mai 2025.qmd` dans [RStudio](https://posit.co/downloads/)
   - Installer les dépendances nécessaires :
     ```r
     install.packages(c("quarto", "tidyverse", "shiny", "ggplot2"))  # compléter selon besoins
     ```
   - Puis cliquer sur **Render** ou utiliser :
     ```r
     quarto::quarto_render("prsentation mai 2025.qmd")
     ```

## 💡 Technologies utilisées

- [Quarto](https://quarto.org/)
- [R](https://cran.r-project.org/)
- [Shiny](https://shiny.posit.co/)
- [ggplot2](https://ggplot2.tidyverse.org/)
- Outils récents : Gander, Shiny Assistant, Posit Cloud, etc.

## ✉️ Contact

Pour toute question ou suggestion, vous pouvez contacter :

**Aurélien Nicosia**  
Université Laval  
[aurelien.nicosia@mat.ulaval.ca](mailto:aurelien.nicosia@mat.ulaval.ca)
