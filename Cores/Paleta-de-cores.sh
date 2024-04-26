#!/bin/bash
#Paleta-de-cores.sh
#Mostra todas as combinações de cores do controle
for letra in 0 1 2 3 4 5 6 7; do
  for brilho in '' ';1'; do
    for fundo in 0 1 2 3 4 5 6 7; do    #LINHAS: cores das letras
      seq="4$fundo;3$letra"             #liga/desliga cor brilhante
      echo -e "\033[$seq${brilho}m\c"   #compõe código de cores
      echo -e " $seq${brilho:-  } \c"   #mostra o código na tela
      echo -e "\033[m\c"                #desliga a cor
    done; echo                          #quebra a linha
  done
done