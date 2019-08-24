%%Vende(Empresa,EstiloDeViaje,Destino)
vende(mcs,crucero(10),rioDeJaneiro).
vende(mcs,crucero(20),mykonos).
vende(vacaviones,allInclusive(burjAllArab), dubai).
vende(vacaviones,qllInclusive(wyndhamPlayaDelCarmen), playaDelCarmen).
vende(moxileres,mochila([carpa,bolsaDeDormir,linterna]), elBolson).
vende(moxileres,([camara,cantimplora,protectorSolar,malla]),puntaDelDiablo).
vende(tuViaje,clasico(primavera,avion),madrid).
vende(tuViaje,clasico(verano,micro),villaGesell).
%%crucero(CantidadDeDias).
%%allInclusive(Hotel).
%%mochila(Objetos).
%%clasico(Temporada,MedioDeTransporte).
%%continente(Destino,Continente).
continente(rioDeJaneiro,sudAmerica).
continente(mykonos,europa).
continente(dubai,asia).
continente(playaDelCarmen,centroAmerica).
continente(puntaDelDiablo,sudAmerica).
continente(sydney,oceania).
continente(madagascar,africa).
continente(madrid,europa).
%%Moneda(Destino,Moneda).
moneda(rioDeJaneiro,real).
moneda(miami,dolar).
moneda(shenzhen,renminbi).
%%CambioAPesos(Moneda,Conversion).
cambioAPesos(real,11).
cambioAPesos(dolar,44).
cambioAPesos(pesoMexicano,2).
cambioAPesos(ariaryMalgache,0.012).


viajaA(Empresa, Continente):-
    vende(Empresa,_, Destino),
    continente(Destino, Continente).