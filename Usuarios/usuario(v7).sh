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
#versão 6: Adicionadas opções -r, --reverse, -u, --uppercase,
#          leitura de múltiplas opções (loop)
#versão 7: Melhoria no código para que fique mais legível,
#          adicionadas opções -d e --delimiter
#
#Nicolau, Fevereiro de 2024
#
ordenar=0       #A saída deverá ser ordenada?
inverter=0      #A saída deverá ser invertida?
maiusculas=0    #A saída deverá ser em maiúsculas?
delim='\t'      #Caractere usado como delimitador da saída
MENSAGEM_USO="
Uso: $(basename "$0") [OPÇÕES]
OPÇÕES:
    -r, --reverse   Inverte a listagem
    -s, --sort      Ordena a listagem alfabeticamente
    -u, --uppercase Mostra a listagem em MAIÚSCULAS
    -h, --help      Mostra esta tela de ajuda e sai
    -V, --version   Mostra a versão do programa e sai  
"
#Tratamento das opções de linha de comando
case "$1" in
    -s | --sort)        ordenar=1       ;;
    -r | --reverse)     inverter=1      ;;
    -u | --uppercase)   maiusculas=1    ;;

    -d | --delimiter)
        shift
        delim="$1"

        if test -z "$delim"
        then
            echo "faltou o argumento para a -d"
            exit 1
        fi
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

#Opção $1 já processada, a fila deve andar
shift
done

#Extrai a Listagem
Lista=$(cut -d : -f 1,5 /etc/passwd)
#Ordena a listagem (se necessário)
test "$ordenar"     = 1 && lista=$(echo "$lista" | sort)
test "$inverter"    = 1 && lista=$(echo "$lista" | tac)
test "$maiusvculas" = 1 && lista=$(echo "$lista" | tr a-z A-Z)
#Mostra o resultado para o usuário
echo "$lista" | tr ; "$delim"
