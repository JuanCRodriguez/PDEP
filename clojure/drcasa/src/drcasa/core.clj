(ns drcasa.core)
(defrecord Persona [nombre temperatura celulas enfermedades])
(defrecord EnfermedadInfecciosa [nombre celulasAmenazadas])
(defrecord EnfermedadAutoInmune [nombre celulasAmenazadas cantDias])

(def unaMalaria (->EnfermedadInfecciosa "Malaria" 500))
(def otraMalaria (->EnfermedadInfecciosa "Malaria" 800))
(def otitis (->EnfermedadInfecciosa "Otitis"  100))
(def lupus (->EnfermedadAutoInmune "Lupus" 10000 0))

(def logan (->Persona "Logan" 35 3000000 [unaMalaria otitis lupus]))
(def frank (->Persona "Frank" 36 3500000 []))


(defprotocol enfermedadEsAgresiva (fn [enfermedad persona] (class enfermedad)))
(defmethod enfermedadEsAgresiva drcasa.core.EnfermedadInfecciosa
  [enfermedad persona]
  (> (:celulasAmenazadas enfermedad) ((comp (partial * 0.10) :celulas) persona)))
;(defmethod enfermedadEsAgresiva :autoinmune
;  [enfermedad persona]
;  )
;(def (enfermedadEsAgresiva unaMalaria logan))