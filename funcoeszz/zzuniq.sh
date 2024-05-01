# ----------------------------------------------------------------------------
# Retira as linhas repetidas (consecutivas ou não)
# Útil quando não se pode alterar a ordem original das linhas,
# então o tradicional sort|uniq falha.
# Uso: zzuniq [arquivo]
# Ex.: zzuniq /etc/inittab
#     cat /etc/inittab | zzuniq
# ----------------------------------------------------------------------------
zzuniq ()
{
  zzzz -h uniq $1 && return
  # As linhas do arquivo são numeradas para guardar a ordem original
  cat -n "${1:--}" | # Numera as linhas do arquivo
      sort -k2     | # Ordena ignorando a numeração
      uniq -f1     | # Remove duplicadas, ignorando a numeração
      sort -n      | # Restaura a ordem original
      cut -f2-       # Remove a numeração
}