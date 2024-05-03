# ----------------------------------------------------------------------------
# Faz cálculos com horários
# A opção -r torna o cálculo relativo à primeira data, por exemplo:
#   02:00 - 03:30 = -01:30 (sem -r) e 22:30 (com -r)
# Uso: zzhora [-r] hh:mm [+|- hh:mm]
# Ex.: zzhora 8:30 + 17:25        # preciso somar duas horas!
#      zzhora 12:00 - agora       # quando falta para o almoço?
#      zzhora -12:00 + -5:00      # horas negativas!!!
#      zzhora 1000                # quanto é 1000 minutos?
#      zzhora -r 5:30 - 8:00      # que horas ir dormir para acordar ás 5:30?
#      zzhora -r agora + 57:00    # e daqui 57 horas, será quando?
# ----------------------------------------------------------------------------
zzhora ()
{
  zzzz -h hora $1 && return
  local hhmm1 hhmm2 operacao
  local hh1 mm1 hh2 mm2 n1 n2 resultado negativo
  local horas minutos dias horas_do_dia hh mm hh_dia extra
  local relativo=0
  # Opções de linha de comando
  [ "$1" = '-r' ] && {
    relativo=1
    shift
}
  # Verificação dos parâmetros
  [ "$1" ] || { zztool uso hora; return; }

  # Dados informados pelo usuário (com valores padrão)
  hhmm1="$1"
  operacao="${2:-+}"
  hhmm2="${3:-00}"

  # Somente adição e subtração são permitidas
  if [ "${operacao#[+-]}" ]
  then
      echo "Operação Inválida: $operacao"
      return
  fi

  # Atalhos bacanas para a hora atual
  [ "$hhmm1" = 'agora' -o "$hhmm1" = 'now' ] && hhmm1=$(date +%H:%M)
  [ "$hhmm2" = 'agora' -o "$hhmm2" = 'now' ] && hhmm2=$(date +%H:%M)

  # Se as horas não foram informadas, coloca 00
  [ "${hhmm1#*:}" = "$hhmm1" ] && hhmm1=00:$hhmm1
  [ "${hhmm2#*:}" = "$hhmm2" ] && hhmm2=00:$hhmm2

  # Extrai horas e minutos para variáveis separadas
  hh1=${hhmm1%:*}
  mm1=${hhmm1#*:}
  hh2=${hhmm2%:*}
  mm2=${hhmm2#*:}

  # Retira o zero das horas e minutos menores que 10
  hh1=${hh1#0}
  mm1=${mm1#0}
  hh2=${hh2#0}
  mm2=${mm2#0}

  # Os cálculos são feitos utilizando apenas minutos.
  # Então é preciso converter as horas:minutos para somente minutos.
  n1=$((hh1*60+mm1))
  n2=$((hh2*60+mm2))

  # Tudo certo, hora de fazer o cálculo
  resultado=$(($n1 $operacao $n2))

  # Resultado negativo, seta a flag e remove o sinal de menos "-"
  if [ $resultado -lt 0 ]
  then
      negativo=-
      resultado=${resultado#-}
  fi

  # Agora é preciso converter o resultado para o formato hh:mm
  horas=$((resultado/60))
  minutos=$((resultado%60))
  dias=$((horas/24))
  horas_do_dia=$((horas%24))

  # Restaura o zero dos minutos/horas menores que 10
  hh=$horas
  mm=$minutos
  hh_dia=$horas_do_dia
  [ $hh -le 9 ] && hh=0$hh
  [ $mm -le 9 ] && mm=0$mm
  [ $hh_dia -le 9 ] && hh_dia=0$hh_dia

  # Decide como mostrar o resultado para o usuário.
  #
  # Relativo:
  #   $ zzhora -r 10:00 + 48:00
  #   10:00 (2 dias)
  #
  # Normal:
  #   $ zzhora 10:00 + 48:00
  #   58:00 (2d 10h 0m)
  #
  if [ $relativo -eq 1 ]
  then

      # Relativo

      # Somente em resultados negativos o relativo é útil.
      # Para valores positivos não é preciso fazer nada.
      if [ "$negativo" ]
      then
          # Para o resultado negativo é preciso refazer algumas contas
          minutos=$(( (60-minutos) % 60))
          dias=$((horas/24 + (minutos>0) ))
          hh_dia=$(( (24 - horas_do_dia - (minutos>0)) % 24))
          mm=$minutos
          # Zeros para dias e minutos menores que 10
          [ $mm -le 9 ] && mm=0$mm
          [ $hh_dia -le 9 ] && hh_dia=0$hh_dia
      fi
      # "Hoje", "amanhã" e "ontem" são simpáticos no resultado
      case $negativo$dias in
          1)
              extra='amanhã'
          ;;
          -1)
              extra='ontem'
          ;;
          0|-0)
              extra='hoje'
          ;;
          *)
              extra="$negativo$dias dias"
          ;;
      esac
      echo "$hh_dia:$mm ($extra)"
else

      # Normal

      echo "$negativo$hh:$mm (${dias}d ${horas_do_dia}h
${minutos}m)"
  fi
}