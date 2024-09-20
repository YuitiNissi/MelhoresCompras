def avaliar_atendimento():
  """Solicita ao usuário uma nota de 0 a 10 para avaliar o atendimento e retorna o índice de satisfação."""

  while True:
    try:
      nota = int(input("Como você avalia o atendimento recebido? Digite uma nota entre 1 e 10, onde 1 significa completamente insatisfeito e 10, completamente satisfeito: "))
      if 1 <= nota <= 10:
        break
      else:
        print("Valor inválido. Por favor, digite um número inteiro entre 1 e 10.")
    except ValueError:
      print("Valor inválido. Por favor, digite um número inteiro.")

  if 1 <= nota <= 6:
    classificacao = 'insatisfatório'
  elif 7 <= nota <= 8:
    classificacao = 'neutro'
  else:
    classificacao = 'satisfatório'

  print(f"Seu índice de satisfação foi: {classificacao}")
avaliar_atendimento()