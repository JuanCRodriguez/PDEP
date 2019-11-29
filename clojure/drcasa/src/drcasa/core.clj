(ns drcasa.core)

(defn flip
	"	Se comporta como el flip de haskell, lo defino a manopla porque no existe en clojure"
	[f arg1, arg2]
	(f arg2 arg1))

(defprotocol Enfermedad
	"	Protocolo base para las enfermedades
	"
	(esAgresiva [self persona])
	(afectarPersona [self persona]))

(defprotocol _EnfermedadInfecciosa
	"Protocolo para las enfermedades infecciosas
	"
	(reproducirse [self]))

(defprotocol _EnfermedadAutoInmune
	"	Protocolo para las enfermedades autoinmunes
	"
	(aumentarDia [self]))


(defprotocol _Persona
	"	Protocolo para las personas
	"
	(contraerEnfermedad [self enfermedad])
	(pasarDia [self])
	(pasarDias [self n])
	(aumentarTemperatura [self cuanto])
	(disminuirCelulas [self cuanto])
	(enComa [self])
	(getEnfAutoInmunes [self]))

(defrecord Persona [nombre temperatura celulas enfermedades]

	_Persona
	(getEnfAutoInmunes [self]
		"satisfies?: retorna true si el elemento implementa ese protocolo
		"
		(filter (partial satisfies? _EnfermedadAutoInmune) enfermedades))

	(contraerEnfermedad [self enfermedad]
		"	update-in: actualiza el valor de las keywords indicadas
			conj: agrega un elemento a una lista
		"
		(update-in self [:enfermedades] conj enfermedad))

	(enComa [self]
		"	some: similar a cualquier any
		"
		(or (some (comp (partial >= 5) :cantDias) (getEnfAutoInmunes self)) (> temperatura 45) (< celulas 1000000)))

	(pasarDia [self]
		"	Aplica todas las enfermedades
			reduce: funciona parecido al fold de haskell
		"
		(reduce (partial flip afectarPersona) self enfermedades))

	(pasarDias [self n]
		"	Pasan N dias.
			nth: consigue el n elemento de una lista
			iterate: genera una lista infinita del estilo f(f(x))
			"
		(nth (iterate pasarDia self) n))

	(aumentarTemperatura
		[self cuanto]
		(update self :temperatura + cuanto))

	(disminuirCelulas
		[self cuanto]
		(update self :celulas - cuanto)))

(defrecord EnfermedadInfecciosa [nombre celulasAmenazadas]

	Enfermedad
	(esAgresiva [self persona]
		(> (:celulasAmenazadas self) ((comp (partial * 0.10) :celulas) persona)))

	(afectarPersona [self persona]
		((comp (partial aumentarTemperatura persona) (partial / 1000) :celulasAmenazadas) self))

	_EnfermedadInfecciosa
	(reproducirse [self]
		(update self :celulasAmenazadas * 2)))
	
(defrecord EnfermedadAutoInmune [nombre celulasAmenazadas cantDias]

	Enfermedad
	(esAgresiva [_ _]
		(>= cantDias 30))

	(afectarPersona [self persona]
		((comp(partial disminuirCelulas persona) :celulasAmenazadas aumentarDia) self))

	_EnfermedadAutoInmune
	(aumentarDia [self]
		(update self :cantDias + 1)))



(def unaMalaria (->EnfermedadInfecciosa "Malaria" 500))
(def otraMalaria (->EnfermedadInfecciosa "Malaria" 800))
(def otitis (->EnfermedadInfecciosa "Otitis"  100))
(def lupus (->EnfermedadAutoInmune "Lupus" 10000 1))


(def logan (->Persona "Logan" 35 3000000 [unaMalaria otitis lupus]))
(def frank (->Persona "Frank" 36 3500000 []))
