# ----------------------------------------------------------------------------
# Conversão de letras entre minúsculas e MAIÚSCULAS, inclusive acentuadas
# Uso: zzmaiusculas [arquivo]
#      zzminusculas [arquivo]
# Ex.: zzmaiusculas /etc/passwd
#      echo NÃO ESTOU GRITANDO | zzminusculas
# ----------------------------------------------------------------------------
zzminusculas ()
{
  zzzz -h minusculas $1 && return

  sed '
      y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/
      y/ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÇÑ/àáâãäåèéêëìíîïòóôõöùúûüçñ/' "$@"
}

zzmaiusculas ()
{
  zzzz -h maiusculas $1 && return

  sed '
      y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/
      y/àáâãäåèéêëìíîïòóôõöùúûüçñ/ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÇÑ/' "$@"
}