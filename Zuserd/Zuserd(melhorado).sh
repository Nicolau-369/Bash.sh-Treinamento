#!/bin/bash
#
# zuserd
# Lista, adiciona e remove usuários do sistema Z
#
# Requisitos: bantex.sh, dialog
#
# 2006-10-31 v1 Joaquim da Silva: Versão inicial
# 2006-10-31 v2 Joaquim da Silva:
#   - Tratamento do ESC e dos botões Cancelar
#   - Aplicação agora roda em loop

# Localização do arquivo do banco de dados
BANCO=usuarios.txt

# Inclui o gerenciador do banco
source bantex.sh || {
    echo "Ops, ocorreu algum erro no gerenciador do banco"
    exit 1
}

while :
do
    acao=$( dialog --stdout \
        --title " Aplicativo Zuserd - Interface amigável " \
        --menu "" \
        0 0 0 \
        lista "Lista todos os usuários do sistema" \
        adiciona "Adiciona um usuário novo no sistema" \
        remove "Remove um usuário do sistema")
    [ $? -ne 0 ] && exit

    # Lida com os comandos recebidos
    case "$acao" in

    lista)
        # Lista dos logins (apaga a primeira linha)
        temp=$(mktemp -t lixo)
        pega_campo 1 | sed 1d > "$temp"
        dialog --title "Usuários" --textbox "$temp" 13 30
        rm $temp
    ;;
    
    adiciona)
        login=$(dialog --stdout --inputbox "Digite o login:" 0 0)
        
        [ $? -ne 0 ] && continue
        [ "$login" ] || continue

        # Primeiro confere se já não existe esse usuário
        tem_chave "$login" && {
            msg="O usuário '$login' já foi cadastrado."
            dialog --msgbox "$msg" 6 40
            continue
        }

        # Ok, é um usuário novo, prossigamos
        nome=$(dialog --stdout --inputbox "Nome completo:" 0 0)

        [ $? -ne 0 ] && continue
        
        idade=$(dialog --stdout --inputbox "Idade:" 0 0)
        [ $? -ne 0 ] && continue

        sexo=$(dialog --stdout --radiolist "Sexo:" 0 0 3 \
            Feminino "" on Masculino "" off)
        [ $? -ne 0 ] && continue
        sexo=$(echo $sexo | cut -c1)

        # Dados obtidos, hora de mascarar eventuais dois-pontos
        nome=$(echo $nome | mascara)

        # Tudo pronto, basta inserir
        msg=$(insere_registro "$login:$nome:$idade:$sexo")
        dialog --title "Resultado" --msgbox "$msg" 6 40
    ;;

    remove)
        # Obtém a lista de usuários
        usuarios=$(pega_campo 1,2 | sed 1d)
        usuarios=$(echo "$usuarios" | sed 's/:/ "/;s/$/"/')

        login=$(eval dialog --stdout \
            --menu \"Escolha o usuário a remover\" \
            0 0 0 $usuarios)
        [ $? -ne 0 ] && continue

        msg=$(apaga_registro "$login")
        dialog --title "Resultado" --msgbox "$msg" 6 40
    ;;
        esac
    done    