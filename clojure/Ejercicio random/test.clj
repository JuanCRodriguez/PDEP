;; partial == aplicacion parcial
;; ((partial + 5) 4) == (+5) 5 en Haskell
;; comp == composicion de funciones
;; ((comp f2, f1) val) == (f2 . f1) val en haskell
;; ((comp even? (partial + 5)) 5) == (even . (+ 5)) 5 en haskell


(defn deReversa 
;; update elemento nuevoValor utilizando :key
	[auto] 
		(update auto :nafta + (* 1000 (/ 1 5))))
(defn impresionar 
	[auto] 
		(update auto :velInicial * 2))
(defn nitro 
	[auto] 
		(update auto :velInicial + 15))
(defn fingirAmor 
;; Assoc es lo mismo que update pero sin reutilizar el valor de Key
	[auto enamorado] 
		(assoc auto :enamorado enamorado))

(defn cantVocales [enamorado]
;; re-seq genera una lista de los caracteres matcheados por el regex
;; #"regex" se utiliza para indicar que es una regular expression, en este caso matchea todas las vocales
;; apply str castea a string
;; antes de castear a string se genera una lista del estilo ["a" "b" "c"]
;; retorna "abc"
	((comp count (partial apply str) (partial re-seq #"[aeiou]")) enamorado))

(defn criterioVelocidad
;; cond == guardas de haskell a grandes rasgos
	[cantVocales] 
		(cond
			(<= cantVocales 2) 15
			(<= cantVocales 5) 20
			:else 25))

(defn incrementarVelocidad 
	[auto]
	(update auto :velInicial + ((comp criterioVelocidad cantVocales (partial :enamorado)) auto)))

(def Rocha 
	{
	:nafta 300
	:velInicial 0
	:enamorado "Ronco"
	:truco deReversa
	})

(def Biankerr 
	{
	:nafta 500
	:velInicial 20
	:enamorado "Tinch"
	:truco impresionar
	})

(def Gushtav 
	{
	:nafta 200
	:velInicial 130
	:enamorado "PetiLaLinda"
	:truco nitro
	})

(def Rodra 
	{
	:nafta 0
	:velInicial 50
	:enamorado "Taisa"
	:truco (partial fingirAmor "Petra")
	})
