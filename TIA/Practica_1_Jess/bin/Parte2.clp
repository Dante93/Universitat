 (deftemplate PC
        (slot modelo)
        (slot compra)
)
        
(deftemplate Problemas
        (slot pc)
        (slot programa)
        (multislot problemas)
)
        
;; TEST

(deffacts TEST
        ;;MSI
        (PC (modelo "MSI") (compra 2014))
        (Problemas (pc "MSI") (programa "Steam") (problemas programa-falla))
        
        ;;ACER
        (PC (modelo "ACER") (compra 2002))
        (Problemas (pc "ACER") (programa "ECLIPSE") (problemas result-erroneo))
		
    	;;ASUS
        (PC (modelo "ASUS") (compra 2000))
        (Problemas (pc "ASUS") (programa "AutoCad") (problemas programa-lento))
    
)
        

;; REGLAS

;; Si el programa falla, entonces programa erroneo
(defrule programa-erroneo
        (declare (no-loop TRUE))
        
        ;;Aqui sacamos la informacion del pc y los problemas
        
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))
        
        ;; Nos aseguramos que el pc y el pc que tiene problemas son le mismo
        
        (test (eq ?modelo-PC ?modelo))
        (test (eq ?error programa-falla))
    
        =>
    
        (modify ?r (problemas ?pre ?error ?post prog-erroneo))
)

;;Si resultados erroneos, entonces error en el codigo
(defrule error-codigo
        
        (declare (no-loop TRUE))
                
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))
        
        (test (eq ?modelo-PC ?modelo))
        (test (eq ?error result-erroneo))
        =>
        (modify ?r(problemas ?pre ?error ?post code-error))
        
)

;;Si año de compra >= 2005 Entonces PC nuevo
(defrule PC-nuevo

        (declare (no-loop TRUE))
                
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))

        (test (eq ?modelo-PC ?modelo))
        ;; Miramos si el pc está comprado de 2005 en adelente
        (test (>= ?año 2005))
        =>
        (modify ?r (problemas ?pre ?error ?post pc-nuevo))
        
        
)

;;Si año de compra < 2005 Entonces PC viejo
(defrule PC-viejo

        (declare (no-loop TRUE))
                
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))

        (test (eq ?modelo-PC ?modelo))
        ;; Miramos si el pc está comprado antes de 2005
        (test (< ?año 2005))
        =>
        (modify ?r (problemas ?pre ?error ?post pc-viejo))
)

;;Si programa lento y PC nuevo Entonces memoria insuficiente
(defrule mem-insufi

        (declare (no-loop TRUE))
                
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error ?error1 $?post))

        (test (eq ?modelo-PC ?modelo))
        (test (and (eq ?error programa-lento) (eq ?error1 pc-nuevo)) )
        =>
        (modify ?r (problemas ?pre ?error ?post mem-insuficiente))
)

;;Si programa lento y PC viejo Entonces PC obsoleto
(defrule PC-obsoleto
        (declare (no-loop TRUE))
                
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error ?error1 $?post))

        (test (eq ?modelo-PC ?modelo))
        (test (and (eq ?error programa-lento) (eq ?error1 pc-viejo)))
        =>
        (modify ?r (problemas ?pre ?error ?post pc-obsoleto))
)

;;Si PC obsoleto Entonces CONSEJO renovar PC
(defrule renovar-pc
        (declare (no-loop TRUE) (salience 2000))
                
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))

        (test (eq ?modelo-PC ?modelo))
        (test (eq ?error pc-obsoleto))
        =>
 	(printout t "En el pc " ?modelo " falla el programa: " ?nom_prg " por que está obsoleto. CONSEJO RENOVAR PC." crlf)
    (retract ?q)
    (retract ?r)
)        

;;Si memoria insuficiente Entonces memoria saturada
    
(defrule memoria-saturada

        (declare (no-loop TRUE))
                
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))

        (test (eq ?modelo-PC ?modelo))
        (test (eq ?error mem-insuficiente))
        =>
        (modify ?r (problemas ?pre ?error ?post mem-saturada))
)

;;Si programa erroneo Entonces conflictos
    
(defrule conflictos

        (declare (no-loop TRUE))
                
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))

        (test (eq ?modelo-PC ?modelo))
        (test (eq ?error prog-erroneo))
        =>
        (modify ?r (problemas ?pre ?error ?post conflict))
)

;;Si conflictos o memoria saturada Entonces windows sobrecargado
(defrule windows-sobrecargado

        (declare (no-loop TRUE))
        
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))

        (test (eq ?modelo-PC ?modelo))
        (test (or (eq ?error conflict) (eq ?error mem-saturada)))
        =>
        (modify ?r (problemas ?pre ?error ?post sobrecarga))
)

;;Si error en el código Entonces corregir fuentes
(defrule corregir-fuentes

        (declare (no-loop TRUE))
        
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))

        (test (eq ?modelo-PC ?modelo))
        (test (eq ?error code-error))
        =>
        (modify ?r (problemas ?pre ?error ?post fuentes))
)

;;Si windows sobrecargado Entonces CONSEJO reiniciar PC
    
(defrule reiniciar-pc

        (declare (no-loop TRUE) (salience 2000))
                
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))

        (test (eq ?modelo-PC ?modelo))
        (test (eq ?error sobrecarga))
        =>
         (printout t "En el pc " ?modelo ", Windows está sobrecargado, CONSEJO REINICIAR PC." crlf)
    (retract ?q)
    (retract ?r)
)

;;Si corregir fuentes Entonces CONSEJO Apagar PC
    
(defrule apagar-pc

        (declare (no-loop TRUE) (salience 2000))
                
        ?q <- (PC (modelo ?modelo-PC) (compra ?año))
        ?r <- (Problemas (pc ?modelo) (programa ?nom_prg) (problemas $?pre ?error $?post))

        (test (eq ?modelo-PC ?modelo))
        (test (eq ?error fuentes))
        =>
 	(printout t  "En el pc " ?modelo ", hay que corregir fuentes. CONSEJO APAGAR PC." crlf)
    (retract ?q)
    (retract ?r)
)

(reset)
(facts)
(run)
(facts)

