#!/bin/bash
#
#mensagem.sh
#Mostra uma mensagem colorida na tela, lendo os
#Dados de um arquivo de configuração externo.
#
#2024-03-07 Nicolau Salvatore
CONFIG="mensagem.conf"      #Arquivo de configuração
#Configurações (serão lidas $CONFIG)
USAR_CORES=0                #config: UsarCores
COR_LETRA=                  #config: CorLetra
COR_FUNDO=                  #config: CorFundo
MENSAGEM='Mensagem padrão'  #config: Mensagem
#Loop para ler linha a linha a configuração, guardando em $LINHA
while read LINHA; do
    #Comando vazio, que não faz nada
    :
done < "$CONFIG"
    
