#!bin/bash
#shell+html-3.sh
#Mostra as 5 últimas manchetes do BR-Linux
#Versão 3 que procura no Feed XML
#
#Nicolau, Março de 2024
URL="http://br-linux.org/linux/node/feed"
#Função feed: Extrai as manchetes mais recentes de um Feed.
#Passe o endereço do feed como argumento
#Exemplo: feed http://br-linux.org/feed/
#
feed() {
    lynx -source "$1" | grep '<title>' | tr -d \\t |
        sed 's/ *<[^>]*>//g; s/&quot;/"/g; 1d'
}
done