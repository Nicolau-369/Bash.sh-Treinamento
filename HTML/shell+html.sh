#!bin/bash
#shell+html.sh
#Mostra as 5 últimas manchetes do BR-Linux
#Versão 1 que procura no texto
#
#Nicolau, Março de 2024
URL="http://br-linux.org"
#O padrão são linhas que iniciam com maiúsculas.
#Até a linha "Destaque de hoje" é bom...
lynx -dump -nolist "$URL" |
    grep '^[A-Z]' |
    sed '1,/^Destaques de hoje/ d' |
    head -n 5
done    