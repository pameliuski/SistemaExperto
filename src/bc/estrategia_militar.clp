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

(deftemplate transporte-disponible
    (slot id)
    (slot tipo)
    (slot capacidad)
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
    (ruta (inicio bm_santa_cruz) (fin bm_la_paz))
	(ruta (inicio bm_la_paz) (fin bm_santa_cruz) (estado COMPROMETIDO))
	(ruta (inicio bm_santa_cruz) (fin bm_cbba))
	(ruta (inicio bm_cbba) (fin bm_santa_cruz))
	(ruta (inicio bm_la_paz) (fin bm_cbba))
	(ruta (inicio bm_cbba) (fin bm_la_paz))
    (ruta (inicio bm_sucre) (fin bm_potosi) (estado COMPROMETIDO))
    (ruta (inicio bm_potosi) (fin bm_sucre))
	(transporte (id A0X-1) (tipo avion) (capacidad 500) (combustible 100) (ubicacion bm_la_paz))
	(transporte (id A0X-3) (tipo avion) (capacidad 200) (combustible 100) (ubicacion bm_cbba))
	(transporte (id A0X-5) (tipo helicoptero) (capacidad 100) (combustible 80) (ubicacion bm_santa_cruz)))

; ******
; REGLAS
; ******

; REGLAS DE TRANSPORTE

(defrule verificacion-disponibilidad-transporte
    (carga (cantidad ?cantidad))
    (ubicacion-inicial (id ?ubicacionId))
    ?transporte <- (transporte {ubicacion == ?ubicacionId && capacidad >= ?cantidad} (id ?transporteId) (tipo ?tipo) (capacidad ?capacidad))
    =>
    (assert (transporte-disponible (id ?transporteId) (tipo ?tipo) (capacidad ?capacidad) (ubicacion ?ubicacionId))))

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
    (assert (soltar-carga-en-paracaidas)))

(defrule aterrizar-helicoptero-en-punto-cercano
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == NO_DISPONIBLE && razon == "conflicto armado"})
    (transporte-disponible {tipo == helicoptero})
    =>
    (assert (aterrizar-helicoptero-en-punto-cercano)))

(defrule aterrizar-avion-normalmente
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == DISPONIBLE})
    (transporte-disponible {tipo == avion})
    =>
    (assert (aterrizar-avion-normalmente)))

(defrule aterrizar-helicoptero-normalmente
    (ubicacion-destino (id ?uId))
    (ubicacion {id == ?uId && estado == DISPONIBLE})
    (transporte-disponible (id ?transporteId))
    (transporte {id == ?transporteId && tipo == helicoptero})
    =>
    (assert (aterrizar-helicoptero-normalmente)))

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
(reset)