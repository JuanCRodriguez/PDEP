//deberia catchear las exepciones de los atributos de la familia?
//deberia transformarse en pickle y arrojar la excepcion nuevamente?

class NoPuedeViajarExcepcion inherits Exception { }

class Morty{
	var property nombre = "Morty"
	var disminucionSalud = 30 //Disminucion por irse de aventura
	var property saludMental = 0
	
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
	
	method irdeAventura(){
		var hoy = new Date()
		if (hoy.internalDayOfWeek() != 3){
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
	var familia = self.__generar_familia()
	
	method irdeAventura(){
		try{
			familia.forEach{familiar =>
				self.viajarCon(familiar)
			}
		} catch e : NoPuedeViajarExcepcion{
			self.transformarseEnPickle()
		}

	}
	
	method transformarseEnPickle(){
		demencia /= 2
	}
	
	method viajarCon(companiero){
		var cantidadMorty = 50
		var cantidadBeth = 20
		var cantidadSummer = cantidadBeth
		
		companiero.irdeAventura()
		if (companiero.nombre() == 'Morty') self.aumentarDemencia(cantidadMorty)
		if (companiero.nombre() == 'Beth') self.disminuirDemencia(cantidadBeth)
		if (companiero.nombre() == 'Summer') self.disminuirDemencia(cantidadSummer)
	}
	
	method aumentarDemencia(cantidad){
		if (cantidad + demencia >= 100) throw new NoPuedeViajarExcepcion(message='La demencia supero el 100%')
		demencia += cantidad
	}
	
	method disminuirDemencia(cantidad){
		if (cantidad - demencia <= 0) throw new NoPuedeViajarExcepcion(message='La demencia es menor a 0')
		demencia -= cantidad
	}
	
	
	method __generar_familia(){ //pinto hacer un random para q tenga muchos familiares
		var lista = []
		var morty = new Morty()
		var beth = new Beth()
		var summer = new Summer()
		var jerry = new Jerry()
		var familiares = [morty, beth, summer, jerry]
		var cant_familiares = familiares.size()
		var familiares_totales = 10
		familiares_totales.times ({_ =>
			var index = 0.randomUpTo(cant_familiares-1)
			lista.add(familiares.get(index))
		})
		return lista
	}
	
}