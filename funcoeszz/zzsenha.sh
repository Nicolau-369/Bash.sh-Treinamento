# ----------------------------------------------------------------------------
# Gera uma senha aleatória de N caracteres formada por letras e números
# Obs.: A senha gerada não possui caracteres repetidos
# Uso: zzsenha [n]      (padrão n=6)
# Ex.: zzsenha
#      zzsenha 8
# ----------------------------------------------------------------------------
zzsenha ()
{
  zzzz -h senha $1 && return
  local posicao letra
  local n=6
  local
  alpha="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  local maximo=${#alpha}
  # Guarda o número informado pelo usuário (se existente)
  [ "$1" ] && n=$1
  # Foi passado um número mesmo?
  if ! zztool testa_numero "$n"
  then
    zztool uso senha
    return
  fi
  # Já que não repete as letras, temos uma limitação de tamanho
  if [ $n -gt $maximo ]
  then
    echo "O tamanho máximo da senha é $maximo"
    return
  fi
  # Esquema de geração da senha:
  # A cada volta é escolhido um número aleatório que indica uma
  # posição dentro do $alpha. A letra dessa posição é mostrada na
  # tela e removida do $alpha para não ser reutilizada.
  while [ $n -ne 0 ]
  do
    n=$((n-1))
    posicao=$((RANDOM % ${#alpha} + 1))
    letra=$(echo -n "$alpha" | cut -c$posicao)
    alpha=$(echo $alpha | tr -d $letra)
    echo -n $letra
  done
  echo
}