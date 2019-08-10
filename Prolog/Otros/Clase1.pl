padre(homero, lisa).
padre(homero, bart).
padre(homero, maggie).
padre(abe, homero).
padre(adam, abe).


% findall(Elemento, condicionElemento, listaElementos).
% Agrega el Elemento a la lista si se cumple la condicion.
% Elemento debe ligarse en la condicion.
% Se puede utilizar para contar y comparar (cuento y luego comparo)
% Se puede utilizar para sumar (mediante sumlist || sum_list)

cuantosHijosTiene(Padre, CantidadHijos):-
    padre(Padre, _), %Generador de padres
    findall(Hijo, padre(Padre, Hijo), Hijos),
    length(Hijos, CantidadHijos).

tieneMasDeUnHijo(Padre):-
    padre(Padre, Hijo),
    padre(Padre, OtroHijo),
    Hijo \= OtroHijo.

tieneUnSoloHijo(Padre):- 
    padre(Padre, _),
    not(tieneMasDeUnHijo(Padre)).

manutencion(bart, 100).
manutencion(lisa, 1500).
manutencion(maggie, 0).
manutencion(homero, 10).

cuantoDuele(Padre, Gasto):-
    padre(Padre, _),
    findall(Manutencion, (padre(Padre, UnHijo), manutencion(UnHijo, Manutencion)), Manutenciones),
    sum_list(Manutenciones, Gasto).

%Recursividad
% Punto de corte, si no lo ponemos, dara false en vez de iterar
ancestro(Persona, Ancestro):- 
    padre(Ancestro, Persona).

%Consulta recursiva
ancestro(Persona, Ancestro):-
    padre(Padre, Persona),
    ancestro(Padre, Ancestro).

% Practica: Implementar recursivamente
% ? member(Elem, [1, 5, 7])
% elem = 1;
% elem = 5;
% elem = 7;

% ? last([5,3,7], Ultimo)
% ultimo = 7

% ? maximo([3,2,9], Maximo)
% maxomo = 9

head([X|_], X).
tail([_|Xs], Xs).

memberPropio(X, [X|_]).
memberPropio(X, [_|Xs]):-
    memberPropio(X, Xs).

lastPropio(X, [X]).
lastPropio(X, [_|Xs]):-
    lastPropio(X, Xs).

%fixme
maximo(Numero, [X|_]):-
    Numero > X,
    Numero is X.

maximo(Numero, [X|Xs]):-
    Numero < X,
    maximo(Numero, Xs).
    

