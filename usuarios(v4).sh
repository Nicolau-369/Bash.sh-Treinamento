#!/bash/bash
#usuario.sh
#
#Mostra os logins e nomes de usuários do Sistema
#Obs.: Lê dados do arquivo /etc/passwd
#
#Versão 1: Mostra usuários e nome separados por TAB
#Versão 2: Adicionado suporte à opção -h
#Versão 3: Adicionado suporte à opção -V e opções inválidas
#Versão 4: Arrumado Bug quando não tem opções, basename no
#          nome do programa, -V extraindo direto dos cabeçalho,
#          adicionadas opções --help & --version
#
#Nicolau, Fevereiro de 2024
#
MENSAGEM_USO="
Uso: $(basename "$0") [-h | -V]
    -h    Mostra esta tela de ajuda e sai
    -V    Mostra a versão do programa e sai  
"
#Tratamento das opções de linha de comando
case "$1" in
    -h | --help)
        echo "$MENSAGEM_USO"
        exit 0
    ;;

    -V | --Version)
        echo -n $(basename "$0")
        #extra: A versão diretamente dos cabeçalho do programa
        grep '^# versão' "$0" | tail-1 | cut -d : -f 1 | tr -d \#
        exit 0
    ;;

    *)
      if test -n "$1"
      then
        echo Opção inválida: $1
        exit 1
      fi  
    ;;
esac
#Processamento
cut -d : -f 1,5 /etc/passwd | tr : \\ t
