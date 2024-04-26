#!/bin/bash
# mostra_path_lista.sh
# Vamos mostrar uma página HTML
echo Content-type: text/html
echo
# Adiciona um diretório falso ao PATH
PATH=$PATH:/noel
# Inicia uma lista de itens
echo "<UL>"
# Para cada pasta do $PATH...
IFS=:
for pasta in $PATH; do
  # Confirme se ela existe
  if test -d $pasta; then
  extra="existe"
  else
  extra="não existe"
  fi
  # E mostre o resultado na tela (item da lista)
  echo "<LI>$pasta ($extra)</LI>"
done
# Fecha a lista
echo "</UL>"