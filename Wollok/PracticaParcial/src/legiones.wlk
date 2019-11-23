import susto.Ninio

class Legion inherits Ninio{
	var miembros = new List()
	
	method lider() {
		try{
			return miembros.max {ninio => ninio.capacidadSusto()}
		}catch e{
			throw new DomainException(message = "No hay lider")
		}
	}
	
	override method capacidadSusto(){
		return miembros.sum {miembro => miembro.capacidadSusto()}
	}
	
	override method caramelos(){
		return miembros.sum {miembro => miembro.caramelos()}
	}
		
	override method aumentarCaramelos(cantidad){
		self.lider().aumentarCaramelos(cantidad)
	}
	
	method crearLegion(conjuntoNinios){
		if(conjuntoNinios.size() < 2) throw new DomainException()
		miembros = conjuntoNinios
	}	
}