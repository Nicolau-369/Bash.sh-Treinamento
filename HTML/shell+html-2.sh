#!bin/bash
#shell+html-2.sh
#Mostra as 5 últimas manchetes do BR-Linux
#Versão 2 que procura no código HTML
#
#Nicolau, Março de 2024
URL="http://br-linux.org"
#O padrão são linhas "<h1><a style".
#O sed remove as tags HTML, restaura as aspas e
#apaga os espaços do início.
#O head limita o número de manchetes em 5.
#
lynx -source "$URL" |
    grep '<h1><a style' |
    sed '
        s/<[^>]*>//g
        s/&quot;/"/g
        s/^ *//' |
    head -n 5
done