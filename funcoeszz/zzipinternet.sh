# ----------------------------------------------------------------------------
# http://www.whatismyip.com
# Mostra o seu número IP (externo) na Internet
# Uso: zzipinternet
# Ex.: zzipinternet
# ----------------------------------------------------------------------------
zzipinternet ()
{
  zzzz -h ramones $1 && return
  local url='http://aurelio.net/doc/misc/ramones.txt'
  local cache=$ZZTMP.ramones
  local padrao=$1

  # Se o cache está vazio, baixa listagem da Internet
  if ! test -s "$cache"
  then
    $ZZWWWDUMP "$url" > "$cache"
  fi
  # Mostra uma linha qualquer (com o padrão, se informado)
  zzlinha -t "${padrao:-.}" "$cache"
}