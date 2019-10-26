//deberia catchear las exepciones de los atributos de la familia?

class NoPuedeViajarExcepcion inherits Exception { }

class Morty{
	var property nombre = "Morty"
	var disminucionSalud = 30 //Disminucion por irse de aventura
	var property saludMental = 100
	
	method irdeAventura(){
		saludMental -= disminucionSalud
	}
}

class Beth{
	var property nombre = "Beth"
	var aumentoAfecto = 10 // Aumento por irse de aventura
	var property afectoPorPadre = 0
	
	method irdeAventura(){
		afectoPorPadre += aumentoAfecto
	}
}

class Summer{
	var property nombre = "Summer"
	var aumentoAfecto = 10 // Aumento por irse de aventura
	var property afectoPorRick = 0
	var property dia = new Date()  // utilizo el dia de hoy si no se especifica al inicializar
	
	method irdeAventura(){
		if (dia.internalDayOfWeek() != 3){
			throw new NoPuedeViajarExcepcion(message = 'Summer no puede viajar ya que no es miercoles')
		}
		afectoPorRick += aumentoAfecto
	}
}

class Jerry{
	var property nombre = "Jerry"
	method irdeAventura(){ 
		throw new NoPuedeViajarExcepcion(message = 'Jerry no puede ir de aventuras')
	}
}

class Rick{
	var demencia = 0
	var property esPickle = false
	
	method demencia() = demencia
	
	method irdeAventura(familiar){
		try{
			self.viajarCon(familiar)
		} catch e : NoPuedeViajarExcepcion{
			self.transformarseEnPickle()
			throw e
		}

	}
	
	method transformarseEnPickle(){
		demencia /= 2
		esPickle = true
	}
	
	method viajarCon(familiar){
		var cantidadMorty = 50
		var cantidadBeth = 20
		var cantidadSummer = cantidadBeth
		
		familiar.irdeAventura()
		if (familiar.nombre() == 'Morty') self.aumentarDemencia(cantidadMorty)
		if (familiar.nombre() == 'Beth') self.disminuirDemencia(cantidadBeth)
		if (familiar.nombre() == 'Summer') self.disminuirDemencia(cantidadSummer)
	}
	
	method aumentarDemencia(cantidad){
		if (cantidad + demencia >= 100) throw new NoPuedeViajarExcepcion(message='La demencia supero el 100%')
		demencia += cantidad
	}
	
	method disminuirDemencia(cantidad){
		if (0 >= (demencia - cantidad)) throw new NoPuedeViajarExcepcion(message='La demencia es menor a 0')
		demencia -= cantidad
	}
}