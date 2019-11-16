object tom {
	var energia = 80
	var property coordenadas = (0 -> 0)
	
	method energia() = energia
	
	method energia(valor) {
		energia = valor	
	}
	
	method velocidad(){
		return 5 + (energia / 10)
	}	
	
	method puedeAtrapar(quien){
		return self.velocidad() > quien.velocidad()
	}
	
	method correrA(quien){
		const distancia_total = distancia.entre(self.coordenadas(), quien.coordenadas())
		const nueva_energia = 0.5 * self.velocidad() * distancia_total
		self.energia(nueva_energia)
		self.coordenadas(quien.coordenadas())
	}
	
}

object jerry {
	var peso = 3
	var property coordenadas = (10 -> 5)
	
	method peso() = peso
	
	method peso(valor){
		peso = valor
	}
	
	method velocidad(){
		return 10 - peso
	}	
}

object distancia {
	
	method entre(unaCoordenada, otraCoordenada){
		const distanciaX = unaCoordenada.key() - otraCoordenada.key()
		const distanciaY = unaCoordenada.value() - otraCoordenada.key()
		return distanciaX + distanciaY 
	}
}