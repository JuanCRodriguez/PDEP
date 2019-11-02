import legiones.Legion

class Maquillaje {
	var property cantAsusta = 3
}

class Traje {
	method cantAsusta()
}

class TrajeTierno inherits Traje {
	var cantAsusta = 2
	
	override method cantAsusta() = cantAsusta
}
	

class TrajeTerrorifico inherits Traje {
	var cantAsusta = 5
	
	override method cantAsusta() = cantAsusta
}


class Ninio {
	var cantCaramelos
	var actitud
	var elementos = new List()
	var estado
	
	method cambiarEstado(nuevoEstado){estado = nuevoEstado}
	
	method estado() = estado
	
	method aumentarCaramelos(cant) {cantCaramelos += cant}
	
	method disminuirActitud(nuevaActitud) {actitud = nuevaActitud}
	
	method actitud() = actitud
	
	method quitarCaramelos(cant) {
		if(0 > (cantCaramelos - cant)) throw new Exception()
		cantCaramelos -= cant
	}
	
	method caramelos() = cantCaramelos
	
	method capacidadSusto() = self.sumatoriaSustoElementos() * actitud
	
	method elementos() = elementos
	
	method sumatoriaSustoElementos() = elementos.fold(0, {acum, elemento => acum + elemento.cantAsusta()})
	
	method asustar(adulto){
		if(!adulto.puedeSerAsustadoPor(self)) throw new Exception()
		adulto.asustarse(self)
	}
	
	method comer(cantidad){
		estado.comer(cantidad, self)
	}
	
}

class Adulto {
	var cantCaramelosMinima = 15
	var cantVecesAsustado = 0
	
	method tolerancia() = 10 * cantVecesAsustado
	
	method puedeSerAsustadoPor(ninio) = ninio.capacidadSusto() > self.tolerancia()
	
	method asustarse(ninio){
		if(ninio.caramelos() > cantCaramelosMinima) cantVecesAsustado += 1
		self.entregarCaramelos(ninio)
	}
	
	method cantCaramelos() = self.tolerancia() / 2
	
	method entregarCaramelos(ninio) {ninio.aumentarCaramelos(self.cantCaramelos())}
}

class Abuelo inherits Adulto {
	
	override method puedeSerAsustadoPor(ninio) = true
	
	override method cantCaramelos() = super() / 2
	 
}

class AdultoNecio inherits Adulto {
	override method puedeSerAsustadoPor(ninio) = false
}

