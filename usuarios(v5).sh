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
#versão 5: Adicionado opções -s e --sort
#
#Nicolau, Fevereiro de 2024
#
ordenar=0 #A saída deverá ser ordenada?
MENSAGEM_USO="
Uso: $(basename "$0") [-h | -V | -s]
    -s, --sort      Ordena a listagem alfabeticamente
    -h, --help      Mostra esta tela de ajuda e sai
    -V, --version   Mostra a versão do programa e sai  
"
#Tratamento das opções de linha de comando
case "$1" in
    -s | --sort)
        ordenar=1
    ;;

    -h | --help)
        echo "$MENSAGEM_USO"
        exit 0
    ;;

    -V | --Version)
        echo -n $(basename "$0")
        #extrai a versão diretamente dos cabeçalho do programa
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
#Extrai a Listagem
Lista=$(cut -d : -f 1,5 /etc/passwd)
#Ordena a listagem (se necessário)
if test "$ordenar" = 1
then
    Lista=$(echo"$lista" | sort)
fi
#Mostra o resultado para o usuário
echo "$lista" | tr : \\t
#Processamento
cut -d : -f 1,5 /etc/passwd | tr : \\ t
