;(ns drcasa.core)

(defprotocol Persona ;Funciona como si fuera una clase abstracta, muestro la firma de los metodos que van a implementar
					 ; todo: seguir implementando
	(aumentarTemperatura [self cantidad] update self :temperatura + cantidad))

(defprotocol Enfermedad  
	(esAgresiva [self persona])
	(pasarDia [self persona]))
	
(defrecord Persona [nombre temperatura celulas enfermedades])
(defrecord EnfermedadInfecciosa [nombre celulasAmenazadas]
	Enfermedad
	(esAgresiva [self persona] (> celulasAmenazadas ((comp (partial * 0.10) :celulas) persona)))
	(pasarDia [self persona] (aumentarTemperatura persona (/ 1000 celulasAmenazadas))))
	
(defrecord EnfermedadAutoInmune [nombre celulasAmenazadas cantDias])

(def unaMalaria (->EnfermedadInfecciosa "Malaria" 500))
(def otraMalaria (->EnfermedadInfecciosa "Malaria" 800))
(def otitis (->EnfermedadInfecciosa "Otitis"  100))
(def lupus (->EnfermedadAutoInmune "Lupus" 10000 0))

(def logan (->Persona "Logan" 35 3000000 [unaMalaria otitis lupus]))
(def frank (->Persona "Frank" 36 3500000 []))

