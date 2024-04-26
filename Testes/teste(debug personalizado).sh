#!/bin/bash
#teste(debug persolnalizado).sh
#
#mostra uma palvra ($TXT) em maúsculas e com exclamações
#exemplo: foo -> !!!!!FOO!!!!!
debug=1         #depuração: 0 Desliga, 1 Liga
#função de depuração
debug() {
    ["$DEBUG" = 1 ] && echo "$*"
}
TXT="Funcione"
TXT="       $TXT        "       #adiciona 5 espaços ao redor
debug"TXT com espaços : [$TXT]"
TXT=$(echo $TXT | tr '''!')     #troco os espaçoes por exclamações
debug
TXT=$(echo $TXT | tr a-z A-Z)   #deixa o texto em maiúsculas
echo "$TXT"                     #mostra a mensagem
