# -------------------------------------------------------------------
# http://br.invertia.com
# Busca a cotação do dia do dólar (comercial, paralelo e turismo)
# Obs.: As cotações são atualizadas de 10 em 10 minutos
# Uso: zzdolar
# -------------------------------------------------------------------
zzdolar ()
{
  zzzz -h dolar $1 && return
  $ZZWWWDUMP
'http://br.invertia.com/mercados/divisas/tiposdolar.aspx' |
  sed '
      # Você acredita que essa sopa de letrinhas funciona?
      # Pois é, eu também não... Mas funciona :)
      s/^ *//
      /Data:/,/Turismo/!d
      /percent/d
      s/ */ /g
      s/.*Data: \(.*\)/\1 compra  venda hora/
      s|^[1-9]/|0&|
      s@^\([0-9][0-9]\)/\([0-9]/\)@\1/0\2@
      s/^D.lar //
      s/- Corretora//
      s/ SP//g
      s/ [-+]\{0,1\}[0-9.,]\{1,\}   *%$//
      s/al /& /
      s/lo /&   /
      s/mo /&     /
      s/ \([0-9]\) / \1.000 /
      s/\.[0-9]\>/&0/g
      s/\.[0-9][0-9]\>/&0/g
      /^[^0-9]/s/[0-9] /& /g' |
  sed '/^Compra/d'
}