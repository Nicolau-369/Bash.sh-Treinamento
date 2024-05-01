# ----------------------------------------------------------------------------
# Mostra uma tela de ajuda com explicação e sintaxe de todas as funções
# Uso: zzajuda
# ----------------------------------------------------------------------------
zzajuda ()
{
  zzzz -h ajuda $1 && return
  # Salva a configuração original de cores
  local zzcor_orig=$ZZCOR
  # Desliga cores para os paginadores antigos
  if [ "$PAGER" = 'less' -o "$PAGER" = 'more' ]
  then
    ZZCOR=0
  fi
  # Mostra ajuda das funções padrão e das extras
  cat $ZZPATH $ZZEXTRA |
      # Magia negra para extrair somente os textos de descrição
      sed '
          1 {
              s/.*/** Ajuda das funções ZZ (tecla Q sai)/
              G
              P
          }
          /^# --*$/,/^# --*$/ {
              s/-\{20,\}/-------/
              s/^# //p
          }
          d'  |
      uniq |
      sed "s/^-\{7\}/&&&&&&&&&&&/" |
      zztool acha 'zz[a-z0-9]\{2,\}' |
      ${PAGER:-less -r}
      # Restaura configuração de cores
      ZZCOR=$zzcor_orig
}