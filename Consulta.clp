          (defrule regla_1
          =>
           (printout t "Introduce motivo de consulta" crlf)
           (assert (respuesta1 (read)))
           )


           (defrule anticonceptivos

           	?respuesta1 <- (respuesta1 ?respuesta1-read&anticonceptivos)
             (mujer)
           	=>
           	 (retract ?respuesta1)
             (assert(anticonceptivos))

           	  (printout t "¿Esta utilizando el anticonceptivo oral meramente por su uso anticonceptivo?" crlf)
              (assert (respuesta10 (read)))
             )

             (defrule presc_si
             	?respuesta10 <- (respuesta10 ?respuesta10-read&si)
             	=>
             	 (retract ?respuesta10)
               (printout t "Usar anticonceptivos de barrera, como preservativos, diafragma, espermicidas, etc." crlf)
             	 (assert(anticonceptivos_alternativos))
               (assert(comprobar_inr))
               )


               (defrule presc_no
               	?respuesta10 <- (respuesta10 ?respuesta10-read&no)
               	=>
               	 (retract ?respuesta10)
                 (printout t "Dosificar el sintrom y realizar controles muy frecuentemente" crlf)
               	 (assert(controles))
                 (assert(comprobar_inr))
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

          	 			 (assert(tcorto))
          	 			 (assert(comprobar_inr)))

          	 			 (defrule regla_13
                     (tcorto)
          	 			 	(or
          	 			 		(inr_alto)(inr_bajo)(inr_normal)
          	 			 	)
          	 			 	=>
          	 				(assert(regla_13))
          	 	(printout t "Recetar paracetamol no mas de 1,5g al dia" crlf)
          	 			 )

          	 		(defrule t_largo
          	 	 		?respuesta2 <- (respuesta2 ?respuesta2-read&largo)
          	 	 			=>
          	 	 			 (retract ?respuesta2)


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
                 (assert(arritmia))
                 (assert(comprobar_inr))
          			 )

                 (defrule inr_normal
                   (or
                     (arritmia)(tcorto)(colesterol)(cistitis)(erictomicina)
                     (cefuroxima)(augmentine)(candidiasis)(anticonceptivos_alternativos)(controles)
                   )
                   ?respuesta3 <- (respuesta3 ?respuesta3-read&normal)
                     =>
                      (retract ?respuesta3)
                      (assert(inr_normal))
                 )

                 (defrule inr_alto
                   (or
                     (arritmia)(tcorto)(colesterol)(cistitis)(erictomicina)
                     (cefuroxima)(augmentine)(candidiasis)(anticonceptivos_alternativos)(controles)
                   )
                   ?respuesta3 <- (respuesta3 ?respuesta3-read&alto)
                     =>
                      (retract ?respuesta3)
                        (assert(inr_alto))

                 )
                  (defrule red_sint
                    (inr_alto)
                    =>
                      (printout t "Reducir dosis sintrom" crlf)
                      (assert(reducir_sintrom))
                  )
                 (defrule inr_bajo
                   (or
                     (arritmia)(tcorto)(colesterol)(cistitis)(erictomicina)
                     (cefuroxima)(augmentine)(candidiasis)(anticonceptivos_alternativos)(controles)
                   )

                   ?respuesta3 <- (respuesta3 ?respuesta3-read&bajo)
                     =>
                      (retract ?respuesta3)
                      (assert(inr_bajo))
                 )
                 (defrule aum_sint
                   (inr_bajo)
                   =>
                     (printout t "Aumentar dosis sintrom" crlf)
                     (assert(aumentar_sintrom))
                 )

                 (defrule atenolol
                   (arritmia)
                   (or
                     (inr_alto)(inr_bajo)(inr_normal))
                   =>
                   (printout t "Recetar Atenolol" crlf)
                   (assert(atenolol))


                 )


          			 (defrule colesterol
          			 	?respuesta4 <- (respuesta4 ?respuesta4-read&colesterol)
          			 	=>
          			 	 (retract ?respuesta4)
                   (assert
                     (colesterol)
                   )
                   (assert(comprobar_inr))
          			 	 )

          (defrule pravastatina
            (colesterol)
            (or(inr_alto)(inr_bajo)(inr_normal))
            =>
            (printout t "Recetar Pravastatina" crlf)
            (assert(pravastatina))
          )

          (defrule dieta
            (pravastatina)
            =>
            (printout t "Comer alimentos bajos en grasa y en su mayoría de origen vegetal ( excluyendo los que sean ricos en vitamina k)" crlf)
            (assert(dietac))
          )

          			 (defrule infecciones
          				?respuesta1 <- (respuesta1 ?respuesta1-read&infeccion)
          				=>
          				 (retract ?respuesta1)
          				 (printout t "¿De que tipo de infeccion se trata?" crlf)
               	 	(assert (respuesta6 (read))))

                  (defrule otorrinolaringologica
                    ?respuesta6 <- (respuesta6 ?respuesta4-read&otorrinolaringologica)
                    =>
                     (retract ?respuesta6)
                     (assert(otorrinolaringologica))
                  )

                  (defrule penicilina
                    (otorrinolaringologica)
                    =>
                    (printout t "¿Es alergico a la penicilina?" crlf)
                	 	(assert (respuesta7 (read)))

                  )
                  (defrule si
                    ?respuesta7 <- (respuesta7 ?respuesta7-read&si)
            				=>
            				 (retract ?respuesta7)
            				 (printout t "Recetar Erictomicina" crlf)
                    (assert
                      (erictomicina)
                    )
                    (assert(comprobar_inr))
                  )

                  (defrule no
                    ?respuesta7 <- (respuesta7 ?respuesta7-read&no)
                    =>
                     (retract ?respuesta7)
                     (assert(no_penicilina))
                     (printout t "¿Se ha tratado para esta enfermedad ya?" crlf)
                 	 	(assert (respuesta8 (read))
                    )
                  )
                  (defrule tratamientosi
                    ?respuesta8 <- (respuesta8 ?respuesta8-read&si)
                    =>
                     (retract ?respuesta8)
                     (printout t "Recetar Cefuroxima" crlf)
                     (assert(cefuroxima))
                     (assert(comprobar_inr))
                  )
                  (defrule tratamientono
                    ?respuesta8 <- (respuesta8 ?respuesta8-read&no)
                    =>
                     (retract ?respuesta8)
                     (printout t "Recetar Augmentine" crlf)
                     (assert(augmentine))
                     (assert(comprobar_inr))
                  )
                  (defrule candidiasis
                    (mujer)
                   ?respuesta6 <- (respuesta6 ?respuesta4-read&candidiasis)
                   =>
                    (retract ?respuesta6)
                  (assert(candidiasis))
                  (assert(comprobar_inr))
                    )
                    (defrule micomazol
                      (candidiasis)
                      =>
                      (printout t "Recetar Micomazol y realizar revision cada 2-3 dias." crlf)
                      (assert(micomazol))
                    )


                  (defrule cistitis
                   ?respuesta6 <- (respuesta6 ?respuesta4-read&cistitis)
                   =>
                    (retract ?respuesta6)
                    (assert(comprobar_inr))
                    (assert(cistitis))
                    )

                    (defrule fosfomicina
                      (cistitis)
                      (or
                        (inr_alto)(inr_bajo)(inr_normal))
                      =>
                      (printout t "Se receta Fosfomicina" crlf)
                      (assert(fosfomicina))
                    )

          			(defrule pantoprazol
          				(or(regla_5)(regla_8)(regla_9)(regla_13)
          				)

          			=>
          			(printout t "Pantoprazol 2h separadasde la toma del sintrom" crlf)
          			(assert(pantoprazol))

          				)

          				(defrule vitamina
          					(or(pantoprazol)(regla_21)(atenolol)(dietac)(fosfomicina)(erictomicina)
                    (cefuroxima)(augmentine)(micomazol)(anticonceptivos_alternativos)(controles) )
          					=>
          					(printout t "Dieta baja en Vitamina K, ya que esta Vitamina puede afectar a la coagulacion de la sangre." crlf)
          					)
