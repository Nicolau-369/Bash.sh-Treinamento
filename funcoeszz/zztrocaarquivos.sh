# ----------------------------------------------------------------------------
# Troca o conteúdo de dois arquivos, mantendo suas permissões originais
# Uso: zztrocaarquivos arquivo1 arquivo2
# Ex.: zztrocaarquivos /etc/fstab.bak /etc/fstab
# ----------------------------------------------------------------------------
zztrocaarquivos ()
{
  zzzz -h trocaarquivos $1 && return

  # Um terceiro arquivo é usado para fazer a troca
  local tmp="$ZZTMP.trocaarquivos.$$"
  # Verificação dos parâmetros
  [ "$#" -eq 2 ] || { zztool uso trocaarquivos; return; }
  # Verifica se os arquivos existem
  zztool arquivo_legivel "$1" || return
  zztool arquivo_legivel "$2" || return
  # A dança das cadeiras
  cat "$2"  > "$tmp"
  cat "$1"  > "$2"
  cat "$tmp" > "$1"

  # E foi
  rm "$tmp"
  echo "Feito: $1 <-> $2"
}