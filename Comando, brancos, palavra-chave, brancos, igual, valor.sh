Arquivo: vimrc
Programa: Vim (Editor de textos)
Detalhes: Utiliza as aspas como caractere de comentário, podendo aparecer
também no meio da linha. Cada linha de configuração é um comando. Não
são permitidos brancos ao redor do sinal de igual. Algumas palavras-chave
possuem valores, outras não.
set aw
set ai
set ts=4
set report=0
set shm=filmnrwxt
set et
retab
"AutoWrite: gravacao automatica a cada alteracao
"AutoIndent: identacao automatica
"TabStop: numero de caracteres de avanco do TAB
"reporta acoes com linhas
"SHortMessages: encurta as mensagem do rodape
"ExpandTab: troca TABs por espacos
"converter os TABs ja existentes