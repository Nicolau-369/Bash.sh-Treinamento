--- zuser   2024-03-13 20:03:48.000000000 -0200
+++ zuserd  2024-03-13 22:53:06.000000000 -0200
@@ -1,99 +1,75 @@
#!/bin/bash
#
-# zuser
+# zuserd
# Lista, adiciona e remove usuários do sistema Z
#
-# Requisitos: bantex.sh
-#
-# Uso: zuser [ lista | adiciona | remove ]
+# Requisitos: bantex.sh, dialog
#
# 2006-10-31 Joaquim da Silva
-
-# Se não passar nenhum argumento, mostra a mensagem de ajuda
-[ "$1" ] || {
-   echo
-   echo "Uso: zuser [ lista | adiciona | remove ]"
-   echo
-   echo "  lista       - Lista todos os usuários do sistema"
-   echo "  adiciona    - Adiciona um usuário novo no sistema"
-   echo "  remove      - Remove um usuário do sistema"
-   echo
-   exit 0
-}
-
# Localização do arquivo do banco de dados
BANCO=usuarios.txt
# Inclui o gerenciador do banco
source bantex.sh || {
    echo "Ops, ocorreu algum erro no gerenciador do banco"
    exit 1
}
+acao=$( dialog --stdout \
+   --menu "Aplicativo Zuserd - Interface amigável" \
+   0 0 0 \
+   lista "Lista todos os usuários do sistema" \
+   adiciona "Adiciona um usuário novo no sistema" \
+   remove "Remove um usuário do sistema")
+
# Lida com os comandos recebidos
-case "$1" in
+case "$acao" in
    lista)
        # Lista dos logins (apaga a primeira linha)
-           pega_campo 1 | sed 1d
+           temp=$(mktemp -t lixo)
+           pega_campo 1 | sed 1d > "$temp"
+           dialog --title "Usuários" --textbox "$temp" 13 30
+           rm $temp
    ;;
    adiciona)
-           echo -n "Digite o login do usuário novo: "
-           read login
-
-           # Temos algo?
-           [ "$login" ] || {
-               echo "O login não pode ser vazio, tente novamente."
-               exit 1
-           }
+           login=$(dialog --stdout --inputbox "Digite o login:" 0 0)
+           [ "$login" ] || exit 1
            # Primeiro confere se já não existe esse usuário
            tem_chave "$login" && {
-                echo "O usuário '$login' já foi cadastrado."
+                msg="O usuário '$login' já foi cadastrado."
+                dialog --msgbox "$msg" 6 40
                exit 1
            }

            # Ok, é um usuário novo, prossigamos
-            echo -n "Digite o nome completo: "
-            read nome
-            echo -n "Digite a idade: "
-            read idade
-            echo -n "É do sexo masculino ou feminino? [MF] "
-            read sexo
-            echo
+            nome=$(dialog --stdout --inputbox "Nome completo:" 0 0)
+            idade=$(dialog --stdout --inputbox "Idade:" 0 0)
+            sexo=$(dialog --stdout --radiolist "Sexo:" 0 0 3 \
+                Feminino "" on Masculino "" off)
+            sexo=$(echo $sexo | cut -c1)
            # Dados obtidos, hora de mascarar eventuais dois-pontos
            nome=$(echo $nome | mascara)

            # Tudo pronto, basta inserir
-            insere_registro "$login:$nome:$idade:$sexo"
-            echo
+            msg=$(insere_registro "$login:$nome:$idade:$sexo")
+            dialog --title "Resultado" --msgbox "$msg" 6 40
    ;;
    remove)
-            # Primeiro mostra a lista de usuários, depois pergunta
-            echo "Lista dos usuários do sistema Z:"
-            pega_campo 1 | sed 1d | tr \\n ' '
-            echo
-            echo
-            echo -n "Qual usuário você quer remover? "
-            read login
-            echo
+            # Obtém a lista de usuários
+            usuarios=$(pega_campo 1,2 | sed 1d)
+            usuarios=$(echo "$usuarios" | sed 's/:/ "/;s/$/"/')
+
+            login=$(eval dialog --stdout \
+               --menu \"Escolha o usuário a remover\" \
+               0 0 0 $usuarios)

-            # Vamos apagar ou puxar a orelha?
-            if tem_chave "$login"; then
-                apaga_registro "$login"
-            else
-               echo "Não, não, esse usuário não está aqui..."
-            fi
-            echo
-       ;;
-
-       *)
-            # Qualquer outra opção é erro
-            echo "Opção inválida $1"
-            exit 1
+            msg=$(apaga_registro "$login")
+            dialog --title "Resultado" --msgbox "$msg" 6 40
        ;;
esac