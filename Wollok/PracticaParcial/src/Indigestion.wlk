class Sano{
	method comer(cantidad, ninio){
		ninio.quitarCaramelos(cantidad)	
		if(cantidad > 10){
			ninio.cambiarEstado(new Empachado())
		}
	}
}

class Empachado{
	method comer(cantidad, ninio){
		ninio.disminuirActitud(ninio.actitud() / 2)
		if(cantidad > 10){
			ninio.cambiarEstado(new EnCama())
		}
	}
}

class EnCama{
	method comer(cantidad, ninio){
		ninio.disminuirActitud(0)
		throw new DomainException()
	}
}