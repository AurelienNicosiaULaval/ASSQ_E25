## 4.3 Démo ellmer – pas à pas

1. `pak::pkg_install("ellmer")` puis `library(ellmer)`.  
1.b Choisir un modèle, moi j'utilise ollama qui est local `chat <- chat_ollama(model = "llama3:latest")`
2. `chat$chat("Écris une fonction R qui calcule la médiane ?")` → réponse directe.  
5. Illustrer l’injection d’environnement :
   ```r
   nums <- rnorm(100)
   chat$chat("Calcule-moi la moyenne de 'nums' déjà chargés en mémoire.")
   ```
