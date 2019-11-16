class Caminante{
	var sedSangre
	var somnoliento
	var cantDientes
	
	method sed() = sedSangre
	method estaSomnoliento() = somnoliento
	method cantDientes() = cantDientes
	method poderCorrosivo() = 2 * sedSangre + cantDientes
	
	method setSed(nuevaSed) {sedSangre = nuevaSed}
	method setSomnoliento(nuevoEstado) {somnoliento = nuevoEstado}
	method setDientes(nuevosDientes) {cantDientes = nuevosDientes}
	
	method aumentarSed(cantAumento) {sedSangre += cantAumento}
	method disminuirSed(cantDisminucion) {sedSangre -= cantDisminucion}
	
	method esDebil() = (sedSangre <= 15 && somnoliento)
}

class Sobreviviente {
	var puntosSobreviviente = 0
	var resistenciaMinimaAtaque = 12
	var resistencia = 0
	var carisma = 0
	var estado
	var armas = new List()
	
	method poderOfensivo(){
		var poderPropio = puntosSobreviviente * (1 + carisma / 100)
		return poderPropio + self.poderOfensivoArmaRandom()
	}
	
	method carisma() = carisma
	method aumentarCarisma(cantAumento) {carisma += cantAumento}
	method disminuirCarisma(cantDisminucion) {carisma -= cantDisminucion}
	
	method resistencia() = resistencia
	method aumentarResistencia(cantAumento) {resistencia += cantAumento}
	method disminuirResistencia(cantDisminucion) {resistencia -= cantDisminucion}
	
	method armas() = armas;
	method agregarArma(nuevaArma) {armas.add(nuevaArma)}
	method quitarArmas() {armas.clear()}
	method tieneArmasRuidosas() = armas.any{arma => arma.esRuidosa()}
	
	method estado() = estado
	method setEstado(nuevoEstado) {estado = nuevoEstado}
	
	method puedeAtacar() = resistencia >= resistenciaMinimaAtaque
	
	method poderOfensivoArmaRandom(){
		if(armas.isEmpty()) return 0
		
		var armaRandom = armas.anyOne()
		return armaRandom.poderOfensivo()
	}
	
	method atacar(caminante){ 
		if(!self.puedeAtacar()) throw new DomainException()
		
		self.disminuirResistencia(2)
		estado.atacar(self)
	}
	
	method comer(){
		estado.comer(self)
	}
}

class Saludable {
	var property nombre = "Saludable"
	method atacar(sobreviviente){}
	method comer(sobreviviente){}
}

class Arrebatado {
	var property nombre = "Arrebatado"
	var aumentoCarismaAtacar = 1
	var aumentoCarismaComer = 20
	var aumentoResistenciaComer = 50
	
	method atacar(sobreviviente){
		sobreviviente.aumentarCarisma(aumentoCarismaAtacar)
	}
	
	method comer(sobreviviente){
		sobreviviente.aumentarCarisma(aumentoCarismaComer)
		sobreviviente.aumentarResistencia(aumentoResistenciaComer)
	}
}

class Infectado{
	var property nombre = "Infectado"
	var disminucionResistenciaAtacar = 3
	var aumentoResistenciaComer = 40
	var property turnos = 0
	
	method atacar(sobreviviente){
		sobreviviente.disminuirResistencia(disminucionResistenciaAtacar)
		if (turnos >= 5){
			sobreviviente.setEstado(new Desmayado())
		}
		turnos += 1
	}
	
	method comer(sobreviviente){
		sobreviviente.aumentarResistencia(aumentoResistenciaComer)
		if(turnos <= 3){
			sobreviviente.setEstado(new Saludable())
		}else{
			turnos = 0
		}
	}
	
}

class Desmayado {
	var property nombre = "Desmayado"
	method atacar(sobreviviente){}
	method comer(sobreviviente){
		sobreviviente.setEstado(new Saludable())
	}
}

class Arma{
	var tipo
	var calibre
	var potenciaDestructiva
	
	method poderOfensivo() = calibre * 2 + potenciaDestructiva
	
	method tipo() = tipo
	method esRuidosa() = tipo.esRuidosa()
}

object armaRuidosa{
	method esRuidosa() = true
}

object armaSilenciosa{
	method esRuidosa() = false
}

class Predador inherits Sobreviviente {
	var esclavos = new List()
	
	method esclavos() = esclavos
	method agregarEsclavo(nuevoEsclavo) {esclavos.add(nuevoEsclavo)}
	method totalPoderCorrosivoEsclavos() = esclavos.sum {esclavo => esclavo.poderCorrosivo()}
	
	override method atacar(caminante){
		super(caminante)
		if(caminante.esDebil()){
			self.agregarEsclavo(caminante)
		}
	}
	
	override method poderOfensivo(){
		return (super() / 2) + self.totalPoderCorrosivoEsclavos()
	}
}

class GrupoSobreviviente{
	var integrantes = new Set()
	var ubicacion = "Buenos Aires"
	
	method integrantes() = integrantes
	method integranteRandom() = integrantes.anyOne()
	method atacantes() = integrantes.filter{integrante => integrante.puedeAtacar()}
	method integrantesJodidos() = integrantes.filter {integrante => integrante.resistencia() <= 40}
	method atacanteRandom() = self.atacantes().anyOne()
	method integranteMasDebil() = integrantes.min {integrante => integrante.poderOfensivo()}
	method lider() = integrantes.max {integrante => integrante.carisma()}
	
	method poderOfensivo(){
		var carismaLider = self.lider().carisma()
		var poderAtacantes = self.atacantes().sum {integrante => integrante.poderOfensivo()}
		return carismaLider * poderAtacantes
	} 
	
	method puedeTomarLugar(lugar){
		return lugar.puedeSerTomado(self)
	}
	
	method tomarLugar(lugar){
		if(!self.puedeTomarLugar(lugar)){
			self.eliminarIntegranteMasDebil()
			self.pasarAInfectado(self.integrantesJodidos())
		}else{
			self.moverseHacia(lugar)
			lugar.caminantes().forEach{caminante => self.atacanteRandom().atacar(caminante)}
			lugar.tomarPor(self)
		}
	}

	method comer(){
		integrantes.forEach {integrante => integrante.comer()}
	}
	
	method tieneArmasRuidosas(){
		return integrantes.any {integrante => integrante.tieneArmasRuidosas()}
	}
	
	method ubicacion() = ubicacion
	method moverseHacia(lugar) {ubicacion = lugar.ubicacion()}
	
	method eliminarIntegranteMasDebil(){
		integrantes.remove(self.integranteMasDebil())
	}	
	
	method pasarAInfectado(_integrantes){
		_integrantes.forEach{integrante => integrante.setEstado(new Infectado())}
	}
	
}

class Lugar{
	var caminantes
	var property ubicacion = "La Plata"
	
	method puedeSerTomado(grupo) {
		return grupo.poderOfensivo() > self.poderCorrosivo() && self.puedeSerTomadoEspecifico(grupo)
	}
	method tomarPor(grupo)
	
	method caminantes() = caminantes
	method poderCorrosivo() = caminantes.sum {caminante => caminante.poderCorrosivo()}
}

class Prision inherits Lugar{
	var pabellones
	var armas
	method puedeSerTomadoEspecifico(grupo){
		return (grupo.poderOfensivo() >= pabellones * 2)
	}
	
	override method tomarPor(grupo){
		armas.forEach{arma => grupo.integranteMasDebil().agregarArma(arma)}
	}
}

class Granja inherits Lugar {
	
	method puedeSerTomadoEspecifico(grupo){
		return true
	}
	
	override method tomarPor(grupo){
		grupo.comer()
	}
}

class Bosque inherits Lugar {
	var tieneNiebla
	
	method puedeSerTomadoEspecifico(grupo){
		return !grupo.tieneArmasRuidosas()
	}
	
	override method tomarPor(grupo){
		if(tieneNiebla){
			grupo.integranteRandom().quitarArmas()
		}
	}
}
