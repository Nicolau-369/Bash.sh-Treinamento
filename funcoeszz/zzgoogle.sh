# -----------------------------------------------------------------------------
# http://google.com
# Retorna apenas os títulos e links do resultado da pesquisa no Google
# Uso: zzgoogle [-n <número>] palavra(s)
# Ex.: zzgoogle receita de bolo de abacaxi
#      zzgoogle -n 5 ramones papel higiênico cachorro
#  ----------------------------------------------------------------------------
zzgoogle ()
{
  zzzz -h google $1 && return
  local padrao
  local limite=10
  local url='http://www.google.com.br/search'
  # Opções de linha de comando
  if [ "$1" = '-n' ]
  then
      limite=$2
      shift 2
  fi
  # Verificação dos parâmetros
  [ "$1" ] || { zztool uso google; return; }
  # Prepara o texto a ser pesquisado
  padrao=$(echo "$*" | sed "$ZZSEDURL")
  [ "$padrao" ] || return 0

  # Pesquisa, baixa os resultados e filtra
  $ZZWWWHTML "$url?q=$padrao&num=$limite&ie=ISO-8859-1&hl=pt-BR" |
      sed '/<div class=g>/!d ; s/class=g/&\ /g' |
      sed -n 's|^><a href="\([^"]*\)" class=l>\(.*\)</a><table.*|\2\  \1\ |p' |
      sed 's/<[^>]*>//g'
}
