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
#
#Nicolau, Fevereiro de 2024
#
ordenar=0       #A saída deverá ser ordenada?
inverter=0      #A saída deverá ser invertida?
maiusculas=0    #A saída deverá ser em maiúsculas?
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
    -s | --sort)
        ordenar=1
    ;;

    -r | --reverse)
        inverter=1
    ;;

    -u | --uppercase)
        maiusculas=1
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
if test "$ordenar" = 1
then
    Lista=$(echo"$lista" | sort)
fi
# Inverte a listagem (se necessário)
if test "$inverte" = 1
then
    lista=$(echo"$lista" | tac)
# converte paea maiúsculas (se necessários)
if test "$maiusculas" = 1
then
    lista=$(echo "$lista" | tr a-z A-Z)
fi        
# Mostra o resultado para o usuário
echo "$lista" | tr : \\t
