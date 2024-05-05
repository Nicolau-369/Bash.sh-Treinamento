# -------------------------------------------------------------------
# http://... - vários
# Busca as últimas notícias sobre linux em páginas nacionais
# Obs.: Cada página tem uma letra identificadora que pode ser passada como
#       parâmetro, identificando quais páginas você quer pesquisar:
#
#       Y)ahoo Linux        B)r Linux
#       C)ipsga             N)otícias linux
#       V)iva o Linux       U)nder linux
#
# Uso: zznoticiaslinux [sites]
# Ex.: zznoticiaslinux
#      zznoticiaslinux yn
# -------------------------------------------------------------------
zznoticiaslinux ()
{
  zzzz -h noticiaslinux $1 && return
  local url limite
  local n=5
  local sites='byvucin'
  limite="sed ${n}q"
  [ "$1" ] && sites="$1"
  # Yahoo
  if zztool grep_var y $sites
  then
      url='http://br.news.yahoo.com/tecnologia/linux'
      echo
      zztool eco "* Yahoo Linux ($url):"
      $ZZWWWHTML "$url" |
          sed -n '
              /topheadline/ {
                  n
                  s,</a>.*,,
                  s/<[^>]*>//gp
              }
              /clearfix/ {
                    n
                  s/<[^>]*>//gp
              }' |
          sed 's/^[[:blank:]]*//' |
          $limite
  fi

  # Viva o Linux
  if zztool grep_var v $sites
  then
      url='http://www.vivaolinux.com.br'
      echo
      zztool eco "* Viva o Linux ($url):"
      $ZZWWWHTML "$url/index.rdf" |
          sed -n '1,/<item>/d;s@.*<title>\(.*\)</title>@\1@p' |
          $limite
  fi

  # Cipsga
  if zztool grep_var c $sites
   then
      url='http://www.cipsga.org.br'
      echo
      zztool eco "* CIPSGA ($url):"
      $ZZWWWHTML "$url" |
          sed '/^.*<tr><td bgcolor="88ccff"><b>/!d;s///;s@</b>.*@@' |
          $limite
   fi

   # Br Linux
   if zztool grep_var b $sites
   then
        url='http://br-linux.org/rss/brlinux-iso.xml'
        echo
        zztool eco "* BR Linux ($url):"
        $ZZWWWDUMP "$url" |
            sed -n '1,/<item>/d;s@.*<title>\(.*\)</title>@\1@p' |
            $limite
   fi

   # UnderLinux
  if zztool grep_var u $sites
  then
      url='http://under-linux.org/feed'
      echo
      zztool eco "* UnderLinux ($url):"
      $ZZWWWDUMP "$url" |
          sed -n '1,/<item>/d;s@.*<title>\(.*\)</title>@\1@p' |
          $limite
  fi

  # Notícias Linux
  if zztool grep_var n $sites
  then
      url='http://www.noticiaslinux.com.br'
      echo
      zztool eco "* Notícias Linux ($url):"
      $ZZWWWHTML "$url" |
          sed -n '/<[hH]3>/{s/<[^>]*>//g;s/^[[:blank:]]*//g;p;}' |
          $limite
   fi
}