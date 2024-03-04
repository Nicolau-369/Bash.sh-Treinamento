#!bin/bash
#shell+html-3.sh
#Mostra as 5 últimas manchetes do BR-Linux
#Versão 3 que procura no Feed XML
#
#Nicolau, Março de 2024
URL="http://br-linux.org/linux/node/feed"
#O padrão são linhas "<title>".
#O sed remove as tags HTML, restaura as aspas,
#apaga os espaços do início e remove a primera linha.
#O head limita o número de manchetes em 5.
#
lynx -source "$URL" |
    grep '<h1><a style' |
    sed '
        s/<[^>]*>//g
        s/&quot;/"/g
        s/^ *//
        1d |
    head -n 5
done