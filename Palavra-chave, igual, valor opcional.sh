Arquivo: lilo.conf
Programa: LILO (Gerenciador de inicialização)
Detalhes: Possui seções sequenciais (a ordem importa) iniciadas pela palavra
other. Os espaços ao redor do sinal de igual são opcionais. Algumas
palavras-chave não precisam de valores. Palavras-chave em minúsculas.
boot = /dev/hda
map = /boot/map
timeout = 500
prompt
    vga = normal
    read-only
other = /dev/hda1
    label = win
other = /dev/hda2
label = linux