esCandidato(frank,rojo).
esCandidato(claire,rojo).
esCandidato(catherine,rojo).
esCandidato(garret,azul).
esCandidato(linda,azul).
esCandidato(jackie,amarillo).
esCandidato(seth,amarillo).
esCandidato(heather,amarillo).


candidatos(bsas,rojo).
candidatos(bsas,azul).
candidatos(bsas,amarillo).
candidatos(santafe,rojo).
candidatos(cordoba,rojo).
candidatos(chubut,rojo).
candidatos(tierradelfuego,rojo).
candidatos(tierradelfuego,azul).
candidatos(sanluis,rojo).

localidadesPartidoRojo(bsas,santafe,cordoba,chubut,tierradelfuego,sanluis).
localidadesPartidoAzul(bsas,chaco,tierradelfuego,sanluis,neuquen).
localidadesPartidoAmarillo(chaco,formosa,tucuman,salta,santacruz,lapampa,corrientes,misiones,bsas).

habitantes(bsas,15355000).
habitantes(chaco,1143201).
habitantes(tierradelfuego,60720).
habitantes(sanluis,489255).
habitantes(neuquen,637913).
habitantes(santafe,3397532).
habitantes(cordoba,3567654).
habitantes(chubut,577466).
habitantes(formosa,527895).
habitantes(tucuman,1687305).
habitantes(salta,1333365).
habitantes(santacruz,273964).
habitantes(lapampa,349299).
habitantes(corrientes,992595).
habitantes(misiones,1189446).


nacio(frank,1969).
nacio(claire,1967).
nacio(garret,1955).
nacio(peter,1993).
nacio(jackie,1981).
nacio(linda,1989).
nacio(catherine,1960).
nacio(heather,1969).

edad(Persona,Edad):- nacio(Persona,Anio),
		Anio is 2019-Edad.


esPicante(Provincia):-
		habitantes(Provincia,Anio), Anio>1000000, candidatos(Provincia,Pcia1), candidatos(Provincia,Pcia2),Pcia1\=Pcia2.




%%intencionDeVotoEn(Provincia, Partido, Porcentaje)
intencionDeVotoEn(bsas, rojo, 40).
intencionDeVotoEn(bsas, azul, 30).
intencionDeVotoEn(bsas, amarillo, 30).
intencionDeVotoEn(chaco, rojo, 50).
intencionDeVotoEn(chaco, azul, 20).
intencionDeVotoEn(chaco, amarillo, 0).
intencionDeVotoEn(tierradelfuego, rojo, 40).
intencionDeVotoEn(tierradelfuego, azul, 20).
intencionDeVotoEn(tierradelfuego, amarillo, 10).
intencionDeVotoEn(sanluis, rojo, 50).
intencionDeVotoEn(sanluis, azul, 20).
intencionDeVotoEn(sanluis, amarillo, 0).
intencionDeVotoEn(neuquen, rojo, 80).
intencionDeVotoEn(neuquen, azul, 10).
intencionDeVotoEn(neuquen, amarillo, 0).
intencionDeVotoEn(santafe, rojo, 20).
intencionDeVotoEn(santafe, azul, 40).
intencionDeVotoEn(santafe, amarillo, 40).
intencionDeVotoEn(cordoba, rojo, 10).
intencionDeVotoEn(cordoba, azul, 60).
intencionDeVotoEn(cordoba, amarillo, 20).
intencionDeVotoEn(chubut, rojo, 15).
intencionDeVotoEn(chubut, azul, 15).
intencionDeVotoEn(chubut, amarillo, 15).
intencionDeVotoEn(formosa, rojo, 0).
intencionDeVotoEn(formosa, azul, 0).
intencionDeVotoEn(formosa, amarillo, 0).
intencionDeVotoEn(tucuman, rojo, 40).
intencionDeVotoEn(tucuman, azul, 40).
intencionDeVotoEn(tucuman, amarillo, 20).
intencionDeVotoEn(salta, rojo, 30).
intencionDeVotoEn(salta, azul, 60).
intencionDeVotoEn(salta, amarillo, 10).
intencionDeVotoEn(santacruz, rojo, 10).
intencionDeVotoEn(santacruz, azul, 20).
intencionDeVotoEn(santacruz, amarillo, 30).
intencionDeVotoEn(lapampa, rojo, 25).
intencionDeVotoEn(lapampa, azul, 25).
intencionDeVotoEn(lapampa, amarillo, 40).
intencionDeVotoEn(corrientes, rojo, 30).
intencionDeVotoEn(corrientes, azul, 30).
intencionDeVotoEn(corrientes, amarillo, 10).
intencionDeVotoEn(misiones, rojo, 90).
intencionDeVotoEn(misiones, azul, 0).
intencionDeVotoEn(misiones, amarillo, 0).




leGana(Candidato1,Candidato2,Pcia):-
		esCandidato(Candidato1,Partido1),
		esCandidato(Candidato2,Partido2),
		candidatos(Pcia,Partido1),
		candidatos(Pcia,Partido2),
		Partido1\=Partido2,
		intencionDeVotoEn(Pcia,Partido1,Porcentaje1),
		intencionDeVotoEn(Pcia,Partido2,Porcentaje2),
		Porcentaje1>Porcentaje2.

leGana(Candidato1,Candidato2,Pcia):-
		esCandidato(Candidato1,Partido1),
		esCandidato(Candidato2,Partido2),
		candidatos(Pcia,Partido1),
		candidatos(Pcia,Partido2),
		Partido1==Partido2.


		
