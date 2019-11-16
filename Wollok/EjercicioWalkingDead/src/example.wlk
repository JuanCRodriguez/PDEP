class Caminante{
	var sedSangre
	var somnoliento;
	var cantDientes;
	
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
	var puntosSobreviviente
	var resistenciaMinimaAtaque = 12
	var resistencia
	var carisma
	var estado
	var armas = new List()
	
	method poderOfensivo(){
		var armaRandom = self.armaRandom()
		var poderPropio = puntosSobreviviente * (1 + carisma / 100)
		return poderPropio + armaRandom.poderOfensivo()
	}
	
	method carisma() = carisma
	method aumentarCarisma(cantAumento) {carisma += cantAumento}
	method disminuirCarisma(cantDisminucion) {carisma -= cantDisminucion}
	
	method resistencia() = resistencia
	method aumentarResistencia(cantAumento) {resistencia += cantAumento}
	method disminuirResistencia(cantDisminucion) {resistencia -= cantDisminucion}
	
	method armas() = armas;
	method agregarArma(nuevaArma){armas.add(nuevaArma)}
	method quitarArmas() {armas.clear()}
	method armaRandom() = armas.anyOne()
	method tieneArmasRuidosas() = armas.any{arma => arma.esRuidosa()}
	
	method estado() = estado
	method setEstado(nuevoEstado) {estado = nuevoEstado}
	
	method puedeAtacar() = resistencia >= resistenciaMinimaAtaque
	
	method atacar(caminante){ 
		if(!self.puedeAtacar()) throw new DomainException()
		
		self.disminuirResistencia(2)
		estado.atacar(self)
	}
	
	method comer(){
		estado.comer()
	}
}

class Saludable {
	method atacar(sobreviviente){}
	method comer(sobreviviente){}
}

class Arrebatado {
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
	var disminucionResistenciaAtacar = 3
	var aumentoResistenciaComer = 40
	var turnos = 0
	
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
	
	method integrantes() = integrantes
	method integranteRandom() = integrantes.anyOne()
	method atacantes() = integrantes.filter{integrante => integrante.puedeAtacar()}
	method integranteMasDebil() = integrantes.min {integrante => integrante.poderOfensivo()}
	method lider() = integrantes.max {integrante => integrante.carisma()}
	
	method poderOfensivo(){
		var carismaLider = self.lider().carisma()
		var poderAtacantes = self.atacantes().sum {integrante => integrante.poderOfensivo()}
		return carismaLider + poderAtacantes
	} 

	method tomarLugar(lugar){
		if(!lugar.puedeSerTomadoPor(self)) throw new DomainException()
		
		
		
		lugar.tomarPor(self)
	}
	
	method moverseHacia(lugar){
		
	}
	
	method comer(){
		integrantes.forEach {integrante => integrante.comer()}
	}
	
	method tieneArmasRuidosas(){
		return integrantes.any {integrante => integrante.tieneArmasRuidosas()}
	}
}

class Lugar{
	var caminantes
	
	method puedeSerTomadoPor(grupo) = grupo.poderOfensivo() > self.poderCorrosivo()
	method tomarPor(grupo)
	
	method caminantes() = caminantes
	method poderCorrosivo() = caminantes.sum {caminante => caminante.poderCorrosivo()}
}

class Prision inherits Lugar{
	var pabellones
	var armas
	override method puedeSerTomadoPor(grupo){
		return (grupo.poderOfensivo() >= pabellones * 2) && super(grupo)
	}
	
	override method tomarPor(grupo){
		armas.forEach{arma => grupo.integranteMasDebil().agregarArma(arma)}
	}
}

class Granja inherits Lugar {
	
	override method tomarPor(grupo){
		grupo.comer()
	}
}

class Bosque inherits Lugar {
	var tieneNiebla
	override method puedeSerTomadoPor(grupo){
		return !grupo.tieneArmasRuidosas() && super(grupo)
	}
	
	override method tomarPor(grupo){
		if(tieneNiebla){
			grupo.integranteRandom().quitarArmas()
		}
	}
}
