# ----------------------------------------------------------------------------
# Mostra informações sobre as funções, como versão e localidade
# Com a opção --atualiza, baixa a versão mais nova das funções
# Com a opção --bashrc, "instala" as funções no ~/.bashrc
# Com a opção --tcshrc, "instala" as funções no ~/.tcshrc
# Com a opção --tcshrc, "instala" as funções no ~/.tcshrc
# Uso: zzzz [--atualiza|--bashrc|--tcshrc]
# ----------------------------------------------------------------------------
zzzz ()
{
  local nome_func arg_func padrao
  local info_instalado info_cor versao_local versao_remota
  local arquivo_aliases arquivo_zz extra
  local bashrc="$HOME/.bashrc"
  local tcshrc="$HOME/.tcshrc"
  local url_site='http://funcoeszz.net'
  local url_exe="$url_site/funcoeszz"
  local instal_msg="Instalacao das Funcoes ZZ
(http://funcoeszz.net)"
  # A versão atual das funções é extraída direto do Changelog
  if test -f "$ZZPATH"
  then
    versao_local=$(
        sed -n '/^$/q;s/^# 200\(.\)\(..\).*/\1.\2/p' $ZZPATH |
        sed '$!d;s/\.0/./'
    )
  fi
   case "$1" in
      # Atenção: Prepare-se para viajar um pouco que é meio complicado :)
      #
      # Todas as funções possuem a opção -h e --help para mostrar um
      # texto rápido de ajuda. Normalmente cada função teria que
      # implementar o código para verificar se recebeu uma destas opções
      # e caso sim, mostrar o texto na tela. Para evitar a repetição de
      # código, estas tarefas estão centralizadas aqui.
      # Chamando a zzzz com a opção -h seguido do nome de uma função e
      # seu primeiro parâmetro recebido, o teste é feito e o texto é
      # mostrado caso necessário.
      #
      # Assim cada função só precisa colocar a seguinte linha no início:
      #
      #     zzzz -h beep $1 && return
      # Ao ser chamada, a zzzz vai mostrar a ajuda da função zzbeep caso
      # o valor de $1 seja -h ou --help. Se no $1 estiver qualquer outra
      # opção da zzbeep ou argumento, nada acontece.
      # Com o "&& return" no final, a função zzbeep pode sair imediatamente
      # caso a ajuda tenha sido mostrada (retorno zero), ou continuar seu
      # processamento normal caso contrário (retorno um).
      # Se a zzzz -h for chamada sem nenhum outro argumento, é porque o
      # usuário quer ver a ajuda da própria zzzz.
      # Nota: Ao invés de "beep" literal, poderíamos usar $FUNCNAME, mas
      #       o Bash versão 1 não possui essa variável.
      -h | --help)

            nome_func=${2#zz}
            arg_func=$3

            # Nenhum argumento, mostre a ajuda da própria zzzz
            if ! [ "$nome_func" ]
            then
              nome_func='zz'
              arg_func='-h'
            fi
            # Se o usuário informou a opção de ajuda, mostre o texto
            if [ "$arg_func" = '-h' -o "$arg_func" = '--help' ]
            then
              padrao="Uso: [^ ]*zz$nome_func \{0,1\}"
              # Um xunxo bonito: filtra a saída da zzajuda, mostrando
              # apenas a função informada.
              zzajuda |
                grep -C9 "^$padrao\b" |
                sed -e ':a' -e '$bz' -e 'N;ba' -e ':z' \
                    -e "s/.*\n---*\(\n\)\(.*$padrao\)/\1\2/;s/\(\n\)---.*/\1/"
              return 0
            else
              # Alarme falso, o argumento não é nem -h nem --help
              return 1
            fi
      ;;
    # Garantia de compatibilidade do -h com o formato antigo (-z):
    # zzzz -z -h zzbeep
    -z)
      zzzz -h $3 $2
    ;;
   # Baixa a versão nova, caso diferente da local
   --atualiza)
     echo "Procurando a versão nova, aguarde."
     versao_remota=$(
        $ZZWWWDUMP "$url_site" |
        sed -n 's/.*versão atual \([0-9.]\{1,\}\).*/\1/p'
     )
       echo "versão local : $versao_local"
       echo "versão remota: $versao_remota"
       echo
        # Aborta caso não encontrou a versão nova
        [ "$versao_remota" ] || return
        # Compara e faz o download
        if [ "$versao_local" != "$versao_remota" ]
        then
          echo -n 'Baixando a versão nova... '
          $ZZWWWHTML "$url_exe" > "funcoeszz-$versao_remota"
          echo 'PRONTO!'
          echo "Arquivo 'funcoeszz-$versao_remota' baixado, instale-o manualmente."
          echo "O caminho atual é $ZZPATH"
        else
          echo 'Você já está com a versão mais recente.'
        fi
   ;;
   # Instala as funções no arquivo .bashrc
   --bashrc)
     if ! grep -qs "^[^#]*${ZZPATH:-zzpath_vazia}" "$bashrc"
     then
       (
        echo
        echo "# $instal_msg"
        echo "source $ZZPATH"
        echo "export ZZPATH=$ZZPATH"
       ) >> "$bashrc"

       echo 'Feito!'
       echo "As Funções ZZ foram instaladas no $bashrc"
     else
       echo "Nada a fazer. As Funções ZZ já estão no $bashrc"
       fi
     ;;
   # Cria aliases para as funções no arquivo .tcshrc
   --tcshrc)
     arquivo_aliases="$HOME/.zzcshrc"

     # Chama o arquivo dos aliases no final do .tcshrc
     if ! grep -qs "^[^#]*$arquivo_aliases" "$tcshrc"
     then
       (
        echo
        echo "# $instal_msg"
        echo "source $arquivo_aliases"
        echo "setenv ZZPATH $ZZPATH"
       ) >> "$tcshrc"
         echo 'Feito!'
         echo "As Funções ZZ foram instaladas no $tcshrc"
     else
       echo "Nada a fazer. As Funções ZZ já estão no $tcshrc"
     fi

     # Cria o arquivo de aliases
      echo > $arquivo_aliases
      for func in $(ZZCOR=0 zzzz | sed '1,/^(( fu/d; /^(/d;s/,//g')
      do
        echo "alias zz$func 'funcoeszz zz$func'" >> "$arquivo_aliases"
        done
        echo
        echo "Aliases atualizados no $arquivo_aliases"
      ;;
    # Mostra informações sobre as funções
    *)
      # As funções estão configuradas para usar cores?
      [ "$ZZCOR" = '1' ] && info_cor='sim' || info_cor='não'

      # As funções estão instaladas no bashrc?
      if grep -qs "^[^#]*${ZZPATH:-zzpath_vazia}" "$bashrc"
      then
          info_instalado="$bashrc"
      else
          info_instalado='não instalado'
      fi

      # Informações, uma por linha
      zztool eco "( local)\c"
      echo " $ZZPATH"
      zztool eco "(versão)\c"
      echo " $versao_local"
      zztool eco "( cores)\c"
      echo " $info_cor"
      zztool eco "(   tmp)\c"
      echo " $ZZTMP"
      zztool eco "(bashrc)\c"
      echo " $info_instalado"
      zztool eco "(extras)\c"
      echo " ${ZZEXTRA:-nenhum}"
      zztool eco "( site)\c"
      echo " $url_site"

      # Lista de todas as funções
      for arquivo_zz in "$ZZPATH" "$ZZEXTRA"
      do
          if [ "$arquivo_zz" -a -f "$arquivo_zz" ]
          then
              echo
              zztool eco "(( funções disponíveis ${extra:+EXTRA}))"
              # Nota: zzzz --tcshrc procura por " fu"
              # Sed mágico que extrai e formata os nomes de funções
              # limitando as linhas em 50 colunas
              sed -n '/^zz\([a-z0-9]\{1,\}\) *(.*/s//\1/p'
              "$arquivo_zz" |
                                sort |
                                sed -e ':a' -e '$b' -e 'N; s/\n/, /; /.\ {50\}/{p;d;};ba'
              # Flag tosca para identificar a segunda volta do
              loop
              extra=1
          fi
      done
      ;;
    esac
}