(ns drcasa.core)
(require '[clojure.core.reducers :as r])

(defprotocol Enfermedad
	(esAgresiva [self persona])
	(afectarPersona [self persona]))

(defprotocol _EnfermedadInfecciosa
	(reproducirse [self]))


(defn flip [f val1 val2]
	(f val2 val1))

(defn pasarDias [persona dias] (dotimes [n dias] ()))

(defprotocol _Persona
	(contraerEnfermedad [self enfermedad])
	(pasarDia [self]))

(defrecord Persona [nombre temperatura celulas enfermedades]
	_Persona
	(contraerEnfermedad [self enfermedad] (update-in self [:enfermedades] conj enfermedad))
	(pasarDia [self] (r/fold (partial flip afectarPersona self) (:enfermedades self)))
	)

(defn aumentarTemperatura [persona cuanto] (update persona :temperatura + cuanto))
(defn disminuirCelulas [persona cuanto] (update persona :celulas - cuanto))


(defrecord EnfermedadInfecciosa [nombre celulasAmenazadas]
	Enfermedad
	(esAgresiva [self persona] (> (:celulasAmenazadas self) ((comp (partial * 0.10) :celulas) persona)))
	(afectarPersona [self persona] (aumentarTemperatura persona (/ 1000 (:celulasAmenazadas self))))
	_EnfermedadInfecciosa
	(reproducirse [self] (update self :celulasAmenazadas * 2)))
	
(defrecord EnfermedadAutoInmune [nombre celulasAmenazadas cantDias]
	Enfermedad
	(esAgresiva [_ _] (>= cantDias 30))
	(afectarPersona [self persona] (disminuirCelulas persona (:celulasAmenazadas self))))

(def unaMalaria (->EnfermedadInfecciosa "Malaria" 500))
(def otraMalaria (->EnfermedadInfecciosa "Malaria" 800))
(def otitis (->EnfermedadInfecciosa "Otitis"  100))
(def lupus (->EnfermedadAutoInmune "Lupus" 10000 0))


(def logan (->Persona "Logan" 35 3000000 [unaMalaria otitis lupus]))
(def frank (->Persona "Frank" 36 3500000 []))

