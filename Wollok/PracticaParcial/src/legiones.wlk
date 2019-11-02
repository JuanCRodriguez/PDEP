class Legion {
	var miembros
	
	method lider() {
		return miembros.max {ninio => ninio.capacidadSusto()}
	}
	method capacidadSusto(){
		return miembros.sum {miembro => miembro.capacidadSusto()}
	}
	
	method caramelos(){
		return miembro.sum {miembro => miembro.caramelos()}
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