class EstadisticasBarriales{
	var ninios = new List()
	
	method top3Caramelos() = self._ordenarPorCaramelos().take(3)
	
	method topEquipamiento() {
		var lista = self._masDeNCaramelos(10)
		return self._equipamientoSinRepetir(lista)
	}
	
	method _ordenarPorCaramelos(){
		return ninios.sortedBy {a, b => a.caramelos() > b.caramelos() }
	}
	method _masDeNCaramelos(cant){
		return ninios.filter{ninio => ninio.caramelos() >= cant}
	}
	
	method _equipamientoSinRepetir(_lista){
		var lista = _lista.map{ninio => ninio.elementos()}.flatten()
		return lista.withoutDuplicates()
	}
}
