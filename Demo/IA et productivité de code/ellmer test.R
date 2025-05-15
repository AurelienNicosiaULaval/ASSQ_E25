library(ellmer)
chat <- chat_ollama(model = "llama3:latest")

chat$chat("Écris une fonction R qui calcule la medianne et la moyenne ?")



