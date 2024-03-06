Arquivo: httpd.conf
Programa: Apache (Servidor HTTP)
Detalhes: Usa o caractere [#] para comentários, espaços em branco separam a
palavra-chave de seu valor, que pode estar ou não entre aspas. Preferência
por palavras-chaves iniciadas por maiúsculas, SempreGrudadas.
#
#Timeout: The number of seconds before receives and sends time out.
#
Timeout 300
#
#ServerAdmin: Your address, where problems with the server should be
#e-mailed. This address appears on some server-generated pages, such
#as error documents.
#
ServerAdmin root@localhost
#
#DocumentRoot: The directory out of which you will server your
#documents. By default, all requests are taken from this directory,
#but symbolic links and aliases may be used to point to other
#locations.
#
DocumentRoot "/var/www/default"