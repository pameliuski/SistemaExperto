; ********************
; PLANTILLAS DE HECHOS
; ********************

(deftemplate ubicacion
    "Una ubicacion en el mapa de planificacion"
    (slot id)
    (slot nombre (type STRING))
    (slot estado (default DISPONIBLE)) ; DISPONIBLE | NO_DISPONIBLE
    (slot visitado (default FALSE))
    (slot razon (type STRING)))

(deftemplate ruta
    "Una ruta une dos ubicaciones"
    (slot estado (default DISPONIBLE))
    (slot inicio) ;<inicio> es la ubicacion donde empieza la ruta
    (slot fin) ;<fin> es la ubicacion donde termina la ruta
    (slot distancia (type INTEGER)))

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

(deftemplate transporte-disponible
    (slot id)
    (slot tipo)
    (slot capacidad)
    (slot distancia-maxima)
    (slot combustible)
    (slot ubicacion))

(deftemplate accion
    (slot texto (type STRING)))
; ********************
; DEFINICION DE HECHOS
; ********************

(deffacts escenario "Definicion del escenario"
        (ubicacion (id bm_la_paz) (nombre "Base Militar La Paz"))
	(ubicacion (id bm_cbba) (nombre "Base Militar Cochabamba") (estado NO_DISPONIBLE) (razon "conflicto armado"))
	(ubicacion (id bm_santa_cruz) (nombre "Base Militar Santa Cruz"))
	(ubicacion (id bm_sucre) (nombre "Base Militar Sucre"))
        (ubicacion (id bm_potosi) (nombre "Base Militar Potosi"))
<<<<<<< HEAD
        (ruta (inicio bm_santa_cruz) (fin bm_la_paz) (distancia 2000))
	(ruta (inicio bm_la_paz) (fin bm_santa_cruz) (estado COMPROMETIDO) (distancia 200))
	(ruta (inicio bm_santa_cruz) (fin bm_cbba) (distancia 1000))
	(ruta (inicio bm_cbba) (fin bm_santa_cruz) (distancia 1000))
	(ruta (inicio bm_la_paz) (fin bm_cbba)(distancia 3000))
	(ruta (inicio bm_cbba) (fin bm_la_paz)(distancia 3000))
        (ruta (inicio bm_sucre) (fin bm_potosi) (estado COMPROMETIDO)(distancia 4500))
        (ruta (inicio bm_potosi) (fin bm_sucre)(distancia 4500))
	(transporte (id A0X-1) (tipo avion) (capacidad 500) (combustible 500) (ubicacion bm_la_paz))
	(transporte (id A0X-3) (tipo avion) (capacidad 200) (combustible 500) (ubicacion bm_cbba))
	(transporte (id A0X-5) (tipo helicoptero) (capacidad 100) (combustible 500) (ubicacion bm_santa_cruz)))
=======

        (ruta (inicio bm_santa_cruz) (fin bm_la_paz))
	(ruta (inicio bm_santa_cruz) (fin bm_cbba))
        (ruta (inicio bm_santa_cruz) (fin bm_sucre))
        (ruta (inicio bm_santa_cruz) (fin bm_potosi))
        (ruta (inicio bm_la_paz) (fin bm_santa_cruz) (estado COMPROMETIDO))
        (ruta (inicio bm_la_paz) (fin bm_cbba))
        (ruta (inicio bm_la_paz) (fin bm_sucre))
        (ruta (inicio bm_la_paz) (fin bm_potosi))
	(ruta (inicio bm_cbba) (fin bm_santa_cruz))
	(ruta (inicio bm_cbba) (fin bm_la_paz))
        (ruta (inicio bm_cbba) (fin bm_sucre))
        (ruta (inicio bm_cbba) (fin bm_potosi))
        (ruta (inicio bm_sucre) (fin bm_potosi) (estado COMPROMETIDO))
        (ruta (inicio bm_sucre) (fin bm_la_paz))
        (ruta (inicio bm_sucre) (fin bm_cbba))
        (ruta (inicio bm_sucre) (fin bm_santa_cruz))
        (ruta (inicio bm_potosi) (fin bm_sucre))
        (ruta (inicio bm_potosi) (fin bm_la_paz))
        (ruta (inicio bm_potosi) (fin bm_cbba))
        (ruta (inicio bm_potosi) (fin bm_santa_cruz))

	(transporte (id A0X-1) (tipo avion) (capacidad 500) (combustible 100) (ubicacion bm_la_paz))
	(transporte (id A0X-3) (tipo avion) (capacidad 200) (combustible 100) (ubicacion bm_cbba))
	(transporte (id H0X-2) (tipo helicoptero) (capacidad 100) (combustible 80) (ubicacion bm_santa_cruz))
	(transporte (id A0X-2) (tipo avion) (capacidad 200) (combustible 100) (ubicacion bm_sucre))
	(transporte (id H0X-4) (tipo helicoptero) (capacidad 100) (combustible 80) (ubicacion bm_potosi)))
>>>>>>> 021e59874f6e7243fb957fca43a911907fe008e2

; ******
; REGLAS
; ******

; REGLAS DE TRANSPORTE

(defrule si-capacidad-transporte-es-mayor-o-igual-a-cantidad-carga-entonces-transporte-disponible
    (carga (cantidad ?cantidad))
    (ubicacion-inicial (id ?ubicacionId))
    ?transporte <- (transporte {ubicacion == ?ubicacionId && capacidad >= ?cantidad} (id ?transporteId) (tipo ?tipo) (capacidad ?capacidad))
    =>
    (assert (transporte-disponible (id ?transporteId) (tipo ?tipo) (capacidad ?capacidad) (ubicacion ?ubicacionId))))

(defrule si-capacidad-transporte-es-menor-a-cantidad-carga-entonces-transporte-no-disponible
    (carga (cantidad ?cantidad))
    (ubicacion-inicial (id ?ubicacionId))
    ?transporte <- (transporte {ubicacion == ?ubicacionId && capacidad < ?cantidad})
    =>
    (assert (transporte-no-disponible)))

; REGLAS DE DESCARGA

(defrule personal-militar-desciende-en-paracaidas
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE && razon == "conflicto armado"})
    (transporte-disponible {tipo == avion})
    (carga (tipo personal-militar))
    =>
    (assert (accion (texto "El personal militar debe descender en paracaidas.") )))

(defrule soltar-carga-en-paracaidas
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE && razon == "conflicto armado"})
    (transporte-disponible {tipo == avion})
    (carga (tipo suministros))
    =>
    (assert (accion (texto "Soltar la carga en paracaidas"))))

(defrule aterrizar-helicoptero-en-punto-cercano
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE && razon == "conflicto armado"})
    (transporte-disponible {tipo == helicoptero})
    =>
    (assert (accion (texto "Aterrizar el helicoptero en un punto cercano"))))

(defrule aterrizar-avion-normalmente
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == DISPONIBLE})
    (transporte-disponible {tipo == avion})
    =>
    (assert (accion (texto "Aterrizar el avion normalmente"))))

(defrule aterrizar-helicoptero-normalmente
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == DISPONIBLE})
    (transporte-disponible (id ?transporteId))
    (transporte {id == ?transporteId && tipo == helicoptero})
    =>
    (assert (accion (texto "Aterrizar el helicoptero normalmente"))))

; REGLAS DE DISPONIBILIDAD DE AEROPUERTO

(defrule aeropuerto-inicial-no-disponible
    "Verifica si el aeropuerto inicial no esta disponible"
    (ubicacion-inicial (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE} (razon ?razon))
    =>
    (assert (aeropuerto-inicial-no-disponible)))

(defrule aeropuerto-destino-no-disponible
    "Verifica si el aeropuerto destino no esta disponible"
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE} (razon ?razon))
    =>
    (assert (aeropuerto-destino-no-disponible)))

(defrule aterrizar-en-ubicacion-cercana-para-recargar-combustible
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE && razon == "bajo en combustible"})
    (transporte-disponible (id ?transporteId))
    (transporte {id == ?transporteId && tipo == helicoptero})
    =>
    (printout t "Aterrizar en punto cercano para recargar combustible" crlf)
    (assert (aterrizar-en-ubicacion-cercana-para-recargar-combustible)))

(defrule aeropuerto-destino-no-disponible-por-cuasas-naturales
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE && razon == "cuasas naturales"})
    =>
    (printout t "El destino no esta disponbible por " ?razon "." crlf))

(defrule aeropuerto-destino-no-disponible-por-bombardeo
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE && razon == "bombardeo"})
    =>
    (printout t "El destino no esta disponbible por " ?razon "." crlf))

(defrule aeropuerto-destino-no-disponible-por-mal-pistas
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE && razon == "mal pistas de aterizaje"})
    =>
    (printout t "El destino no esta disponbible por " ?razon "." crlf))
;--------------------------------------------------
(deffunction MaxDistancia (?a ?b)
      (return * ?a ?b))

(defglobal ?*kmporltAVION* = 100)
(defglobal ?*kmporltHELICPOTERO* = 50)

(defrule distancia-maxima-de-transporte-disponible
    (ubicacion-inicial (id ?idIni))
    (ubicacion-destino (id ?idDes))
    (ruta {inicio == ?idIni && fin == ?idDes} (distancia ?distanciaRuta))
    ?transporte-disponible <- (transporte-disponible (id ?transporteId) (combustible ?combustible))
    =>
    (modify ?transporte-disponible (distancia-maxima(MaxDistancia(?combustible ?*kmporltAVION*)))))
