(do-backward-chaining cubre)
(do-backward-chaining reproduce)
(do-backward-chaining come)
(do-backward-chaining garras)
(do-backward-chaining color)
(do-backward-chaining piel)
(do-backward-chaining rayas)
(do-backward-chaining vuela)
(do-backward-chaining nada)
(do-backward-chaining da_leche)
(do-backward-chaining pico)
; 'alimenta', 'tipo' y 'nombre' no son necesarios
; REGLES


(defrule responder
    (declare (salience 10))
    (cubre ?c)
    (reproduce ?r)
    (come ?co)
    (garras ?g)
    (color ?cl)
    (piel ?p)
    (rayas ?r)
    (vuela ?v)
    (nada ?n)
    (da_leche ?dl)
    (pico ?p)
    =>
    (printout t "INTERROGATORIO TERMINADO" crlf)
)

; AQUI EMPIEZAN LAS PREGUNTAS

(defrule pregunta-cubre
    (exists (need-cubre ?))
    =>
    (printout t "El animal se cubre de pelo o de plumas?" crlf)
    (assert (cubre (read)))
)

(defrule pregunta-reproduce
    (exists (need-reproduce ?))
    =>
    (printout t "Que tipo de reproduccion utiliza el animal(Oviparo o Viviparo))" crlf)
    (assert (reproduce (read)))
)

(defrule pregunta-come
    (exists (need-come ?))
    =>
    (printout t "Que come el animal?" crlf)
    (assert (come (read)))
)

(defrule pregunta-garras
    (exists (need-garras ?))
    =>
    (printout t "El animal tiene garras?" crlf)
    (assert (garras (read)))
)

(defrule pregunta-color
    (exists (need-color ?))
    =>
    (printout t "Que color tiene el animal?" crlf)
    (assert (color (read)))
)

(defrule pregunta-piel
    (exists (need-piel ?))
    =>
    (printout t "Como es la piel del animal" crlf)
    (assert (piel (read)))
)

(defrule pregunta-rayas
    (exists (need-rayas ?))
    =>
    (printout t "Si el animal tiene rayas, de que color son?" crlf)
    (assert (rayas (read)))
)

(defrule pregunta-vuela
    (exists (need-vuela ?))
    =>
    (printout t "Como vuela el animal: 'mal' o 'muy_bien'?" crlf)
    (assert (vuela (read)))
)

(defrule pregunta-nada
    (exists (need-nada ?))
    =>
    (printout t "Como nada el animal(bien o no nada)?" crlf)
    (assert (nada (read)))
)

(defrule pregunta-da_leche
    (exists (need-da_leche ?))
    =>
    (printout t "El animal da leche?" crlf)
    (assert (da_leche (read)))
)

(defrule pregunta-pico

    (exists (need-pico ?))
    =>
    (printout t "El animal tiene pico?" crlf)
    (assert (pico (read)))
)


;AQUI EMPIEZAN LAS REGLAS

(defrule regla1 
    (cubre ?c)
    (test (eq ?c pelo))
    =>
    (assert (tipo mamifero))
    )

(defrule regla2
    (cubre ?c)
    (test (eq ?c plumas))
    (reproduce ?r)
    (test (eq ?r oviparo))
        =>
    (assert (tipo ave))
    )

(defrule regla3
    (tipo ?t)
    (test (eq ?t mamifero))
    (come ?c)
    (test (eq ?c carne))
    (garras ?g)
    (test (eq ?g si))
        =>
    (assert (alimenta carnivoro))
    )

(defrule regla4
    (alimenta ?a)
    (test (eq ?a carnivoro))
    (color ?c)
    (test (eq ?c pardo))
    (piel ?p)
    (test (eq ?p manchas))
        =>
    (printout t "El animal es el guepardo")
    (halt)
    )

(defrule regla5
    (alimenta ?a)
    (test (eq ?a carnivoro))
    (color ?c)
    (test (eq ?c pardo))
    (rayas ?r)
    (test (eq ?r negras))
        =>
    (printout t "El animal es el tigre")
    (halt)
    )

(defrule regla6
    (tipo ?t)
    (test (eq ?t ave))
    (vuela ?v)
    (test (eq ?v mal))
    (nada ?n)
    (test (eq ?n bien))
        =>
    (printout t "El animal es el pinguino")
    (halt)
    )

(defrule regla7
    (tipo ?t)
    (test (eq ?t ave))
    (vuela ?v)
    (test (eq ?v muy_bien))
        =>
    (printout t "El animal es la gaviota")
    (halt)
    )

(defrule regla8
    (da_leche ?dl)
    (test (eq ?dl si))
    =>
    (assert (tipo mamifero))
    )

(defrule regla9
    (pico ?p)
    (test (eq ?p si))
    (reproduce ?r)
    (test (eq ?r oviparo))
    =>
    (assert (tipo ave))
    )


(reset)
(run)
    
 