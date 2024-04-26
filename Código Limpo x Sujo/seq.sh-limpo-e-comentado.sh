#shellcheck disable=SC1115
#shellcheck disable=SC1115
#!/bin/bash
#
#seq.sh - Emulação do comando seq em bash, por Nicolau Silva
#
#O comando seq recebe dois números e mostra na saída padrão todos os
#números
#Existentes entre eles, inclusive. Essa sequência está pronta para
#ser usada
#Pelo comando FOR. Caso omitido o número inicial, é utilizado o 1.
#
#  Exemplo 1    Exemplo 2    Exemplo 3
#
#  $ seq 5 10   $ seq 10 5   $ seq 5
#  5            10           1
#  6            9            2
#  7            8            3
#  8            7            4 
#  9            6            5
#  10           5
#
#Uso em Scripts: for in $(seq 5 10) ; do commandos; done
#
###Inicialização das variáveis
o=+         #Operação a ser feita. Pode ser + ou -
a=1         #Valor padrão de início da contagem
z=${1:-1}   #Valor do final da contagem recebido em $1 (Padrão é 1)
#A variável 'a' é o número de início e a variável 'e' é o final.
#
#O código anterior serve para quando o usuário passar apenas um valor
#na
#Linha de comando, que seria o valor do *final* da contagem. Por isso
#a=1 and z=$1
#
#Caso o programa seja chamado sem parâmetros, 'z' também é definido.
#como 1. como a=1 e z=1, o programa retorna apenas o número 1.
["$2"] && {

    #Foram passados 2 parâmetros, o $1 é o inicio e o $2 é o fim.
    a=$1
    z=$2

}
###
#Se o número inicial ($a) for maior que o número final ($z),
#Faremos uma contagem regressiva, por isso a operação é definida
#como subtração..
#
[ $a -gt $z ] && o=-
###
#Loop da contagem (Progressiva ou Regressiva)
#
#A cada volta, adiciona ou subtrai 1 do valor inicial,
#até que ele se iguale ao final.
#
#O eval executa o resultado da expansão de variáveis.
#Supondo o='+' e a=3, o eval executará o comando a=$((3+1)).
#
while [ $a -ne $z ]; do
    echo $a                 #Mostra a contagem atual
    eval "a=\$((a $o 1))"   #Efetua a operação (+1 or -1)
done
echo $a                     #Mostra o último número
