#!/bin/bash
#usuarios.sh
#
#Mostra os logins e nomes de usuários do Sistema
#Obs.: Lê dados do arquivo /etc/passwd
#
#Nicolau, Fevereiro de 2024
#
cut -d : -f 1,5 /etc/passwd | tr : \\t
