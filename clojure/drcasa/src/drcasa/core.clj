(ns drcasa.core)

(defn flip
  "	Se comporta como el flip de haskell, lo defino a manopla porque no existe en clojure"
  [f arg1, arg2]
  (f arg2 arg1))

(defprotocol Enfermedad
  "	Protocolo base para las enfermedades
  "
  (esAgresiva [self persona])
  (afectarPersona [self persona])
  (disminuirCelulasAmenazadas [self cantidad]))

(defprotocol _EnfermedadInfecciosa
  "Protocolo para las enfermedades infecciosas
  "
  (reproducirse [self]))

(defprotocol _EnfermedadAutoInmune
  "	Protocolo para las enfermedades autoinmunes
  "
  (aumentarDia [self]))

"Defino las funciones que se van a comportar de igual manera en medico y en persona fuera de los records para no repetir logica"

(defn _aumentarDiaEnfermedades
  [self]
  "	update-in data [:key] f: actualiza el valor aplicando f(:key data)
    (# f arg): f(%) (en este caso el arg seria el valor viejo de update-in)
    if condicion funcionEsTrue funcionEsFalse
    utilizo map ya que :enfermedades retorna una lista
  "
  (update-in self [:enfermedades] (partial map #(if (satisfies? _EnfermedadAutoInmune %) (aumentarDia %) %))))

(defn _contraerEnfermedad
  "
    lista conj elemento: agrega un elemento a una lista
  "
  [self enfermedad]
  (update-in self [:enfermedades] conj enfermedad))

(defn _pasarDia
  "	Aplica todas las enfermedades
    reduce f valorInicial Lista: funciona parecido al fold de haskell
  "
  [self]
  ((comp _aumentarDiaEnfermedades (partial reduce (partial flip afectarPersona) self) :enfermedades) self))

(defn _pasarDias
  "
    nth lista n: consigue el n elemento de una lista
    iterate f: genera una lista infinita del estilo f(f(x))
  "
  [self n]
  (nth (iterate _pasarDia self) n))

(defn _aumentarTemperatura
  [self cuanto]
  (update self :temperatura + cuanto))

(defn _disminuirCelulas
  [self cuanto]
  (update self :celulas - cuanto))

(defn _getEnfAutoInmunes
  " satisfies? protocolo elemento: retorna true si el elemento implementa ese protocolo
  "
  [self]
  (filter (partial satisfies? _EnfermedadAutoInmune) (:enfermedades self)))

(defn _compararTemp
  " Recibe una funcion que espera un valor a comparar, ej: (partial > 5)
  "
  [self comparacion]
  ((comp comparacion :temperatura) self))

(defn _compararCelulas
  " idem _compararTemp
  "
  [self comparacion]
  ((comp comparacion :celulas) self))

(defn _enfMayorA5Dias
  ;Solo existe not-any? en clojure
  ;asique tengo que usar not para hacer doble negacion ¯\\_(ツ)_/¯
  ;some f lista: busca el primer elemento que cumpla la condicion, caso contrario retorna nil
  ;not bool: (not true) = false

  [self]
  ((comp not (partial not-any? (comp (partial <= 5) :cantDias)) _getEnfAutoInmunes) self))

(defn _enComa?
  [self]
  (or (_compararTemp self (partial <= 45)) (_compararCelulas self (partial >= 1000000)) (_enfMayorA5Dias self)))

(defn _eliminarEnfermedadesCuradas [enfermedades]
	(filter #((comp (partial < 0) :celulasAmenazadas) %) enfermedades))



(defn _atenuarEnfermedades
  [self cantidad]
  (update-in self [:enfermedades]
						 					(comp
											_eliminarEnfermedadesCuradas
											(partial map #(disminuirCelulasAmenazadas % cantidad)))))

; La implementacion de un protocolo se puede realizar de dos maneras,
; una es implementando en cada record y otra es generando un map con la implementacion de cada una y extendiendo el record
; Para evitar la repeticion de logica y codigo, extiendo el record de Persona y Medico
(def mapImplementacionesPersona
  {:contraerEnfermedad
   (fn [self enfermedad] (_contraerEnfermedad self enfermedad))
   :pasarDia
   (fn [self] (_pasarDia self))
   :pasarDias
   (fn [self n] (_pasarDias self n))
   :aumentarTemperatura
   (fn [self cuanto] (_aumentarTemperatura self cuanto))
   :disminuirCelulas
   (fn [self cuanto] (_disminuirCelulas self cuanto))
   :enComa?
   (fn [self] (_enComa? self))
   :getEnfAutoInmunes
   (fn [self] (_getEnfAutoInmunes self))
	 :atenuarEnfermedades
	 (fn [self cantidad] (_atenuarEnfermedades self cantidad))
   })

(defprotocol _Persona
  "	Protocolo para las personas
  "
  (contraerEnfermedad [self enfermedad])
  (pasarDia [self])
  (pasarDias [self n])
  (aumentarTemperatura [self cuanto])
  (disminuirCelulas [self cuanto])
  (enComa? [self])
  (getEnfAutoInmunes [self])
  (atenuarEnfermedades [self cantidad]))

(defprotocol _Medico
  " Protocolo para los medicos
  "
  (calcularAtenuacion [self])
  (curar [self, quien])
	(curarse [[self]])
  )

(defprotocol _jefeMedico
	(subordinadoRandom [self]))

(defrecord Medico [nombre temperatura celulas enfermedades medicacion]
  _Medico
  (calcularAtenuacion [self] (* medicacion 15))
	(curar [self quien] ((comp (partial atenuarEnfermedades quien) calcularAtenuacion) self))
	(curarse [self] (curar self self)))

(extend Medico
	;Extiendo el record para implementar el protocolo persona
  _Persona
  mapImplementacionesPersona
  )

(defrecord JefeMedico [nombre temperatura celulas enfermedades subordinados]
	_Medico
	(curar [self quien] (curar (subordinadoRandom self) quien))
	_jefeMedico
	(subordinadoRandom [self] ((comp rand-nth :subordinados) self))
	)
(extend JefeMedico
	_Persona
	mapImplementacionesPersona)


(defrecord Persona [nombre temperatura celulas enfermedades])
(extend Persona
  _Persona
  mapImplementacionesPersona)

(defn _disminuirCelulasAmenazadas [self cantidad] (update self :celulasAmenazadas - cantidad))
(defrecord EnfermedadInfecciosa [nombre celulasAmenazadas]

  Enfermedad
  (esAgresiva [self persona]
    (> (:celulasAmenazadas self) ((comp (partial * 0.10) :celulas) persona)))

  (disminuirCelulasAmenazadas [self cantidad] (_disminuirCelulasAmenazadas self cantidad))

  (afectarPersona [self persona]
    ((comp (partial aumentarTemperatura persona) (partial / 1000) :celulasAmenazadas) self))

  _EnfermedadInfecciosa
  (reproducirse [self]
    (update self :celulasAmenazadas * 2)))

(defrecord EnfermedadAutoInmune [nombre celulasAmenazadas cantDias]

  Enfermedad
  (esAgresiva [_ _]
    (>= cantDias 30))

  (disminuirCelulasAmenazadas [self cantidad] (_disminuirCelulasAmenazadas self cantidad))

  (afectarPersona [self persona]
    ((comp (partial disminuirCelulas persona) :celulasAmenazadas aumentarDia) self))

  _EnfermedadAutoInmune
  (aumentarDia [self]
    (update self :cantDias + 1)))



(def unaMalaria (->EnfermedadInfecciosa "Malaria" 500))
(def otraMalaria (->EnfermedadInfecciosa "Malaria" 800))
(def otitis (->EnfermedadInfecciosa "Otitis" 100))
(def lupus (->EnfermedadAutoInmune "Lupus" 10000 0))


(def logan (->Persona "Logan" 36 3000000 [unaMalaria otitis lupus]))
(def frank (->Persona "Frank" 36 3500000 []))
(def unMedico (->Medico "Pepe" 36 3500000 [] 2))
(def otroMedico (->Medico "Nacho" 36 3500000 [] 40))
(def house (->JefeMedico "House" 36 350000 [unaMalaria] [unMedico]))