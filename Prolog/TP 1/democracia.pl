/*
Por el principio de universo cerrado no se agregaron los siguientes predicados:
-El partido violeta no tiene candidatos
-Peter no es candidato del partido Amarillo
-El partido rojo no se presentará en Formosa.
*/
%Candidatos del partido rojo
esCandidatoDelPartido(frank, rojo).
esCandidatoDelPartido(claire, rojo).
esCandidatoDelPartido(catherine, rojo).

%Candidatos del partido azul
esCandidatoDelPartido(garrett, azul).
esCandidatoDelPartido(linda, azul).

%Candidatos del partido amarillo
esCandidatoDelPartido(seth, amarillo).
esCandidatoDelPartido(heather, amarillo).

%Edades y nacio en (validar si nacion en es util)
edadDe(frank, 50).
edadDe(claire, 52).
edadDe(garret, 64).
edadDe(peter, 26).
edadDe(jackie, 38).
edadDe(linda, 30).
edadDe(catherine, 59).

nacioEn(heather, 1969).

%Postulaciones del azul
sePostulaEn(azul, buenosAires).
sePostulaEn(azul, chaco).
sePostulaEn(azul, tierraDelFuego).
sePostulaEn(azul, sanLuis).
sePostulaEn(azul, neuquen).

%Postulaciones del rojo
sePostulaEn(rojo, buenosAires).
sePostulaEn(rojo, santaFe).
sePostulaEn(rojo, cordoba).
sePostulaEn(rojo, chubut).
sePostulaEn(rojo, tierraDelFuego).
sePostulaEn(rojo, sanLuis).

%Postulaciones del amarillo
sePostulaEn(amarillo, chaco).
sePostulaEn(amarillo, formosa).
sePostulaEn(amarillo, tucuman).
sePostulaEn(amarillo, salta).
sePostulaEn(amarillo, santaCruz).
sePostulaEn(amarillo, laPampa).
sePostulaEn(amarillo, corrientes).
sePostulaEn(amarillo, misiones).
sePostulaEn(amarillo, buenosAires).

% habitantes
habitantes(buenosAires,15355000).
habitantes(chaco,1143201).
habitantes(tierraDelFuego,60720).
habitantes(sanLuis,489255).
habitantes(neuquen,637913).
habitantes(santaFe,3397532).
habitantes(cordoba,3567654).
habitantes(chubut,577466).
habitantes(formosa,527895).
habitantes(tucuman,1687305).
habitantes(salta,1333365).
habitantes(santaCruz,273964).
habitantes(laPampa,349299).
habitantes(corrientes,992595).
habitantes(misiones,1189446).

% intencionDeVotoEn(Provincia, Partido, Porcentaje)
intencionDeVotoEn(buenosAires, rojo, 40).
intencionDeVotoEn(buenosAires, azul, 30).
intencionDeVotoEn(buenosAires, amarillo, 30).
intencionDeVotoEn(chaco, rojo, 50).
intencionDeVotoEn(chaco, azul, 20).
intencionDeVotoEn(chaco, amarillo, 0).
intencionDeVotoEn(tierraDelFuego, rojo, 40).
intencionDeVotoEn(tierraDelFuego, azul, 20).
intencionDeVotoEn(tierraDelFuego, amarillo, 10).
intencionDeVotoEn(sanLuis, rojo, 50).
intencionDeVotoEn(sanLuis, azul, 20).
intencionDeVotoEn(sanLuis, amarillo, 0).
intencionDeVotoEn(neuquen, rojo, 80).
intencionDeVotoEn(neuquen, azul, 10).
intencionDeVotoEn(neuquen, amarillo, 0).
intencionDeVotoEn(santaFe, rojo, 20).
intencionDeVotoEn(santaFe, azul, 40).
intencionDeVotoEn(santaFe, amarillo, 40).
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
intencionDeVotoEn(santaCruz, rojo, 10).
intencionDeVotoEn(santaCruz, azul, 20).
intencionDeVotoEn(santaCruz, amarillo, 30).
intencionDeVotoEn(laPampa, rojo, 25).
intencionDeVotoEn(laPampa, azul, 25).
intencionDeVotoEn(laPampa, amarillo, 40).
intencionDeVotoEn(corrientes, rojo, 30).
intencionDeVotoEn(corrientes, azul, 30).
intencionDeVotoEn(corrientes, amarillo, 10).
intencionDeVotoEn(misiones, rojo, 90).
intencionDeVotoEn(misiones, azul, 0).
intencionDeVotoEn(misiones, amarillo, 0).

%Valida si dos partidos estan postulados en una provincia
estanPostuladosEn(UnPartido, OtroPartido, Provincia):- sePostulaEn(UnPartido, Provincia),
                                                       sePostulaEn(OtroPartido, Provincia),
                                                       UnPartido \= OtroPartido.

%Es picante, valida si la provincia tiene mas de 1M habitantes y tiene dos partidos postulados
esPicante(Provincia):- habitantes(Provincia, Habitantes),
                    Habitantes >= 1000000,
                    estanPostuladosEn(UnPartido, OtroPartido, Provincia).


leGanaA(CandidatoGanador, CandidatoPerdedor, Provincia):-   CandidatoGanador \= CandidatoPerdedor,
                                                            esCandidatoDelPartido(CandidatoGanador, PartidoGanador),
                                                            esCandidatoDelPartido(CandidatoPerdedor, PartidoPerdedor),
                                                            sePostulaEn(PartidoGanador, Provincia); 
                                                            (sePostulaEn(PartidoPerdedor, Provincia),
                                                            intencionDeVotoEn(Provincia, PartidoGanador, IntencionGanador),
                                                            intencionDeVotoEn(Provincia, PartidoPerdedor, IntencionPerdedor),
                                                            IntencionGanador > IntencionPerdedor); esCandidatoDelPartido(CandidatoPerdedor, PartidoGanador).





                                                