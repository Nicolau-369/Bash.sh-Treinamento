##############################################################################
#
#                                   Configuração
#                                   ------------
#
### Configuração via variáveis de ambiente
#
# Algumas variáveis de ambiente podem ser usadas para alterar o comportamento
# padrão das funções. Basta defini-las em seu .bashrc ou na própria linha de
# comando antes de chamar as funções. São elas:
#
#     $ZZCOR      - Liga/Desliga as mensagens coloridas (1 e 0
#     $ZZPATH     - Caminho completo para o arquivo das funções
#     $ZZEXTRA    - Caminho completo para o arquivo com funções adicionais
#     $ZZTMPDIR   - Diretório para armazernar arquivos temporários
#
# Nota: Se você é paranoico com segurança, configure a ZZTMPDIR para
#       um diretório dentro do seu HOME.
### Configuração fixa neste arquivo (hardcode)
#
# A configuração também pode ser feita diretamente neste arquivo, se você
# puder fazer alterações nele.
#
ZZCOR_DFT=1                       # colorir mensagens? 1 liga, 0
  desliga
ZZPATH_DFT="/usr/bin/funcoeszz"   # rota absoluta deste arquivo
ZZEXTRA_DFT="$HOME/.zzextra"      # rota absoluta do arquivo de extras
ZZTMPDIR_DFT="${TMPDIR:-/tmp}"    # diretório temporário
#
#
#
#                               Inicialização
#                               -------------
#
#
# Variáveis auxiliares usadas pelas funções ZZ.
# Não altere nada aqui.
#
#
ZZWWWDUMP='lynx -dump         -nolist -crawl -width=300 - accept_all_cookies'
ZZWWWLIST='lynx -dump                        -width=300 - accept_all_cookies'
ZZWWWPOST='lynx -post-data    -nolist -crawl -width=300 - accept_all_cookies'
ZZWWWHTML='lynx -source'
ZZCODIGOCOR='36;1'            # use zzcores para ver os códigos
ZZFAQ='http://funcoeszz.net/download.html#problemas'
ZZERDATA='[0-9][0-9]\/[0-9][0-9]\/[0-9]\{4\}'; # dd/mm/aaa ou mm/dd/aaaa
ZZERHORA='[012][0-9]:[0-9][0-9]'
ZZERIP='\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}'   # 0.0.0.0 > 999.999.999.999
ZZSEDURL='s| |+|g;s|&|%26|g;s|@|%40|g'
#
### Truques para descobrir a localização deste arquivo no sistema
# Se a chamada foi pelo executável, o arquivo é o $0.
# Senão, tenta usar a variável de ambiente ZZPATH, definida pelo usuário.
# Caso não exista, usa o local padrão ZZPATH_DFT.
# Finalmente, força que ZZPATH seja uma rota absoluta.
#
[ "${0##*/}" = 'bash' -o "${0#-}" != "$0" ] || ZZPATH="$0"
[ "$ZZPATH" ] || ZZPATH=$ZZPATH_DFT
[ "$ZZPATH" ] || echo 'AVISO: $ZZPATH vazia. zzajuda e zzzz não funcionarão'
[ "${ZZPATH#/}" = "$ZZPATH" ] && ZZPATH="$PWD/${ZZPATH#./}"
[ "$ZZEXTRA" ] || ZZEXTRA=$ZZEXTRA_DFT
[ -f "$ZZEXTRA" ] || ZZEXTRA=
#
### Últimos ajustes
#
ZZCOR="${ZZCOR:-$ZZCOR_DFT}"
ZZTMP="${ZZTMPDIR:-$ZZTMPDIR_DFT}/zz"
unset ZZCOR_DFT ZZPATH_DFT ZZEXTRA_DFT ZZTMPDIR_DFT
#
#
##############################################################################