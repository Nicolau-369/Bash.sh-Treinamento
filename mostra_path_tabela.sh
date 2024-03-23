#!/bin/bash
# mostra_path_tabela.sh
# Vamos mostrar uma página HTML
echo Content-type: text/html
echo
# Adiciona um diretório falso ao PATH
PATH=$PATH:/noel
# Título da página
echo "<h1>Componentes de seu PATH</h1>"
# Inicia a tabela
echo '<TABLE BORDER="1" CELLSPACING="0" CELLPADDING="5">'
# Para cada pasta do $PATH...
IFS=:
for pasta in $PATH; do
    # Confirme se ela existe
    if test -d $pasta; then
    extra='<FONT COLOR="green">existe</FONT>'
    else
    extra='<FONT COLOR="red">não existe</FONT>'
    fi
    # E mostre o resultado na tela (linha da tabela)
    echo "<TR><TD>$pasta</TD><TD>$extra</TD></TR>"
done
# Fecha a tabela
echo "</TABLE>"