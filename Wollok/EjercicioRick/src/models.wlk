//deberia catchear las exepciones de los atributos de la familia?

class NoPuedeViajarExcepcion inherits Exception { }

class Morty{
	var property aumentoDemenciaRick = 50
	var property nombre = "Morty"
	var disminucionSalud = 30 //Disminucion por irse de aventura
	var property saludMental = 100
	
	method irdeAventura(rick){
		rick.aumentarDemencia(aumentoDemenciaRick)
		saludMental -= disminucionSalud
	}
}

class Beth{
	var property nombre = "Beth"
	var disminucionDemenciaRick = 20
	var aumentoAfecto = 10 // Aumento por irse de aventura
	var property afectoPorPadre = 0
	
	method irdeAventura(rick){
		rick.disminuirDemencia(disminucionDemenciaRick)
		afectoPorPadre += aumentoAfecto
	}
}

class Summer{
	var property nombre = "Summer"
	var aumentoAfecto = 10 // Aumento por irse de aventura
	var property afectoPorRick = 0
	var property dia = new Date()  // utilizo el dia de hoy si no se especifica al inicializar
	var disminucionDemenciaRick = 20
	
	method irdeAventura(rick){
		if (dia.internalDayOfWeek() != 3){
			throw new NoPuedeViajarExcepcion(message = 'Summer no puede viajar ya que no es miercoles')
		}
		rick.disminuirDemencia(disminucionDemenciaRick)
		afectoPorRick += aumentoAfecto
	}
}

class Jerry{
	var property nombre = "Jerry"
	method irdeAventura(rick){ 
		throw new NoPuedeViajarExcepcion(message = 'Jerry no puede ir de aventuras')
	}
}

class Rick{
	var demencia = 0
	var property esPickle = false
	
	method demencia() = demencia
	
	method irdeAventura(familiar){
		try{
			familiar.irdeAventura(self)
		} catch e : NoPuedeViajarExcepcion{
			self.transformarseEnPickle()
		}

	}
	
	method transformarseEnPickle(){
		demencia /= 2
		esPickle = true
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