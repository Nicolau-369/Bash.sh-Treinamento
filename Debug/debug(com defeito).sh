#!/bin/bash
#debug(com defeito).sh
#
#mostra uma palavra ($TXT) em maiúsculas e conhecemos
#exemplo -> foo !!!!!FOO!!!!!
TXT="Funcione"
TXT="       $TXT        "       #adiciona 5 espaços ao redor
TXT=$(echo $TXT | tr ' ' '!')   #troca os espaços por exclamações
TXT=$(echo $TXT | tr a-z A-Z)   #mostra a mensagem
echo "$TXT"                     #mostra a mensagem
