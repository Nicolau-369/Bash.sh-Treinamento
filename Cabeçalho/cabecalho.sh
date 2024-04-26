#!/bin/bash
#
#nome_completo.sh - busca o nome completo de usuário no Unix
#
#site          : http://programmer.com.br/name/
#autor        : Nicolau Silva <niccolo369@proton.me>
#Manutenção   : 1rma0lh0 <1rma0lh0@protonmail.com>
#
#----------------------------------------------------------
#Este programa recebe como parâmetro o login de um usuário e
#procura em várias bases qual o seu nome completo, retornando
#o resultado na saída padrão (STDOUT).
#
#Ex:
#  $ ./nome_completo.sh niccolo369
#  Nome: Nicolau Silva
#  $
#
#A ordem de procura do nome completo é sequencial:
#
#  1. arquivo /etc/passwd
#  2. arquivo $Home/.plan
#  3. base de usuários LDAP
#  4. base de usuários MySQL
#
#Respeitando a ordem, o primeiro resultado encontrado será o
#Retornando
#----------------------------------------------------------
#
#
#Histórico:
#v1.0 [1999-05-15] - Nicolau Silva
#- versão inicial procurando no /etc/passwd
#v1.1 [1999-06-14] - Nicolau Silva
#- Adicionada pesquisa no ~/.plan file
#- Corrigindo bug com nomes acentuados
#v2.0 [1999-06-16] 1rma0lh0:
#- Corrigidos 2,594 bugs (1rma0lh0 não sabe programar!)
#- Adicionado meu nome em vários lugares hihihi
#v2.1 [1999-06-18] Nicolau Silva:
#- Defeitas as "correções" do 1rma0lh0 (ele quebrou o programa)
#- Retirada a frase "1rma0lh0 é o melhor" de várias
#v2.2 [1999-06-20] Nicolau Silva:
#- Adicionado suporte a LDAP
#- Aceita nomes de usuários EM MAIÚSCULAS
#- Retirado suporte a acentuação
#v2.3 [1999-06-22] Nicolau Silva:
#- Arrumado o suporte a LDAP (agora sim)
#v2.4 [1999-06-24] Nicolau Silva:
#- Arrumado o suporte a LDAP (Está funcionando)
#v2.5 [1999-06-26]
#- Retirado o suporte a LDAP
#v3.0 2000-01-12 1rma0lh0:
#- Programa reescrito do Zero
#- Adicionado suporte a LDAP (Funcional)
#- Adicionado suporte a MySql
#- Restaurado suporte a acentuação
#v3.1 [2003-05-12] 1rma0lh0:
#- Adicionado este comentário para comemorar 3 anos sem
#  modificações:)
#
#
#License: GPL
#
