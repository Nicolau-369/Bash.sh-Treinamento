# ----------------------------------------------------------------------------
# Miniferramentas para auxiliar as funções
# Uso: zztool ferramenta [argumentos]
# ----------------------------------------------------------------------------
zztool ()
{
  case "$1" in
  uso)
    # Extrai a mensagem de uso da função $2, usando seu --help
    zzzz -h $2 -h | grep Uso
    ;;
  eco)
    shift
    # Mostra mensagem colorida caso $ZZCOR esteja ligada
    if [ "$ZZCOR" != '1' ]
    then
        echo -e "$*"
    else
        echo -e "\033[${ZZCODIGOCOR}m$*"
        echo -ne "\033[m"
    fi
    ;;
  acha)
    # Destaca o padrão $2 no texto via STDIN ou $3
    # O padrão pode ser uma regex no formato BRE (grep/sed)
    local esc=$(echo -ne '\033')
    local padrao=$(echo "$2" | sed 's,/,\\/,g') # escapa /
    shift 2
    zztool multi_stdin "$@" |
        if [ "$ZZCOR" != '1' ]
        then
            cat -
        else
            sed "s/$padrao/$esc[${ZZCODIGOCOR}m&$esc[m/g"
        fi
    ;;
  grep_var)
        # $2 está presente em $3?
        test "${3#*$2}" != "$3"
  ;;
  arquivo_vago)
        # Verifica se o nome de arquivo informado está vago
        if test -e "$2"
        then
            echo "Arquivo $2 já existe. Abortando."
            return 1
        fi
  ;;
  arquivo_legivel)
        # Verifica se o arquivo existe e é legível
        if ! test -r "$2"
        then
            echo "Não consegui ler o arquivo $2"
            return 1
        fi
  ;;
  testa_numero)
        # Testa se $2 é um número positivo
        echo "$2" | grep -qs '^[0-9]\{1,\}$'
  ;;
  testa_numero_sinal)
        # Testa se $2 é um número (pode ter sinal: -2 +2)
        echo "$2" | grep -qs '^[+-]*[0-9]\{1,\}$'
  ;;
  testa_binario)
        # Testa se $2 é um número binário
        echo "$2" | grep -qs '^[01]\{1,\}$'
  ;;
  testa_ip)
        # Testa se $2 é um número IP (nnn.nnn.nnn.nnn)
        local nnn="\([0-9]\{1,2\}\|1[0-9][0-9]\|2[0-4][0-9]\|25[0-5]\)" # 0-255
        echo "$2" | grep -qs "^$nnn\.$nnn\.$nnn\.$nnn$"
  ;;
  multi_stdin)
        # Mostra na tela os argumentos *ou* a STDIN, nesta ordem
        # Útil para funções/comandos aceitarem dados das duas formas:
        #     echo texto | funcao
        # ou
        #     funcao texto
        shift
        if [ "$1" ]
        then
                  echo "$*"
        else
                  cat -
        fi
  ;;
  trim)
      shift
      zztool multi_stdin "$@" |
            sed 's/^[[:blank:]]*// ; s/[[:blank:]]*$//'
  ;;
  esac
}