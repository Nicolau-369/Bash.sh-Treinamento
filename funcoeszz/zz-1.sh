#!/bin/bash
# funcoeszz
# INFORMAÇÕES: http://funcoeszz.net
# NASCIMENTO : 22 fevereiro 2000
# AUTORES    : Aurelio Marinho Jargas <verde (a) aurelio net>
#              Thobias Salazar Trevisan <thobias (a) thobias org>
# DESCRIÇÃO  : Funções de uso geral para o shell Bash, que buscam informações
#              em arquivos locais e fontes na Internet
# REGISTRO DE MUDANÇAS:
# 20000222 ** 1a versão
# 20000424 ++ cores, beep, limpalixo, rpmverdono
# 20000504 ++ calcula, jpgi, gifi, trocapalavra, ajuda, echozz, forzz
# 20000515 ++ dominiopais, trocaextensao, kill, <> $* > "$@"
#          -- jpgi, gifi: o identify já faz
# 20000517 <> trocapalavra -> basename no $T
# 20000601 -- dicbabel: agora com session &:(
# 20000612 ++ celulartim, trocaarquivo
... removidas centenas de linhas para poupar as árvores;
# 20061114 ++ zzfoneletra (valeu rodolfo)
#          <> dicabl: URL e filtro atualizados (valeu sartini)
#          <> dicasl: URL e filtro atualizados
#          <> dicportugues: filtro atualizado (BSD)
#          <> dolar: filtro atualizado (BSD)
#          <> dominiopais: URL e filtro atualizados
#          <> google: filtro atualizado
#          <> howto: filtro atualizado
#          <> ipinternet: filtro atualizado
#          <> linuxnews: S) filtro atualizado, O) filtro atualizado
#          <> locale: URL e filtros atualizados
#          <> loteria: URL e filtro atualizados (valeu casali)
#          <> nomefoto: não sobrescreve arquivo já existente (valeu nogaroto)
#          <> linuxnews: S) filtro atualizado, O) filtro atualizado
#          <> locale: URL e filtros atualizados
#          <> loteria: URL e filtro atualizados (valeu casali)
#          <> nomefoto: não sobrescreve arquivo já existente (valeu nogaroto)
#          <> noticiaslinux: I) URL atualizada (valeu aires)
#          <> noticiaslinux: U) URL e filtro atualizados
#          <> noticiaslinux: V) filtro atualizado, N) filtro atualizado
#          <> pronuncia: agora usa o comando 'say' no mac
#          <> security: URL e filtro atualizados para Conectiva e Mandriva
#          <> sigla: filtro atualizado
# 20070717 ++ ZZERIP: regex para casar IPs
#          <> zzzz: adicionada URL do site das funções
#          <> pronuncia: URL atualizada (valeu douglas)
#          <> ipinternet: filtro atualizado (valeu .*)
#          <> dolar: URL e filtro atualizados
#          <> google: filtro atualizado
#          <> whoisbr: URL atualizada
#          <> noticiaslinux: I) removido pois é não é linux-only
#          <> noticiaslinux: Y) URL e filtro atualizados
#          -- dicabl: removida pois agora usam AJAX :(
#          <> dictodos: removido ABL
#          <> arrumanome: opção nova -n (não faz nada, igual zznomefoto)
#          ++ checagem de problemas relacionados ao UTF-8 (valeu piero)