Arquivo: mesa.conf
Programa: Mesa (Biblioteca de gráficos 3D)
Detalhes: A configuração é feita em código em Lisp!
;; Default profile - should normally be an empty list of
;; configurations.
;;
(config-mesa mesa3.1beta1 ())
;; Really is an empty config.
;;
(config-mesa empty ())
;; Turn off some compliance for the sake of speed.
;;
(config-mesa quake2
(
;; Quake2 likes this extension, but it really hurts performance if
;; you don't also disable software fallbacks, below. (And do
;; something else to stop the eye-space calculations too...)
;;
(disable-extension GL_EXT_point_parameters)))