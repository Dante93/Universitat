;; SALUD Y DEFENSA
(deftemplate salud-principal
    0 100
	((cercana-muerte (0 1)(50 0))
	(buena (20 0)(50 1)(80 0))
    (excelente (50 0) (100 1))
	)
)
    
(deftemplate salud-enemigo
	0 100
	((cercana_muerte (0 1)(50 0))
	(buena (20 0)(50 1)(80 0))
    (excelente (50 0) (100 1))
	)
)
        
(deftemplate estrategia
	0 5
    ((salir-corriendo(0 1)(1 1)(2 0))
     (ataque-defensivo (1 0)(2 1)(3 1)(4 0))
     (KO (3 0)(4 1)(5 1))
    )
)
     
;; ESTRATEGIA SALIR CORRIENDO
(defrule salir-corriendo
    (salud-principal cercana-muerte)
    (or (salud-enemigo excelente)(salud-enemigo buena))
    =>
    (assert (estrategia salir-corriendo))
    (printout t "La mejor estrategia es salir corriendo." crlf)
    )