# ----------------------------------------------------------------------------
# http://www1.caixa.gov.br/loterias
# Consulta os resultados da quina, megasena, duplasena, lotomania e lotofácil
# Uso: zzloteria [quina | megasena | duplasena | lotomania | lotofacil]
# Ex.: zzloteria
#      zzloteria quina megasena
# ----------------------------------------------------------------------------
zzloteria ()
{
  zzzz -h loteria $1 && return
  local dump numero_concurso resultado acumulado tipo
  local url='http://www1.caixa.gov.br/loterias/loterias'
  local tipos="quina megasena duplasena lotomania lotofacil"

  # O padrão é mostrar todos os tipos, mas o usuário pode informar alguns
  [ "$1" ] && tipos=$*
  # Para cada tipo de loteria...
  for tipo in $tipos
  do
    zztool eco $tipo:

    # O resultado da pesquisa (código HTML) é guardado em $dump
    # Depois cada dado desejado é extraído localmente
    dump=$($ZZWWWHTML "$url/$tipo/${tipo}_pesquisa.asp")

    numero_concurso=$(
        echo "$dump" |
        sed -n "s/^\([0-9][0-9]*\)|.*|\($ZZERDATA\)|.*/\1 (\2)/p"
    )
      acumulado=$(
          echo "$dump" |
          sed -n '/ACUMUL/{
              s/.*ACUMUL.* \([0-9/][0-9/: R$.,Mi]*,00\)\..*/Acumulado para \1/
              s/\.\([0-9]\)00\.000,00/.\1 Mi/ ; p ;}'
      )

      # Para obter os números do resultado é mais complicado, varia
      case "$tipo" in
      lotomania)
        resultado=$(
            echo "$dump" |
            sed -n 's/.*[>|]|\(\([0-9][0-9]|\)\{20\}\).*/\1/p' |
            sed 's/|$// ; s/|/@ 10 ; s/|/ - /g' |
            tr @ '\n'
        )
      ;;
      lotofacil)
          resultado=$(
          echo "$dump" |
          sed -n 's/.*[>|]|\(\([0-9][0-9]|\)\{15\}\).*/\1/p' |
          sed 's/|$// ; s/|/@ /10 ; s/|/@ /5 ; s/|/ - /g' |
          tr @ '\n'
        )
      ;;
      *)
        # Tratamento genérico para a maioria dos tipos
        resultado=$(
            echo "$dump" |
            sed -n 's,.*<ul>\(\(<li>[0-9][0-9]*</li>\)*\) </ul>.*,\1,p' |
            sed 's,</li><li>, - ,g ; s,</*li>,,g'
        )
      ;;
    esac
    # Mostra o resultado na tela (caso encontrado algo)
        if [ "$resultado" ]
        then
          echo "    $resultado"
          echo "    Concurso $numero_concurso"
          [ "$acumulado" ] && echo "    $acumulado"
          echo
        fi
    done
}