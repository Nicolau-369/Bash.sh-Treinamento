Arquivo: my.cnf
Programa: MySQL (Banco de dados)
Detalhes: Possui seções iniciadas por marcadores entre [colchetes] que
identificam componentes do banco.
[mysql.server]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
[mysqladmin]
socket=/var/lib/mysql/mysql.sock
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
[mysql]
socket=/var/lib/mysql/mysql.sock