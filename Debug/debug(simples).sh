#!/bin/bash
#debug(simples).sh
#
#mostra uma palavra ($TXT) em maiúsculas e com exclamações
#exemplo -> foo !!!!!FOO!!!!!
TXT="Funcione"
TXT="       $TXT        "           #adiciona 5 espaços ao redor
echo "TXT com espaço : [$TXT]"      
TXT=$(echo $TXT | tr ' ' '!')       #troca os espaços por exclamações
echo "TXT com esclamações : [$TXT]" 
TXT=$(echo $TXT | tr a-z A-Z)       #deixa os texto em maiúsculasss
echo "$TXT"                         #mostra a mensagem
