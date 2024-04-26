Arquivo: sysctl.conf
Programa: sysctl (Configura parâmetros do kernel)
Detalhes: Palavra-chave tipo programação orientada a objeto, no formato
módulo.componente. Utiliza os valores 0 (zero) e 1 para desligar e ligar uma
opção. Comentários podem iniciar por # ou ponto e vírgula. Os brancos ao
redor do sinal de igual são opcionais.
# If active, logs 'impossible' source addresses
net.ipv4.conf.all.log_martians = 1
# If active, rewrites outgoing IP packets if address changes
net.ipv4.ip_dynaddr = 1
# If active, ignores ICMP with broadcast destination
net.ipv4.icmp_echo_ignore_broadcasts = 1
# If active, accepts IP packets with source route info
net.ipv4.conf.all.accept_source_route = 0
# If active, ignores all ICMP requests
net.ipv4.icmp_echo_ignore_all = 0