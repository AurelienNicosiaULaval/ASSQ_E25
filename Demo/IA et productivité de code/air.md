## Démo Air – pas à pas

1. Créer `messy.R` avec du code mal indenté.  
2. Dans Posit IDE : **Tools ▸ Global Options ▸ Code ▸ Diagnostics** → cocher “Format on Save (Air)”.  
3. Sauvegarder le fichier : Air reformate instantanément.  
4. Montrer la même chose en console : `air::style_file("messy.R")`.  
5. *Bonus* : proposer un *pre‑commit hook* Git utilisant `air::style_dir()`.
