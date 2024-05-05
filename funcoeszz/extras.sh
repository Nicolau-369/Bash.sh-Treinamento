# --------------------------------------------------
## Incluindo as funções extras
[ "$ZZEXTRA" -a -f "$ZZEXTRA" ] && source "$ZZEXTRA"
# --------------------------------------------------
## Lidando com a chamada pelo executável
# Se há parâmetros, é porque o usuário está nos chamando
if [ "$1" ]
then
  case "$1" in
  # Mostra a tela de ajuda
  -h | --help)

    cat - <<-FIM
        Uso: funcoeszz <função> [<parâmetros>]
             funcoeszz <função> --help
        Dica: Inclua as funções ZZ no seu login shell,
              e depois chame-as diretamente pelo nome:
          prompt$ funcoeszz zzzz --bashrc
          prompt$ source ~/.bashrc
          prompt$ zz<TAB><TAB>
          Obs.: funcoeszz zzzz --tcshrc também funciona
        Lista das funções:
              prompt$ funcoeszz zzzz
   FIM
    ;;
  # Mostra a versão das funções
  -v | --version)
  echo -n 'Funções ZZ v'
  zzzz | sed '/versã/!d ; s/.* //'
  ;;

  # Chama a função informada, caso ela exista
  *)

    func="zz${1#zz}" # o prefixo zz é opcional

    if type $func >&- 2>&- # a função existe?

    then
        shift
        $func "$@"
    else
        echo "Função inexistente '$func' (tente --help)"
    fi
  ;;
  esac
fi