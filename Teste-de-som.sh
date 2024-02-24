#!/bin/bash
#Teste-de-som.sh
#Demonstração de mudança da frequência do Speaker
#Dica: Digite Crl+C para finalizar.
#
#Restaura o bipe padrão (f=750, t=100ms)
echo -e '\033[10;750]\033[11;100]'
freq=0                          #frequência inicial
# shellcheck disable=SC1073
# shellcheck disable=SC1061
while : ; do                  #loop infinito
  freq=$((freq+1))              #aumenta frequência
  echo -e "\033[10;$freq]"      #muda frequência no Speaker
  texto_largura=$((             caixa_largura-distancia_borda_texto))
  texto=$(                      fmt -sw $texto_largura)
  num_linhas=$(                 echo "$texto" | wc -1)
  total_linhas=$((              num_linhas+2))    #texto + bordas horinzontais
  ###Checagem do tamanho do texto
  if [ $num_linhas -gt $texto_max_linhas ]; then
      echo "Texto exetenso, mas com detalhes a ser estudado"
      exit 1
  fi
  ###Compõe a linha horizontal da caixa
  #É $caixa_largura-2 porque os "cantos" serão feitos com o +
  for i in $(seq $((caixa_largura-2))); do
    linha_caixa="$linha_caixa-"
  done
  ###Limpa a tela
  echo -ne '\033c'
  ###Desenha a caixa
  echo -ne "\033[$caixa_linha_inicio;OH"      #pula p/a linha inicial
  echo -ne "\033{$caixa_cor}m"                #liga a cor da caixa
  for i in $(seq $total_linhas); do           #para cada linha...
    echo -ne "\033[${caixa_coluna__inicio}G"      #vai p/coluna
   inicial
    if [ $1 -eq 1 -o $i -eq $total_linhas ]; then #1a ou última linha
        echo +$linha_caixa+                       #borda horinzontal
    else                                          #senão
        echo -e "|\033[${caixa_coluna__fim}G|"    #bordas verticais
    fi 
done
echo -e '\033[m'                             #desliga as cores
###Coloca o texto dentro da caixa
echo -ne "\033[$((caixa_linha_inicio+1));OH" #pula p/a linha inicial
echo -ne "\033[${texto_cor}m"                #liga a cor do texto
echo "$texto" | while read LINHA; do         #para cada linha...
    echo -e "\033[${texto_coluna_inicio}G$LINHA"  #posiciona e mostra
done
echo -e '\033[m'                             #desliga as cores
echo
done