Arquivo: lpd.conf
Programa: lpd (Servidor de impressão)
Detalhes: É preciso colocar um @ no final da palavra-chave para desligá-la.
# Purpose: open the printer for reading and writing
#
default rw@ (FLAG off)
# Purpose: save job when an error
#
default save_on_error@ (FLAG off)
# Purpose: save job when done
#
default save_when_done@ (FLAG off)
# Purpose: send block of data, rather than individual files
#
default send_block_format@ (FLAG off)
# Purpose: send data files first, then control file
#
default send_data_first@ (FLAG off)