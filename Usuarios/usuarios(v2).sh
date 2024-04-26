#!/bin/bash
#usuarios.sh
#
#Mostra os logins e nomes de usuários do Sistema
#Obs.: Lê dados do arquivo /etc/passwd
#
#Versão 1: Mostra usuários e nome separados por TAB
#Versão 2: Adicionado suporte à opção -h
#
#Nicolau, Fevereiro de 2024
#
MENSAGEM_USO="
Uso: $0 [-h]
    -h    Mostra esta tela de ajuda e sai
"
#Treinamento das opções de linha de comando
if test "$1" = "-h" 
then
    echo 
    exit 0
fi
#Processamento
cut -d : -f 1,5 /etc/passwd | tr : \\t         
