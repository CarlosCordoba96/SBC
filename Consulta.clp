(defrule regla_1
=>
 (printout t "Introduce motivo de consulta" crlf)
 (assert (respuesta1 (read)))
 )

(defrule fiebre_dolor
	?respuesta1 <- (respuesta1 ?respuesta1-read&fiebre|dolor)
	=>
	 (retract ?respuesta1)
	 (assert(fiebredolor)))



	 	(defrule regla_3
	 		(fiebredolor)
	 		=>
	 		(printout t "¿El periodo de tiempo que va a tener el tratamiento va a ser, largo o corto?" crlf)
	 		(assert (respuesta2 (read))))

	 		(defrule t_corto
	 			?respuesta2 <- (respuesta2 ?respuesta2-read&corto)
	 			=>
	 			 (retract ?respuesta2)
	 			 (printout t "TRATAMIENTO CORTO" crlf)
	 			 (assert(tcorto))
	 			 (assert(comprobar_inr)))

	 			 (defrule regla_10
	 			 	(tcorto)
	 			 	?respuesta3 <- (respuesta3 ?respuesta3-read&normal)
	 			 		=>
	 			 		 (retract ?respuesta3)
	 			 		(assert(regla_10)
	 			 		)
	 			 )
	 			 (defrule regla_13
	 			 	(or
	 			 		(regla_10)(regla_12)(regla_15)
	 			 	)
	 			 	=>
	 				(assert
	 					(regla_13)
	 				)

	 	(printout t "Recetar paracetamol no mas de 1,5g al dia" crlf)
	 			 )

	 			 (defrule regla_11
	 			  (tcorto)
	 			  ?respuesta3 <- (respuesta3 ?respuesta3-read&alto)
	 			 	 =>
	 			 		(retract ?respuesta3)

	 					(assert(regla_11))
	 			 )

	 			 (defrule regla_12
	 			 	(regla_11)
	 			 	=>
	 				(printout t "Reducir dosis sintrom" crlf)
	 				(assert(regla_12))
	 			 )


	 			 (defrule regla_14
	 			  (tcorto)
	 			  ?respuesta3 <- (respuesta3 ?respuesta3-read&bajo)
	 			 	=>
	 			 	 (retract ?respuesta3)
	 			 	 (printout t "CORTO-BAJO" crlf)
	 				 (assert(regla_14))

	 			 )
	 			 (defrule regla_15
	 			 	(regla_14)
	 			 	=>
	 				(printout t "Aumentar dosis sintrom" crlf)
	 				(assert(regla_15))
	 			 )

	 		(defrule t_largo
	 	 		?respuesta2 <- (respuesta2 ?respuesta2-read&largo)
	 	 			=>
	 	 			 (retract ?respuesta2)
	 	 			 (printout t "TRATAMIENTO LARGO" crlf)

	 				 (assert(tratamientolargo))
	 				  (assert(comprobar_inr)))




	 (defrule comp_inr
	 	(comprobar_inr)
	 	=>
	 	(printout t "¿Como está el nivel de INR del paciente?" crlf)
	 	(assert (respuesta3 (read)))
	 )
	 ;TRATAMIENTO LARGO Y INR NORMAL
	 			(defrule regla_4
	 				(tratamientolargo)
	 				?respuesta3 <- (respuesta3 ?respuesta3-read&normal)
	 					=>
	 					 (retract ?respuesta3)
	 					 (assert(regla4))
	 			)
	 			(defrule regla_5
	 				(regla4)
	 				=>
	 				(printout t "Ajustar tratamiento de sintrom, recetar paracetamol y ajustarlo" crlf)
	 				(assert(regla_5))
	 			)

	 			(defrule regla_6
	 				(tratamientolargo)
	 				?respuesta3 <- (respuesta3 ?respuesta3-read&alto)
	 					=>
	 					 (retract ?respuesta3)
	 					 (assert(regla_6))
	 			)

	 			(defrule regla_8
	 				(regla_6)
	 				=>
	 				(printout t "Reducir la dosis de sintrom, recetar paracetamol y ajustarlo" crlf)
	 				(assert(regla_8))

	 			)

	 			(defrule regla_7
	 				(tratamientolargo)
	 				?respuesta3 <- (respuesta3 ?respuesta3-read&bajo)
	 					=>
	 					 (retract ?respuesta3)
	 					 (assert(regla_7))
	 			)
	 			(defrule regla_9
	 				(regla_7)
	 				=>
	 				(printout t "Aumentar la dosis de sintrom, recetar paracetamol y ajustarlo" crlf)
	 				(assert(regla_9))

	 			)


	 (defrule problemas_corazon
	 	?respuesta1 <- (respuesta1 ?respuesta1-read&corazon)
	 	=>
	 	 (retract ?respuesta1)
		 (printout t "¿Que tipo de problema tiene en el corazon?" crlf)
 		(assert (respuesta4 (read))))

		(defrule arritmia
			?respuesta4 <- (respuesta4 ?respuesta1-read&arritmia)
			=>
			 (retract ?respuesta4)
			 (printout t "ARRITMIA" crlf)
			 )

			 (defrule colesterol
			 	?respuesta4 <- (respuesta4 ?respuesta4-read&colesterol)
			 	=>
			 	 (retract ?respuesta4)
				 (printout t "COLESTEROL" crlf)
			 	 )




			 (defrule infecciones
				?respuesta1 <- (respuesta1 ?respuesta1-read&infeccion)
				=>
				 (retract ?respuesta1)
				 (printout t "AMO A VER2" crlf)
				 (assert(fiebredolor)))
















			(defrule pantoprazol
				(or(regla_5)(regla_8)(regla_9)(regla_13)
				)

			=>
			(printout t "Pantoprazol 2h separadasde la toma del sintrom" crlf)
			(assert(pantoprazol))

				)

				(defrule vitamina
					(or(pantoprazol) )
					=>
					(printout t "Dieta baja en Vitamina K" crlf)
					)
