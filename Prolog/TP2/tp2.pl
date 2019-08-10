% PUNTO 1

candidato(frank).
candidato(claire).
candidato(catherine).
candidato(garret).
candidato(linda).
candidato(jackie).
candidato(seth).
candidato(heather).
candidato(peter).

esCandidato(frank,rojo).
esCandidato(claire,rojo).
esCandidato(catherine,rojo).
esCandidato(garret,azul).
esCandidato(linda,azul).
esCandidato(jackie,amarillo).
esCandidato(seth,amarillo).
esCandidato(heather,amarillo).

partidoDe(bsas,rojo).
partidoDe(bsas,azul).
partidoDe(bsas,amarillo).
partidoDe(santafe,rojo).
partidoDe(cordoba,rojo).
partidoDe(chubut,rojo).
partidoDe(tierradelfuego,rojo).
partidoDe(tierradelfuego,azul).
partidoDe(sanluis,rojo).

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


% PUNTO 2

esPicante(Provincia):-
			habitantes(Provincia,Cantidad),
			Cantidad>1000000, 
			partidoDe(Provincia,Partido1),
			partidoDe(Provincia,Partido2),
			Partido1\=Partido2.


% PUNTO 3

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



% Caso1 partidos distintos 
leGana(Candidato1,Candidato2,Pcia):-
		esCandidato(Candidato1,Partido1),
		esCandidato(Candidato2,Partido2),
		partidoDe(Pcia,Partido1),
		partidoDe(Pcia,Partido2),
		Partido1\=Partido2,
		intencionDeVotoEn(Pcia,Partido1,Votos1),
		intencionDeVotoEn(Pcia,Partido2,Votos2),
		Votos1>Votos2.


% Caso2 mismos partidos
leGana(Candidato1,Candidato2,Pcia):-
		esCandidato(Candidato1,Partido),
		esCandidato(Candidato2,Partido),
		partidoDe(Pcia,Partido),
		Candidato1\=Candidato2.

% Caso3 Candidato de ningun partido  
leGana(Candidato1,Candidato2,Pcia):-
		not(candidato(Candidato2)),
		esCandidato(Candidato1,Partido),
		partidoDe(Pcia,Partido).

% Caso4 partido que n compite en pcia
leGana(Candidato1,Candidato2,Pcia):-
		esCandidato(Candidato1,Partido1),
		esCandidato(Candidato2,Partido2),
		partidoDe(Pcia,Partido1),
		not(partidoDe(Pcia,Partido2)).



% PUNTO 4


elGranCandidato(UnCandidato):-
		nacio(UnCandidato,Anio),
		nacio(OtroCandidato,Anio2),
		UnCandidato\=OtroCandidato,
		Anio>Anio2,
		esCandidato(UnCandidato,Partido),
		esCandidato(OtroCandidato,Partido),
		intencionDeVotoEn(Pcia, Partido, Votos1),
		intencionDeVotoEn(Pcia, Partido2, Votos2),
		Partido\=Partido2,
		forall(partidoDe(Pcia,Partido),Votos1>Votos2).

% PUNTO 5
% Caso Gano en la prov
ajusteConsultora(UnPartido, UnaProvincia, VerdaderoPorcentaje):-
		intencionDeVotoEn(UnaProvincia, UnPartido, UnaIntencionDeVoto),
		forall((intencionDeVotoEn(UnaProvincia, OtroPartido, OtraIntencionDeVoto), UnPartido \= OtroPartido), UnaIntencionDeVoto > OtraIntencionDeVoto), %el primer argumento podria estar delegado
		VerdaderoPorcentaje is UnaIntencionDeVoto - 20.

% Caso else
ajusteConsultora(UnPartido, UnaProvincia, VerdaderoPorcentaje):-
		intencionDeVotoEn(UnaProvincia, UnPartido, UnaIntencionDeVoto),
		VerdaderoPorcentaje is UnaIntencionDeVoto + 5.

% En el caso de querer utilizar los valores reales, 
% seria cuestion de modificar el predicado para que en lugar de IntencionDeVotoEn utilice ajusteConsultora 
% a la hora de realizar la comparacion

% PUNTO 6

% Functores Promesas:
% inflacion(cotaInferior, cotaSuperior)
% construir(listaDeObras)
% nuevosPuestosDeTrabajo(cantidad)

% Functor Obras:
% edilicio(hospital, 800)

% Promesas
% Azul
promete(azul, construir([edilicio(hospital, 1000), edilicio(jardin, 100), edilicio(escuela, 5)])).
promete(azul, inflacion(2, 4)).

% Amarillo
promete(amarillo, construir([edilicio(hospital, 100), edilicio(universidad, 1), edilicio(comisaria, 200)])).
promete(amarillo, nuevosPuestosDeTrabajo(10000)).
promete(amarillo, inflacion(1, 15)).

% Rojo
promete(rojo, nuevosPuestosDeTrabajo(800000)).
promete(rojo, inflacion(10, 30)).


% Punto 7
esEdilicioOtro(ListaEdilicios):-
		not(member(edilicio(hospital, _), ListaEdilicios)),
		not(member(edilicio(escuela, _), ListaEdilicios)),
		not(member(edilicio(jardin, _), ListaEdilicios)),
		not(member(edilicio(comisaria, _), ListaEdilicios)),
		not(member(edilicio(universidad, _), ListaEdilicios)).

% Influencias
influenciaDePromesas(construir(ListaEdilicios), -1):-
		esEdilicioOtro(ListaEdilicios).

influenciaDePromesas(nuevosPuestosDeTrabajo(Cant), 3):-
		Cant > 50000.

influenciaDePromesas(nuevosPuestosDeTrabajo(Cant), 0):-
		Cant =< 50000.

influenciaDePromesas(inflacion(Min, Max), Variacion):-
		Variacion is ((Min + Max) / 2) * (-1).

influenciaDePromesas(construir(ListaEdilicios), 2):-
		member(edilicio(hospital, _), ListaEdilicios).

influenciaDePromesas(construir(ListaEdilicios), Variacion):-
		member(edilicio(escuela, Cant), ListaEdilicios),
		Variacion is Cant * 0.10.

influenciaDePromesas(construir(ListaEdilicios), Variacion):-
		member(edilicio(jardin, Cant), ListaEdilicios),
		Variacion is Cant * 0.10.

influenciaDePromesas(construir(ListaEdilicios), 2):-
		member(edilicio(comisaria, 200), ListaEdilicios).

influenciaDePromesas(construir(ListaEdilicios), 0):-
		member(edilicio(universidad, _), ListaEdilicios).


% Punto 8
promedioDeCrecimiento(UnPartido, Sumatoria):-
		partidoDe(_, UnPartido),
		findall(Variacion, (promete(UnPartido, Promesa), influenciaDePromesas(Promesa, Variacion)), ListaVariaciones),
		sum_list(ListaVariaciones, Sum),
		Sumatoria is Sum.