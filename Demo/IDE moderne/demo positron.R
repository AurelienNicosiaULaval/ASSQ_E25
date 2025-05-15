# Installer les packages si nécessaire
# install.packages(c("palmerpenguins", "ggplot2", "dplyr", "gt", "patchwork", "ggtext", "viridis"))

library(palmerpenguins)
library(ggplot2)
library(dplyr)
library(gt)
library(patchwork)
library(ggtext)
library(viridis)

# Nettoyer les données
penguins_clean <- penguins %>% 
  filter(!is.na(sex), !is.na(bill_length_mm), !is.na(flipper_length_mm), !is.na(body_mass_g))

# Tableau récapitulatif
penguins_summary <- penguins_clean %>%
  group_by(species, island) %>%
  summarise(
    Nombre = n(),
    `Longueur bec (mm)` = round(mean(bill_length_mm), 1),
    `Longueur nageoire (mm)` = round(mean(flipper_length_mm), 1),
    `Masse (g)` = round(mean(body_mass_g), 0)
  ) %>%
  gt() %>%
  tab_header(title = md("**📊 Statistiques par espèce et île**")) %>%
  fmt_number(columns = where(is.numeric), decimals = 1)

penguins_summary

# Graphique 1 : Bec vs Nageoire
g1 <- ggplot(penguins_clean, aes(x = bill_length_mm, y = flipper_length_mm, color = species)) +
  geom_point(alpha = 0.8, size = 3) +
  labs(
    title = "📏 Relation entre <span style='color:#21908CFF;'>longueur du bec</span> et <span style='color:#FDE725FF;'>longueur de la nageoire</span>",
    x = "Longueur du bec (mm)",
    y = "Longueur de la nageoire (mm)",
    color = "Espèce"
  ) +
  scale_color_viridis_d(option = "C") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_markdown(size = 16)
  )+
    theme(legend.position = "bottom")


# Graphique 2 : Masse corporelle par espèce et sexe
g2 <- ggplot(penguins_clean, aes(x = species, y = body_mass_g, fill = sex)) +
  geom_violin(trim = FALSE, alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.3) +
  scale_fill_viridis_d(option = "B") +
  labs(
    title = "⚖️ Répartition de la masse corporelle",
    x = "Espèce",
    y = "Masse corporelle (g)",
    fill = "Sexe"
  ) +
  theme_minimal(base_size = 14)+
  theme(legend.position = "bottom")

# Affichage combiné
g1 + g2 + plot_annotation(title = "🐧 Visualisations interactives des manchots de Palmer")
