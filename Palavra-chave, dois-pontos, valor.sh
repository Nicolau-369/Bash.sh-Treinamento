Arquivo: lynx.cfg
Programa: Lynx (Navegador em modo texto)
Detalhes: Formatação HTML embutida (.h1, .h2) para gerar documentação.
Não pode haver brancos antes ou depois do dois-pontos. Preferência por
palavras-chave em maiúsculas, separadas pelo sublinhado.
.h1 Interaction
# These settings control interaction of the user with lynx.
.h2 SCROLLBAR
# If SCROLLBAR is set TRUE, Lynx will show scrollbar on windows. With
# mouse enabled, the scrollbar strip outside the bar is clickable, and
# scrolls the window by pages. The appearance of the scrollbar can be
# changed from LYNX_LSS file: define attributes scroll.bar,
# scroll.back (for the bar, and for the strip along which the
# scrollbar moves).
SCROLLBAR:FALSE
.h2 SCROLLBAR_ARROW
# If SCROLLBAR_ARROW is set TRUE, Lynx's scrollbar will have arrows at
# the ends. With mouse enabled, the arrows are clickable, and scroll
# the window by 2 lines. The appearance of the scrollbar arrows can
# be changed from LYNX_LSS file: define attributes scroll.arrow,
# scroll.noarrow (for enabled-arrows, and disabled arrows). An arrow
# is "disabled" if the bar is at this end of the strip.
SCROLLBAR_ARROW:TRUE