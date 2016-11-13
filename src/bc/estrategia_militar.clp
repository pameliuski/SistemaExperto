; ********************
; PLANTILLAS DE HECHOS
; ********************

(deftemplate ubicacion
    "Una ubicacion en el mapa de planificacion"
    (slot id)
    (slot nombre (type STRING))
    (slot estado (default DISPONIBLE)) ; DISPONIBLE | NO_DISPONIBLE
    (slot visitado (default FALSE)))

(deftemplate ruta
    "Una ruta une dos ubicaciones"
    (slot estado (default DISPONIBLE))
    (slot inicio) ;<inicio> es la ubicacion donde empieza la ruta
    (slot fin) ;<fin> es la ubicacion donde termina la ruta
    (slot distancia))

(deftemplate carga
    "La carga que se desea transportar"
    (slot tipo) ;<tipo> puede ser ( personal-militar | suministros | vehiculos )
    (slot cantidad (type INTEGER)))

(deftemplate ubicacion-inicial
    "La ubicacion inicial del vuelo"
    (slot id)) ;<id> es el identificador de la ubicacion inicio

(deftemplate ubicacion-destino
    "La ubicacion de destino del vuelo"
    (slot id)) ;<id> es el identificador de la ubicacion destino

(deftemplate transporte
    (slot id) ;<id> es el identificador del transporte
    (slot tipo) ;<tipo> puede ser ( avion | helicoptero )
    (slot capacidad (type INTEGER));la capacidad maxima de carga
    (slot combustible (type INTEGER))
    (slot ubicacion (default base-militar)))

; ********************
; DEFINICION DE HECHOS
; ********************

(deffacts escenario "Definicion del escenario"
    ; Ubicaciones
        (ubicacion (id bm_la_paz) (nombre "Base Militar La Paz"))
	(ubicacion (id bm_cbba) (nombre "Base Militar Cochabamba") (estado NO_DISPONIBLE))
	(ubicacion (id bm_santa_cruz) (nombre "Base Militar Santa Cruz"))
        (ubicacion (id bm_sucre) (nombre "Base Militar Sucre"))
        (ubicacion (id bm_potosi) (nombre "Base Militar Potosi"))
	
    ; Rutas	
        (ruta (inicio bm_santa_cruz) (fin bm_la_paz))
	(ruta (inicio bm_la_paz) (fin bm_santa_cruz) (estado COMPROMETIDO))
	(ruta (inicio bm_santa_cruz) (fin bm_cbba))
	(ruta (inicio bm_cbba) (fin bm_santa_cruz))
	(ruta (inicio bm_la_paz) (fin bm_cbba))
	(ruta (inicio bm_cbba) (fin bm_la_paz))
        (ruta (inicio bm_sucre) (fin bm_potosi) (estado COMPROMETIDO))
        (ruta (inicio bm_potosi) (fin bm_sucre))

    ; Cargas
        (carga (tipo suministros) (cantidad 100))
        (carga (tipo suministros) (cantidad 200))
        (carga (tipo personal-militar) (cantidad 40)) 
        (carga (tipo personal-militar) (cantidad 60)) 
        (carga (tipo vehiculos) (cantidad 30))

    ;Transporte
        (transporte (id A0X-1) (tipo avion) (capacidad 80) (combustible 100) (ubicacion bm_la_paz))
        (transporte (id A0X-3) (tipo avion) (capacidad 100) (combustible 100))
)

; *********
; FUNCIONES
; *********

(deffunction ver-si-carga-mayor-que-capacidad-transporte(?a ?b)
    (if (> ?a ?b) then
      (return true)
  else
      (return false)))

(deffunction iniciar ()
    (reset)
    (assert (fase preguntar-ubicacion-inicial))
    (run)
    (facts))

; ******
; REGLAS
; ******

(defrule si-la-fase-es-preguntar-ubicacion-inicial
    ?fase <- (fase preguntar-ubicacion-inicial)
    =>
    (printout t "SE: Cual es la ubicacion inicial?" crlf)
    (assert (ubicacion-inicial (id (read))))
    (retract ?fase)
    (assert (fase preguntar-ubicacion-destino)))

(defrule si-la-fase-es-preguntar-ubicacion-destino
    ?fase <- (fase preguntar-ubicacion-destino)
    =>
    (printout t "SE: Cual es la ubicacion destino?" crlf)
    (assert (ubicacion-destino (id (read))))
    (retract ?fase)
    (assert (fase preguntar-tipo-de-carga)))

(defrule si-la-fase-es-preguntar-tipo-de-carga
    ?fase <- (fase preguntar-tipo-de-carga)
    =>
    (printout t "SE: Que tipo de carga desea llevar?" crlf)
    (assert (carga (tipo (read))))
    (retract ?fase)
    (assert (fase preguntar-cantidad-de-carga)))

(defrule si-la-fase-es-preguntar-cantidad-de-carga
    ?fase <- (fase preguntar-cantidad-de-carga)
    ?carga <- (carga (tipo ?tipo))
    =>
    (printout t "SE: Cual es la cantidad de " ?tipo "?" crlf)
    (modify ?carga (cantidad (read)))
    (retract ?fase)
    (assert (fase verificar-disponibilidad-transporte)))

(defrule aeropuerto-inicial-no-disponible
    "Verifica si el aeropuerto inicial no esta disponible"
    (ubicacion-inicial (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE})
    =>
    (printout t "Aeropuerto inicial no disponible" crlf))

(defrule aeropuerto-destino-no-disponible
    "Verifica si el aeropuerto destino no esta disponible"
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE})
    =>
    (printout t "Aeropuerto destino no disponible" crlf))

(iniciar)
