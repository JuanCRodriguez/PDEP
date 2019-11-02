class Legion {
	var miembros
	
	method lider() {
		return miembros.fold(miembros.anyOne().capacidadSusto(), {
			acum, miembro => acum.max(miembro.capacidadSusto())
		})
	}
	method capacidadSusto(){
		return miembros.fold(0, {acum, miembro => acum + miembro.capacidadSusto()})
	}
	
	method caramelos(){
		return miembro.fold(0, {acum, miembro => acum + miembro.caramelos()})
	}
	
	method asustar(adulto){
		if(!adulto.puedeSerAsustadoPor(self)) throw new Exception()
		adulto.asustarse(self)
	}
		
	method aumentarCaramelos(cantidad){
		self.lider().aumentarCaramelos(cantidad)
	}
	
	method crearLegion(conjuntoNinios){
		if(conjuntoNinios.size() <= 2) throw new Exception()
		miembros = conjuntoNinios
	}	
}